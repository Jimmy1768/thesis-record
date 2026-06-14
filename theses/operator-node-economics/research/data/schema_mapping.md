# Schema Mapping

Status: schema verification record. Not an analysis output.

This file records exact public-use/API fields only where they were directly
verified from official Census API metadata or accepted source notes. Fields
that still need exact table/API names remain unresolved and must not be used
as exact variables.

## Access Paths Inspected

| Dataset | Access Path | Result |
| --- | --- | --- |
| Census API catalog | `https://api.census.gov/data.json` | Confirmed endpoints for BDS, BFS, NES, and AIES-NES; did not find SUSB or BTOS API endpoints by catalog search terms used in this pass. |
| NES 2023 variables | `https://api.census.gov/data/2023/nonemp/variables.json` and `.html` | Exact 2023 NES fields previously confirmed. |
| BFS variables | `https://api.census.gov/data/timeseries/eits/bfs/variables.json` | Exact API structural fields confirmed. Metric values are encoded through `data_type_code`/`category_code` and still need value-code mapping. |
| BFS geography | `https://api.census.gov/data/timeseries/eits/bfs/geography.json` | API reports U.S.-level geography only in inspected metadata. |
| BDS variables | `https://api.census.gov/data/timeseries/bds/variables.json` | Exact BDS fields confirmed for firms, establishments, employment, entries/exits, job flows, NAICS, size, age, and geography. |
| BDS geography | `https://api.census.gov/data/timeseries/bds/geography.json` | U.S., state, county, and metro/micro geographies confirmed. |
| BDS groups | `https://api.census.gov/data/timeseries/bds/groups.json` and `.../groups/BDSFAGEFSIZE.json` | Group metadata confirms a firm-age-by-firm-size API group and exact fields available in that group. 2022 U.S. combined query, value-label queries, selected geography checks, and selected NAICS checks are verified; tested non-2022 U.S. all-industry API contexts returned no rows. |
| BDS downloadable sector-age-size CSV | `https://www.census.gov/data/datasets/time-series/econ/bds/bds-datasets.html` and `https://www2.census.gov/programs-surveys/bds/tables/time-series/2023/bds2023_sec_fa_fz.csv` | Official multi-year sector by firm age by firm size CSV path verified. Schema inspection found years 1978-2023, sector/fage/fsize fields, and 104,880 rows excluding header. |
| AIES-NES variables | `https://api.census.gov/data/2023/aiesnonemp/variables.json` | Exact employer/nonemployer revenue comparison fields confirmed. |
| AIES-NES geography | `https://api.census.gov/data/2023/aiesnonemp/geography.json` | U.S.-only geography confirmed in inspected API metadata. |
| SUSB datasets page | `https://www.census.gov/data/datasets/2022/econ/susb/2022-susb.html` | Confirmed 2022 comma-delimited datasets, 2017 NAICS, geographic/industry/enterprise-size tabulation, and record-layout access path. |
| SUSB record layout | `https://www.census.gov/programs-surveys/susb/technical-documentation/record-layouts.html` and `https://www2.census.gov/programs-surveys/susb/technical-documentation/record_layout_us_and_state_2007_to_present.txt` | Exact U.S./state annual dataset fields verified. |
| BTOS data page | `https://www.census.gov/data/experimental-data-products/business-trends-and-outlook-survey.html` | Confirms employer-business coverage, 2017 NAICS sector/state/MSA/subsector tabulations, expanded employment size classes after September 2023, and questionnaire links. |
| BTOS AI questionnaire | `https://www2.census.gov/data/experimental-data-products/business-trends-and-outlook-survey/questionnaire-ai-supplement.pdf` | Confirms AI question wording and question numbers, but not public-use variable names or weights. |
| NAICS reference page | `https://www.census.gov/naics/` and `https://www.census.gov/naics/2022NAICS/2022_NAICS_Structure.xlsx` | Confirms official Census NAICS reference files and a durable 2022 structure file with change indicators. Conservative harmonization rule recorded in `research/data/naics_harmonization_rule.md`; many-to-many allocation remains unimplemented. |

