# Evidence Signals

Status: intake stubs only. Not source truth, claim support, paper evidence, or
thesis validation.

Use this folder for weak but potentially useful leads:

- screenshots;
- social/news graphics;
- market signals;
- article leads;
- unexplained charts;
- claims that need source tracing;
- strategy-relevant observations that are not yet verified.

## Required Fields

Each signal file should state:

- `status`;
- `verification_status`;
- `evidence_use`;
- `claim_support`;
- source path or URL if available;
- exact claim observed;
- what is verified;
- what remains unverified;
- why the signal may matter;
- next verification action.

## Allowed Statuses

- `directional_signal_stub`
- `source_tracing_needed`
- `verification_in_progress`
- `promoted_to_source_note`
- `rejected`

## Promotion Rule

A signal can be promoted only after direct source inspection. Promotion should
create or update a source note under `research/source_notes/`, or move the item
to `rejected/` if it is unusable.

Signals must not update `research/claims_index.md`, paper prose, prediction
status, or claim support.
