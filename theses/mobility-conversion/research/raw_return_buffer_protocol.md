# Raw Return Buffer Protocol

Status: formation-stage workflow rule.

## Purpose

Mobility Conversion uses a raw-return buffer between outside research outputs
and accepted ThesisRecord material.

The buffer exists because outsourced research can be useful without being
authoritative. Raw outputs may contain valuable leads, errors, weak claims,
incorrect paths, unsupported details, or premature synthesis. The project should
preserve them honestly without pretending they are evidence.

## Core Rule

Raw external material must be preserved before it is interpreted.

Interpreted intake must be separate from raw material.

Accepted source truth, evidence, methodology, and claims must be separate from
both.

```text
raw return -> intake classification -> verified source note / methodology candidate / open question / rejected material
```

## What The Buffer Protects

The buffer protects accepted work from raw values by preventing:

- unverified claims from becoming source truth;
- source leads from becoming evidence;
- outside recommendations from becoming methodology;
- incorrect suggested paths from reshaping the repo;
- premature rankings, scores, or MTR selections from entering accepted work.

The buffer also protects raw values from being hidden by preserving:

- the full outside return;
- mistakes and weak claims;
- rejected ideas;
- source leads that are not yet verified;
- reasoning that may later become useful;
- process history showing what was considered and why.

## Storage Rule

Raw returns belong under:

```text
theses/mobility-conversion/operator_records/external_query_tests/
```

Raw returns do not belong in:

- `evidence/`;
- `research/source_notes/`;
- `source_truth/`;
- `paper/`.

## Intake Rule

Each raw return should receive a separate intake note under:

```text
theses/mobility-conversion/research/
```

The intake note should classify material into:

- source leads;
- methodology candidates;
- open questions;
- counterarguments;
- rejected or quarantined items;
- immediate formation-stage uses.

The intake note should link to the raw artifact and state explicitly that the
return is not evidence, source truth, final methodology, or accepted scoring.

## Promotion Rule

No item from a raw return can support a claim until the underlying source is
independently inspected and converted into an appropriate ThesisRecord artifact.

Promotion paths:

- source lead -> verified source note;
- methodology candidate -> methodology record or rejection;
- open question -> research queue;
- counterargument -> criticism or falsifiability record;
- rejected item -> rejection note or quarantine section;
- process history -> operator record only.

## Rejection Is Not Deletion

Rejected material should remain visible in the raw artifact and, when important,
be summarized in the intake note.

This is intentional. The project should not hide failed leads, mistaken
suggestions, weak claims, or confusing outside framing. Preserving them makes
the research process auditable and prevents rediscovering the same mistake
later.

## Naming Convention

Recommended raw artifact pattern:

```text
YYYY-MM-DD-topic-raw-return.md
```

Recommended intake artifact pattern:

```text
topic_intake_YYYY-MM-DD.md
```

Use descriptive topic names, for example:

- `2026-06-28-mtr-boundary-source-scan-raw-return.md`
- `mtr_boundary_source_scan_intake_2026-06-28.md`

## Current Example

The first active example is:

- raw:
  `theses/mobility-conversion/operator_records/external_query_tests/2026-06-28-mtr-boundary-source-scan-raw-return.md`
- intake:
  `theses/mobility-conversion/research/mtr_boundary_source_scan_intake_2026-06-28.md`

The raw return is preserved as process history. The intake note extracts source
leads and methodology candidates while explicitly withholding evidence status.
