# Sector Panel Build Plan

Status: acquisition and cleaning design only. Not a data extract,
transformation script, processed panel, or analysis.

Run date: 2026-06-12.

Purpose: define the first reproducible build path for the conservative
17-sector all-source overlap identified in `research/data/naics_code_list_qa.md`.
This plan converts the existing data architecture into execution gates. It does
not download new data, compute outcomes, estimate effects, or evaluate any
prediction.

Companion query/file inventory:

- `research/data/sector_panel_query_inventory.md`
- `data/manifests/sector_panel_query_inventory.csv`

Dry-run validator:

- `research/data/sector_panel_dry_run_validator.py`

Smoke-test record:

- `research/data/sector_panel_api_fetch_smoke_test.md`

Full API validation record:

- `research/data/sector_panel_api_full_fetch_validation.md`
- `data/manifests/sector_panel_api_payload_manifest.csv`

Staging parser design:

- `research/data/sector_panel_staging_parser_design.md`
- `data/manifests/sector_panel_staging_manifest_template.csv`

Staging parser implementation:

- `research/data/sector_panel_staging_parser.py`
- `research/data/sector_panel_staging_parser_run.md`
- `data/manifests/sector_panel_staging_manifest.csv`

Staging validation:

- `research/data/sector_panel_staging_validator.py`
- `research/data/sector_panel_staging_validation.md`

Transformation design:

- `research/data/sector_panel_transformation_design.md`

Transformation implementation:

- `research/data/sector_panel_transform.py`
- `research/data/sector_panel_transform_run.md`
- `data/manifests/sector_panel_processed_manifest.csv`

Analysis design:

- `research/data/sector_panel_analysis_design.md`

Analysis dry-run validation:

- `research/data/sector_panel_analysis_dry_run_validator.py`
- `research/data/sector_panel_analysis_dry_run_validation.md`

Descriptive analysis implementation:

- `research/data/sector_panel_descriptive_analysis.py`
- `research/data/sector_panel_descriptive_analysis_run.md`
- `data/manifests/sector_panel_analysis_manifest.csv`

## Scope

Target panel role:

- Business-boundary measurement architecture for TCE-P001, TCE-P007, TCE-P009,
  and TCE-P010.
- Sector-level mixed-vintage comparison only.
- No AI-exposure merge until a separate exposure-source design is accepted.

Out of scope:

- Fine-code NAICS panels.
- State, county, metro, or geography-sector panels.
- BFS industry panels.
- BTOS public-use extraction.
- Occupational-exposure construction.
- Quantitative results, ratios, growth rates, rankings, treatment effects, or
  support/contradiction calls.

## Canonical Sector Frame

Use the all-source overlap from `research/data/naics_code_list_qa.md`:

```text
11;21;22;23;31-33;42;44-45;48-49;51;52;53;54;56;62;71;72;81
```

Excluded from the first-pass all-source frame:

- `55`: absent from inspected NES and AIES-NES code lists.
- `61`: absent from inspected AIES-NES code list.

Sector-frame rules:

- Store the frame as an explicit ordered code list before any pull or parse.
- Preserve sector labels from each native source; do not overwrite source
  labels with a handcrafted common label during raw parsing.
- Carry a `canonical_sector` field only after verifying a source row maps
  exactly to one of the 17 approved sector codes.
- Keep excluded sectors in native-source QA logs if present, but do not include
  them in the first all-source comparison frame.

## Source Inputs

| Source | Status | Planned Role | First-Pass Unit |
| --- | --- | --- | --- |
| NES 2023 API | ingestion readiness verified | Nonemployer establishment and receipt outcomes | U.S.-sector-2023 |
| AIES-NES 2023 API | ingestion readiness verified | National employer/nonemployer revenue comparison | U.S.-sector-2023 |
| SUSB 2022 U.S./state file | raw file downloaded and manifested local-only | Employer firm, establishment, employment, payroll, and receipts baseline | U.S.-sector-2022, `ENTRSIZE=01` |
| BDS sector-age-size CSV | raw file downloaded and manifested local-only | Employer-firm age/size dynamics by sector | U.S.-sector-year-age-size |
| BDS basic API | row-smoke verified | Optional employer-firm sector-year validation path | U.S.-sector-year |
| BFS | blocked | No first-pass industry panel use | none |
| BTOS AI supplement | extract blocked | Exposure context only until extract schema is verified | none |
| Bonney et al. 2026 | source-truth context | Employer AI diffusion context, not a panel extract | none |

## Acquisition Order

1. Create a tracked query inventory before any new pull. Current inventory:
   `research/data/sector_panel_query_inventory.md` and
   `data/manifests/sector_panel_query_inventory.csv`.
2. Run the local-only dry-run validator before any API fetch:
   `python3 research/data/sector_panel_dry_run_validator.py`.
3. Use `research/data/sector_panel_api_fetch_smoke_test.md` for the targeted
   API fetch smoke test.
4. Use `research/data/sector_panel_api_full_fetch_validation.md` and
   `data/manifests/sector_panel_api_payload_manifest.csv` for completed full
   API payload validation.
