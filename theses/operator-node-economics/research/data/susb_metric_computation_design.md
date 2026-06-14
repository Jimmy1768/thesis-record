# SUSB Metric Computation Design

Status: computation-design scaffold. Not metric computation, observation
creation, analysis, claim support, paper prose, or thesis evidence.

Run date: 2026-06-12.

## Canonical Defaults

V1 defaults are controlled by:

- `living_dissertation_app/config/living_dissertation_policy.yml`

Policy section:

- `public_ingestion_v1.susb_us_state_annual.metric_computation_design_v1`

## V1 Defaults

Eligible first-pass rows:

- `ENTRSIZE=01` only.

Reason:

- SUSB enterprise-size rows include overlapping buckets such as `<5`, `<20`,
  and `<500`. Using `01: Total` first avoids accidental double-counting.

Metric grain:

- `source_native_context`

Dimensions:

- `year`
- `state_code`
- `naics_code`

Allowed first metric keys:

- `susb_employer_firm_count`
- `susb_employer_establishment_count`
- `susb_employment`
- `susb_annual_payroll_thousand`
- `susb_receipts_thousand_economic_census_year`

Allowed statuses:

- `staged_context`
- `quality_review_required`
- `blocked_noise_or_suppression`

Noise rules:

| Flag | V1 Status |
| --- | --- |
| `G` | `staged_context` |
| `H` | `staged_context` |
| `J` | `quality_review_required` |
| `D` | `blocked_noise_or_suppression` |
| `S` | `blocked_noise_or_suppression` |

Evidence class:

- `employer_side_context_only`

Claim-status effect:

- `unchanged`

## Prohibited In This Design Phase

- ratios;
- trends;
- aggregation;
- productivity measures;
- AI or node interpretation;
- claim support;
- exports.

## Rails Task

```sh
bin/rails public_sources:susb:verify_metric_design
```

The task verifies that the centralized policy still blocks over-interpretation
before a future computation slice is allowed.

The underlying checker can be run with a stricter `require_no_observations`
option in tests, but the Rails task does not fail merely because later guarded
context observations exist.

## Boundary

SUSB remains employer-side public context only. It still does not measure AI
adoption, nonemployers, one-human firms, management layers, transaction costs,
remote work, or Operator Nodes.

2I may compute observations only if it preserves this design and does not
convert SUSB context into claim support.

2I context-observation implementation is documented in:

- `research/data/susb_context_observations.md`

Quality review policy for stored context observations is documented in:

- `research/data/susb_quality_review_policy.md`
