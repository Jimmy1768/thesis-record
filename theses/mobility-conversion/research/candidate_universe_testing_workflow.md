# Candidate-Universe Testing Workflow

Status: formation-stage workflow. No candidate MTR list is approved.

Purpose: define how Thesis 2 may move from source leads to testable
Metropolitan Transport Region boundary records without selecting regions by
reputation, convenience, or outcome intuition.

This workflow does not approve final MTR boundaries, final candidate selection,
scores, rankings, or paper claims.

## Governing Inputs

Use these records together:

- `theses/mobility-conversion/research/candidate_universe_protocol.md`
- `theses/mobility-conversion/research/boundary_candidate_readiness_checklist.md`
- `theses/mobility-conversion/research/boundary_source_decision_record_2026-06-28.md`
- `theses/mobility-conversion/research/pre_testing_rules.md`
- `theses/mobility-conversion/research/boundary_record_template.md`
- `theses/mobility-conversion/research/boundary_source_registry_candidate.md`
- `theses/mobility-conversion/research/deep_research_return_protocol.md`
- `theses/mobility-conversion/research/raw_return_buffer_protocol.md`

## Core Rule

Do not start from cities.

Start from source families, boundary systems, inclusion rules, and data
availability constraints. A proposed MTR can be tested only after there is a
source-led reason to create a boundary record.

## Dry-Run Modes

Method tests must live under:

- `theses/mobility-conversion/research/method_tests/`

Dry-run modes:

- source-family dry run: tests source eligibility and verification without
  naming a region;
- proposed-MTR dry run: tests a filled boundary record for one explicitly
  labeled region without admitting it as a candidate.

Do not place source-family dry runs under `boundary_records/`.

Do not create a live candidate-universe ledger from any dry run.

## Workflow Stages

### Stage 0: Methodology Readiness

Inputs:

- boundary source decision record exists;
- pre-testing rules exist;
- boundary record template exists;
- boundary/candidate-universe readiness checklist exists;
- candidate-universe protocol blocks reputation selection.

Allowed output:

- proceed to source-family eligibility testing.

Stop if:

- the operator wants to name regions before the boundary gate exists;
- the proposed workflow depends on transit fame, livability rankings, congestion
  narratives, GDP, or country reputation.

### Stage 1: Source-Family Eligibility

Question:

Can the source family legally and methodologically support an MTR denominator
during candidate formation?

Allowed source classes for denominator testing:

- `observed_functional_region`
- `national_commuting_zone`
- `hybrid_functional_statistical_region`
- `official_statistical_metro`
- `modelled_functional_region`

Rejected as denominator source classes:

- `built_up_urban_core`
- `governance_or_service_region`
- `service_derived_boundary`
- `accessibility_dataset_geography`

Outputs:

- eligible source family;
- rejected source family;
- `needs_methodology_decision`.

Stop if:

- the only available geography is service-derived, built-form-only,
  governance-only, or inherited from an accessibility dataset.

### Stage 2: Source Verification

Question:

Has the underlying source been directly inspected and converted into a
ThesisRecord source note?

Required output:

- source note under
  `theses/mobility-conversion/research/source_notes/`;
- source authority recorded;
- source URL or access path recorded;
- source vintage or release recorded where available;
- boundary basis classified;
- limitations recorded;
- suitability judgment assigned.

Stop if:

- the source is known only from a raw Deep Research return;
- the source definition is not directly inspected;
- the source cannot be traced.

### Stage 3: Non-Selection Filter

Question:

Is the proposed test region emerging from a source-led boundary system rather
than from fame, intuition, or desired comparison?

Required checks:

- not selected for transit reputation;
- not selected for congestion reputation;
- not selected for walkability reputation;
- not selected from livability or city rankings;
- not selected because it is rich, poor, familiar, admired, or notorious;
- not selected after observing expected outcome performance.

Allowed output:

- source-led proposal may create a boundary record;
- proposal rejected as reputation-led.

Stop if:

- the operator cannot state a source-led reason for testing the proposed MTR.

### Stage 4: Boundary Record Creation

Action:

Create one boundary record using:

- `theses/mobility-conversion/research/boundary_record_template.md`

