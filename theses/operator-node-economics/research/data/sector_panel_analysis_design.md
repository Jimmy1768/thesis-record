# Sector Panel Analysis Design

Status: analysis design only. Not an analysis script, results file, claim
update, or paper prose.

Run date: 2026-06-12.

Purpose: define the limited descriptive measures that a future analysis script
may calculate from the conservative sector-panel processed inputs, along with
validation gates and interpretation limits.

## Preconditions

Required completed inputs:

- `research/data/sector_panel_staging_validator.py`
- `research/data/sector_panel_transform.py`
- `research/data/sector_panel_transform_run.md`
- `data/manifests/sector_panel_processed_manifest.csv`
- `research/data/sector_panel_analysis_dry_run_validator.py`
- `research/data/sector_panel_analysis_dry_run_validation.md`

Required commands before any future analysis script:

```bash
python3 research/data/sector_panel_staging_validator.py
python3 research/data/sector_panel_transform.py
```

Required transform output:

```text
processed_tables_written=3
processed_manifest_rows=3
analysis_performed=false
missing_aies_sector_rows=11;81
```

If either command fails, no analysis table should be written.

Required dry-run validation before any future descriptive calculation:

```bash
python3 research/data/sector_panel_analysis_dry_run_validator.py
```

Required output:

```text
analysis_dry_run_validated=true
calculations_performed=false
claim_support_updated=false
```

Implementation and run record:

- `research/data/sector_panel_descriptive_analysis.py`
- `research/data/sector_panel_descriptive_analysis_run.md`
- `data/manifests/sector_panel_analysis_manifest.csv`

## Input Tables

| Input | Role | Current Grain | Limits |
| --- | --- | --- | --- |
| `sector_source_index` | source coverage and NAICS-vintage metadata | canonical sector | QA only; no outcomes. |
| `sector_boundary_measure_inputs` | NES, AIES-NES, and SUSB source-native fields | canonical sector | One-year mixed-source snapshot; AIES sector rows missing for `11` and `81`. |
| `sector_bds_age_size_inputs` | BDS source-native employer dynamics | sector-year-firm-age-firm-size | Employer-side only; no nonemployer transition identifier. |

## Measure Families Permitted Later

These measures may be specified for a future analysis script. They are not
calculated in this design file.

### Nonemployer Descriptive Inputs

Source:

- `sector_boundary_measure_inputs`

Permitted measures:

- `nes_receipts_per_establishment`: `nes_NRCPTOT / nes_NESTAB`.

Required checks:

- `nes_NESTAB` is numeric and greater than zero.
- `nes_NRCPTOT_N` and `nes_NRCPTOT_N_F` are preserved next to the measure.
- Units are recorded as receipts in thousands of dollars per nonemployer
  establishment.

Interpretation limit:

- This is not revenue per human, income, profit, productivity, AI use, or proof
  of one-human operation.

Relevant predictions:

- TCE-P001.
- TCE-P009.
- TCE-P010.

### Employer/Nonemployer Revenue Share Inputs

Source:

- `sector_boundary_measure_inputs`

Permitted measures:

- `aies_nonemployer_revenue_share`:
  `aies_RCPT_TOT_VAL_NS / (aies_RCPT_TOT_VAL + aies_RCPT_TOT_VAL_NS)`.

Required checks:

- `aies_sector_row_available=true`.
- Sectors `11` and `81` are excluded from this measure or retained with a
  missing-value flag.
- AIES coefficient-of-variation and nonemployer noise fields are preserved next
  to the measure.
- Denominator is numeric and greater than zero.

Interpretation limit:

- This is a one-year national employer/nonemployer revenue comparison input.
  It is not causal AI evidence and not evidence of firm-boundary change by
  itself.

Relevant predictions:

- TCE-P001.
- TCE-P010.

### Employer Baseline Inputs

Source:

- `sector_boundary_measure_inputs`

Permitted measures:

- `susb_payroll_per_employee`: `susb_PAYR / susb_EMPL`.
- `susb_employment_per_firm`: `susb_EMPL / susb_FIRM`.
- `susb_establishments_per_firm`: `susb_ESTB / susb_FIRM`.

Required checks:

- denominators are numeric and greater than zero;
- `susb_EMPLFL_N`, `susb_PAYRFL_N`, and `susb_RCPTFL_N` are preserved;
- units are recorded as payroll in thousands of dollars per employee where
  payroll is used.