## NAICS Harmonization

Rule file:

- `research/data/naics_harmonization_rule.md`
- `research/data/naics_code_list_qa.md`

Source note:

- `research/source_notes/census_2022_naics_reference_files.md`

Inspected official source:

- Census NAICS page: `https://www.census.gov/naics/`
- Census workbook:
  `https://www.census.gov/naics/2022NAICS/2022_NAICS_Structure.xlsx`

Verified workbook facts:

- Sheet: `2022 NAICS Structure`.
- Header fields: `Change Indicator`, `2022 NAICS Code`,
  `2022 NAICS Title`.
- Change indicators define title-only changes, new 2022 codes, reused codes
  with content changes, and reused codes with lower-level content changes.

Selected rule:

- Preserve native NAICS vintage.
- Default to sector-level stable comparisons for mixed 2017/2022-vintage
  panels.
- Permit finer same-code comparisons only for 2022 codes with blank or `*`
  change indicators and matching same-code availability in the 2017-vintage
  source.
- Treat `**`, `***`, and `****` codes as changed-code cells that require
  exclusion, aggregation to a stable parent, or a later approved
  concordance/allocation rule.
- Do not split receipts, employment, payroll, firms, establishments, or
  formation counts across changed codes in first-pass architecture.

Still unresolved:

- An official many-to-many 2017-to-2022 allocation-weight source has not been
  selected.
- A committed code-list QA table for actual panel rows has not been generated;
  current QA is a readiness record only.

## NES Mapping

Endpoint:

```text
https://api.census.gov/data/2023/nonemp
```

Confirmed exact fields:

| Exact Field | Label | Role |
| --- | --- | --- |
| `YEAR` | Year | Reference year. |
| `NAICS2022` | 2022 NAICS code | Industry code. |
| `NAICS2022_LABEL` | 2022 NAICS label | Industry label. |
| `NESTAB` | Number of establishments | Nonemployer establishment count. |
| `NRCPTOT` | Nonemployer sales, value of shipments, or revenue ($1,000) | Nonemployer receipt field. |
| `NRCPTOT_N` | Noise range for nonemployer sales, value of shipments, or revenue | Nonemployer receipt noise range. |
| `NRCPTOT_N_F` | Attribute flag for `NRCPTOT_N` | Nonemployer receipt noise flag. |
| `RCPSZES` | Sales, value of shipments, or revenue size of establishments code | Receipt-size class. |
| `RCPSZES_LABEL` | Receipt-size class label | Receipt-size label. |
| `LFO` | Legal form of organization code | Legal-form class. |
| `LFO_LABEL` | Legal-form label | Legal-form label. |

Confirmed years/geography:

- Inspected endpoint is 2023 NES.
- API examples and metadata support U.S., state, county, metro/micro, and CSA
  geographies.
- NAICS vintage: 2022.

Ingestion-readiness status:

- Record: `research/data/nes_aies_api_ingestion_readiness.md`.
- `LFO=001` and `RCPSZES=001` verified as `All establishments`.
- U.S. all-class NAICS query returned 452 rows excluding header and zero
  bad-width rows.
- Observed `NRCPTOT_N_F` flag count in that schema-only query: `G` = 452.

Still unresolved:

- State/county/metro pull size and suppression/noise behavior across
  geographies.
- Comparability rules before mixing 2022 NES methodology with prior years.
- Any AI-use, hidden-labor, survival, or nonemployer-to-employer transition
  field.

Compatibility:

- NAICS-year: compatible for nonemployer cells using 2022 NAICS, with
  methodology warning and harmonization rule.
- Geography-NAICS-year: compatible where geography responses are validated.
- Employer/nonemployer comparison cells: nonemployer side only; use AIES-NES
  for national employer/nonemployer revenue comparison.
