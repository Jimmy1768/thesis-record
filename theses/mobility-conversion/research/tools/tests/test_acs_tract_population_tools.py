from __future__ import annotations

import csv
import hashlib
import importlib.util
import json
import sys
from pathlib import Path
import unittest


TOOLS_DIR = Path(__file__).resolve().parents[1]


def load_tool(module_name: str):
    path = TOOLS_DIR / f"{module_name}.py"
    spec = importlib.util.spec_from_file_location(module_name, path)
    module = importlib.util.module_from_spec(spec)
    assert spec and spec.loader
    sys.modules[module_name] = module
    spec.loader.exec_module(module)
    return module


fetch_tool = load_tool("acs_tract_population_fetch")
join_tool = load_tool("acs_tract_population_join")


def make_shapefile(base: Path, rows: list[dict[str, str]]) -> None:
    import shapefile

    base.parent.mkdir(parents=True, exist_ok=True)
    writer = shapefile.Writer(str(base), shapeType=shapefile.POLYGON)
    for field in [
        ("STATEFP", "C", 2, 0),
        ("COUNTYFP", "C", 3, 0),
        ("TRACTCE", "C", 6, 0),
        ("GEOID", "C", 11, 0),
        ("GEOIDFQ", "C", 20, 0),
        ("NAME", "C", 80, 0),
        ("NAMELSAD", "C", 80, 0),
        ("MTFCC", "C", 5, 0),
        ("FUNCSTAT", "C", 1, 0),
        ("ALAND", "C", 20, 0),
        ("AWATER", "C", 20, 0),
        ("INTPTLAT", "C", 20, 0),
        ("INTPTLON", "C", 20, 0),
    ]:
        writer.field(*field)
    for row in rows:
        writer.poly([[[0.0, 0.0], [1.0, 0.0], [1.0, 1.0], [0.0, 1.0], [0.0, 0.0]]])
        writer.record(
            row["STATEFP"],
            row["COUNTYFP"],
            row["TRACTCE"],
            row["GEOID"],
            row.get("GEOIDFQ", f"1400000US{row['GEOID']}"),
            row["NAME"],
            row["NAMELSAD"],
            row.get("MTFCC", "G5020"),
            row.get("FUNCSTAT", "S"),
            row.get("ALAND", "1"),
            row.get("AWATER", "0"),
            row.get("INTPTLAT", "+0.0000000"),
            row.get("INTPTLON", "-0.0000000"),
        )
    writer.close()
    base.with_suffix(".prj").write_text("GEOGCS[\"GCS_North_American_1983\"]", encoding="utf-8")
    base.with_suffix(".cpg").write_text("UTF-8", encoding="utf-8")


def api_payload_bytes(rows: list[list[str]]) -> bytes:
    return json.dumps(rows, separators=(",", ":")).encode("utf-8")


def write_raw_county_bytes(output_dir: Path, state: str, county: str, payload_bytes: bytes) -> str:
    filename = fetch_tool.build_county_filename(state, county)
    output_dir.mkdir(parents=True, exist_ok=True)
    (output_dir / filename).write_bytes(payload_bytes)
    return hashlib.sha256(payload_bytes).hexdigest()