Interpretation limit:

- These are employer-side baselines only. They do not measure nonemployers,
  hierarchy depth, management layers, or AI effects.

Relevant predictions:

- TCE-P001.
- TCE-P010.

### BDS Employer Dynamics Inputs

Source:

- `sector_bds_age_size_inputs`

Permitted carry-forward:

- BDS-published rate fields already present in the source file.
- BDS source-native counts by sector, year, firm age, and firm size.

Future derived measures require a separate design if they collapse firm-age or
firm-size cells.

Required checks:

- publication markers such as `D`, `X`, and `N` are preserved;
- `fage` and `fsize` remain coded categories;
- no row is treated as a nonemployer transition.

Interpretation limit:

- BDS is employer-side only. Establishment entry is not firm startup, and BDS
  does not observe nonemployer-to-employer conversion.

Relevant predictions:

- TCE-P007.
- TCE-P009.
- TCE-P010.

## Measures Still Blocked

The current processed inputs do not authorize:

- high-AI-exposure sector labels;
- treatment/control assignment;
- pre/post generative-AI comparisons;
- growth rates;
- inflation adjustment;
- concentration ratios;
- high-receipt nonemployer shares;
- nonemployer survival or churn;
- nonemployer-to-employer transition rates;
- employer-to-vendor substitution;
- management-layer or span-of-control measures;
- claim-support or contradiction status updates.

## Required Analysis Output Guardrails

Any future analysis script must:

- write outputs under ignored `data/analysis/` or another approved ignored
  directory;
- write a tracked manifest with row counts, SHA-256 hashes, source inputs,
  calculation list, and `claim_support_updated=false`;
- preserve source rows, flags, units, and missing-value reasons;
- keep sectors `11` and `81` flagged for AIES-sector-row absence;
- include denominator checks for every ratio;
- include a no-secret scan;
- run `git diff -- paper/draft.md`;
- run `git diff --check`;
- avoid ranking sectors unless a later design explains why ranking is needed.

## Interpretation Rules

Descriptive measures from the current processed inputs can support only:

- measurement readiness;
- baseline descriptive summaries;
- identification of missing cells;
- criticism-aware design of future AI-exposure tests.

They cannot support:

- the Operator Node hypothesis;
- AI-enabled one-human firm claims;
- causal AI effects;
- durable firm-boundary shifts;
- transaction-cost reduction claims;
- management-layer thinning claims.

Claim status may change only after a later analysis has:

- verified AI exposure or adoption at the same or defensibly linked unit;
- defined comparison groups and timeframes;
- handled AIES missing sectors and NAICS-vintage limits;
- addressed the confounders listed in `research/empirical_strategy.md`;
- documented failure conditions before looking at directional results.

## Prediction Mapping

| Prediction | Permitted Later Descriptive Inputs | Current Interpretation Limit |
| --- | --- | --- |
| TCE-P001 | NES receipts per establishment; AIES nonemployer revenue share where available; SUSB employer baselines. | No AI exposure linkage and no revenue-per-human evidence. |
| TCE-P007 | BDS employer age/size dynamics as employer-side context. | No nonemployer-to-employer transition identifier. |
| TCE-P009 | NES receipts per establishment and BDS employer dynamics as separate inputs. | No nonemployer survival/churn or AI linkage. |
| TCE-P010 | AIES employer/nonemployer revenue share where available; SUSB and BDS employer baselines. | No concentration, AI exposure, or causal corporate-absorption evidence. |
| TCE-P005 | none. | No management-layer fields. |

## Stop Conditions

Stop and record a blocker if:

- staging validation or transform rerun fails;
- processed manifest hashes do not match ignored processed outputs;
- a denominator is zero, blank, nonnumeric, or suppressed without a handling
  rule;
- AIES sectors `11` or `81` are accidentally included in AIES-based ratios;
- a calculation requires AI exposure before an exposure-source design exists;
- a calculation would change claim support;
- an output would be used as paper prose rather than research evidence.

## Next Slice

The next Research slice should design an AI-exposure linkage path before any
sector-panel interpretation. Without a verified exposure source and comparison
groups, the descriptive measures cannot support prediction outcomes or claim
status changes.
