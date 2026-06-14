---
record_id: return-2026-06-11-data-storage-convention
record_type: return
workflow_id: 2026-06-11-data-storage-convention
status: completed
created_at: 2026-06-11T19:11:37+08:00
owner: Research
---

# Return: Data Storage Convention

## Scope

This Research pass added a raw-data storage convention so future empirical data
downloads can be kept out of git while committing reproducibility metadata. It
did not download raw data, create ingestion scripts, or run quantitative
analysis.

`paper/draft.md` was not edited.

## Files Changed

- `.gitignore`
- `data/README.md`
- `data/manifests/README.md`
- `data/manifests/manifest_template.csv`
- `research/data/acquisition_scaffold.md`
- `research/empirical_strategy.md`
- `docs/operator/returns/2026-06-11-data-storage-convention-return.md`

## Storage Policy Added

Ignored local-only paths:

- `data/raw/`
- `data/intermediate/`
- `data/processed/`

Tracked metadata path:

- `data/manifests/`

Manifest template fields:

- `dataset`
- `source_owner`
- `source_url`
- `query_or_file_url`
- `retrieved_at`
- `timezone`
- `http_status`
- `content_type`
- `content_length`
- `local_path`
- `sha256`
- `row_count`
- `field_list`
- `geography_predicates`
- `naics_vintage`
- `reference_year_or_period`
- `suppression_or_noise_fields`
- `source_note_status`
- `guardrail_notes`

## Research File Updates

- `research/data/acquisition_scaffold.md` now says raw data must not be
  committed, raw/intermediate/processed outputs are ignored, and manifests are
  tracked.
- SUSB 2022 U.S./state status is now
  `file_paths_verified_storage_rule_ready`: file paths are verified and a
  storage/manifest convention exists, but files were not downloaded.
- `research/empirical_strategy.md` now says any SUSB acquisition should create
  a manifest row first and download only into ignored `data/raw/`.

## Guardrails Preserved

- No raw data was downloaded.
- No quantitative analysis was run.
- No ingestion or cleaning script was added.
- No Operator Node claim was promoted.
- Census API row smoke tests remain blocked until a key is configured outside
  the repository.
- `paper/draft.md` remained untouched.

## Verification Commands

Run after editing:

```bash
git diff -- paper/draft.md
git diff --check
git check-ignore data/raw/example.txt data/intermediate/example.txt data/processed/example.txt
rg -n "data/raw|data/intermediate|data/processed|data/manifests|manifest_template|file_paths_verified_storage_rule_ready|No raw data|No quantitative analysis|Census API key" .gitignore data/README.md data/manifests/README.md research/data/acquisition_scaffold.md research/empirical_strategy.md docs/operator/returns/2026-06-11-data-storage-convention-return.md
rg -n "Buddh[i]sm|Tao[i]sm|Sun[y]ata|dependent[ -]originat[i]on|man[i]festo|conclus[i]ons?|firm is dea[d]|end of the fir[m]" data/README.md data/manifests/README.md research/data/acquisition_scaffold.md research/empirical_strategy.md docs/operator/returns/2026-06-11-data-storage-convention-return.md
rg -n "[ \t]+$" .gitignore data/README.md data/manifests/README.md data/manifests/manifest_template.csv research/data/acquisition_scaffold.md research/empirical_strategy.md docs/operator/returns/2026-06-11-data-storage-convention-return.md
git status --short
```

Results:

- `git diff -- paper/draft.md`: no output.
- `git diff --check`: passed with no output.
- `git check-ignore data/raw/example.txt data/intermediate/example.txt data/processed/example.txt`:
  returned all three ignored paths.
- Storage/guardrail scan returned expected matches for local data paths,
  manifest template, SUSB storage-ready status, no-raw-data language,
  no-analysis language, and Census API key blocker.
- Prohibited-foundation/polemical-language scan: no output.
- Trailing-whitespace scan: no output.
- `git status --short`: modified `.gitignore`, acquisition scaffold, and
  empirical strategy; new `data/` metadata files; new schema-smoke and
  storage-convention return records.

## Commit Status

No commit or push was performed for this slice.
