# BDS Metric Computation Design

Status: computation design implemented and used for source-native BDS
observations. Not quality review, export, prediction-link creation, analysis,
claim support, or paper prose.

Date: 2026-06-14.

## Purpose

Define the rules that must be satisfied before BDS source-native observations
can be computed from `bds_public_file_rows`.

The source-native observation computation is recorded in
`research/data/bds_source_native_observations.md`.

## Policy Source

Canonical values live in:

- `living_dissertation_app/config/living_dissertation_policy.yml`
  under
  `public_ingestion_v1.bds_sector_age_size_public_file.parser_design_v1.metric_computation_design_v1`.

Executable check:

```sh
bin/rails public_sources:bds:verify_metric_design
```

## Eligible Metric Keys

The design covers only the draft-disabled definitions in
`research/data/bds_metric_definition_scaffold.md`:

- `bds_firms`
- `bds_establishments`
- `bds_employment`
- `bds_establishment_entries`
- `bds_establishment_exits`
- `bds_firm_deaths`
- `bds_job_creation`
- `bds_job_destruction`
- `bds_net_job_creation`
- `bds_reallocation_rate`

## Source Value Rules

| Source value condition | Status |
| --- | --- |
| numeric source cell | `staged_context_candidate` |
| publication flag `D` | `blocked_fewer_than_three_firms` |
| publication flag `S` | `quality_review_required_before_use` |
| publication flag `X` | `blocked_structural_missing_or_zero` |
| publication flag `N` | `blocked_rate_cannot_be_calculated` |
| null numeric value | `blocked_publication_flag_or_missing` |
| missing source row | `blocked_missing_source_row` |

## Required Quality Metadata

Any future observation must carry:

- source table;
- source row ID and row hash;
- metric key;
- source grain;
- source year, sector, firm-age, and firm-size codes;
- raw source cell value;
- source publication flag;
- metric status reason;
- claim-status effect;
- false guardrail flags for ratios, trends, aggregation, exports, prediction
  links, and claim support;
- guardrail text.

## Prohibited Computation

The design prohibits:

- ratios;
- trends;
- aggregation;
- NAICS crosswalk;
- productivity measures;
- AI or Operator Node interpretation;
- nonemployer conversion;
- management-layer inference;
- transaction-cost inference;
- firm-boundary conclusions;
- claim support;
- exports;
- prediction links.

## Boundary

BDS remains employer-firm dynamics context only. This design does not measure AI
adoption, nonemployers, hidden contractors, management layers, transaction
costs, Operator Nodes, one-person firms, or firm-boundary change.

## Next Gate

The next slice can define BDS quality-review policy and review-state storage.
Until that review gate exists, BDS observations remain unreviewed context only.