- Exposure cells: no AI fields.

Guardrail:

- NES no-paid-employee status is not one-human status and does not identify
  Operator Nodes.

## BFS Mapping

Endpoint:

```text
https://api.census.gov/data/timeseries/eits/bfs
```

Confirmed exact fields:

| Exact Field | Label | Role |
| --- | --- | --- |
| `time` | ISO-8601 Date/Time value | Monthly/year time predicate. |
| `data_type_code` | item type | Encodes the specific BFS measure; monthly value-code mapping verified for target codes. |
| `time_slot_id` | Time Slot | Time-slot identifier. |
| `seasonally_adj` | Seasonally adjusted yes or no | Seasonal-adjustment flag. |
| `program_code` | Component Name | Program/component identifier. |
| `category_code` | Industry list | Industry/category code; monthly sector and aggregate code mapping verified. |
| `geo_level_code` | geo level code | Geography level code. |
| `time_slot_date` | Time Slot Date | Human-readable date field. |
| `time_slot_name` | Time Slot Name | Human-readable period label. |
| `cell_value` | data value | Numeric or string value for the requested `data_type_code`. |
| `error_data` | Error data yes or no | Error/quality flag. |

Confirmed years/geography:

- Time variable supports year and month.
- Inspected geography metadata reports U.S.-level geography.

Verified target `data_type_code` mappings:

| Concept | API Code |
| --- | --- |
| Business applications | `BA_BA` |
| High-propensity business applications | `BA_HBA` |
| Business formations within four quarters | `BF_BF4Q` |
| Business formations within eight quarters | `BF_BF8Q` |
| Projected business formations within four quarters | `BF_PBF4Q` |
| Projected business formations within eight quarters | `BF_PBF8Q` |

Additional verified series codes:

- `BA_CBA`
- `BA_WBA`
- `BF_SBF4Q`
- `BF_SBF8Q`
- `BF_DUR4Q`
- `BF_DUR8Q`

Verified `category_code` mapping status:

- Monthly BFS data dictionary maps `TOTAL`, `NAICS11`, `NAICS21`,
  `NAICS22`, `NAICS23`, `NAICSMNF`, `NAICS42`, `NAICSRET`, `NAICSTW`,
  `NAICS51`, `NAICS52`, `NAICS53`, `NAICS54`, `NAICS55`, `NAICS56`,
  `NAICS61`, `NAICS62`, `NAICS71`, `NAICS72`, `NAICS81`, `NAICS92`, and
  `NONAICS` to total, sector, aggregate, and no-NAICS categories.

Example-shape query:

- Official `examples.json` uses `get=data_type_code,time_slot_id,
  seasonally_adj,category_code,cell_value,error_data`, `time=2012`, and
  `for=us:*`.
- A keyed 2012 example-shape query returned 5,544 rows, `time_slot_id=0`, and
  `seasonally_adj` values `no` and `yes`.

Still unresolved:

- Whether non-U.S. geographies are available through other BFS access paths or
  downloads.
- State/region geography exists in monthly CSV documentation, but inspected
  API geography metadata remains U.S.-only.
- First-pass ingestion design still needs explicit rules for sector categories,
  aggregate categories (`NAICSMNF`, `NAICSRET`, `NAICSTW`), `NONAICS`,
  seasonal adjustment, and treatment of duration/spliced series.

Compatibility:

- NAICS-year: possible only at monthly BFS sector/aggregate category level
  after a later ingestion design. It remains blocked for quantitative use in
  this scaffold.
- Geography-NAICS-year: blocked in inspected API metadata because only U.S.
  geography was confirmed.
- Employer/nonemployer comparison cells: no.
- Exposure cells: no AI fields.

Guardrail:

- BFS employer formations remain only an indirect payroll-transition proxy, not
  nonemployer-to-employer conversion evidence.

Implementation scaffold:

