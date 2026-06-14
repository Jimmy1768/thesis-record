# Repository Structure

ThesisRecord separates platform infrastructure from thesis-specific content.

## Root

- `README.md` describes the platform identity and first thesis metadata.
- `.gitignore` blocks local secrets, runtime files, local databases, and
  generated empirical data outputs.
- `data/` is reserved for platform-level templates or shared non-thesis
  fixtures.

## Platform Docs

- `docs/architecture/` documents repository and application structure.
- `docs/audit/` documents audit expectations.
- `docs/migration/` documents migration decisions and verification.
- `docs/operations/` documents sanitized operations examples and boundaries.
- `docs/source-verification/` documents source verification rules.
- `docs/thread-roles/` documents Control, Research, and Writer responsibilities.

## Rails App

- `thesis_record_app/` contains the Rails application.
- The app is currently migrated from the prior prototype with naming cleanup
  only.
- It is still effectively focused on Thesis 1 until a later multi-thesis schema
  introduces a first-class `Thesis` model.

## Thesis Content

Each thesis should live under `theses/<slug>/`.

For Thesis 1:

- `theses/operator-node-economics/thesis.yml` stores thesis metadata.
- `theses/operator-node-economics/source_truth/` stores thesis-specific research
  contracts, definitions, terminology, and falsifiability rules.
- `theses/operator-node-economics/research/` stores research body and source
  notes.
- `theses/operator-node-economics/evidence/` stores thesis-specific evidence
  material and public source manifests.
- `theses/operator-node-economics/paper/` stores paper scaffolding. The draft is
  intentionally held back until explicitly approved.
- `theses/operator-node-economics/operator_records/` stores historical operator
  execution records, returns, handoffs, and acceptances.
- `theses/operator-node-economics/peer_review/` stores peer review planning.

## Placement Rule

Platform-generic capabilities belong in `docs/`, `data/`, or
`thesis_record_app/`.

Thesis-specific evidence, claims, forecasts, source notes, paper material, and
operator records belong under `theses/<slug>/`.
