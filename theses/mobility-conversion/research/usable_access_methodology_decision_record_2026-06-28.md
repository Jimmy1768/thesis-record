# Usable Access Methodology Decision Record

Date: 2026-06-28

Status: formation-stage decision record. This does not approve final metrics,
weights, scores, rankings, or comparative conclusions.

## Decision

Usable access should be developed as a broad multi-dimensional outcome
framework with explicit missingness, not as a narrow comparable-score framework.

The first formation-stage outcome framework should keep all seven candidate
dimensions:

1. access to opportunities;
2. network coverage and service availability;
3. travel time and reliability;
4. transportation safety;
5. affordability;
6. walking, cycling, and universal access;
7. asset condition and resilience.

No dimension is approved as a final metric yet.

## Rationale

The thesis asks how Metropolitan Transport Regions convert resources,
constraints, governance, urban form, and growth conditions into usable access.

A narrow globally comparable metric set would be easier to compute, but it
would likely over-reward regions with clean data and undercount important access
failures such as informal transport invisibility, disability barriers, gendered
safety constraints, affordability burdens, pedestrian exposure, and deferred
asset risk.

The honest formation-stage position is:

```text
Start broad, preserve missingness, and only narrow after source standards and
failure rules are explicit.
```

## What This Means

The usable-access outcome should:

- remain multi-dimensional;
- avoid a single composite score during candidate formation;
- preserve dimension-level uncertainty;
- separate outcome dimensions from explanatory axes;
- allow missingness to be visible instead of silently dropping hard-to-measure
  access barriers;
- require every proposed metric to map to an MTR boundary or documented
  approximation.

## What This Does Not Mean

This does not mean:

- all seven dimensions will be equally measurable;
- all seven dimensions will enter a future score;
- missing data is acceptable without flags;
- narrative evidence can replace traceable sources;
- every MTR must have complete data before boundary admission;
- weak data should be treated as weak performance;
- strong data availability should be treated as strong performance.

## Outcome Evidence Tiers

Formation-stage evidence should use tiers.

### Tier 1: Core Access Dimensions

These dimensions are central to the outcome and should be prioritized for
source verification:

- access to opportunities;
- network coverage and service availability;
- travel time and reliability;
- transportation safety;
- affordability.

### Tier 2: Access Completeness Dimensions

These dimensions are essential for avoiding a narrow commuter/transit/system
legibility frame, but source comparability may be weaker:

- walking, cycling, and universal access;
- asset condition and resilience.

Tier 2 does not mean optional. It means the project should expect more
source-friction and record missingness carefully.

## Required Metric Gate

No proposed usable-access metric may be accepted unless it records:

- outcome dimension;
- metric definition;
- source authority;
- source URL or access path;
- source vintage;
- geographic unit;
- compatibility with MTR boundary;
- whether a crosswalk or approximation is required;
- population or trip denominator;
- distributional treatment;
- mode coverage;
- temporal coverage;
- known exclusions;
- missingness status;
- comparability class;
- rejection risk.

## Comparability Classes

Candidate comparability classes:

- `directly_comparable_on_mtr_boundary`
- `comparable_with_documented_crosswalk`
- `within_region_only`
- `source_family_comparable_only`
- `not_comparable_but_contextual`
- `not_usable`

## Missingness Classes

Use missingness classes from pre-testing rules:

- `available_on_boundary`
- `available_with_documented_crosswalk`
- `available_only_on_misaligned_geography`
- `available_but_not_comparable`
- `not_found`
- `not_applicable_with_rationale`

Add one outcome-specific class:

- `available_but_access_barrier_undermeasured`

Use this when a source exists but likely misses suppressed demand, informal
transport, disability barriers, gendered safety constraints, first/last-mile
friction, or unreported incidents.

## Rejection Rules

Reject or quarantine a proposed metric if it:

- measures city or transit reputation;
- measures wealth, GDP, or investment capacity as the outcome;
- duplicates an explanatory axis;
- rewards one mode without measuring usable access;
- depends on an opaque proprietary ranking;
- cannot be traced to a source and date;
- cannot be mapped to the MTR boundary or documented approximation;
- treats missing data as zero, average, or high performance;
- hides distributional access differences behind a regional average;
- works only in source-rich regions without a bias flag.

## Immediate Next Work

Batch O1 source verification has been completed as a source-family verification
step.

Batch O2A safety source verification has been completed as a source-family
verification step.

Batch O2B affordability source verification has been completed as a
source-family verification step.

Batch O2C access-to-opportunities source verification has been completed as a
source-family verification step.

The outcome metric pre-admission matrix has been drafted as a gate before
filled metric records.

The first candidate metric pre-admission test has been run as a dry run and
blocked before metric record creation.

Population denominator and travel-time method notes have been created to resolve
two blockers identified by the job-access pre-admission test.

Source-vintage alignment and distribution rules have been created for access
metric retesting.

Job-access pre-admission retest 1 has been run and remains blocked before
metric record creation because no MTR boundary and source bundle exist.

Next: return to boundary/candidate-universe readiness or wait for a source-led
MTR proposal before further metric retesting.

Outcome metric registry template:

- `theses/mobility-conversion/research/outcome_metric_registry_template.md`

Tier 1 source-family scan:

- `theses/mobility-conversion/research/tier_1_outcome_source_family_scan_2026-06-28.md`

Batch O1 summary:

- `theses/mobility-conversion/research/batch_o1_outcome_source_verification_summary_2026-06-28.md`

Batch O2A summary:

- `theses/mobility-conversion/research/batch_o2a_safety_source_verification_summary_2026-06-30.md`

Batch O2B summary:

- `theses/mobility-conversion/research/batch_o2b_affordability_source_verification_summary_2026-06-30.md`

Batch O2C summary:

- `theses/mobility-conversion/research/batch_o2c_access_to_opportunities_source_verification_summary_2026-06-30.md`

Outcome metric pre-admission matrix:

- `theses/mobility-conversion/research/outcome_metric_pre_admission_matrix_2026-06-30.md`

First candidate metric pre-admission test:

- `theses/mobility-conversion/research/method_tests/2026-07-01-job-access-pre-admission-test.md`

ACS population denominator source note:

- `theses/mobility-conversion/research/source_notes/us_census_acs_population_denominator_access_input_2026-07-01.md`

Travel-time method note:

- `theses/mobility-conversion/research/travel_time_method_note_access_metrics_2026-07-01.md`

Source-vintage alignment rule:

- `theses/mobility-conversion/research/source_vintage_alignment_rule_access_metrics_2026-07-01.md`

Distribution plan:

- `theses/mobility-conversion/research/distribution_plan_access_metrics_2026-07-01.md`

Job-access pre-admission retest 1:

- `theses/mobility-conversion/research/method_tests/2026-07-01-job-access-pre-admission-retest-1.md`

## Open Questions

- Should the first proposed access-to-opportunities metric begin with jobs only,
  or a broader opportunity bundle?
- What minimum source quality is acceptable for access-to-opportunities
  sources?
- Job-access retest 1 still blocks on MTR boundary, MTR-specific source bundle,
  feed completeness, denominator geography, and travel-time implementation.
  Should Thesis 2 now return to boundary/candidate-universe readiness?
- How should universal access avoid being reduced to wheelchair access alone?
- How should resilience be measured without becoming a narrative claim?
- When, if ever, should dimensions be combined?