- `research/data/bfs_api_ingestion_scaffold.md`
- `research/data/bfs_value_code_mapping.md`
- `research/data/bfs_ingestion_design.md`
- `research/data/bfs_sample_row_load.md`
- `research/data/bfs_metric_definition_scaffold.md`
- `research/data/bfs_metric_computation_design.md`
- `research/data/bfs_source_native_observations.md`
- `research/data/bfs_quality_review_policy.md`
- `bin/rails public_sources:bfs:scaffold`
- `bin/rails public_sources:bfs:verify_ingestion_design`
- `bin/rails public_sources:bfs:load_sample_rows`
- `bin/rails public_sources:bfs:scaffold_metric_definitions`
- `bin/rails public_sources:bfs:verify_metric_computation_design`
- `bin/rails public_sources:bfs:compute_source_native_observations`
- `bin/rails public_sources:bfs:verify_quality_review_policy`
- `bin/rails public_sources:bfs:create_quality_reviews`
- Scaffold registers official API metadata and verified monthly value-code
  mappings only.
- Ingestion design adds the staging schema.
- The V1 sample load stores raw/staged 2012 U.S.-level rows only. It does not
  compute metrics, create observations, create prediction links, export data, or
  authorize analysis.
- The metric-definition scaffold creates draft-disabled BFS `MetricDefinition`
  rows only.
- The metric-computation design allows source-native monthly context
  observations only.
- Source-native observations are not aggregation, trend measurement,
  prediction links, exports, or claim support.
- Quality reviews mark BFS observations as reviewed context only and do not
  authorize prediction links, exports, or claim support.
- The BFS quality-review summary/dashboard is read-only and reports review
  coverage and guardrail counts without writing records.
- The combined source health summary/dashboard is read-only and reports BFS and
  SUSB row, definition, observation, review, policy, link, export, and guardrail
  status without writing records.

## BDS Mapping

Endpoint:

```text
https://api.census.gov/data/timeseries/bds
```

Confirmed exact fields:

| Exact Field | Label | Role |
| --- | --- | --- |
| `time` | ISO-8601 Date/Time value | Year predicate. |
| `YEAR` | Year | Reference year field. |
| `NAICS` | 2017 NAICS Code | Industry code. |
| `FIRM` | Number of firms | Employer-firm count. |
| `ESTAB` | Number of establishments | Employer-establishment count. |
| `EMP` | Number of employees | Employer employment. |
| `ESTABS_ENTRY` | Number of establishments born during the last 12 months | Establishment entry. |
| `ESTABS_EXIT` | Number of establishments exited during the last 12 months | Establishment exit. |
| `FIRMDEATH_FIRMS` | Number of firms that exited during the last 12 months | Firm exit/shutdown proxy. |
| `JOB_CREATION` | Number of jobs created from expanding and opening establishments during the last 12 months | Job creation. |
| `JOB_CREATION_BIRTHS` | Number of jobs created from opening establishments during the last 12 months | Job creation from births. |
| `JOB_DESTRUCTION` | Number of jobs lost from contracting and closing establishments during the last 12 months | Job destruction. |
| `JOB_DESTRUCTION_DEATHS` | Number of jobs lost from closing establishments during the last 12 months | Job destruction from deaths. |
| `NET_JOB_CREATION` | Number of net jobs created from expanding/contracting and opening/closing establishments during the last 12 months | Net job creation. |
| `FAGE` | Firm age code | Firm-age dimension. |
| `EMPSZFI` | Employment size of firms code | Firm-size dimension. |
| `EMPSZES` | Employment size of establishments code | Establishment-size dimension. |
| `GEO_ID` | Geographic identifier code | Geography identifier. |
| `STATE` | State | State code. |
| `COUNTY` | County | County code. |
| `CBSA` | Metropolitan/Micropolitan Statistical Area | Metro/micro geography. |

Attribute labels:

- Several label fields appear as attributes rather than standalone variable
  entries in the inspected JSON, such as `NAICS_LABEL`, `FAGE_LABEL`,
  `EMPSZFI_LABEL`, `EMPSZES_LABEL`, and `NAME`.
