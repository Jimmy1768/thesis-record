# Operator Node Economics Retirement Audit

## Scope

This audit covers the old project repository originally located at:

`/Users/jimmy1768/Projects/operator-node-economics`

It was archived after the audit to:

`/Volumes/DevSSD/Projects/archive/operator-node-economics`

It compares the old repository to the migrated ThesisRecord repository:

`/Users/jimmy1768/Projects/thesis-record`

The old repository was inspected read-only during the audit. After the audit,
the whole repository was moved intact to DevSSD archive storage. No files inside
the old repository were edited, deleted, pruned, or copied selectively.

## Current Git State

- ThesisRecord: clean on `main`
- Old repository archive: clean on `main`

## Migration Status

The main thesis-specific records have been migrated into:

`theses/operator-node-economics/`

The prototype Rails app has been migrated and renamed into:

`thesis_record_app/`

The structured local PostgreSQL evidence data from
`living_dissertation_app_development` has been promoted into production
PostgreSQL and recorded in:

`theses/operator-node-economics/evidence/manifests/production_data_promotion_2026-06-14.md`

## Already Migrated

| Old path | New path | Status |
| --- | --- | --- |
| `data/manifests/` | `theses/operator-node-economics/evidence/manifests/` | Migrated |
| `docs/source_truth/` | `theses/operator-node-economics/source_truth/` | Migrated |
| `docs/operator/` and operator records | `theses/operator-node-economics/operator_records/` | Migrated / expanded |
| `research/` | `theses/operator-node-economics/research/` | Migrated |
| `paper/argument_map.md` | `theses/operator-node-economics/paper/argument_map.md` | Migrated |
| `paper/evidence_requirements.md` | `theses/operator-node-economics/paper/evidence_requirements.md` | Migrated |
| `paper/outline.md` | `theses/operator-node-economics/paper/outline.md` | Migrated |
| `paper/references.bib` | `theses/operator-node-economics/paper/references.bib` | Migrated |
| `peer_review/` | `theses/operator-node-economics/peer_review/` | Migrated |
| `living_dissertation_app/` | `thesis_record_app/` | Migrated with ThesisRecord naming cleanup |

Research, source-truth, peer-review, and manifest path comparisons found no
missing mapped files.

## Intentionally Not Migrated Yet

| Old path | Reason | Later decision |
| --- | --- | --- |
| `paper/draft.md` | Held back to avoid mixing old project-specific prose into the platform migration | Copy later to `theses/operator-node-economics/paper/draft.md` only if explicitly approved |

## Archival / Do Not Migrate By Default

The old repo still contains 45 generated or raw data files under:

- `data/raw/`
- `data/intermediate/`
- `data/processed/`
- `data/analysis/`

These files should not be copied wholesale into ThesisRecord. The structured
evidence rows derived from the old local database have already been promoted to
production PostgreSQL. If any generated CSV/JSON artifact is later needed as a
published or inspectable evidence artifact, promote it through a new manifest
and place it under the Thesis 1 evidence tree deliberately.

## Excluded / Never Migrate

The old repo contains local runtime and machine-specific files that should not
be migrated:

- `.env.local`
- `living_dissertation_app/log/`
- `living_dissertation_app/tmp/`
- `living_dissertation_app/tmp/local_secret.txt`
- old Rails cache files under `living_dissertation_app/tmp/cache/`
- old local app logs
- local runtime placeholders

The old sanitized example file
`living_dissertation_app/.env.production.example` has already been superseded by
the ThesisRecord production example in `thesis_record_app/`.

## Retirement Recommendation

Do not delete `/Volumes/DevSSD/Projects/archive/operator-node-economics` yet.

Recommended transition:

1. Keep the old repo read-only as archival/reference on DevSSD.
2. Decide explicitly whether to copy `paper/draft.md`.
3. Decide whether any of the 45 old raw/generated data files need curated
   evidence-artifact promotion.
4. After those decisions, delete the archived old repo only after a final
   approval.

The old repo is no longer the system of record for structured evidence data.
Production PostgreSQL under ThesisRecord is the canonical structured evidence
store.

## Deletion Gates

Delete the old repo only after all of these are true:

- ThesisRecord remains clean and pushed.
- Production ThesisRecord health checks pass.
- `paper/draft.md` has either been copied or explicitly abandoned.
- Old raw/generated data files have either been promoted by manifest or
  explicitly abandoned.
- No active docs, scripts, or operator handoffs reference the old path as an
  operational source.
- A final human approval says the archived old repo may be deleted.