5. Pull only schema-ready public inputs:
   NES 2023, AIES-NES 2023, already-manifested SUSB 2022, and
   already-manifested BDS sector-age-size CSV.
6. Keep downloaded API payloads and raw files under ignored `data/raw/`.
7. Record each query or file in `data/manifests/` before or during acquisition.
8. Use `research/data/sector_panel_staging_parser_design.md` for the staging
   parser contract.
9. Use `research/data/sector_panel_staging_parser.py` and
   `research/data/sector_panel_staging_parser_run.md` for the first parser run
   into ignored `data/intermediate/`.
10. Use `research/data/sector_panel_staging_validator.py` and
   `research/data/sector_panel_staging_validation.md` to validate staged
   output contracts, hashes, sector coverage, and guardrails before any
   transformation design.
11. Use `research/data/sector_panel_transformation_design.md` as the current
   conservative design for future processed sector-level inputs. It permits
   source-field carry-forward and QA design only, not implementation or
   analysis.
12. Use `research/data/sector_panel_transform.py` and
   `research/data/sector_panel_transform_run.md` for the first conservative
   processed-input build. This writes ignored `data/processed/sector_panel/`
   files and a tracked processed manifest with `analysis_performed=false`.
13. Use `research/data/sector_panel_analysis_design.md` as the current design
   for permitted future descriptive measures, validation gates, and stop
   conditions.
14. Use `research/data/sector_panel_analysis_dry_run_validator.py` and
   `research/data/sector_panel_analysis_dry_run_validation.md` to check
   processed-input hashes, denominator availability, missing AIES cells, and
   manifest shape before descriptive calculations.
15. Use `research/data/sector_panel_descriptive_analysis.py` and
   `research/data/sector_panel_descriptive_analysis_run.md` for the first
   descriptive baseline calculations. This writes ignored
   `data/analysis/sector_panel/` output and a tracked analysis manifest with
   `claim_support_updated=false`.
16. Do not update claim support from processed inputs until a separate
   claim-evaluation slice is approved.

No step in this order authorizes analysis.

## Query And File Inventory Requirements

Each future query/file inventory row must include:

- Dataset name.
- Source URL or API endpoint.
- Retrieval date/time and timezone.
- Full query path with API key redacted.
- Raw file path under `data/raw/`.
- Manifest path.
- Expected fields.
- Reference year or year range.
- NAICS vintage.
- Geography predicate.
- Sector predicate or sector-frame version.
- Noise, suppression, or coefficient-of-variation fields.
- Source-note or data-architecture reference.
- Guardrail note.

The Census API key must be loaded from ignored `.env.local` at command runtime
and must not be printed, logged, stored in manifests, or committed.

## Staging Tables

### `stg_nes_sector_2023`

Raw source:

- NES 2023 API.

Required fields:

- `NAICS2022`
- `NAICS2022_LABEL`
- `NESTAB`
- `NRCPTOT`
- `NRCPTOT_N`
- `NRCPTOT_N_F`
- appended `LFO`
- appended `RCPSZES`
- appended `us`

Required predicates:

- `LFO=001`
- `RCPSZES=001`
- `for=us:1`
- `NAICS2022` restricted to the 17-sector frame.

Cleaning rules:

- Preserve all raw fields before numeric coercion.
- Add `year=2023` from endpoint vintage.
- Add `naics_vintage=2022`.
- Add `source_dataset=NES`.
- Map `NAICS2022` to `canonical_sector` only for exact 17-sector matches.
- Do not derive receipts per establishment during staging.

### `stg_aies_nes_sector_2023`

Raw source:

- AIES-NES 2023 API.

Required fields:

- `NAICS2017`
- `NAICS2017_LABEL`
- `GEO_ID`
- `RCPT_TOT_VAL`
- `RCPT_TOT_VAL_NS`
- `RCPT_TOT_CV`
- `RCPT_TOT_VAL_NS_N`
- `RCPT_TOT_VAL_NS_N_F`
- `INDLEVEL`
- `SECTOR`
- `SUBSECTOR`
- `INDGROUP`
- appended `YEAR`
- appended `us`

Required predicates:

- `YEAR=2023`
- `for=us:1`
- `SECTOR` restricted to the 17-sector frame, using AIES sector predicates
  `31`, `44`, and `48` for canonical range sectors `31-33`, `44-45`, and
  `48-49`.

Cleaning rules:

- Use the cleaner query form that avoids requesting `YEAR` in `get=` when it is
  already a predicate.
- Preserve employer and nonemployer revenue fields separately.
- Add `naics_vintage=2017`.
- Add `source_dataset=AIES_NES`.
- Map `SECTOR` to `canonical_sector`, with explicit range-sector mappings for
  `31` to `31-33`, `44` to `44-45`, and `48` to `48-49`.
- Do not compute employer/nonemployer shares during staging.

### `stg_susb_sector_2022`

Raw source:

- `data/raw/susb/2022/us_state_6digitnaics_2022.txt`

Required fields:

