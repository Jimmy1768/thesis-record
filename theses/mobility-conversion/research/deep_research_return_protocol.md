# Deep Research Return Protocol

Status: formation-stage workflow rule.

## Purpose

ChatGPT Deep Research can help with source discovery, terminology discovery,
methodology alternatives, and counterargument discovery. It cannot create
evidence or source truth by itself.

This protocol defines how outsourced research returns should be handled when
they come back to Thesis 2.

This protocol uses the raw-return buffer defined in
`theses/mobility-conversion/research/raw_return_buffer_protocol.md`.

Raw returns should be preserved first, then interpreted in a separate intake
note.

## Intake Classes

Each item in a Deep Research return must be classified into one of these
classes:

- source lead;
- methodology candidate;
- open question;
- counterargument;
- rejected material;
- process artifact.

No item should be classified as evidence at initial intake.

## Source Lead

A source lead is a cited or described source that may be worth inspecting.

Required fields before promotion to a source note:

- source title;
- source owner or publisher;
- URL, DOI, document identifier, or access path;
- publication or release date if available;
- claim the source might support;
- reason it matters for Mobility Conversion;
- verification status.

## Methodology Candidate

A methodology candidate is a possible definition, boundary rule, measurement
approach, comparison design, or failure rule.

It must not become accepted methodology until Thesis 2 records:

- what problem it solves;
- what assumptions it makes;
- what source classes it requires;
- what regions or data environments it excludes;
- how it could bias results;
- how it can fail.

## Open Question

An open question is a useful unresolved issue created or sharpened by the
return.

Open questions belong in `research/open_questions.md` or a more specific
methodology file.

## Counterargument

A counterargument is a reason the thesis framing, unit, outcome, axis, or method
may be wrong, unstable, biased, or too broad.

Counterarguments should be preserved even if they are inconvenient.

## Rejected Material

Reject material that:

- relies on city reputation;
- relies on livability rankings;
- recommends candidate MTRs before the protocol allows selection;
- scores cities or regions;
- treats GDP or wealth as the outcome;
- lacks traceable sources;
- confuses Metropolitan Transport Region with the prohibited transit-region expansion of MTR;
- mixes explanatory axes into outcome scoring;
- uses proprietary ranking methods that cannot be inspected.

## Process Artifact

The raw return may be stored under
`operator_records/external_query_tests/` as process history.

Raw returns should not be copied into `evidence/` or `research/source_notes/`
without processing.

## Promotion Gate

Nothing from a Deep Research return can support a claim until a Thesis 2 worker
has independently inspected the underlying source and created a source note or
methodology record.
