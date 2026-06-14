# Sector Panel Transformation Design

Status: transformation design only. Not a transformation script, processed
panel, analysis, or empirical result.

Run date: 2026-06-12.

Purpose: define the conservative next-step design for turning validated staging
outputs into future processed sector-level tables, while preserving source
boundaries and blocking empirical calculations until a separate implementation
slice.

## Preconditions

Required completed inputs:

- `research/data/sector_panel_staging_parser.py`
- `research/data/sector_panel_staging_parser_run.md`
- `data/manifests/sector_panel_staging_manifest.csv`
- `research/data/sector_panel_staging_validator.py`
- `research/data/sector_panel_staging_validation.md`

Implementation and run record:

- `research/data/sector_panel_transform.py`
- `research/data/sector_panel_transform_run.md`
- `data/manifests/sector_panel_processed_manifest.csv`

Required command before any future transformation script:

```bash
python3 research/data/sector_panel_staging_validator.py
```

Required output:

```text
staging_manifest_rows=5
staging_outputs_validated=5
staging_rows_validated=94303
analysis_performed=false
```

If validation fails, no processed table should be written.

## Source Staging Tables

| Staging Table | Source Role | Native Grain | NAICS Metadata | Boundary Role |
| --- | --- | --- | --- | --- |
| `stg_nes_sector_2023` | nonemployer outcome source | U.S.-sector-2023 | 2022 NAICS | Nonemployer establishments and receipts only. |
| `stg_aies_nes_sector_2023` | employer/nonemployer revenue comparison source | U.S.-industry-2023 within sector predicates | 2017 NAICS | Employer and nonemployer revenue comparison; no counts. |
| `stg_susb_sector_2022` | employer baseline source | U.S.-sector-2022, `ENTRSIZE=01` | 2017 NAICS | Employer firms, establishments, employment, payroll, receipts baseline. |
| `stg_bds_sector_age_size` | employer dynamics source | U.S.-sector-year-firm-age-firm-size | 2017 sector categories | Employer firm age/size dynamics; no nonemployer transitions. |

## Proposed Future Outputs

The future transformation script may create these ignored or tracked outputs
only after a separate implementation slice approves exact paths and QA.

### `sector_source_index`

Purpose:

- One row per approved canonical sector.
- Record which source staging tables cover each sector and which NAICS vintage
  each source carries.

Allowed fields:

- `canonical_sector`
- `sector_frame_version`
- `nes_2023_available`
- `aies_nes_2023_available`
- `susb_2022_available`
- `bds_sector_age_size_available`
- `nes_naics_vintage`
- `aies_nes_naics_vintage`
- `susb_naics_vintage`
- `bds_sector_category_vintage`
- `join_class`
- `guardrail_notes`

Allowed transformations:

- Presence flags.
- Native metadata carry-forward.
- `join_class=sector_stable` for the 17-sector frame.

Blocked transformations:

- Any outcome comparison, share, ratio, growth rate, ranking, or prediction
  label.

### `sector_boundary_measure_inputs`

Purpose:

- One row per canonical sector carrying source-native outcome fields that could
  later feed TCE-P001, TCE-P009, and TCE-P010 designs.

Allowed fields copied from NES:

- `NESTAB`
- `NRCPTOT`
- `NRCPTOT_N`
- `NRCPTOT_N_F`
- `LFO`
- `RCPSZES`

Allowed fields copied from sector-level AIES-NES rows:

- `RCPT_TOT_VAL`
- `RCPT_TOT_VAL_NS`
- `RCPT_TOT_CV`
- `RCPT_TOT_VAL_NS_N`
- `RCPT_TOT_VAL_NS_N_F`
- `INDLEVEL`
- `NAICS2017`
- `SECTOR__predicate`

Allowed fields copied from SUSB:

- `FIRM`
- `ESTB`
- `EMPL`
- `EMPLFL_N`
- `PAYR`
- `PAYRFL_N`
- `RCPT`
- `RCPTFL_N`
- `ENTRSIZE`

Allowed metadata:

- source row references;
- native years;
- native NAICS vintage;
- `canonical_sector`;
- noise and suppression flags;
- source dataset names.

Required filter:

- AIES-NES must be reduced to sector-level rows only before any sector-level
  join. The future implementation must verify the exact sector-row rule from
  staged fields, likely `INDLEVEL=2` and matching sector predicate/code, before
  writing a processed table.
