# France NAP Lyon TCL Static Feed Recovery Source Note

Date inspected: 2026-07-05

Verification status: `directly_inspected_official_source_blocked`

Source:

- Title or dataset: France NAP `Réseau urbain TCL`
- Authority or publisher: transport.data.gouv.fr / SYTRAL Mobilités / Data
  Grand Lyon
- URL, DOI, document identifier, archive path, API endpoint, or access path:
  - `https://transport.data.gouv.fr/api/datasets/5de42c4d8b4c417a10e62ec9`
  - `https://transport.data.gouv.fr/datasets/horaires-theoriques-du-reseau-transports-en-commun-lyonnais`
  - `https://download.data.grandlyon.com/files/rdata/tcl_sytral.tcltheorique/GTFS_TCL.ZIP`
  - `https://download.data.grandlyon.com/files/rdata/tcl_sytral.tcltheorique/NETEX_TCL.ZIP`
  - `https://data.grandlyon.com/siri-lite/2.0/estimated-timetables.json`
- Release date, source vintage, or version:
  - NAP dataset `updated`: `2026-05-12T22:15:44.378000Z`.
  - Resources refreshed in the official catalog through 2026-05-12 for SIRI
    Lite and 2025-01-22 for listed static resources.

Status: independently inspected source note. This note does not admit an MTR,
accept an outcome metric, create an evidence manifest, authorize raw data
archiving, calculate scores, rank MTRs, or make final paper claims.

## Source Authority

The French National Access Point catalogs the Lyon TCL dataset. The inspected
dataset identifies SYTRAL Mobilités as publisher and legal owner. The static
and SIRI Lite resource URLs point to Data Grand Lyon endpoints.

## What The Source Defines

The live NAP API response identifies:

```yaml
dataset:
  id: 5de42c4d8b4c417a10e62ec9
  title: Réseau urbain TCL
  slug: horaires-theoriques-du-reseau-transports-en-commun-lyonnais
  type: public-transit
  publisher: SYTRAL Mobilités
  legal_owner: SYTRAL Mobilités
  licence: mobility-licence
  tags:
    - licence-mobilités
    - authentification_requise
  updated: "2026-05-12T22:15:44.378000Z"
  raw_api_response_archived_in_repo: false
```

The inspected resource status remains:

```yaml
resources:
  available_in_catalog:
    - resource_id: 84026
      format: SIRI Lite
      title: Horaires théoriques du réseau Transports en Commun Lyonnais
      original_url: https://data.grandlyon.com/siri-lite/2.0/estimated-timetables.json
      updated: "2026-05-12T07:07:46.116000Z"
    - resource_id: 84027
      format: SIRI Lite
      title: Horaires théoriques du réseau Transports en Commun Lyonnais
      original_url: https://data.grandlyon.com/siri-lite/2.0/situation-exchange.json
      updated: "2026-05-12T07:07:46.117000Z"
    - resource_id: 84028
      format: SIRI Lite
      title: Horaires théoriques du réseau Transports en Commun Lyonnais
      original_url: https://data.grandlyon.com/siri-lite/2.0/vehicle-monitoring.json
      updated: "2026-05-12T22:15:44.378000Z"
  unavailable_in_catalog:
    - resource_id: 65812
      format: GTFS
      original_url: https://download.data.grandlyon.com/files/rdata/tcl_sytral.tcltheorique/GTFS_TCL.ZIP
      updated: "2025-01-22T23:07:31.267000Z"
      historical_metadata_validity: "2022-04-14 to 2022-07-12"
    - resource_id: 65813
      format: NeTEx
      original_url: https://download.data.grandlyon.com/files/rdata/tcl_sytral.tcltheorique/NETEX_TCL.ZIP
      updated: "2025-01-22T23:07:31.266000Z"
```

Direct HEAD requests to the Grand Lyon GTFS, NeTEx, and SIRI Lite Estimated
Timetable URLs returned HTTP 401 with `www-authenticate: Basic realm="Access to
files"`. That confirms a credential barrier for raw acquisition in this
environment.

## Source Function For Mobility Conversion

- `service_or_network_source`
- `outcome_indicator_source_family`, only after a metric-specific method note
- `methodology_reference`

## Boundary / Denominator Role

- MTR boundary source: no.
- Resident-population denominator source: no.
- Overlay or input only: yes, after an independent `FR002F` boundary is
  verified.
