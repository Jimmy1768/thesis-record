# Outcome Metric Registry Template

Status: formation-stage template. No usable-access metric is accepted by this
template.

Purpose: provide a standard record shape for proposed usable-access metrics so
they can be reviewed without becoming final metrics, scores, weights, rankings,
or evidence claims.

## Use Rule

Create one metric record per proposed metric only after there is a traceable
source lead or methodology reason to test it.

Every metric record must begin as `proposed_not_accepted`.

Do not use this registry to calculate scores, rank MTRs, compare MTRs, or
select cases.

## Allowed Metric Status Values

- `proposed_not_accepted`
- `needs_source_verification`
- `needs_boundary_alignment_review`
- `needs_comparability_review`
- `needs_methodology_decision`
- `rejected_metric`
- `accepted_for_candidate_testing`

`accepted_for_candidate_testing` does not mean accepted for final scoring or
paper claims.

## Allowed Outcome Dimensions

- `access_to_opportunities`
- `network_coverage_and_service_availability`
- `travel_time_and_reliability`
- `transportation_safety`
- `affordability`
- `walking_cycling_and_universal_access`
- `asset_condition_and_resilience`

## Evidence Tier Values

- `tier_1_core_access`
- `tier_2_access_completeness`
- `context_only`
- `not_usable`

Tier 1 dimensions:

- access to opportunities;
- network coverage and service availability;
- travel time and reliability;
- transportation safety;
- affordability.

Tier 2 dimensions:

- walking, cycling, and universal access;
- asset condition and resilience.

Tier 2 means source-friction is expected. It does not mean optional.

## Comparability Classes

- `directly_comparable_on_mtr_boundary`
- `comparable_with_documented_crosswalk`
- `within_region_only`
- `source_family_comparable_only`
- `not_comparable_but_contextual`
- `not_usable`

## Missingness Classes

- `available_on_boundary`
- `available_with_documented_crosswalk`
- `available_only_on_misaligned_geography`
- `available_but_not_comparable`
- `available_but_access_barrier_undermeasured`
- `not_found`
- `not_applicable_with_rationale`

## YAML Record Shape

```yaml
metric_record_id:
metric_status: proposed_not_accepted
record_created:
record_updated:
operator_thread: Thesis 2

metric_identity:
  metric_name:
  outcome_dimension:
  evidence_tier:
  short_definition:
  intended_access_question:
  unit_of_measure:
  directionality:
  candidate_denominator:

source:
  source_name:
  source_authority:
  source_url_or_access_path:
  source_vintage:
  latest_known_release:
  retrieval_or_inspection_date:
  source_note_path:
  source_class:
  license_or_reuse_notes:
  verification_status:

boundary_alignment:
  geographic_unit:
  mtr_boundary_compatibility:
  requires_crosswalk: false
  crosswalk_method:
  known_boundary_mismatch:
  boundary_record_dependency:
  risk_of_unit_switching:

coverage:
  mode_coverage:
  trip_purpose_coverage:
  population_coverage:
  temporal_coverage:
  peak_offpeak_treatment:
  informal_transport_treatment:
  disability_or_universal_access_treatment:
  gendered_or_perceived_safety_treatment:

distribution:
  reports_regional_average:
  reports_distribution:
  distribution_groups:
  denominator_population:
  denominator_trip_or_exposure:
  suppressed_demand_risk:
  equity_visibility_notes:

comparability:
  comparability_class:
  missingness_class:
  comparable_regions_or_source_family:
  known_noncomparability:
  source_rich_region_bias_risk:
  informal_or_unreported_activity_bias_risk:

methodology_review:
  duplicates_explanatory_axis: false
  reputation_metric_risk: false
  mode_advocacy_risk: false
  opaque_proprietary_method_risk: false
  treats_missing_as_performance: false
  hides_distributional_gap: false
  narrative_without_traceable_source: false
  rejection_risk_notes:

decision:
  decision: proposed_not_accepted
  decision_date:
  decided_by:
  rationale:
  required_follow_up:
```

## Required Acceptance Gate

No metric can be marked `accepted_for_candidate_testing` unless:

- source authority is recorded;
- source date or vintage is recorded;
- source note exists or is explicitly required as follow-up;
- outcome dimension is assigned;
- metric definition is explicit;
- geographic unit is recorded;
- MTR boundary compatibility is reviewed;
- denominator is recorded;
- distributional treatment is recorded;
- mode and trip-purpose coverage are recorded;
- comparability class is assigned;
- missingness class is assigned;
- rejection risks are reviewed.

## Rejection Rules

Reject or quarantine a metric if it:

- measures city reputation rather than usable access;
- measures transit fame rather than usable access;
- measures GDP, wealth, or investment capacity as the outcome;
- duplicates an explanatory axis;
- rewards one mode without measuring access usefulness;
- depends on an opaque proprietary ranking;
- cannot be traced to source and date;
- cannot be mapped to an MTR boundary or documented approximation;
- treats missing data as zero, average, or high performance;
- hides severe distributional access gaps behind an average;
- works only for source-rich regions without a bias flag.

## Storage Rule

Future filled metric records should live under:

```text
theses/mobility-conversion/research/outcome_metric_records/
```

Do not create filled metric records until there is a source lead or methodology
reason to test a proposed metric.

## Next Step

Run a source-family scan for Tier 1 outcome dimensions before filling metric
records.

