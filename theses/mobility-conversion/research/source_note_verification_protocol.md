# Source Note Verification Protocol

Date: 2026-07-01

Status: formation-stage source-verification rule. A source note verifies that a
source was independently inspected and classified. It does not by itself admit
an MTR, accept an outcome metric, create an evidence manifest, authorize a raw
data archive, calculate scores, rank MTRs, or make final paper claims.

## Purpose

Define when a source lead from a raw return, source-led MTR proposal intake, or
methodology scan can be promoted into a Thesis 2 source note.

This protocol protects the distinction between:

- raw outside claims;
- source leads;
- independently inspected source notes;
- evidence manifests;
- accepted methodology;
- final claims.

## Promotion Rule

A source lead may become a source note only after a Thesis 2 worker
independently inspects the underlying source, not merely the research return
that mentioned it.

Minimum trace required:

- source title or dataset name;
- source authority or publisher;
- URL, DOI, document identifier, archive path, API endpoint, or access path;
- inspection date;
- release date, data vintage, or source-version field when available;
- source function for Mobility Conversion;
- limitations and caveats;
- suitability judgment.

If these cannot be supplied, keep the item as a source lead or quarantine it.

## Verification Status Values

Use one of:

- `source_lead_only`
- `directly_inspected_official_source`
- `directly_inspected_primary_literature`
- `directly_inspected_data_catalog`
- `directly_inspected_documentation`
- `directly_inspected_archive`
- `secondary_reference_only`
- `blocked_unreachable`
- `blocked_unclear_authority`
- `rejected_not_relevant`
- `rejected_not_traceable`

Only `directly_inspected_*` statuses can support a source note used in later
methodology or manifest work.

## Source Function Classes

Assign one or more:

- `boundary_source_family`
- `population_denominator_source`
- `outcome_indicator_source_family`
- `service_or_network_source`
- `governance_overlay_source`
- `economic_capacity_source`
- `demand_intensity_source`
- `urban_form_source`
- `growth_maturity_source`
- `methodology_reference`
- `counterargument_source`

## Suitability Values

Use one of:

- `candidate_primary_boundary`
- `candidate_validation_overlay`
- `candidate_indicator_source_family`
- `candidate_denominator_source`
- `candidate_methodology_reference`
- `context_only`
- `source_lead_pending`
- `not_suitable`

Suitability is not acceptance. It only states what role the source may be
allowed to play after later gates.

## Required Caveat Checks

Every source note must state whether the source is:

- an MTR boundary source or only an overlay/input;
- a resident-population denominator source or not;
- an outcome source family or not;
- complete enough for cross-region comparison or only local testing;
- current enough for formation-stage use;
- limited by geography, mode, data vintage, licensing, missing fields, or
  informal/undocumented transport.

## Prohibited Promotions

Do not promote:

- a Deep Research paragraph into a source note without inspecting the cited
  source;
- a transit agency service area into an MTR denominator;
- a GTFS feed into a boundary source;
- a livability, transit reputation, congestion, or walkability claim into a
  selection reason;
- a proprietary ranking into evidence unless its source data and method are
  independently inspectable.

## Relationship To Evidence Manifests

A source note can authorize creation of a draft evidence manifest only if the
next work requires acquiring, archiving, transforming, or versioning raw
artifacts.

No raw data archive should be created from a source note without a manifest.

## Relationship To Candidate Admission

A source note can support a later boundary record, readiness checklist, or
method test.

It cannot directly create:

- admitted MTR;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking.
