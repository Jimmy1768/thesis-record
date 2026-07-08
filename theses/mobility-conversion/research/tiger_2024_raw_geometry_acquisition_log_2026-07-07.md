# TIGER 2024 Raw Geometry Acquisition Log

Date: 2026-07-07

Status: raw acquisition log under an existing draft evidence manifest. This log
does not accept evidence for method testing, boundary records, metric records,
scores, rankings, or final paper claims.

Related manifest:

- `theses/mobility-conversion/evidence/manifests/tiger_2024_subcounty_geometry_overlay_manifest_2026-07-07.md`

Related license/storage review:

- `theses/mobility-conversion/research/tiger_2024_license_storage_review_2026-07-07.md`

Raw archive root:

- `theses/mobility-conversion/evidence/raw/us_census/tiger_2024_subcounty_geometry/`

## Acquired Files

```yaml
tiger_2024_raw_geometry_acquisition:
  acquisition_date: 2026-07-07
  acquisition_mode: bulk_file_download_under_existing_manifest
  raw_archive_path: theses/mobility-conversion/evidence/raw/us_census/tiger_2024_subcounty_geometry/
  processed_path: not_created
  files:
    tl_2024_27_bg.zip:
      geography: Minnesota block group
      source_url: https://www2.census.gov/geo/tiger/TIGER2024/BG/tl_2024_27_bg.zip
      byte_size: 13095867
      sha256: 608a2cf783eb473f0e0d1d96085cd9b36f5d0581e25556f95686b2a1af71ed5f
      zip_integrity: passed
    tl_2024_27_tract.zip:
      geography: Minnesota tract
      source_url: https://www2.census.gov/geo/tiger/TIGER2024/TRACT/tl_2024_27_tract.zip
      byte_size: 7492209
      sha256: ff85e970af09db62e28f1010cbf51c0241373da4e75b168aee76ca224473f3ce
      zip_integrity: passed
    tl_2024_41_bg.zip:
      geography: Oregon block group
      source_url: https://www2.census.gov/geo/tiger/TIGER2024/BG/tl_2024_41_bg.zip
      byte_size: 16965287
      sha256: 3c6ab8255d8300f25c9605c3550abd6fe3b39c768d5827b327cf180d1e4d2525
      zip_integrity: passed
    tl_2024_41_tract.zip:
      geography: Oregon tract
      source_url: https://www2.census.gov/geo/tiger/TIGER2024/TRACT/tl_2024_41_tract.zip
      byte_size: 10648349
      sha256: 5c429b7577273441ee7f045718cb9989a6fb03f6bf72167410efebbc144cba5c
      zip_integrity: passed
    tl_2024_53_bg.zip:
      geography: Washington block group
      source_url: https://www2.census.gov/geo/tiger/TIGER2024/BG/tl_2024_53_bg.zip
      byte_size: 16249192
      sha256: 6a650e5db7510922815eba5e40623e6985803987469198408dc1e9a0d7fcefe4
      zip_integrity: passed
    tl_2024_53_tract.zip:
      geography: Washington tract
      source_url: https://www2.census.gov/geo/tiger/TIGER2024/TRACT/tl_2024_53_tract.zip
      byte_size: 9827813
      sha256: 60af16a9d108a55e8a9642dc38c77d10e77b143c2303758fc5bd626229e3a89f
      zip_integrity: passed
    tl_2024_55_bg.zip:
      geography: Wisconsin block group
      source_url: https://www2.census.gov/geo/tiger/TIGER2024/BG/tl_2024_55_bg.zip
      byte_size: 13843348
      sha256: 3832c7b938ae357e88f162d6d97f141cdab9efced9684d60de62ab3708ff57e0
      zip_integrity: passed
    tl_2024_55_tract.zip:
      geography: Wisconsin tract
      source_url: https://www2.census.gov/geo/tiger/TIGER2024/TRACT/tl_2024_55_tract.zip
      byte_size: 7642880
      sha256: 313c378d7fa173bf653381d644d8ded7b4f6241b2065d2b890e1fccccaab5de5
      zip_integrity: passed
  total_byte_size: 95764945
```

## ZIP Content Pattern

Each archive contains the expected TIGER/Line shapefile sidecar set for its
geography:

- `.cpg`
- `.dbf`
- `.prj`
- `.shp`
- `.shp.ea.iso.xml`
- `.shp.iso.xml`
- `.shx`

No archive extraction, processed geometry creation, schema-level DBF review,
feature counting, coordinate-system review, or crosswalk construction was done
in this step.

## Current Evidence Status

The raw ZIP files are archived under a manifest-controlled evidence path and
have passed checksum capture and ZIP integrity checks. They remain unavailable
for method tests, boundary records, metric records, final claims, scores, or
rankings until quality review and downstream method gates are completed.

## Next Required Review

- inspect shapefile schemas and geography identifiers;
- record feature counts by archive;
- confirm coordinate reference system metadata;
- decide whether to extract a processed geometry layer;
- keep ACS population-table acquisition deferred until live API row
  verification succeeds.
