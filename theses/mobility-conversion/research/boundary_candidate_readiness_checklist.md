# Boundary And Candidate-Universe Readiness Checklist

Date: 2026-07-01

Status: formation-stage readiness gate. No MTR is selected. No boundary record
is filled. No evidence manifest is filled. No candidate universe, score,
ranking, metric record, or MTR comparison is authorized.

## Purpose

Define the minimum conditions for moving from abstract methodology to a
source-led proposed MTR boundary record and source bundle.

This checklist sits before:

- filled boundary records under `research/boundary_records/`;
- filled evidence manifests under `evidence/manifests/`;
- any MTR-specific metric pre-admission retest;
- any candidate-universe ledger.

Returned source-led proposal lists should first be processed through:

- `theses/mobility-conversion/research/source_led_mtr_proposal_return_intake_protocol.md`

Individual returned leads can then be reviewed with:

- `theses/mobility-conversion/research/source_led_mtr_lead_review_template.md`

## Core Decision

Thesis 2 is ready to receive a source-led MTR proposal, but not ready to name or
select MTRs from intuition.

The next admissible unit of work is not "pick a city."

The next admissible unit of work is:

> evaluate a source-led boundary/source-bundle proposal against this checklist.

## Required Proposal Shape

A source-led proposal must include:

- proposed working MTR name or identifier;
- country or countries;
- source-led reason for testing;
- primary boundary source family;
- primary boundary confidence class;
- source authority;
- source URL or access path;
- source vintage or release;
- geography type;
- expected boundary record path, if later created;
- expected evidence manifest path, if later created;
- explicit non-selection statement.

The non-selection statement must confirm the proposal is not based on:

- transit reputation;
- congestion reputation;
- walkability reputation;
- livability rankings;
- GDP, wealth, or national reputation;
- personal familiarity;
- expected outcome performance.

## Readiness Gates

### Gate 1. Boundary Source Eligibility

Pass only if the primary boundary source family is one of:

- `observed_functional_region`
- `national_commuting_zone`
- `hybrid_functional_statistical_region`
- `official_statistical_metro`
- `modelled_functional_region`

Fail or quarantine if the only source family is:

- `built_up_urban_core`
- `governance_or_service_region`
- `service_derived_boundary`
- `accessibility_dataset_geography`

Those may be overlays or validation layers, not MTR denominators.

### Gate 2. Source Verification

Pass only if:

- source authority is identified;
- source URL or access path is traceable;
- source note exists, or the first action is to create one;
- source vintage or release can be recorded;
- source limitations can be stated.

Fail if the source exists only as a raw Deep Research claim or prompt output.

### Gate 3. Boundary Fit

Pass only if the proposal can plausibly answer:

- what functional region is represented;
- what population is included;
- what population might be wrongly excluded;
- what population might be weakly included;
- whether polycentricity matters;
- whether cross-border geography matters;
- whether multiple transport authorities matter;
- whether informal or weakly documented transport matters.

Fail if the proposal is only a city boundary, agency service area, or convenient
data geography without MTR rationale.

### Gate 4. Data Bundle Plausibility

Pass only if the proposal can identify at least a minimal source bundle:

- boundary source;
- population denominator source;
- at least one outcome source family relevant to the first method test;
- source-vintage fields to be recorded;
- manifest need, if any raw artifact will be acquired.

This does not require downloading data yet.

Fail if no denominator or outcome source can plausibly align with the boundary.

### Gate 5. Evidence Manifest Need

Before any raw artifact is archived, decide whether the next step needs:

- source note only;
- draft evidence manifest;
- filled boundary record;
- method test;
- rejected proposal note.

Do not create raw evidence archives without a manifest.

### Gate 6. Candidate-Universe Guardrail

Pass only if the result remains one of:

- source-led proposal accepted for source-note work;
- source-led proposal accepted for draft boundary record;
- proposal rejected or quarantined;
- proposal requires methodology decision.

This gate does not admit the MTR to the candidate universe.

Admission remains governed by:

- `theses/mobility-conversion/research/boundary_record_template.md`
- `theses/mobility-conversion/research/candidate_universe_testing_workflow.md`

## Allowed Outputs

Allowed after this checklist:

- source note;
- source-led proposal intake record;
- source-led MTR lead review;
- filled boundary record with `record_status: not_admitted`;
- draft evidence manifest;
- method test;
- rejection/quarantine note.

Not allowed:

- admitted MTR;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- raw evidence archive without manifest.

## Proposal Intake Record Shape

Use this shape for a source-led proposal before creating a boundary record:

```yaml
proposal_id:
proposal_status: intake
created:
operator_thread: Thesis 2

working_mtr:
  working_name:
  country_or_countries:
  source_led_reason_for_testing:
  non_selection_statement:

boundary_lead:
  source_family:
  confidence_class:
  source_name:
  source_authority:
  source_url_or_access_path:
  source_vintage:
  geography_type:
  source_note_path:

minimal_source_bundle:
  boundary_source:
  population_denominator_source:
  first_outcome_source_family:
  service_or_network_source:
  expected_vintage_fields:

readiness_gate_results:
  boundary_source_eligibility:
  source_verification:
  boundary_fit:
  data_bundle_plausibility:
  evidence_manifest_need:
  candidate_universe_guardrail:

decision:
  decision:
  rationale:
  next_allowed_output:
  prohibited_outputs:
```

Allowed `proposal_status` values:

- `intake`
- `needs_source_note`
- `needs_methodology_decision`
- `ready_for_boundary_record_not_admitted`
- `ready_for_draft_manifest`
- `rejected_reputation_led`
- `rejected_boundary_basis`
- `quarantined_insufficient_source`

## Recommended Next Work

Create a handoff request to the research thread asking for source-led MTR
boundary/source-bundle proposals that fit this checklist.

The request should ask for proposals emerging from boundary source systems, not
from city reputation or transport fame.
