# OECD Helsinki FUA Municipality Membership Source Note

Date inspected: 2026-07-05

Verification status: `directly_inspected_official_source`

Source:

- Title or dataset: OECD list of municipalities in Functional Urban Areas and
  Cities
- Authority or publisher: OECD
- URL, DOI, document identifier, archive path, API endpoint, or access path:
  - `https://www.oecd.org/en/data/datasets/oecd-definition-of-cities-and-functional-urban-areas.html`
  - `https://www.oecd.org/content/dam/oecd/en/data/datasets/oecd-definition-of-cities-and-functional-urban-areas/list_of_municipalities_in_FUAs_and_Cities.csv`
  - `https://ec.europa.eu/eurostat/web/gisco/geodata/statistical-units/cities-functional-urban-areas`
- Release date, source vintage, or version:
  - OECD FUA source family, exact release date not fully reviewed here.
  - The direct CSV was inspected transiently on 2026-07-05.

Status: independently inspected source note. This note does not admit an MTR,
accept an outcome metric, create an evidence manifest, authorize raw data
archiving, calculate scores, rank MTRs, or make final paper claims.

## Source Authority

OECD publishes the municipality membership list for OECD Functional Urban Areas
and Cities. Eurostat GISCO remains the related European geodata source family
for FUA boundaries. The CSV was downloaded transiently to `/tmp` and was not
archived in the repository.

## What The Source Defines

The official OECD CSV exposes these relevant fields:

```yaml
fields:
  - Country
  - ISO3 code
  - Municipality name
  - Municipality ID
  - Municipality OECD ID
  - FUA ID
  - FUA name
  - City ID
  - City name
```

Filtering the official CSV for `FUA ID = FI001F` returned 16 municipality rows:

```yaml
helsinki_fua:
  FUA_ID: FI001F
  FUA_name: Helsinki/Helsingfors
  country: Finland
  ISO3_code: FIN
  raw_csv_archived_in_repo: false
  municipalities:
    - municipality_name: Helsinki
      municipality_id: "091"
      municipality_oecd_id: FIN091
      city_id: FI001C
      city_name: Helsinki/Helsingfors
    - municipality_name: Espoo
      municipality_id: "049"
      municipality_oecd_id: FIN049
      city_id: FI005C
      city_name: Espoo/Esbo
    - municipality_name: Vantaa
      municipality_id: "092"
      municipality_oecd_id: FIN092
      city_id: FI006C
      city_name: Vantaa/Vanda
    - municipality_name: Ingå
      municipality_id: "149"
      municipality_oecd_id: FIN149
    - municipality_name: Järvenpää
      municipality_id: "186"
      municipality_oecd_id: FIN186
    - municipality_name: Kauniainen
      municipality_id: "235"
      municipality_oecd_id: FIN235
    - municipality_name: Kerava
      municipality_id: "245"
      municipality_oecd_id: FIN245
    - municipality_name: Kirkkonummi
      municipality_id: "257"
      municipality_oecd_id: FIN257
    - municipality_name: Mäntsälä
      municipality_id: "505"
      municipality_oecd_id: FIN505
    - municipality_name: Nurmijärvi
      municipality_id: "543"
      municipality_oecd_id: FIN543
    - municipality_name: Pornainen
      municipality_id: "611"
      municipality_oecd_id: FIN611
    - municipality_name: Porvoo
      municipality_id: "638"
      municipality_oecd_id: FIN638
    - municipality_name: Sipoo
      municipality_id: "753"
      municipality_oecd_id: FIN753
    - municipality_name: Siuntio
      municipality_id: "755"
      municipality_oecd_id: FIN755
    - municipality_name: Tuusula
      municipality_id: "858"
      municipality_oecd_id: FIN858
    - municipality_name: Vihti
      municipality_id: "927"
      municipality_oecd_id: FIN927
```

The HSL source note and raw-return intake identify the HSL member municipalities
as Helsinki, Espoo, Vantaa, Kauniainen, Siuntio, Kirkkonummi, Sipoo, Kerava,
and Tuusula. Comparing that documented HSL member list to the official OECD
`FI001F` rows leaves the following official FUA municipalities outside HSL
membership:

```yaml
official_fua_municipalities_outside_hsl_membership:
  - Ingå
  - Järvenpää
  - Mäntsälä
  - Nurmijärvi
  - Pornainen
  - Porvoo
  - Vihti
```

## Source Function For Mobility Conversion

- `boundary_source_family`
- `population_denominator_source`
- `methodology_reference`

## Boundary / Denominator Role

- MTR boundary source: candidate primary boundary source family for the
  Helsinki FUA lead, pending GISCO geometry acquisition and manifesting.