Storage:

- `theses/mobility-conversion/research/boundary_records/`

Required initial status:

- `not_admitted`

Required content:

- proposed MTR working identity;
- primary boundary source;
- confidence class;
- source metadata;
- functional or commute basis if applicable;
- hybrid/statistical rules if applicable;
- fallback or validation boundary;
- required overlays;
- boundary-fit review;
- data-alignment review;
- admission checklist;
- admission decision.

Stop if:

- the record is created as admitted;
- required source and caveat fields are skipped;
- a service-derived geography is used as the denominator.

### Stage 5: Boundary Fit Review

Question:

Does the proposed boundary plausibly approximate the MTR, not just a city,
agency, service area, or statistical convenience?

Required review:

- functional core included;
- peripheral populations shaped by the MTR are considered;
- weakly related distant populations are identified;
- polycentricity reviewed;
- cross-border issues reviewed;
- multiple transport authorities reviewed;
- informal or weakly documented transport reviewed;
- governance is not baked into the outcome;
- service area is not used as denominator.

Allowed output:

- proceed to data-alignment review;
- mark `needs_methodology_decision`;
- mark `rejected_boundary_basis`.

### Stage 6: Data-Alignment Review

Question:

Can the boundary support the later outcome and explanatory data without silently
changing the unit?

Review alignment for:

- population;
- economic capacity;
- demand intensity;
- urban form;
- governance overlays;
- access-to-opportunities indicators;
- network coverage and service availability;
- travel time and reliability;
- safety;
- affordability;
- walking, cycling, and universal access;
- asset condition and resilience.

Allowed output:

- proceed to admission review;
- record missing-data risks;
- mark `needs_methodology_decision`.

Stop if:

- required outcome data can only be joined by replacing the boundary with a
  different unit without documentation.

### Stage 7: Admission Review

Question:

Does the record pass every required checklist item?

Admission may be considered only if:

- source is traceable;
- source note exists;
- confidence class is allowed for denominator testing;
- vintage is recorded;
- geography release is recorded;
- limitations are recorded;
- caveats are recorded;
- fallback or validation boundary is recorded;
- governance overlay is recorded;
- service overlay is recorded without denominator use;
- unserved-population risk is reviewed;
- reputation selection is rejected;
- missing-data rule is applied.

Allowed decisions:

- `admissible_for_candidate_universe`
- `needs_source_verification`
- `needs_methodology_decision`
- `rejected_boundary_basis`

Admission means the MTR may enter candidate-universe testing. It does not mean
the MTR is selected for the final study, scored, ranked, or described as a
finding.

### Stage 8: Candidate-Universe Ledger

Do not create this ledger yet.

The ledger should only be created after at least one boundary record has passed
admission review and after the minimum scale, temporal window, geographic
stratification, cross-border, polycentric, and missing-data rules are
documented.

The ledger should track admitted, rejected, and unresolved proposed MTRs without
turning them into a ranked list.

Ledger design:

- `theses/mobility-conversion/research/candidate_universe_ledger_design.md`

## Required Stop Conditions

Stop the workflow and record the issue if:

- the proposal is reputation-led;
- the only boundary is service-derived;
- the source is unverified;
- the source class is not allowed for denominator testing;
- commute-derived caveats are missing;
- hybrid/statistical adjustment rules are unknown;
- boundary and indicator data require undocumented unit switching;
- governance boundaries would make governance-fit analysis circular;
- missing data would silently exclude weakly served populations.

## Handoff To Deep Research

Use a Deep Research handoff when the workflow needs:

- full current source documentation not yet located;
- official methodology or boundary-file location;
- license and reuse information;
- source-vintage history;
- national-system comparison for a source family;
- counterexamples showing the boundary class fails.

Do not ask Deep Research to:

- choose candidate MTRs by reputation;
- rank transport regions;
- produce final scores;
- decide final methodology;
- bypass the raw-return intake protocol.

## Next Work

Before testing any named MTR, apply:

- `theses/mobility-conversion/research/pre_testing_rules.md`

Next methodology work:

- decide whether to run a proposed-MTR dry run or wait for a real source-led
  proposed MTR.