- The first implementation verified `INDLEVEL=2` with `NAICS2017` equal to
  `canonical_sector`. That rule produced 15 of 17 sector rows, with AIES
  sector-level rows missing for `11` and `81`. These values must remain blank
  and explicitly flagged unless a later source-inspection pass verifies a
  better sector-level AIES mapping.

Blocked transformations:

- `receipts_per_nonemployer_establishment`;
- `nonemployer_receipts_share`;
- `small_employer_payroll_per_employee`;
- high-receipt nonemployer shares;
- inflation adjustment;
- employer/nonemployer comparison calls;
- any high-AI-exposure label.

### `sector_bds_age_size_inputs`

Purpose:

- Preserve BDS employer dynamics at the already validated
  sector-year-firm-age-firm-size grain.

Allowed fields:

- all staged BDS fields copied without aggregation;
- `canonical_sector`;
- `reference_year`;
- `naics_vintage`;
- `source_dataset`;
- `source_row_number`.

Allowed transformations:

- Type-safe field renaming.
- Publication marker preservation.

Blocked transformations:

- collapsing age/size cells;
- deriving startup, shutdown, or job-flow balances beyond fields already
  published by BDS;
- comparing BDS employer dynamics with NES nonemployer outcomes;
- treating establishment entry as firm startup.

## Join Rules

Allowed first-pass join key:

- `canonical_sector`

Allowed join class:

- `sector_stable`

Required source-vintage preservation:

- NES: `2022`.
- AIES-NES: `2017`.
- SUSB: `2017`.
- BDS sector-age-size CSV: `2017 sector categories`.

Cross-vintage rule:

- The future transformation may align sources at the approved 17-sector frame
  only.
- It must not join finer 2017 and 2022 NAICS codes.
- It must not allocate values across changed NAICS cells.
- It must preserve source-native labels and vintages next to any joined row.

## QA Gates For Future Implementation

Before writing any processed table:

- run the staging validator;
- verify the 17-sector frame exactly;
- verify output row count expectations before writing;
- verify AIES sector-row selection rule;
- verify source row references remain traceable to staging files;
- verify no field names imply computed empirical measures unless a later
  analysis design authorizes them;
- verify no `data/processed/` output is created unless the implementation
  slice explicitly allows it.

After writing any future processed table:

- write a tracked manifest row with output path, SHA-256, row count, source
  staging inputs, and `analysis_performed=false`;
- run a no-secret scan;
- run `git diff -- paper/draft.md`;
- run `git diff --check`.

## Prediction Coverage

| Prediction | Design Coverage | Remaining Blocker |
| --- | --- | --- |
| TCE-P001 | Future input table can carry nonemployer receipts/counts and employer baselines by sector. | No AI exposure merge; no derived revenue-per-establishment measure authorized. |
| TCE-P007 | Future BDS input table can preserve employer age/size dynamics. | No nonemployer-to-employer transition identifier; BFS remains outside this sector panel. |
| TCE-P009 | Future input tables can carry nonemployer counts and employer dynamics separately. | No nonemployer survival/churn; no entry/receipt durability calculation authorized. |
| TCE-P010 | Future input table can carry employer and nonemployer revenue/employment baselines. | No AI exposure merge; no corporate-absorption comparison authorized. |
| TCE-P005 | No coverage. | No management-layer, span-of-control, support-staff, or hierarchy-depth fields. |

## Stop Conditions

Stop and record a blocker if:

- staging validation fails;
- AIES sector-level rows cannot be identified unambiguously;
- any staged source loses source-row traceability;
- source vintages cannot be preserved in the future output;
- a proposed transformation requires a ratio, share, growth rate, ranking,
  treatment-effect estimate, prediction result, or claim-status update;
- a proposed transformation requires AI exposure labels before the exposure
  source design is accepted.

## Guardrails

- This design does not authorize quantitative analysis.
- This design does not create a processed panel.
- This design does not merge AI exposure.
- This design does not support firm-boundary findings.
- NES nonemployers are not one-human firms.
- SUSB and BDS remain employer-side sources only.
- AIES-NES provides revenue comparison inputs, not causal AI evidence.
- BDS establishment entry is not firm startup.
- No Operator Node claim is promoted by this design.
