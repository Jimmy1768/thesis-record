# Evidence

This folder stores thesis-specific evidence intake, evidence metadata, and
checkpoint records for Operator Nodes.

## Folder Index

- `signals/` stores weak directional stubs, screenshots, article leads, market
  watch items, and other intake items that are not yet verified source truth.
- `manifests/` stores tracked public-source and dataset metadata, checksums,
  registry CSVs, and acquisition manifests. It does not store raw data.
- `snapshots/` stores future frozen evidence-state records for V1/V2/V3
  checkpoint review.
- `rejected/` stores reviewed items that were rejected as unusable,
  unverifiable, misleading, duplicate, or outside scope.

## Promotion Path

Use this hierarchy when deciding where a file belongs:

```text
signal -> verified source note -> claim review candidate -> accepted evidence snapshot
```

Signals are not source notes. Manifests are not empirical results. Snapshots are
not thesis verdicts unless a separate publication/checkpoint process says so.

## Guardrails

Raw, intermediate, processed, and analysis data outputs are intentionally
excluded from Git. Recreate or reacquire them through reviewed source workflows
rather than treating local files from the old repository as canonical.

Never store API keys, cookies, local secrets, private keys, raw private data,
database dumps, or machine-specific state in this folder.
