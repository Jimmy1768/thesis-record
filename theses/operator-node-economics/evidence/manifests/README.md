# Data Manifests

Status: tracked metadata only.

Use this folder for acquisition manifests that describe local raw data files
without committing those files. A manifest entry should be created for each
future API query or downloaded source file before any analysis uses it.

Required fields are listed in `manifest_template.csv`.

Guardrails:

- A manifest is not evidence of an empirical result.
- A manifest does not authorize analysis by itself.
- Raw file paths should point to ignored local locations such as `data/raw/`.
- API keys, tokens, cookies, and local secrets must never be recorded here.
