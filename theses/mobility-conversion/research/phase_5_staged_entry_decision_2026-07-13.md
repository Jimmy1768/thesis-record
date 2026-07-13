# Phase 5 Staged Entry Decision

Date: 2026-07-13

Status: accepted as a bounded source-truth decision. Phase 5 opens only for a
non-scoring boundary-record construction and readiness-review substage.

## Decision

Phase 5 is now open only as bounded substage `5A`:

- `5A boundary_record_construction_and_readiness_review`

This substage uses the existing Candidate-Universe Testing Workflow without
creating a competing protocol.

Workflow mapping:

- Candidate-Universe Testing Workflow Stage 4: Boundary Record Creation
- Candidate-Universe Testing Workflow Stage 5: Boundary Fit Review
- Candidate-Universe Testing Workflow Stage 6: Data-Alignment Review

This decision does not open admission, a live candidate-universe ledger,
comparison, scoring, ranking, final selection, or publication authority.

## Phase 5 Substages

### 5A Boundary Record Construction And Readiness Review

Status: `active_next`

Allowed scope:

- create one filled boundary record per proposed MTR under
  `theses/mobility-conversion/research/boundary_records/`;
- require `record_status: not_admitted` on first creation;
- fill only evidence-derived fields supported by already accepted repository
  records;
- keep unknowns explicit rather than inferred;
- populate boundary-fit and data-alignment review fields conservatively;
- keep readiness/admission checklist booleans false unless directly supported by
  the accepted repository evidence.

This is boundary-record construction and readiness review only. It is not
admission.

### 5B Admission Review And Live Candidate-Universe Ledger

Status: `closed`

Workflow mapping:

- Candidate-Universe Testing Workflow Stage 7: Admission Review
- Candidate-Universe Testing Workflow Stage 8: Candidate-Universe Ledger

This remains closed until at least one complete boundary record passes every
required gate and reaches `admissible_for_candidate_universe`. Until then, the
design document remains the only ledger-related artifact.

### 5C Comparison, Scoring, Ranking, And Final Selection

Status: `closed`

This remains closed. Nothing in the current ordered contract authorizes
comparison, scoring, ranking, final case selection, or publication claims.

## Why Minneapolis And Portland Are Allowed In 5A

Minneapolis-St. Paul ERS commuting zone and Portland-Vancouver-Hillsboro CBSA
are allowed as proposed-MTR method-test records because:

- both emerged from the already recorded source-led feasibility process rather
  than reputation-led city picking;
- they exercise distinct accepted boundary source families:
  `national_commuting_zone` for Minneapolis and `official_statistical_metro`
  for Portland;
- both were routed through Phase 3 boundary geometry validation and Phase 4
  provisional tract-population overlay work using committed geometry and
  accepted repository evidence;
- creating a boundary record with `record_status: not_admitted` does not admit,
  select, compare, score, rank, or recommend either case;
- current U.S. evidence availability and tooling convenience must be recorded as
  a bias risk, not treated as merit or as a reason for candidate preference.

## Exact Next Allowed Outputs

The next exact implementation unit is:

- one filled boundary record for Minneapolis-St. Paul ERS CZ with
  `record_status: not_admitted`;
- one filled boundary record for Portland-Vancouver-Hillsboro CBSA with
  `record_status: not_admitted`.

Required constraints on those outputs:

- use only already accepted repository evidence;
- fill only evidence-derived fields;
- keep unknowns, caveats, and unresolved items explicit;
- keep readiness/admission checklist booleans false unless directly supported;
- record data-availability and convenience bias as a risk;
- do not create a live candidate-universe ledger;
- do not admit either proposed MTR;
- do not compare, score, rank, select, or recommend.

## Preserved Guardrails

This decision does not approve:

- any accepted population value;
- any accepted denominator value;
- any metric record;
- any MTR admission;
- any candidate list;
- any live candidate-universe ledger;
- any comparison, scoring, ranking, or final selection;
- any publication claim.

## Source Truth References

- `theses/mobility-conversion/README.md`
- `theses/mobility-conversion/thesis.yml`
- `theses/mobility-conversion/research/candidate_universe_protocol.md`
- `theses/mobility-conversion/research/candidate_universe_testing_workflow.md`
- `theses/mobility-conversion/research/candidate_universe_ledger_design.md`
- `theses/mobility-conversion/research/boundary_candidate_readiness_checklist.md`
- `theses/mobility-conversion/research/boundary_record_template.md`
- `theses/mobility-conversion/research/boundary_source_decision_record_2026-06-28.md`
- `theses/mobility-conversion/research/phase_2_source_candidate_feasibility_matrix_2026-07-12.md`
- `theses/mobility-conversion/research/phase_3_boundary_geometry_validation_acceptance_2026-07-12.md`
- `theses/mobility-conversion/research/phase_4_population_join_metric_pre_admission_acceptance_2026-07-13.md`
