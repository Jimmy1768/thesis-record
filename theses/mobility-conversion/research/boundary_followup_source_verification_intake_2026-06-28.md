# Boundary Follow-Up Source Verification Intake

Date: 2026-06-28

Status: Deep Research follow-up intake. Not evidence. Not source truth. Not
final methodology.

Raw process artifact:

- `theses/mobility-conversion/operator_records/external_query_tests/2026-06-28-boundary-follow-up-source-verification-raw-return.md`

## Intake Judgment

The return is useful and should guide the next source-verification cycle. It
does not itself verify sources for ThesisRecord.

The return focuses on three unresolved areas from Batch 1A-1C:

- U.S. public GTFS feed-inventory and National Transit Map sources;
- post-2020 commuting disruption and boundary-vintage caveats;
- national commuting-zone / travel-to-work / statistical metro methods outside
  OECD-Eurostat FUA foundations.

## Source Leads For Direct Inspection

### U.S. GTFS Feed Inventory And National Transit Map

Source leads:

- FTA / NTD General Transit Feed Specification Weblinks dataset
- 2025 NTD Full Reporting Policy Manual
- Recent NTD Developments FAQ
- BTS National Transit Map
- ROSA P National Transit Map archive records

Intake use:

- close the open Batch 1C verification item;
- distinguish GTFS feed inventory from geospatial service catalog;
- verify update cadence and reporting requirements;
- preserve limits around fixed-route-only coverage, stale links, invalid feeds,
  and non-fixed-route exclusions.

Expected suitability if verified:

- `indicator_input_only`;
- `candidate_overlay`;
- source-authentication layer for U.S. GTFS feeds;
- not MTR denominator.

### Post-2020 Commuting Boundary Caveats

Source leads:

- U.S. Census commuting topic page
- U.S. Census commuting-flow tables
- U.S. Census "Commuting in the United States: 2022"
- U.S. Census "Home-Based Workers: 2019-2021"
- ONS Census 2021 travel-to-work quality information
- ONS Data Science Campus travel-to-work matrix estimation
- OECD remote-work report
- ITF/OECD post-COVID urban mobility source
- 2024 Scientific Data paper on U.S. 2020 commuting-zone delineation

Intake use:

- decide whether commuting-derived boundaries need a formal vintage/caveat
  field;
- distinguish caveat from rejection;
- avoid overclaiming that FUAs or commuting zones must be redrawn everywhere.

Expected suitability if verified:

- boundary-caveat source;
- validation layer;
- not primary boundary by itself.

### National Commuting-Zone / Functional Statistical Methods

Source leads:

- UK ONS Travel to Work Areas
- USDA ERS Commuting Zones and Labor Market Areas
- Statistics Canada Census Metropolitan Areas / Census Agglomerations
- Australian Bureau of Statistics ASGS
- ABS Greater Capital City Statistical Areas
- ABS Statistical Area Level 4
- ABS Destination Zones

Intake use:

- expand verified boundary-method examples beyond OECD/Eurostat FUAs;
- classify observed vs modelled vs hybrid official statistical methods;
- identify when national statistical boundaries may be candidate primary,
  fallback, validation, or overlay sources.

Expected suitability if verified:

- UK ONS TTWA: possible candidate primary or validation layer for UK
  labor-market boundaries;
- USDA ERS CZ: U.S. labor-market fallback or validation layer;
- Statistics Canada CMA/CA: Canadian statistical metro container and possible
  candidate boundary;
- ABS GCCSA/ASGS: Australian functional/statistical container and possible
  candidate boundary.

## Methodology Candidates Created Or Reinforced

### Boundary Vintage Caveat

Commuting-derived boundaries should include:

- commuting data vintage;
- geography release vintage;
- pandemic or remote-work caveat;
- whether the source authority recommends continued use, caution, or revision.

### GTFS / Feed Source Registry Fields

Candidate GTFS/feed registry fields:

- `source_id`
- `authority`
- `dataset_name`
- `source_url`
- `retrieval_date`
- `ntd_report_year`
- `update_cadence_claim`
- `mode_coverage`
- `fixed_route_only`
- `gtfs_static_required`
- `gtfs_rt_optional`
- `feed_url`
- `feed_host`
- `feed_validation_status`
- `last_successful_fetch`
- `license_or_public_domain_status`
- `raw_archive_path`
- `processed_archive_path`
- `notes`

### Boundary / Caveat Source Registry Fields

Candidate fields:

- `source_id`
- `authority`
- `source_title`
- `source_url`
- `boundary_family`
- `observed_or_modelled`
- `spatial_unit`
- `commuting_data_vintage`
- `geography_release_vintage`
- `coverage`
- `update_cadence`
- `pandemic_or_remote_work_caveat`
- `transport_access_limitations`
- `raw_archive_path`
- `processed_note_path`
- `confidence_notes`

## Open Questions Created Or Reinforced

- Should every commuting-derived boundary source require a `commuting_data_vintage`
  field?
- Should post-2020 work-from-home disruption be treated as a mandatory caveat
  for all commute-flow boundaries, or only for sources whose authority flags the
  issue?
- Should U.S. GTFS web links and National Transit Map be separate source
  registry entries?
- Should official national statistical metro systems be allowed as candidate
  primary MTR boundaries when they are explicitly functional/statistical rather
  than pure administrative areas?
- Should hybrid systems such as ABS GCCSA/ASGS receive a distinct confidence
  class from observed commuting-flow regions and modelled functional regions?

## Quarantined Or Rejected Items

The return suggests paths under `theses/thesis-2-mobility-conversion/`. That is
not the accepted ThesisRecord folder.

Accepted folder:

- `theses/mobility-conversion/`

The return uses "verified" labels internally. Those labels are not accepted as
ThesisRecord verification until Codex directly inspects the underlying sources
and writes source notes.

The return does not justify scoring, candidate MTR selection, or final boundary
methodology.

## Immediate Thesis 2 Use

The return is strong enough to define Batch 2 verification work:

- Batch 2A: U.S. GTFS feed inventory and National Transit Map;
- Batch 2B: post-2020 commuting-boundary caveat sources;
- Batch 2C: national commuting-zone and functional statistical methods.

The first priority should be Batch 2A because it closes the open Batch 1C
verification item.