- `STATE`
- `NAICS`
- `ENTRSIZE`
- `FIRM`
- `ESTB`
- `EMPL`
- `EMPLFL_N`
- `PAYR`
- `PAYRFL_N`
- `RCPT`
- `RCPTFL_N`
- `STATEDSCR`
- `NAICSDSCR`
- `ENTRSIZEDSCR`

Required filters:

- `STATE=00`.
- `ENTRSIZE=01`.
- `NAICS` restricted to the 17-sector frame.

Cleaning rules:

- Verify SHA-256 against `data/manifests/susb_2022_manifest.csv`.
- Preserve `EMPLFL_N`, `PAYRFL_N`, and `RCPTFL_N` before numeric coercion.
- Treat `D` or `S` flags as withheld publication cells if observed.
- Add `year=2022` from file vintage.
- Add `naics_vintage=2017`.
- Add `source_dataset=SUSB`.
- Map `NAICS` to `canonical_sector` only for exact 17-sector matches.
- Do not aggregate across enterprise-size classes; first-pass uses only
  `ENTRSIZE=01`.

### `stg_bds_sector_age_size`

Raw source:

- `data/raw/bds/2023/bds2023_sec_fa_fz.csv`

Required fields:

- `year`
- `sector`
- `fage`
- `fsize`
- employer-firm and employer-dynamics measures present in the official CSV
  header.

Required filters:

- `sector` restricted to the 17-sector frame.

Cleaning rules:

- Verify SHA-256 against `data/manifests/bds_2023_manifest.csv`.
- Preserve `fage` and `fsize` as coded categorical fields.
- Add `naics_vintage=2017`.
- Add `source_dataset=BDS_SECTOR_AGE_SIZE`.
- Map `sector` to `canonical_sector` only for exact 17-sector matches.
- Do not collapse age/size cells or compute startup, shutdown, or job-flow
  rates during staging.

## Join Keys And Grain

Allowed first-pass keys:

- `canonical_sector`
- `source_dataset`
- `year`
- source-specific categorical keys, such as `fage`, `fsize`, or `ENTRSIZE`,
  where applicable.

Allowed first-pass comparison grains:

- Native source sector-year staging tables.
- A conservative all-source sector frame table.
- Source-specific sector-year QA summaries that count rows and flags only.

Blocked grains:

- Six-digit or fine-code mixed-vintage NAICS panels.
- Geography-sector panels.
- Employer/nonemployer joined panels that compute shares.
- AI-exposure-by-sector panels.

## Minimum QA Gates

Every future acquisition or parse must pass these checks before any processed
panel is created:

- Raw input exists only under ignored `data/raw/`.
- Manifest exists and redacts any API key.
- Header exactly matches the expected field list or produces a documented
  blocker.
- Row widths match the header.
- Duplicate primary keys are counted at the intended staging grain.
- Sector codes are limited to the 17-sector frame after filtering.
- Excluded sector rows, if present, are counted but not mixed into the
  all-source frame.
- Noise, suppression, and coefficient-of-variation fields are preserved.
- NAICS vintage is recorded.
- Source role is recorded as outcome, employer baseline, or context.
- No ratios, growth rates, shares, rankings, or prediction outcomes are
  computed.
- Staging validation passes before any processed panel or transformation script
  is drafted.
- Processed-input manifests must preserve `analysis_performed=false` until an
  explicit analysis slice is approved.

## Stop Conditions

Stop the build and update the reading queue or blocker record if any of these
occur:

- NES or AIES-NES API responses return HTML, key errors, empty bodies, or
  unexpected duplicate fields that cannot be handled losslessly.
- A requested sector code is missing from a source that should cover the
  17-sector frame.
- SUSB or BDS local raw file checksum does not match the manifest.
- Noise or suppression flags appear with undocumented values.
- A source exposes only a finer or coarser NAICS grain than the planned sector
  frame.
- A proposed join would require allocating values across changed 2017/2022
  NAICS codes.

## Prediction Coverage

| Prediction | Architecture Status After This Plan | Remaining Blocker |
| --- | --- | --- |
| TCE-P001 | Sector-level nonemployer and employer-baseline staging design exists | AI exposure linkage, durability, and confounder control remain missing |
| TCE-P007 | Employer-side formation/startup proxy staging design partially exists through BDS; BFS remains blocked | No nonemployer-to-employer transition identifier |
| TCE-P009 | Entry/count and employer-dynamics staging design exists | No direct nonemployer survival/churn or AI linkage |
| TCE-P010 | Employer-baseline staging design exists | No accepted AI-exposure merge and no firm-boundary finding |
| TCE-P005 | Blocked | No management-layer, span-of-control, or hierarchy-depth fields |

## Guardrails

- This plan does not authorize quantitative analysis.
- This plan does not create a processed panel.
- Sector overlap is not economic evidence.
- NES nonemployers are not one-human firms.
- SUSB and BDS are employer-side sources only.
- AIES-NES provides national employer/nonemployer revenue comparison fields,
  not causal AI evidence.
- BFS employer formations remain only an indirect payroll-transition proxy and
  are not included in this first-pass sector panel.
- BTOS and Bonney evidence remain AI-adoption context until a separate
  exposure-merge design is accepted.
- No Operator Node claim is promoted by this plan.
