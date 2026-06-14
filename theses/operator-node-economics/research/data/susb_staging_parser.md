# SUSB Staging Parser

Status: staging-parser scaffold. Not metric computation, analysis, claim
support, paper prose, or thesis evidence.

Run date: 2026-06-12.

## Purpose

Load the validated SUSB U.S./state annual public file into source-native Rails
staging rows while preserving the Census row grain, labels, and noise flags.

## Table

Rails table:

- `susb_public_file_rows`

Unique row grain:

- `data_source_id`
- `year`
- `state_code`
- `naics_code`
- `enterprise_size_code`

Source links:

- `data_source_id`
- `intake_manifest_id`
- `schema_version_id`

Preserved source fields:

- `STATE` -> `state_code`
- `NAICS` -> `naics_code`
- `ENTRSIZE` -> `enterprise_size_code`
- `FIRM` -> `firm_count`
- `ESTB` -> `establishment_count`
- `EMPL` -> `employment`
- `EMPLFL_N` -> `employment_noise_flag`
- `PAYR` -> `annual_payroll_thousand`
- `PAYRFL_N` -> `payroll_noise_flag`
- `RCPT` -> `receipts_thousand`
- `RCPTFL_N` -> `receipts_noise_flag`
- `STATEDSCR` -> `state_name`
- `NAICSDSCR` -> `naics_description`
- `ENTRSIZEDSCR` -> `enterprise_size_description`

## Rails Task

```sh
bin/rails public_sources:susb:load_staging
```

The task:

- validates/reconciles the raw public file first;
- reads source text as ISO-8859-1 and transcodes to UTF-8;
- captures flags before numeric coercion;
- upserts rows at source-native grain;
- records row hashes;
- updates intake-manifest metadata;
- writes an audit event;
- creates no `MetricObservation` rows;
- creates no quality flags in this phase;
- computes no ratios, aggregates, panels, trends, or claim links.

## Guardrails

The staging table is source-native storage only. It is not evidence by itself.

SUSB remains employer-side public context only and still does not measure:

- AI adoption;
- nonemployers;
- one-person firms;
- management layers or hierarchy depth;
- transaction costs;
- remote employment substitution.

Analytic use requires a later metric-computation design, source-quality review,
export review, and human claim-review gate.

Metric-computation design is recorded in:

- `research/data/susb_metric_computation_design.md`