- `FAGE_LABEL` and `EMPSZFI_LABEL` were returned successfully in key-first
  2022 U.S. value-label queries recorded in `research/data/bds_value_sets.md`.

Confirmed years/geography:

- API catalog temporal coverage: 1978-2023.
- Geography metadata confirms U.S., state, county, and metropolitan/
  micropolitan statistical area levels.
- `NAICS` is labeled as 2017 NAICS.

Value-set status:

- `FAGE`: 15 code-label rows verified for `time=2022`, `NAICS=00`,
  `EMPSZFI=001`, and `for=us:1`.
- `EMPSZFI`: 14 code-label rows verified for `time=2022`, `NAICS=00`,
  `FAGE=001`, and `for=us:1`.
- Matching 2023 checks returned HTTP 204/no rows, so 2023 coverage remains
  unverified for the tested `BDSFAGEFSIZE` contexts.

Coverage status:

- U.S., state, selected county, and metro/micro geography query forms returned
  JSON for the 2022 all-industry/all-age/all-size context.
- A 2022 U.S. NAICS-label query returned 394 code-label rows.
- Direct 2022 U.S. row-shape checks returned JSON for `NAICS=54` and
  `NAICS=5415`; `NAICS=541511` returned HTTP 204/no rows.
- U.S. all-industry/all-age/all-size checks for 2019, 2020, 2021, and 2023
  returned HTTP 204/no rows.

Downloadable multi-year path:

- Official CSV: `bds2023_sec_fa_fz.csv`.
- Title/link text: Sector by Firm Age by Firm Size.
- Exact fields: `year`, `sector`, `fage`, `fsize`, `firms`, `estabs`, `emp`,
  `denom`, `estabs_entry`, `estabs_entry_rate`, `estabs_exit`,
  `estabs_exit_rate`, `job_creation`, `job_creation_births`,
  `job_creation_continuers`, `job_creation_rate_births`, `job_creation_rate`,
  `job_destruction`, `job_destruction_deaths`,
  `job_destruction_continuers`, `job_destruction_rate_deaths`,
  `job_destruction_rate`, `net_job_creation`, `net_job_creation_rate`,
  `reallocation_rate`, `firmdeath_firms`, `firmdeath_estabs`,
  `firmdeath_emp`.
- Observed year range: 1978-2023.
- Observed sector count: 19.
- Observed firm-age category count: 12.
- Observed firm-size category count: 10.
- Ingestion-readiness record:
  `research/data/bds_ingestion_readiness.md`.
- Official methodology confirms publication flags `D`, `S`, `X`, and `N`;
  these must be preserved before numeric coercion.
- Living dissertation scaffold:
  `research/data/bds_public_file_scaffold.md` records the Rails metadata-only
  scaffold for this public file. The scaffold creates source, access-path,
  manifest, and schema metadata only; it does not fetch BDS rows, create
  metrics, authorize analysis, export data, or change claim status.
- Living dissertation acquisition/parser design:
  `research/data/bds_acquisition_parser_design.md` records disabled V1
  parser guardrails and the acquisition contract. It defines the expected
  ignored raw path, manifest path, checksum/manifest gates, future
  staging-table name, flag handling, and parser prohibitions.
- Living dissertation fetch/validation:
  `research/data/bds_fetch_validation.md` records the implemented raw-file
  validation service and live validation result. It validates the ignored local
  CSV and metadata only; it does not authorize staging, metrics, analysis,
  exports, or claim support.
- Living dissertation staging-table skeleton:
  `research/data/bds_staging_table_skeleton.md` records the empty
  `bds_public_file_rows` table structure. The table exists to support a future
  source-native parser, but currently has no rows and does not support claims.
- Living dissertation parser skeleton:
  `research/data/bds_parser_skeleton.md` records a fixture-only in-memory
  parser that preserves raw cells, numeric cells, and publication flags. It
  persists zero rows and does not support claims.
