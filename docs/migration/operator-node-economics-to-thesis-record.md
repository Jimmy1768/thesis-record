# Operator Node Economics to ThesisRecord Migration

## Status

The prior scaffold-only handoff is stale. The repository already contains local
commit `a5e654a` (`Migrate ThesisRecord scaffold`) on `main`, ahead of
`origin/main`.

This hardening pass keeps that commit. Do not revert it, rewrite history, or
push until push review is explicitly approved.

## Source and Target

- Old source repository: `/Users/jimmy1768/Projects/operator-node-economics`
- New repository: `/Users/jimmy1768/Projects/thesis-record`
- Product/platform: ThesisRecord
- Public path target: `sourcegridlabs.com/thesis`
- Rails app folder: `thesis_record_app`

## Thesis 1

- Title: Operator Nodes
- Subtitle: AI, Transaction Costs, and the Future of the Firm
- Category: Economics / Organizational Theory
- Slug: `operator-node-economics`
- Target directory: `theses/operator-node-economics/`

## Decisions Encoded

1. Keep `a5e654a`; do not revert or rewrite local history.
2. Hold back `paper/draft.md` initially.
3. Store public source manifests under
   `theses/operator-node-economics/evidence/manifests/`.
4. Keep the Rails migration as naming cleanup only; true multi-thesis schema is
   a later phase.
5. Keep sanitized deployment examples only.
6. Treat local Postgres data and local empirical output files as non-canonical.
7. Preserve historical operator records even when they mention old
   Living Dissertation phase names or old file paths.

## Exclusions

The migration must not commit:

- `paper/draft.md`
- `.env.local`
- real `.env` files
- runtime logs
- runtime tmp files
- local database files
- database dumps
- raw private data
- private keys
- machine-specific state

Committed `.keep` files under otherwise ignored runtime directories are allowed
only as directory placeholders.

## Current Layout

- Platform docs live under `docs/`.
- Root `data/` is reserved for shared platform templates and non-thesis
  fixtures.
- Thesis-specific content lives under `theses/operator-node-economics/`.
- Rails app source lives under `thesis_record_app/`.

## Next Migration Slices

1. Push review for the current local commits.
2. Add source-verification acceptance checks for the migrated evidence records.
3. Decide whether to copy `paper/draft.md` into
   `theses/operator-node-economics/paper/draft.md`.
4. Add a true multi-thesis schema with a first-class `Thesis` model.
5. Attach existing evidence rows to the `operator-node-economics` thesis.
