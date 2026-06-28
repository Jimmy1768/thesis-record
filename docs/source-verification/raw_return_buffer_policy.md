# Raw Return Buffer Policy

Status: platform policy.

## Purpose

External research outputs are useful, but they are not authoritative
ThesisRecord material. They may contain source leads, mistakes, unsupported
claims, premature rankings, incorrect folder suggestions, or methodology ideas
that need independent review.

ThesisRecord therefore requires a buffer between raw external returns and
accepted thesis material:

```text
raw return -> intake classification -> verified source note / methodology candidate / open question / rejected material
```

The buffer protects accepted work from raw values while preserving the raw
research history for audit.

## Core Rule

Raw external material must be preserved before it is interpreted.

Interpreted intake notes must be separate from raw returns.

Accepted source truth, evidence, methodology, claims, forecasts, and publication
prose must be separate from both raw returns and intake notes.

No item from a raw return can support a claim until its underlying source has
been independently inspected and converted into an appropriate ThesisRecord
artifact.

## What The Buffer Prevents

The buffer prevents:

- unverified claims from becoming source truth;
- source leads from becoming evidence;
- outside recommendations from becoming accepted methodology;
- incorrect suggested paths from reshaping the repository;
- premature rankings, scores, samples, or selections from entering accepted
  work;
- reputation-based or ranking-based inputs from contaminating sampling logic.

## What The Buffer Preserves

Raw returns should not be hidden merely because they are weak or wrong.

Preserve:

- full outside returns;
- mistakes and unsupported claims;
- rejected ideas;
- source leads not yet inspected;
- methodology alternatives;
- counterarguments;
- process history showing what was considered and why.

Rejection means quarantine, not deletion.

## Global Folder Convention

For each thesis:

```text
theses/<slug>/operator_records/external_returns/
theses/<slug>/research/intake/
```

Use `operator_records/external_returns/` for raw external returns. These are
operator/process artifacts, not evidence.

Use `research/intake/` for interpreted intake notes. These notes classify raw
material and decide what, if anything, may move into source notes, methodology
records, open questions, counterarguments, or rejected material.

Do not store raw external returns in:

- `evidence/`;
- `research/source_notes/`;
- `source_truth/`;
- `paper/`;
- publication folders.

## Naming Convention

Raw return pattern:

```text
YYYY-MM-DD-<topic>-raw-return.md
```

Intake note pattern:

```text
YYYY-MM-DD-<topic>-intake.md
```

Use a short, descriptive, lowercase topic slug:

```text
2026-06-28-mtr-boundary-source-scan-raw-return.md
2026-06-28-mtr-boundary-source-scan-intake.md
```

## Intake Classification

Every intake note should classify material into these sections when relevant:

- source leads;
- methodology candidates;
- open questions;
- counterarguments;
- rejected or quarantined items;
- process artifacts;
- immediate allowed uses.

The intake note must link to the raw return and state that the raw return is not
evidence, source truth, final methodology, accepted scoring, or accepted prose.

## Promotion Paths

Allowed paths:

- source lead -> verified source note;
- methodology candidate -> methodology record or rejection;
- open question -> research queue;
- counterargument -> criticism, falsifiability, or peer-review record;
- rejected item -> quarantine or rejection note;
- process history -> operator record only.

The underlying source must be independently inspected before any promoted item
can support a claim.

## App And Schema Implications

No Rails schema change is required for the current repository policy.

Later, if ThesisRecord productizes this workflow, candidate app concepts may
include:

- raw external return records;
- intake classification records;
- source-lead promotion links;
- rejection/quarantine links;
- audit events for promotion decisions.

Until then, the filesystem convention and written intake notes are the system of
record.

## Existing Thesis-Local Artifacts

Thesis-local formation artifacts may use older local paths. Do not rewrite them
solely for naming consistency.

New theses and new external research returns should use the global convention
above.