- Living dissertation parser dry run:
  `research/data/bds_parser_dry_run.md` records a full local-file parser dry
  run over the ignored BDS CSV. The live dry run read 104,880 rows, found zero
  duplicate grain keys, counted publication flags, and persisted zero rows. It
  does not create metrics, quality reviews, prediction links, exports, analysis,
  or claim support.
- Living dissertation row-load QA policy:
  `research/data/bds_row_load_qa_policy.md` defines pre-load QA requirements
  for any future BDS row load, including dry-run reconciliation, hashes, load
  IDs, cleanup/rollback, idempotency, and post-load reconciliation.
- Living dissertation source-row load:
  `research/data/bds_source_row_load.md` records the source-native load of
  104,880 BDS rows into `bds_public_file_rows`. It creates no metric
  definitions, metric observations, quality reviews, prediction links, exports,
  analysis, or claim support.
- Living dissertation metric-definition scaffold:
  `research/data/bds_metric_definition_scaffold.md` records 10 draft-disabled
  BDS source-native metric definitions. It creates no metric observations,
  quality reviews, prediction links, exports, analysis, or claim support.
- Living dissertation metric-computation design:
  `research/data/bds_metric_computation_design.md` records source-native
  eligibility, publication-flag handling, required quality metadata, and
  prohibited computations.
- Living dissertation source-native observations:
  `research/data/bds_source_native_observations.md` records 746,174 BDS
  source-native context observations. They are unreviewed context only and
  create no prediction links, exports, analysis, or claim support.
- Living dissertation quality reviews:
  `research/data/bds_quality_reviews.md` records 746,174 BDS quality reviews
  as reviewed context only. They create no prediction links, exports, analysis,
  or claim support.

Still unresolved:

- Exact firm-startup field distinct from establishment entry; `FIRMDEATH_FIRMS`
  is verified for firm exits, but a direct firm birth/startup variable was not
  identified in the extracted field set.
- Whether sector-level multi-year firm-age-by-size coverage is sufficient for
  the BDS role in the empirical strategy.

Compatibility:

- NAICS-year: compatible for employer-firm dynamics using 2017 NAICS in basic
  BDS. For API `BDSFAGEFSIZE`, tested age/size coverage is 2022-only. The
  downloadable sector-age-size CSV supports multi-year sector-level cells.
- Geography-NAICS-year: compatible in basic BDS metadata at U.S., state,
  county, and metro/micro levels. `BDSFAGEFSIZE` query forms returned JSON for
  2022 U.S., state, selected county, and metro/micro contexts, but multi-year
  subnational age/size coverage remains unverified.
- Employer/nonemployer comparison cells: employer side only.
- Exposure cells: no AI fields.

Guardrail:

- BDS is employer-firm evidence only. It does not measure nonemployers,
  management layers, or AI use.

## SUSB Mapping

Access path:

- Census SUSB program page and accepted source note.
- Census API catalog search found no SUSB endpoint in this pass.

Exact fields verified for the U.S./state annual record layout, 2007-present:

| Exact Field | Label/Description | Role |
| --- | --- | --- |
| `STATE` | Geographic Area Code | U.S./state geography code. |
| `NAICS` | Industry Code, 6-digit NAICS | Establishment industry. |
| `ENTRSIZE` | Enterprise Employment Size Code; enterprise receipt size code in years ending in 2 and 7 | Enterprise size class. |
| `FIRM` | Number of Firms | Employer-firm count. |
| `ESTB` | Number of Establishments | Employer-establishment count. |
| `EMPL` | Employment with Noise | Employer employment. |
| `EMPLFL_R` | Employment range/data suppression flag; no longer used starting with 2018 | Legacy suppression/range flag. |
| `EMPLFL_N` | Employment noise flag | Employment noise/suppression flag. |
| `PAYR` | Annual Payroll ($1,000) with Noise | Annual payroll. |
| `PAYRFL_N` | Annual Payroll Noise Flag | Payroll noise/suppression flag. |
| `RCPT` | Receipts ($1,000) with Noise; years ending in 2 and 7 only | Receipts field for economic-census years. |
| `RCPTFL_N` | Receipts Noise Flag; years ending in 2 and 7 only | Receipts noise/suppression flag. |
| `STATEDSCR` | State Description | Geography label. |
| `NAICSDSCR` | NAICS Industry Description | Industry label. |
| `ENTRSIZEDSCR` | Enterprise Employment Size Description; enterprise receipt size description in years ending in 2 and 7 | Enterprise-size label. |