def write_raw_index(output_dir: Path, county_entries: list[dict[str, object]]) -> None:
    index = {
        "source_family": fetch_tool.SOURCE_FAMILY,
        "source_vintage": fetch_tool.SOURCE_VINTAGE,
        "api_base": fetch_tool.API_BASE,
        "requested_fields": fetch_tool.REQUESTED_FIELDS,
        "retrieval_timestamp": "2026-07-12T00:00:00Z",
        "counties": county_entries,
    }
    (output_dir / "index.json").write_text(
        json.dumps(index, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )


class AcsTractPopulationToolsTest(unittest.TestCase):
    def build_opener(self, payloads_by_url: dict[str, bytes], failure_url: str | None = None):
        class Response:
            def __init__(self, payload: bytes):
                self.payload = payload

            def read(self) -> bytes:
                return self.payload

            def __enter__(self):
                return self

            def __exit__(self, exc_type, exc, tb):
                return False

        def opener(request):
            url = request.full_url
            if failure_url is not None and url == failure_url:
                raise OSError("synthetic failure")
            return Response(payloads_by_url[url])

        return opener

    def make_county_payload(self, state: str, county: str, tract_rows: list[list[str]]) -> bytes:
        return api_payload_bytes([fetch_tool.EXPECTED_HEADERS, *tract_rows])

    def test_dry_run_emits_exact_county_urls(self):
        from io import StringIO

        original_stdout = sys.stdout
        buffer = StringIO()
        sys.stdout = buffer
        try:
            fetch_tool.print_dry_run_urls()
        finally:
            sys.stdout = original_stdout
        lines = buffer.getvalue().strip().splitlines()
        self.assertEqual(len(lines), 20)
        self.assertEqual(len(set(lines)), 20)
        self.assertEqual(
            lines[0],
            "https://api.census.gov/data/2024/acs/acs5?get=NAME,B01003_001E,B01003_001M&for=tract:*&in=state:27&in=county:003",
        )
        self.assertEqual(
            lines[-1],
            "https://api.census.gov/data/2024/acs/acs5?get=NAME,B01003_001E,B01003_001M&for=tract:*&in=state:53&in=county:059",
        )

    def test_fetch_rejects_malformed_rows(self):
        rows = [
            fetch_tool.EXPECTED_HEADERS,
            ["Tract 1", "-1", "3", "27", "003", "000100"],
        ]
        with self.assertRaisesRegex(SystemExit, "Negative B01003_001E"):
            fetch_tool.validate_response_rows(rows, "27", "003")

    def test_fetch_preserves_exact_response_bytes_and_index_sha(self):
        import tempfile

        with tempfile.TemporaryDirectory() as temp_dir:
            output_dir = Path(temp_dir) / "raw"
            payloads_by_url = {}
            expected_bytes_by_filename = {}
            for spec in fetch_tool.COUNTY_SPECS:
                state = spec["state_fips"]
                county = spec["county_fips"]
                url = fetch_tool.build_query_url(state, county)
                payload = (
                    b'[\n ["NAME","B01003_001E","B01003_001M","state","county","tract"],\n'
                    + f' ["Example {state}{county}","12","3","{state}","{county}","000100"]\n]'.encode("utf-8")
                )
                payloads_by_url[url] = payload
                expected_bytes_by_filename[f"{state}{county}.json"] = payload

            fetch_tool.run_fetch(output_dir, opener=self.build_opener(payloads_by_url))

            files = sorted(path.name for path in output_dir.iterdir())
            self.assertEqual(len(files), 21)
            self.assertEqual(files[0], "27003.json")
            self.assertEqual(files[-1], "index.json")
            for filename, payload in expected_bytes_by_filename.items():
                self.assertEqual((output_dir / filename).read_bytes(), payload)

            index = json.loads((output_dir / "index.json").read_text(encoding="utf-8"))
            first = index["counties"][0]
            self.assertEqual(first["county_filename"], "27003.json")
            self.assertEqual(first["sha256"], hashlib.sha256(expected_bytes_by_filename["27003.json"]).hexdigest())

    def test_fetch_leaves_no_partial_files_on_later_failure(self):
        import tempfile

        with tempfile.TemporaryDirectory() as temp_dir:
            output_dir = Path(temp_dir) / "raw"
            payloads_by_url = {}
            for spec in fetch_tool.COUNTY_SPECS:
                state = spec["state_fips"]
                county = spec["county_fips"]
                payloads_by_url[fetch_tool.build_query_url(state, county)] = self.make_county_payload(
                    state,
                    county,
                    [[f"Example {state}{county}", "12", "3", state, county, "000100"]],
                )
            failure_url = fetch_tool.build_query_url("41", "051")
            with self.assertRaisesRegex(SystemExit, "Failed to fetch"):
                fetch_tool.run_fetch(output_dir, opener=self.build_opener(payloads_by_url, failure_url=failure_url))
            self.assertTrue(output_dir.exists())
            self.assertEqual(list(output_dir.iterdir()), [])

    def test_join_verifies_checksums_and_one_to_one_coverage(self):
        import tempfile

        with tempfile.TemporaryDirectory() as temp_dir:
            tmp_path = Path(temp_dir)
            raw_dir = tmp_path / "raw"
            geometry_root = tmp_path / "geometry"
            output_dir = tmp_path / "out"

            original_layer_specs = join_tool.LAYER_SPECS
            original_geometry_fields = join_tool.EXPECTED_GEOMETRY_FIELDS
            original_county_specs = join_tool.COUNTY_SPECS
            try:
                join_tool.LAYER_SPECS = {
                    "minneapolis_ers_cz_tracts": {"state_county_fips": {"27003"}, "expected_row_count": 1},
                    "portland_cbsa_tracts": {"state_county_fips": {"41005"}, "expected_row_count": 1},
                }
                join_tool.COUNTY_SPECS = (
                    {"state_fips": "27", "county_fips": "003"},
                    {"state_fips": "41", "county_fips": "005"},
                )

                make_shapefile(
                    geometry_root / "minneapolis_ers_cz_tracts" / "minneapolis_ers_cz_tracts",
                    [
                        {
                            "STATEFP": "27",
                            "COUNTYFP": "003",
                            "TRACTCE": "000100",
                            "GEOID": "27003000100",
                            "GEOIDFQ": "1400000US27003000100",
                            "NAME": "Tract 1",
                            "NAMELSAD": "Census Tract 1",
                        }
                    ],
                )
                make_shapefile(
                    geometry_root / "portland_cbsa_tracts" / "portland_cbsa_tracts",
                    [
                        {
                            "STATEFP": "41",
                            "COUNTYFP": "005",
                            "TRACTCE": "000200",
                            "GEOID": "41005000200",
                            "GEOIDFQ": "1400000US41005000200",
                            "NAME": "Tract 2",
                            "NAMELSAD": "Census Tract 2",
                        }
                    ],
                )

                payload_27003 = self.make_county_payload(
                    "27",
                    "003",
                    [["Tract 1", "10", "1", "27", "003", "000100"]],
                )
                sha27003 = write_raw_county_bytes(
                    raw_dir,
                    "27",
                    "003",
                    payload_27003,
                )
                payload_41005 = self.make_county_payload(
                    "41",
                    "005",
                    [["Tract 2", "20", "2", "41", "005", "000200"]],
                )
                sha41005 = write_raw_county_bytes(
                    raw_dir,
                    "41",
                    "005",
                    payload_41005,
                )
                write_raw_index(
                    raw_dir,
                    [
                        {
                            "state_fips": "27",
                            "county_fips": "003",
                            "query_url": fetch_tool.build_query_url("27", "003"),
                            "county_filename": "27003.json",
                            "row_count": 1,
                            "sha256": sha27003,
                        },
                        {
                            "state_fips": "41",
                            "county_fips": "005",
                            "query_url": fetch_tool.build_query_url("41", "005"),
                            "county_filename": "41005.json",
                            "row_count": 1,
                            "sha256": sha41005,
                        },
                    ],
                )

                join_tool.run_join(raw_dir, geometry_root, output_dir)

                csv_path = output_dir / "acs_2024_5year_tract_population_join.csv"
                summary_path = output_dir / "acs_2024_5year_tract_population_join_summary.json"
                self.assertTrue(csv_path.exists())
                self.assertTrue(summary_path.exists())
                with csv_path.open(newline="", encoding="utf-8") as handle:
                    rows = list(csv.DictReader(handle))
                self.assertEqual(
                    rows,
                    [
                        {
                            "layer": "minneapolis_ers_cz_tracts",
                            "state_fips": "27",
                            "county_fips": "003",
                            "tract": "000100",
                            "geoid": "27003000100",
                            "geometry_name": "Tract 1",
                            "geometry_namelsad": "Census Tract 1",
                            "acs_name": "Tract 1",
                            "b01003_001e": "10",
                            "b01003_001m": "1",
                        },
                        {
                            "layer": "portland_cbsa_tracts",
                            "state_fips": "41",
                            "county_fips": "005",
                            "tract": "000200",
                            "geoid": "41005000200",
                            "geometry_name": "Tract 2",
                            "geometry_namelsad": "Census Tract 2",
                            "acs_name": "Tract 2",
                            "b01003_001e": "20",
                            "b01003_001m": "2",
                        },
                    ],
                )
            finally:
                join_tool.LAYER_SPECS = original_layer_specs
                join_tool.COUNTY_SPECS = original_county_specs

    def test_join_rejects_unmatched_or_duplicate_rows(self):
        import tempfile

        with tempfile.TemporaryDirectory() as temp_dir:
            tmp_path = Path(temp_dir)
            raw_dir = tmp_path / "raw"
            geometry_root = tmp_path / "geometry"
            output_dir = tmp_path / "out"

            original_layer_specs = join_tool.LAYER_SPECS
            original_county_specs = join_tool.COUNTY_SPECS
            try:
                join_tool.LAYER_SPECS = {
                    "minneapolis_ers_cz_tracts": {"state_county_fips": {"27003"}, "expected_row_count": 1}
                }
                join_tool.COUNTY_SPECS = (
                    {"state_fips": "27", "county_fips": "003"},
                )
                make_shapefile(
                    geometry_root / "minneapolis_ers_cz_tracts" / "minneapolis_ers_cz_tracts",
                    [
                        {
                            "STATEFP": "27",
                            "COUNTYFP": "003",
                            "TRACTCE": "000100",
                            "GEOID": "27003000100",
                            "GEOIDFQ": "1400000US27003000100",
                            "NAME": "Tract 1",
                            "NAMELSAD": "Census Tract 1",
                        }
                    ],
                )
                sha27003 = write_raw_county_bytes(
                    raw_dir,
                    "27",
                    "003",
                    self.make_county_payload(
                        "27",
                        "003",
                        [["Tract 1", "10", "1", "27", "003", "000101"]],
                    ),
                )
                write_raw_index(
                    raw_dir,
                    [
                        {
                            "state_fips": "27",
                            "county_fips": "003",
                            "query_url": fetch_tool.build_query_url("27", "003"),
                            "county_filename": "27003.json",
                            "row_count": 1,
                            "sha256": sha27003,
                        }
                    ],
                )

                with self.assertRaisesRegex(SystemExit, "One-to-one coverage failed"):
                    join_tool.run_join(raw_dir, geometry_root, output_dir)
            finally:
                join_tool.LAYER_SPECS = original_layer_specs
                join_tool.COUNTY_SPECS = original_county_specs

    def test_summary_omits_machine_paths_and_includes_stable_provenance(self):
        import tempfile

        with tempfile.TemporaryDirectory() as temp_dir:
            tmp_path = Path(temp_dir)
            raw_dir = tmp_path / "raw"
            geometry_root = tmp_path / "geometry"
            output_dir = tmp_path / "out"

            original_layer_specs = join_tool.LAYER_SPECS
            original_county_specs = join_tool.COUNTY_SPECS
            try:
                join_tool.LAYER_SPECS = {
                    "minneapolis_ers_cz_tracts": {
                        "state_county_fips": {"27003"},
                        "expected_row_count": 1,
                    },
                    "portland_cbsa_tracts": {
                        "state_county_fips": {"41005"},
                        "expected_row_count": 1,
                    },
                }
                join_tool.COUNTY_SPECS = (
                    {"state_fips": "27", "county_fips": "003"},
                    {"state_fips": "41", "county_fips": "005"},
                )

                make_shapefile(
                    geometry_root / "minneapolis_ers_cz_tracts" / "minneapolis_ers_cz_tracts",
                    [{
                        "STATEFP": "27",
                        "COUNTYFP": "003",
                        "TRACTCE": "000100",
                        "GEOID": "27003000100",
                        "GEOIDFQ": "1400000US27003000100",
                        "NAME": "Tract 1",
                        "NAMELSAD": "Census Tract 1",
                    }],
                )
                make_shapefile(
                    geometry_root / "portland_cbsa_tracts" / "portland_cbsa_tracts",
                    [{
                        "STATEFP": "41",
                        "COUNTYFP": "005",
                        "TRACTCE": "000200",
                        "GEOID": "41005000200",
                        "GEOIDFQ": "1400000US41005000200",
                        "NAME": "Tract 2",
                        "NAMELSAD": "Census Tract 2",
                    }],
                )

                payload_27003 = self.make_county_payload(
                    "27", "003", [["Tract 1", "10", "1", "27", "003", "000100"]]
                )
                payload_41005 = self.make_county_payload(
                    "41", "005", [["Tract 2", "20", "2", "41", "005", "000200"]]
                )
                sha27003 = write_raw_county_bytes(raw_dir, "27", "003", payload_27003)
                sha41005 = write_raw_county_bytes(raw_dir, "41", "005", payload_41005)
                write_raw_index(
                    raw_dir,
                    [
                        {
                            "state_fips": "27",
                            "county_fips": "003",
                            "query_url": fetch_tool.build_query_url("27", "003"),
                            "county_filename": "27003.json",
                            "row_count": 1,
                            "sha256": sha27003,
                        },
                        {
                            "state_fips": "41",
                            "county_fips": "005",
                            "query_url": fetch_tool.build_query_url("41", "005"),
                            "county_filename": "41005.json",
                            "row_count": 1,
                            "sha256": sha41005,
                        },
                    ],
                )

                join_tool.run_join(raw_dir, geometry_root, output_dir)
                summary_text = (output_dir / "acs_2024_5year_tract_population_join_summary.json").read_text(encoding="utf-8")
                summary = json.loads(summary_text)
                self.assertNotIn(temp_dir, summary_text)
                self.assertNotIn("/Users/", summary_text)
                self.assertNotIn("/home/", summary_text)
                self.assertNotIn(str(raw_dir), summary_text)
                self.assertNotIn(str(geometry_root), summary_text)
                self.assertEqual(summary["acs_source_family"], join_tool.SOURCE_FAMILY)
                self.assertEqual(summary["acs_source_vintage"], join_tool.SOURCE_VINTAGE)
                self.assertEqual(
                    summary["raw_index_sha256"],
                    hashlib.sha256((raw_dir / "index.json").read_bytes()).hexdigest(),
                )
                self.assertEqual(
                    summary["tiger_geometry_manifest_repo_path"],
                    join_tool.TIGER_GEOMETRY_MANIFEST_REPO_PATH,
                )
                self.assertEqual(summary["status"], "provisional")
                self.assertFalse(summary["accepted_population_value"])
                self.assertFalse(summary["accepted_denominator_value"])
            finally:
                join_tool.LAYER_SPECS = original_layer_specs
                join_tool.COUNTY_SPECS = original_county_specs

    def test_join_rejects_missing_or_extra_raw_files(self):
        import tempfile

        with tempfile.TemporaryDirectory() as temp_dir:
            raw_dir = Path(temp_dir) / "raw"
            raw_dir.mkdir(parents=True, exist_ok=True)
            (raw_dir / "index.json").write_text("{}", encoding="utf-8")
            (raw_dir / "unexpected.json").write_text("[]", encoding="utf-8")
            with self.assertRaisesRegex(SystemExit, "Unexpected raw capture file set"):
                join_tool.verify_capture_directory(raw_dir, 20)

    def test_join_rejects_tampered_bytes_and_malformed_response(self):
        import tempfile

        with tempfile.TemporaryDirectory() as temp_dir:
            raw_dir = Path(temp_dir) / "raw"
            raw_dir.mkdir(parents=True, exist_ok=True)
            payload = self.make_county_payload("27", "003", [["Tract 1", "10", "1", "27", "003", "000100"]])
            wrong_sha = hashlib.sha256(b"other").hexdigest()
            write_raw_county_bytes(raw_dir, "27", "003", payload)
            with self.assertRaisesRegex(SystemExit, "Checksum mismatch"):
                join_tool.validate_raw_payload(
                    raw_dir,
                    {
                        "state_fips": "27",
                        "county_fips": "003",
                        "query_url": fetch_tool.build_query_url("27", "003"),
                        "county_filename": "27003.json",
                        "row_count": 1,
                        "sha256": wrong_sha,
                    },
                )

            malformed_path = raw_dir / "27003.json"
            malformed_path.write_bytes(b'{"not":"a list"}')
            with self.assertRaisesRegex(SystemExit, "Malformed raw county payload|Unexpected raw county payload shape"):
                join_tool.validate_raw_payload(
                    raw_dir,
                    {
                        "state_fips": "27",
                        "county_fips": "003",
                        "query_url": fetch_tool.build_query_url("27", "003"),
                        "county_filename": "27003.json",
                        "row_count": 1,
                        "sha256": hashlib.sha256(b'{"not":"a list"}').hexdigest(),
                    },
                )

    def test_join_exposes_exact_20_county_production_contract(self):
        expected = [f"{spec['state_fips']}{spec['county_fips']}" for spec in fetch_tool.COUNTY_SPECS]
        self.assertEqual(len(expected), 20)
        self.assertEqual(expected, [f"{spec['state_fips']}{spec['county_fips']}" for spec in join_tool.COUNTY_SPECS])

    def test_production_geometry_smoke_reads_committed_layers(self):
        geometry_root = (
            Path(__file__).resolve().parents[3]
            / "evidence/processed/us_census/tiger_2024_subcounty_geometry"
        )
        minneapolis_rows = join_tool.read_layer_geometry(
            "minneapolis_ers_cz_tracts",
            geometry_root,
            join_tool.LAYER_SPECS["minneapolis_ers_cz_tracts"]["state_county_fips"],
        )
        portland_rows = join_tool.read_layer_geometry(
            "portland_cbsa_tracts",
            geometry_root,
            join_tool.LAYER_SPECS["portland_cbsa_tracts"]["state_county_fips"],
        )
        self.assertEqual(len(minneapolis_rows), 845)
        self.assertEqual(len(portland_rows), 568)
        self.assertEqual(
            {f"{row['STATEFP']}{row['COUNTYFP']}" for row in minneapolis_rows},
            join_tool.LAYER_SPECS["minneapolis_ers_cz_tracts"]["state_county_fips"],
        )
        self.assertEqual(
            {f"{row['STATEFP']}{row['COUNTYFP']}" for row in portland_rows},
            join_tool.LAYER_SPECS["portland_cbsa_tracts"]["state_county_fips"],
        )
        self.assertTrue(
            all(row["GEOID"] == f"{row['STATEFP']}{row['COUNTYFP']}{row['TRACTCE']}" for row in minneapolis_rows)
        )
        self.assertTrue(
            all(row["GEOID"] == f"{row['STATEFP']}{row['COUNTYFP']}{row['TRACTCE']}" for row in portland_rows)
        )
        self.assertEqual(
            join_tool.EXPECTED_GEOMETRY_FIELDS,
            [
                "STATEFP",
                "COUNTYFP",
                "TRACTCE",
                "GEOID",
                "GEOIDFQ",
                "NAME",
                "NAMELSAD",
                "MTFCC",
                "FUNCSTAT",
                "ALAND",
                "AWATER",
                "INTPTLAT",
                "INTPTLON",
            ],
        )

    def test_join_refuses_nonempty_output_dir(self):
        import tempfile

        with tempfile.TemporaryDirectory() as temp_dir:
            output_dir = Path(temp_dir)
            (output_dir / "sentinel.txt").write_text("x", encoding="utf-8")
            with self.assertRaisesRegex(SystemExit, "non-empty output directory"):
                join_tool.ensure_empty_output_dir(output_dir)


if __name__ == "__main__":
    unittest.main()