- Resident-population denominator source: candidate geography for later
  Eurostat or official population denominator alignment only; no population
  value is accepted here.
- Overlay or input only: HSL, Digitransit, Fintraffic, FINAP, Matkahuolto,
  municipal service pages, routes, stops, and operators remain service overlays.
- Service-derived denominator risk: high if HSL service area, fare zones,
  GTFS coverage, routing coverage, or operator reach replaces the independent
  `FI001F` FUA geography.

## Outcome / Axis Role

- Outcome dimensions supported: none directly.
- Explanatory axes supported: possible future governance-fit context after
  separate service/governance review.
- Risk of confusing outcome with explanatory axis: high if source richness or
  HSL coverage is treated as evidence of performance.

## Data Availability

- Geography: OECD/Eurostat Functional Urban Area.
- Spatial unit: Finnish municipality rows in the OECD CSV; GISCO boundary
  geometry remains separate and was not acquired here.
- Time period or release vintage: OECD FUA source family; exact vintage pairing
  with GISCO geodata and population denominators remains unresolved.
- Update frequency: not reviewed.
- Access method: direct public CSV download. The OECD HTML page returned a
  command-line Cloudflare 403, but the direct CSV URL downloaded successfully.
- License or usage constraint: not fully reviewed in this note.

## Relevance To Mobility Conversion

This note resolves the official municipality membership question for Helsinki
`FI001F`. It confirms that HSL/Digitransit cannot be assumed to cover the full
FUA merely because it is a rich official service-source family: seven official
FUA municipalities are outside documented HSL membership.

It does not decide whether those outside-HSL municipalities lack relevant
service data. Broader Digitransit, Fintraffic, FINAP, Matkahuolto, rail, and
municipal sources remain possible recovery paths that must be verified
separately.

## Limitations

- The OECD CSV was inspected transiently and not archived in the repo.
- GISCO `FI001F` geometry was not downloaded, hashed, inspected, or archived.
- The OECD HTML landing page returned a Cloudflare 403 to command-line access
  during this pass, although the direct CSV file was accessible.
- HSL membership comparison uses the HSL member list documented in existing
  ThesisRecord notes and raw-return intake; this note did not redownload the
  HSL page.
- Service-source coverage for Ingå, Järvenpää, Mäntsälä, Nurmijärvi,
  Pornainen, Porvoo, and Vihti remains unresolved.
- Population denominator, service overlay, unserved-population visibility, and
  feed manifesting remain unresolved.

## Suitability Judgment

Suitability: `candidate_primary_boundary`

Rationale:

The official OECD CSV directly verifies `FI001F` municipality membership and
confirms that the independent FUA is wider than the documented HSL member area.
Suitability remains conditional on GISCO geometry, denominator vintage
alignment, service-source completeness, and unserved-population visibility.

## Extraction Decision

```yaml
helsinki_fua_membership_extraction:
  lead_id: mtr_src_001
  working_name: Helsinki FUA
  source_authority: OECD / Eurostat GISCO
  exact_name: Helsinki/Helsingfors
  exact_code: FI001F
  geography_type: functional_urban_area
  municipality_membership_status: verified_from_transient_official_oecd_csv_inspection
  municipality_count: 16
  documented_hsl_member_municipality_count_inside_fua: 9
  official_fua_municipalities_outside_hsl_membership_count: 7
  boundary_geometry_status: not_archived
  population_product: unresolved
  population_field: unresolved
  accepted_denominator_value: false
  service_overlay_source: unresolved
  service_coverage_against_boundary: unresolved
  evidence_manifest_status: not_created
  extraction_decision: municipality_membership_verified_service_completeness_blocked
  blockers:
    - raw_OECD_csv_not_archived
    - raw_GISCO_geometry_not_archived
    - population_denominator_not_verified
    - HSL_coverage_not_equivalent_to_FI001F
    - non_HSL_service_sources_not_reconciled
    - unserved_population_visibility_method_missing
```

## Methodology Implication

Helsinki should not return to ChatGPT for the official `FI001F` municipality
membership question. The next work should reconcile non-HSL service sources for
the seven outside-HSL FUA municipalities before any readiness promotion.

## Next Allowed Output

Choose one:

- source-note follow-up.

Specific next follow-up:

- verify broader Digitransit, Fintraffic, FINAP, Matkahuolto, rail, and
  municipal service-source coverage for the seven outside-HSL municipalities;
- acquire GISCO `FI001F` geometry only under a draft evidence manifest;
- verify denominator vintage pairing and unserved-population visibility.

## Prohibited Outputs

This source note does not authorize:

- admitted MTR;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- accepted population value;
- filled boundary record;
- raw data archive without manifest.