Confirmed from source note:

- Latest inspected data year: 2022.
- Covers establishments with paid employees.
- Reports by establishment industry and enterprise size.
- Includes number of firms and establishments, employment, and annual payroll.
- Industry classification is based on 2017 NAICS codes in the 2022 SUSB data
  page.
- U.S./state annual datasets are available in comma-delimited format with the
  above record layout; MSA record layouts are separately published.
- Ingestion-readiness record:
  `research/data/susb_ingestion_readiness.md`.
- Observed 2022 U.S./state file has 570,105 rows excluding header, 14 columns,
  zero bad-width rows, and zero duplicate `STATE`/`NAICS`/`ENTRSIZE` keys.
- Observed 2022 noise flags are `G`, `H`, and `J`; official record-layout
  rules also require handling `D` and `S` as withheld cells if observed.
- `EMPLFL_R` is absent from the observed 2022 file, consistent with the
  record-layout note that it is no longer used starting with 2018.

Still unresolved:

- Exact fields for MSA and other non-U.S./state SUSB layouts if those tables
  are used.
- Whether the future analysis should use enterprise-employment-size or
  enterprise-receipt-size tables; receipt-size use is limited to years ending
  in 2 and 7 in the verified layout.
- Whether a year field exists inside each downloadable file; the verified
  record layout does not list one, so year should be carried from file vintage
  unless a year column is verified in a specific extract.

Compatibility:

- NAICS-year: compatible for U.S./state annual employer cells using verified
  `NAICS` and file vintage, with 2017 NAICS.
- Geography-NAICS-year: compatible for U.S./state annual cells using verified
  `STATE`, `NAICS`, and file vintage; other geographies require their own
  record-layout check.
- Employer/nonemployer comparison cells: employer side only.
- Exposure cells: no AI fields.

Guardrail:

- SUSB enterprise size is not hierarchy depth and cannot support TCE-P005.

## AIES-NES Mapping

Endpoint:

```text
https://api.census.gov/data/2023/aiesnonemp
```

Confirmed exact fields:

| Exact Field | Label | Role |
| --- | --- | --- |
| `YEAR` | Year | Reference year. |
| `NAICS2017` | 2017 NAICS code | Industry code. |
| `RCPT_TOT_VAL` | Employer sales, value of shipments, or revenue ($1,000) | Employer revenue comparison field. |
| `RCPT_TOT_VAL_NS` | Nonemployer sales, value of shipments, or revenue ($1,000) | Nonemployer revenue comparison field. |
| `RCPT_TOT_CV` | Coefficient of variation for employer sales, value of shipments, or revenue (%) | Employer estimate precision. |
| `RCPT_TOT_VAL_NS_N` | Noise range for nonemployer sales, value of shipments, or revenue | Nonemployer noise flag/range. |
| `SECTOR` | NAICS economic sector | Sector code. |
| `SUBSECTOR` | SUBSECTOR | Subsector code. |
| `INDGROUP` | Industry group | Industry grouping. |
| `INDLEVEL` | Industry level | Industry detail level. |
| `GEO_ID` | Geographic identifier code | Geography identifier. |
| `NATION` | Nation | U.S. geography. |

Attribute labels:

- `NAICS2017_LABEL` and `NAME` appear in examples/attributes rather than as
  standalone variable entries in the inspected JSON.
