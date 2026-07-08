# Candidate-Universe Ledger Design

Date: 2026-06-28

Status: formation-stage design. Do not create the actual candidate-universe
ledger yet.

This document defines the future ledger structure for tracking proposed
Metropolitan Transport Regions after boundary records exist. It does not admit
any MTR, name any MTR, create a candidate list, score regions, rank regions, or
approve final inclusion.

## Creation Rule

Do not create the live candidate-universe ledger until:

- at least one boundary record exists under
  `theses/mobility-conversion/research/boundary_records/`;
- at least one boundary record has decision
  `admissible_for_candidate_universe`;
- the boundary record was created from
  `theses/mobility-conversion/research/boundary_record_template.md`;
- pre-testing rules were applied;
- the candidate-universe testing workflow was followed.

Until those conditions are met, this design document is the only ledger-related
artifact.

## Purpose

The future ledger should track the state of proposed MTR boundary records
without turning them into a ranking, recommendation list, or final case set.

It should make it easy to see:

- which proposed MTRs are admitted for candidate-universe testing;
- which were rejected and why;
- which remain blocked by source verification or methodology gaps;
- which source families are overrepresented or underrepresented;
- where missing data may bias the eventual universe.

## Non-Purpose

The future ledger must not:

- rank MTRs;
- score access performance;
- compare outcomes;
- recommend "best" or "worst" regions;
- select final cases;
- substitute for filled boundary records;
- hide missing data;
- collapse source confidence into a single quality score.

## Ledger Status Values

Allowed ledger statuses:

- `not_admitted`
- `admissible_for_candidate_universe`
- `needs_source_verification`
- `needs_methodology_decision`
- `rejected_boundary_basis`
- `deferred_missing_data`
- `deferred_scope_decision`

The ledger status must match or conservatively summarize the linked boundary
record status.

## Required Fields

The future ledger should use these fields:

```yaml
ledger_row_id:
ledger_status:
ledger_added_date:
ledger_updated_date:

boundary_record:
  record_id:
  record_path:
  record_status:
  admission_decision_date:

proposed_mtr:
  working_id:
  working_name:
  country_or_countries:
  world_region:
  source_led_reason_for_testing:

boundary_basis:
  primary_boundary_source_id:
  primary_source_name:
  source_authority:
  confidence_class:
  boundary_family:
  source_vintage:
  geography_release_vintage:
  spatial_unit:
  observed_or_modelled:
  basis_type:

formation_rules:
  minimum_scale_rule_applied:
  temporal_rule_applied:
  missing_data_rule_applied:
  geographic_stratification_rule_applied:
  cross_border_rule_applied:
  polycentric_rule_applied:

flags:
  cross_border:
  polycentric:
  commute_derived:
  post_2020_commute_caveat:
  hybrid_or_statistical_adjustments:
  modelled_boundary:
  service_denominator_prohibited_confirmed:
  governance_circularity_risk:
  unserved_population_risk:

source_coverage_audit:
  source_system_family:
  source_system_region:
  source_availability_class:
  data_completeness_class:
  missingness_bias_risk:

outcome_data_readiness:
  access_to_opportunities:
  network_coverage_and_service_availability:
  travel_time_and_reliability:
  transportation_safety:
  affordability:
  walking_cycling_and_universal_access:
  asset_condition_and_resilience:

explanatory_data_readiness:
  economic_capacity:
  demand_intensity:
  urban_form:
  governance_fit:
  growth_maturity:

decision_notes:
  admitted_reason:
  rejection_or_deferral_reason:
  required_follow_up:
  deep_research_handoff_needed:
  methodology_decision_needed:
```

## Readiness Values

Outcome and explanatory data readiness fields should use the missingness
categories from `pre_testing_rules.md`:

- `available_on_boundary`
- `available_with_documented_crosswalk`
- `available_only_on_misaligned_geography`
- `available_but_not_comparable`
- `not_found`
- `not_applicable_with_rationale`
- `not_checked_yet`

Do not encode performance levels in readiness fields.

## Source Coverage Audit

The ledger should support bias audits before any comparative analysis.

Source-system-family examples:

- `observed_functional_region`
- `national_commuting_zone`
- `hybrid_functional_statistical_region`
- `official_statistical_metro`
- `modelled_functional_region`

Source-availability-class examples:

- `official_boundary_and_geometry_available`
- `official_boundary_available_geometry_pending`
- `method_available_geometry_pending`
- `source_lead_only`
- `requires_deep_research`
- `not_traceable`

Data-completeness-class examples:

- `boundary_complete_indicators_not_checked`
- `boundary_complete_core_indicators_partial`
- `boundary_complete_outcome_dimensions_partial`
- `boundary_complete_explanatory_axes_partial`
- `boundary_complete_data_sparse`

Missingness-bias-risk examples:

- `low_known_risk`
- `medium_documented_risk`
- `high_source_rich_region_bias`
- `high_informal_transport_visibility_risk`
- `high_unserved_population_visibility_risk`
- `unknown`

## Admission Versus Selection

Admission to the candidate universe means only:

```text
This proposed MTR has a boundary record strong enough to be tested further.
```

It does not mean:

- the MTR is selected for a final study;
- the MTR is representative;
- the MTR is high or low performing;
- the MTR will appear in a paper;
- the MTR should be compared before outcome methodology exists.

## Ledger Review Rules

Before any future ledger is used for analysis, review:

- whether admitted rows are clustered in source-rich regions;
- whether regions with informal or weakly documented transport are being
  filtered out by data availability;
- whether source confidence classes are mixed without flagging;
- whether cross-border and polycentric cases are being deferred too often;
- whether modelled boundaries are being used because they are genuinely best or
  merely globally convenient;
- whether official statistical metros are being overused because indicators are
  easier to join.

## Prohibited Columns

Do not add columns for:

- rank;
- score;
- livability score;
- best/worst classification;
- expected finding;
- transit reputation;
- congestion reputation;
- operator preference;
- final case status.

If final case selection later becomes necessary, it must be designed in a
separate decision record after boundary admission and outcome-methodology rules
exist.

## Storage Rule

When creation is allowed, the future live ledger should be stored as a
structured file under:

```text
theses/mobility-conversion/research/candidate_universe/
```

Do not create that folder until the creation rule is satisfied.

## Next Step

Before a live ledger can exist, the project needs either:

- an admitted boundary record; or
- a decision to run a source-led dry-run boundary record for method testing.

A dry run must be explicitly labeled as such and must not become candidate
selection.