- Service-derived denominator risk: high if TCL/SYTRAL service area, catalog
  covered areas, routes, stops, SIRI endpoint coverage, or GTFS extent replaces
  the independent FUA boundary.

## Outcome / Axis Role

- Outcome dimensions supported: none accepted in this note.
- Explanatory axes supported: possible later governance-fit context only after
  separate documentation.
- Risk of confusing outcome with explanatory axis: high if catalog availability
  is treated as transport performance.

## Data Availability

- Geography: TCL/SYTRAL public-transport catalog coverage; not accepted as the
  Lyon `FR002F` FUA.
- Spatial unit: service-feed resources, not boundary units.
- Time period or release vintage: current catalog status as of 2026-07-05;
  historical GTFS metadata references a 2022 feed validity window only.
- Update frequency: unresolved.
- Access method: unauthenticated NAP catalog API; raw Grand Lyon resources
  require Basic authentication.
- License or usage constraint: NAP lists `mobility-licence` and
  `authentification_requise`; license and redistribution terms are unresolved
  for repository archiving.

## Relevance To Mobility Conversion

This note confirms that the official TCL source path exists but remains blocked
for current static-feed use. GTFS and NeTEx are not currently available in the
NAP catalog response, and the raw Grand Lyon resource URLs require
authentication.

SIRI Lite is available as catalog metadata, but it is a dynamic/operational
source family and is not accepted as a substitute for a static GTFS/NeTEx
baseline without a separate method decision.

## Limitations

- No raw GTFS, NeTEx, SIRI Lite, PDF, or other service payload was downloaded
  or archived.
- The full NAP API JSON was inspected live but not stored in the repository.
- Static GTFS/NeTEx resources are listed but unavailable in the catalog.
- Historical GTFS metadata from 2022 remains historical only and cannot support
  current service evidence.
- Raw Grand Lyon endpoints require Basic authentication in this environment.
- `mobility-licence` terms and account authorization remain unresolved.
- `FR002F` service-overlay completeness is unresolved, including SNCF,
  Rhonexpress, regional coach, demand-responsive, school, paratransit, and
  river-shuttle materiality.

## Suitability Judgment

Suitability: `source_lead_pending`

Rationale:

The France NAP and Grand Lyon paths are official and traceable, but current
static schedule acquisition is blocked by catalog unavailability and Basic Auth.
SIRI Lite may support a future method only after authenticated sample capture,
schema review, snapshot semantics, license review, and archive design.

## Extraction Decision

```yaml
lyon_tcl_static_feed_recovery:
  lead_id: mtr_src_002
  working_name: Lyon FUA
  source_authority: transport.data.gouv.fr / SYTRAL Mobilités / Data Grand Lyon
  boundary_code_context: FR002F
  catalog_dataset_id: 5de42c4d8b4c417a10e62ec9
  static_gtfs_status: listed_but_catalog_unavailable_and_http_401
  static_netex_status: listed_but_catalog_unavailable_and_http_401
  siri_lite_status: catalog_available_but_http_401_and_method_unresolved
  license_status: mobility_licence_unreviewed_for_archive
  authentication_status: basic_auth_required
  boundary_geometry_status: not_archived
  service_payload_status: not_archived
  evidence_manifest_status: not_created
  extraction_decision: static_feed_and_siri_method_blocked
  blockers:
    - GTFS_catalog_unavailable
    - NeTEx_catalog_unavailable
    - Grand_Lyon_basic_auth_required
    - mobility_licence_terms_unresolved
    - SIRI_Lite_static_snapshot_method_unresolved
    - FR002F_operator_overlay_not_done
```

## Methodology Implication

Lyon should not return to ChatGPT for a static-feed availability answer unless
credentials or producer authorization are supplied. The next useful work is an
authenticated-source acquisition plan or a separate SIRI Lite method decision.

## Next Allowed Output

Choose one:

- source-note follow-up.

Specific next follow-up:

- obtain or document Grand Lyon account authorization before any raw feed
  acquisition;
- review `mobility-licence` terms for archive/reuse;
- decide whether SIRI Lite can be used only after a controlled, timestamped,
  authenticated payload sample;
- overlay SNCF, Rhonexpress, regional coach, and TCL special services against
  `FR002F`.

## Prohibited Outputs

This source note does not authorize:

- admitted MTR;
- accepted SIRI Lite method;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- accepted population value;
- filled boundary record;
- raw data archive without manifest.