- `RCPT_TOT_VAL_NS_N_F` appears as the attribute flag for
  `RCPT_TOT_VAL_NS_N`.

Confirmed years/geography:

- 2023 only in inspected endpoint.
- U.S.-only geography in inspected API metadata.
- NAICS vintage: 2017.

Ingestion-readiness status:

- Record: `research/data/nes_aies_api_ingestion_readiness.md`.
- Cleaner schema-only national query returned 425 rows excluding header and
  zero bad-width rows.
- Observed `RCPT_TOT_VAL_NS_N_F` flag count in that schema-only query:
  `G` = 425.
- Requesting `YEAR` in `get=` while also using `YEAR=2023` as a predicate
  creates a duplicate `YEAR` header; future ingestion should avoid that form
  or explicitly preserve both raw columns before canonical mapping.

Still unresolved:

- Whether additional AIES-NES years become available later.
- Whether non-API downloadable tables include additional geography or
  suppression metadata.

Compatibility:

- NAICS-year: compatible for 2023 national comparison cells using 2017 NAICS.
- Geography-NAICS-year: not compatible in inspected API metadata because only
  U.S. geography is available.
- Employer/nonemployer comparison cells: compatible at national NAICS cells.
- Exposure cells: no AI fields.

Guardrail:

- AIES-NES revenue comparison does not identify AI use, one-human firms, or
  hidden labor.

## BTOS AI Supplement Mapping

Access path:

- Accepted source note and Census AI-use article/questionnaire inspection.
- Census API catalog search found no BTOS endpoint in this pass.

Fields remain concept fields:

- Current AI use.
- Expected AI use.
- Business function where AI is used.
- Operational changes for AI integration.
- Business size class.
- Industry/sector.
- Survey period.

Confirmed from accepted source note:

- Current inspected article covers Dec. 14, 2025-May 3, 2026.
- AI wording changed on Nov. 17, 2025, from use in producing goods/services to
  use in any business function.
- BTOS covers employer businesses.
- BTOS data released after September 2023 cover all employer businesses in the
  United States except farms and are available by 2017 NAICS sector, state, 25
  most populous MSAs, three-digit NAICS subsector, state-sector cells, and
  expanded employment size classes.
- The AI-supplement questionnaire verifies question 23 for current AI use in
  any business function, question 24 for AI use by business function, question
  25 for employee-task substitution/augmentation/new-task categories, question
  28 for employment effect, question 29 for operational changes, question 31
  for employee generative-AI use, question 32 for generative-AI task categories,
  and questions 33-34 for expected AI use.

Still unresolved:

- Exact public-use field names for AI questions; the official questionnaire
  verifies question numbers and wording, not dataset variable names.
- Exact industry/NAICS detail available in data tables.
- Exact geography detail available in data tables.
- Exact survey-period identifiers and weights.

Compatibility:

- NAICS-year: possible only after industry detail and period aggregation are
  verified.
- Geography-NAICS-year: unresolved.
- Employer/nonemployer comparison cells: no, employer businesses only.
- Exposure cells: possible as employer-business AI exposure, not nonemployer
  AI exposure.

Guardrail:

- BTOS AI supplement measures employer-business adoption/exposure, not
  nonemployer outcomes or firm-boundary change.

## Remaining Blockers

- SUSB MSA and other non-U.S./state record layouts, if those geographies are
  used.
- Exact BTOS public-use/API schema and AI question variable names.
- BFS `data_type_code` and `category_code` value-code mapping.
- BDS direct firm-startup field and successful data-query validation for
  combined NAICS, age, size, geography, and year cells.
- Exact NAICS-vintage transformation method for 2017 NAICS versus 2022 NAICS
  comparisons is now conservative sector/stable-code harmonization only; a
  many-to-many allocation source remains unselected.
- Any accepted AI exposure source for nonemployer businesses.
- Any management-layer field source for TCE-P005.
