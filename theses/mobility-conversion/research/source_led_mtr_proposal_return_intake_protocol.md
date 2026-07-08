# Source-Led MTR Proposal Return Intake Protocol

Date: 2026-07-01

Status: formation-stage intake protocol. No MTR is selected. No boundary record
is filled. No evidence manifest is filled. No candidate universe, metric
record, score, ranking, or MTR comparison is authorized.

## Purpose

Define how Thesis 2 will process the return from:

- `theses/mobility-conversion/operator_records/handoffs/2026-07-01-source-led-mtr-proposal-request.md`

This protocol exists because a source-led proposal return is still raw research
material. It may contain useful leads, but it cannot directly create candidate
MTRs, accepted boundaries, evidence manifests, metric records, or claims.

## Required Buffer

Use the raw-return buffer:

- `theses/mobility-conversion/research/raw_return_buffer_protocol.md`

The raw proposal return must be preserved before interpretation.

Recommended raw return path:

```text
theses/mobility-conversion/operator_records/external_query_tests/YYYY-MM-DD-source-led-mtr-proposal-raw-return.md
```

Recommended intake path:

```text
theses/mobility-conversion/research/source_led_mtr_proposal_intake_YYYY-MM-DD.md
```

Recommended intake template:

- `theses/mobility-conversion/research/source_led_mtr_proposal_intake_template.md`

Recommended per-lead review template, after the full intake note is complete:

- `theses/mobility-conversion/research/source_led_mtr_lead_review_template.md`

## Intake Status Values

Each returned proposal lead must receive one intake status:

- `ready_for_source_note_review`
- `needs_source_trace`
- `needs_boundary_classification_review`
- `ready_for_readiness_checklist_review`
- `ready_for_boundary_record_not_admitted`
- `ready_for_draft_manifest`
- `quarantined_insufficient_source`
- `rejected_reputation_led`
- `rejected_boundary_basis`
- `rejected_service_derived_denominator`
- `rejected_not_mtr_scope`

No intake status admits an MTR to the candidate universe.

No intake status authorizes scoring, ranking, metric records, or final paper
claims.

## Intake Steps

### Step 1. Preserve Raw Return

Store the full return exactly as received.

Do not edit out:

- weak proposals;
- mistakes;
- rejected leads;
- source gaps;
- confusing claims;
- proposal names that later fail.

### Step 2. Confirm Scope Compliance

Check the return for scope violations:

- uses the prohibited transit-region expansion of MTR;
- ranks or scores MTRs;
- recommends final candidates;
- selects by city reputation;
- treats transit fame or livability as source justification;
- uses service-derived geography as denominator;
- omits source URLs or authorities.

Violations do not require deletion. Record them in the intake note.

### Step 3. Classify Each Proposal Lead

For every returned lead, extract:

- working MTR name or identifier;
- country or countries;
- source-led reason for testing;
- boundary source family;
- confidence class;
- source authority;
- source URL or access path;
- source vintage;
- geography type;
- population denominator source;
- first outcome source family;
- service or network source;
- risk notes;
- recommended next action.

Then assign one intake status.

### Step 4. Apply Boundary Source Eligibility

Eligible for denominator review:

- `observed_functional_region`
- `national_commuting_zone`
- `hybrid_functional_statistical_region`
- `official_statistical_metro`
- `modelled_functional_region`

Not eligible as denominator:

- `built_up_urban_core`
- `governance_or_service_region`
- `service_derived_boundary`
- `accessibility_dataset_geography`

If a proposal relies on a transit service area, GTFS catchment, agency district,
or city boundary as the primary denominator, reject or quarantine it unless a
separate eligible MTR boundary source is present.

### Step 5. Apply Non-Selection Test

Reject as `rejected_reputation_led` if the proposal is justified by:

- transit reputation;
- congestion reputation;
- walkability reputation;
- livability ranking;
- city fame;
- wealth or poverty;
- personal familiarity;
- expected performance;
- a desired comparison narrative.

Keep the rejected lead in the intake note.

### Step 6. Apply Minimal Source-Bundle Test

A proposal can move to readiness checklist review only if it has plausible
source families for:

- boundary source;
- resident population denominator;
- at least one first outcome source family;
- service or network input, if relevant;
- source-vintage fields.

If the boundary is plausible but the bundle is incomplete, classify as
`needs_source_trace` or `quarantined_insufficient_source`.

### Step 7. Decide Next Allowed Output

Allowed next outputs:

- source note review;
- source-led MTR lead review;
- readiness checklist review;
- boundary record with `record_status: not_admitted`;
- draft evidence manifest;
- method test;
- rejection or quarantine note.

Prohibited outputs:

- admitted MTR;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- raw data archive without manifest.

## Intake Note Shape

Use this structure for the interpreted intake note:

```markdown
# Source-Led MTR Proposal Intake

Date:

Raw return:

Status: intake only. No MTR selected. No evidence accepted.

## Scope Compliance

## Proposal Lead Table

| Lead | Boundary source family | Source authority | Intake status | Next allowed output |
| --- | --- | --- | --- | --- |

## Lead Details

### Lead: <working name>

- intake status:
- source-led reason:
- non-selection test:
- boundary source eligibility:
- minimal source bundle:
- major risks:
- next allowed output:
- prohibited outputs:

## Rejected Or Quarantined Leads

## Source Leads To Verify

## Open Questions
```

## Promotion Rules

A returned lead may move only through these paths:

- proposal lead -> source note review;
- proposal lead -> source-led MTR lead review;
- proposal lead -> readiness checklist review;
- readiness checklist review -> boundary record with `not_admitted`;
- source artifact need -> draft evidence manifest;
- failed lead -> rejection/quarantine note.

No direct path exists from proposal lead to candidate universe admission.

No direct path exists from proposal lead to outcome metric record.

## Recommended First Intake Decision

When the research return arrives, process all returned leads first before
promoting any single lead.

Reason:

- this prevents the first plausible or familiar proposal from getting
  privileged by order of arrival;
- it preserves comparative source-system context without ranking MTRs;
- it makes rejection/quarantine decisions visible.
