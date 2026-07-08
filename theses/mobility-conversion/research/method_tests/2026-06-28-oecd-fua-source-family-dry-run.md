# Method Test: OECD FUA Source-Family Dry Run

Date: 2026-06-28

Status: dry run. Not a boundary record. Not a candidate MTR. Not admissible for
candidate-universe entry.

## Purpose

Test whether the candidate-universe workflow can process a verified source
family without prematurely naming or admitting an MTR.

This dry run uses the OECD Functional Urban Areas source family because it is a
verified candidate source class and does not require selecting a specific
region.

## Inputs

Workflow:

- `theses/mobility-conversion/research/candidate_universe_testing_workflow.md`

Template:

- `theses/mobility-conversion/research/boundary_record_template.md`

Pre-testing rules:

- `theses/mobility-conversion/research/pre_testing_rules.md`

Source note:

- `theses/mobility-conversion/research/source_notes/oecd_functional_urban_areas_2026-06-28.md`

## Dry-Run Scope

This test evaluates:

- source-family eligibility;
- source verification;
- non-selection control;
- whether the workflow correctly blocks boundary-record creation when no
  source-led proposed MTR exists.

This test does not evaluate:

- a named MTR boundary;
- population scale metadata;
- geometry download and processing;
- indicator data alignment;
- governance overlays;
- service overlays;
- admission into the candidate universe.

## Stage Results

### Stage 0: Methodology Readiness

Result: pass.

Reason:

- boundary source decision record exists;
- pre-testing rules exist;
- boundary record template exists;
- candidate-universe protocol blocks reputation selection.

### Stage 1: Source-Family Eligibility

Result: pass.

Source family:

- OECD Functional Urban Areas.

Candidate confidence class:

- `observed_functional_region` for observed OECD FUAs;
- `modelled_functional_region` for estimated FUAs, requiring separate
  treatment.

Denominator eligibility:

- observed OECD FUAs are eligible for denominator testing during formation;
- estimated/modelled FUAs are not equivalent and must remain lower confidence.

### Stage 2: Source Verification

Result: pass for source-family-level testing.

The source family has a direct source note:

- `theses/mobility-conversion/research/source_notes/oecd_functional_urban_areas_2026-06-28.md`

Verified source-family properties:

- source authority: OECD;
- boundary family: functional urban area;
- basis type: population density, cell contiguity, and workplace commuting;
- suitability: `candidate_primary_boundary` where observed FUA boundaries exist
  and source vintage is acceptable;
- limitations: workplace commuting focus, incomplete global coverage, and need
  to separate observed from estimated FUAs.

### Stage 3: Non-Selection Filter

Result: pass, with no proposed MTR.

No region was named.

No selection was made based on:

- transit reputation;
- congestion reputation;
- walkability reputation;
- livability ranking;
- city familiarity;
- expected outcome performance.

### Stage 4: Boundary Record Creation

Result: intentionally stopped.

Reason:

- the dry run has a verified source family but no source-led proposed MTR;
- the boundary-record template is for proposed MTR records, not source-family
  records;
- creating a boundary record without a proposed MTR would weaken the admission
  gate.

No file was created under:

- `theses/mobility-conversion/research/boundary_records/`

### Stage 5: Boundary Fit Review

Result: not reached.

Reason:

- no proposed MTR boundary exists.

### Stage 6: Data-Alignment Review

Result: not reached.

Reason:

- no proposed MTR boundary exists.

### Stage 7: Admission Review

Result: not reached.

Reason:

- no boundary record exists;
- no MTR can be admitted from a source-family-only dry run.

### Stage 8: Candidate-Universe Ledger

Result: not reached.

Reason:

- no admitted boundary record exists;
- live ledger creation remains prohibited.

## Findings

The workflow behaves correctly for a source-family dry run:

- it allows source-family eligibility to be tested;
- it preserves the observed/modelled distinction;
- it blocks region naming by reputation;
- it prevents a source family from becoming a candidate MTR;
- it prevents live ledger creation.

## Methodology Gap Exposed

The current workflow has two distinct dry-run modes that should remain
separate:

1. Source-family dry run: tests source eligibility and verification without
   naming a region.
2. Proposed-MTR dry run: tests a filled boundary record for one explicitly
   labeled region without admitting it as a candidate.

This file performs only mode 1.

## Decision

Do not create a boundary record from this dry run.

Do not create a candidate-universe ledger from this dry run.

OECD observed FUAs remain an eligible source family for future proposed-MTR
testing, but no MTR is admitted.

## Next Step

If Thesis 2 needs a fuller test, run a separate proposed-MTR dry run using a
source-led proposed region and explicitly label it as dry-run-only.

