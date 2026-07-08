# Handoff: Source-Led MTR Boundary / Source-Bundle Proposal Request

Date: 2026-07-01

From: Thesis 2 working thread

To: Deep Research / external research thread

Status: research request. This is not evidence, not source truth, not an
accepted MTR list, not a candidate-universe record, not a boundary record, not a
metric record, not a score, and not a ranking.

## Thesis Context

Thesis: Mobility Conversion

Full title: Mobility Conversion: How Metropolitan Transport Regions Convert
Capacity, Pressure, Shape, Governance, and Growth into Usable Access

Use term:

- Metropolitan Transport Region
- MTR

Do not use:

- Metropolitan Transit Region

## Purpose

Find source-led MTR boundary/source-bundle proposals that can be evaluated by
Thesis 2.

Do not select cities because they are famous, interesting, admired, congested,
walkable, wealthy, poor, transit-rich, transit-poor, or highly ranked.

Start from boundary source systems and data-source compatibility.

## Current Thesis 2 Gate

Use this readiness checklist:

- `theses/mobility-conversion/research/boundary_candidate_readiness_checklist.md`

The next admissible unit of work is:

> evaluate a source-led boundary/source-bundle proposal against the readiness
> checklist.

The next admissible unit of work is not:

> pick a city.

## Research Task

Return 6-10 source-led proposal candidates.

Each proposal must emerge from one of these boundary source families:

- `observed_functional_region`
- `national_commuting_zone`
- `hybrid_functional_statistical_region`
- `official_statistical_metro`
- `modelled_functional_region`

Do not propose a region if the only available boundary source is:

- built-up urban core;
- governance/service region;
- transit agency service area;
- GTFS/service-derived geography;
- accessibility dataset geography;
- city administrative boundary without MTR rationale.

Those may be overlays later, but they cannot be the primary MTR denominator.

## Required Proposal Fields

For each proposal, return:

```yaml
proposal_id:
proposal_status: research_lead_only

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
  source_note_candidate:

minimal_source_bundle:
  boundary_source:
  population_denominator_source:
  first_outcome_source_family:
  service_or_network_source:
  expected_vintage_fields:

readiness_gate_preview:
  boundary_source_eligibility:
  source_verification:
  boundary_fit:
  data_bundle_plausibility:
  evidence_manifest_need:
  candidate_universe_guardrail:

risk_notes:
  boundary_risks:
  data_alignment_risks:
  reputation_selection_risks:
  missingness_risks:
  source_rich_region_bias_risks:

recommended_next_action:
```

## Non-Selection Statement Requirement

For every proposal, explicitly state:

> This proposal is source-led. It is not proposed because of transit reputation,
> congestion reputation, walkability reputation, livability rankings, GDP,
> wealth, national reputation, personal familiarity, expected outcome
> performance, or "good city" intuition.

If that statement cannot be made honestly, reject or quarantine the proposal.

## Minimal Source Bundle Guidance

For each proposal, identify plausible source families for:

1. MTR boundary source.
2. Resident population denominator.
3. First outcome source family for a basic method test.
4. Service or network input if testing scheduled public transport job access.
5. Source-vintage fields that would need recording.

Do not download data.

Do not calculate metrics.

Do not create scores.

Do not compare MTRs.

Do not recommend final candidates.

## Preferred Proposal Mix

Return a mix across source systems if possible, for example:

- OECD or Eurostat functional urban areas;
- national commuting zones or labour-market areas;
- hybrid functional/statistical metropolitan systems;
- official statistical metros with transparent methodology;
- modelled global functional regions where official functional sources are
  unavailable.

The mix should be driven by source-system coverage and methodological value,
not by city reputation.

## Rejection / Quarantine Rules

Reject or quarantine a proposal if:

- the boundary source is not traceable;
- the source exists only in a prompt return;
- the source URL/access path is missing;
- the boundary is a transit service area or GTFS-derived catchment;
- the region is chosen because it is famous or interesting;
- data availability is being used as an unexamined proxy for transport quality;
- no population denominator can plausibly align;
- no first outcome source family can plausibly align.

## Output Format

Return in this order:

1. Short method summary.
2. Proposal table with 6-10 rows.
3. Full YAML-style proposal blocks.
4. Rejected/quarantined leads and why.
5. Source list with URLs.
6. Open questions for Thesis 2.

## Important Scope Limits

The return is raw research material only.

The Thesis 2 working thread will later process the return through:

- raw-return buffer protocol;
- source-led proposal return intake protocol;
- source-note verification;
- readiness checklist;
- boundary record template;
- evidence manifest process.

The proposal return intake protocol is:

- `theses/mobility-conversion/research/source_led_mtr_proposal_return_intake_protocol.md`

Do not present the return as final candidate selection.

Do not present any proposal as admitted to the candidate universe.
