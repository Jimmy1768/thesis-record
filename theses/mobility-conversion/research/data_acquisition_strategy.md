# Data Acquisition Strategy

Date: 2026-07-01

Status: formation-stage strategy. No production collector, scheduled job,
Sidekiq worker, API integration, database table, evidence download, metric
record, score, ranking, or MTR comparison is authorized by this document.

## Decision

Mobility Conversion should begin with release-based and snapshot-based data
acquisition.

Do not build live collectors yet.

Do not use Sidekiq yet.

Do not mutate ThesisRecord platform infrastructure for Thesis 2 data collection.

The next implementation surface is an evidence manifest, not a background job.

## Rationale

The current Thesis 2 method state does not have:

- an admitted MTR boundary;
- a source-led MTR proposal;
- an MTR-specific source bundle;
- a filled outcome metric record;
- a selected routing or travel-time implementation;
- a live reliability requirement.

Most required sources are naturally release-based:

- statistical boundaries;
- ACS population and income;
- LEHD / LODES jobs;
- household expenditure;
- safety datasets;
- GTFS Schedule snapshots;
- official boundary releases;
- static destination inventories.

Live collection should be justified only if a metric requires observed or
reliability-adjusted service data that cannot be obtained from existing
archives.

## Acquisition Modes

Allowed formation-stage acquisition modes:

- `manual_release_archive`
- `bulk_file_download`
- `api_snapshot`
- `feed_snapshot`
- `official_page_archive`
- `source_note_only`
- `live_stream_deferred`

### Manual Release Archive

Use for official releases that are periodically published as files or tables.

Examples:

- boundary files;
- safety datasets;
- statistical releases;
- household survey extracts;
- PDF methodology documents.

Cadence:

- one archive per release used;
- refresh only when the metric or boundary record requires a newer vintage.

### Bulk File Download

Use for large released datasets.

Examples:

- LEHD / LODES files;
- official boundary geometries;
- national crash files;
- GTFS Schedule zip files where agencies publish static feeds.

Cadence:

- per source release or per analysis snapshot;
- no recurring download until a candidate MTR/source bundle exists.

### API Snapshot

Use for source APIs when a fixed query, response date, and geography are
recorded.

Examples:

- Census API queries;
- statistical data APIs;
- official open-data APIs.

Cadence:

- one snapshot per query/version used;
- no automated recurring calls during formation unless a method test requires
  repeated vintages.

### Feed Snapshot

Use for GTFS Schedule and similar feed files.

Requirements:

- feed URL;
- retrieval timestamp;
- feed version or checksum if available;
- agency/operator scope;
- license/reuse note;
- validation or completeness note;
- evidence that the feed is used only inside an independently defined MTR
  boundary.

Cadence:

- one feed snapshot per analysis date;
- repeat only when comparing different service dates or vintages.

### Official Page Archive

Use when the source is a methodology page, standard, or official documentation.

Requirements:

- URL;
- retrieval date;
- source authority;
- summary source note;
- archived artifact path if saved later.

Cadence:

- refresh only when source method or documentation changes.

### Source Note Only

Use when the current task is source-family verification, not evidence intake.

This is the default state for most current Thesis 2 documents.

### Live Stream Deferred

Use for GTFS Realtime or similar data that would require ongoing capture.

Live stream capture is deferred until all are true:

- an admitted or testable MTR boundary exists;
- a metric explicitly needs observed or reliability-adjusted travel time;
- no adequate public archive exists;
- feed list and operator completeness are known;
- storage, retention, and replay needs are documented;
- Infra thread approves any platform/service implementation.

## Source-Class Strategy

| Source class | Default mode | Cadence | Code needed now? | Notes |
| --- | --- | --- | --- | --- |
| MTR boundaries | manual release archive or bulk file download | per boundary release | no | Must precede MTR-specific metric tests. |
| ACS population/income | API snapshot or bulk file download | per estimate vintage | no | Record estimate type, vintage, geography, and margin-of-error handling. |
| LEHD / LODES jobs | bulk file download | per LODES vintage | no | U.S.-specific job opportunity source; not full opportunity access. |
| GTFS Schedule | feed snapshot | per analysis date/feed version | no | Snapshot only; no live collector. |
| GTFS Realtime | live stream deferred | only if reliability metric requires archive | no | Sidekiq/worker discussion belongs to Infra later. |
| Safety data | manual release archive or bulk file download | per release | no | Requires event type, exposure denominator, and geography crosswalk. |
| Household expenditure | manual release archive/API snapshot | per survey release | no | Usually not MTR-aligned without crosswalk/caveat. |
| Income/living conditions | API snapshot or release archive | per release | no | Denominator/context source, not transport performance. |
| Destination inventories | release archive, API snapshot, or source note only | per source vintage | no | Official registries preferred; OSM requires completeness caveat. |
| Fare policy | feed snapshot plus official page archive | per fare-policy date | no | GTFS fares alone are not affordability. |

## Storage Policy

Formation-stage storage should be manifest-first.

Do not store raw downloaded evidence in this repo until there is a documented
reason and acceptable file size/licensing posture.

Recommended locations:

- manifests: `theses/mobility-conversion/evidence/manifests/`
- source notes: `theses/mobility-conversion/research/source_notes/`
- method decisions: `theses/mobility-conversion/research/`
- raw outsourced research returns:
  `theses/mobility-conversion/operator_records/external_query_tests/`

If raw data is later archived, use a structure like:

```text
theses/mobility-conversion/evidence/raw/<source_family>/<vintage>/
```

Do not create that raw-data tree until a manifest is approved for a concrete
source bundle.

## Evidence Manifest Requirement

Every acquired source artifact needs a manifest before it can be treated as
evidence.

Minimum manifest fields:

- manifest id;
- acquisition status;
- source family;
- source authority;
- source URL or access path;
- acquisition mode;
- retrieval date;
- source vintage;
- geography;
- intended use;
- MTR dependency;
- boundary compatibility;
- license/reuse note;
- raw archive path, if archived;
- checksum, if available;
- source note path;
- known limitations;
- whether it is allowed for method testing;
- whether it is allowed for metric record creation;
- whether it is allowed for final evidence.

## Cadence Rule

Default cadence is source-release cadence, not application scheduling.

Use this hierarchy:

1. Source release cadence.
2. Analysis snapshot date.
3. Manual refresh when a metric retest requires it.
4. Live recurring collection only after a documented reliability metric need.

No formation-stage source requires Sidekiq.

## Trigger For Code

Write local acquisition code only when:

- a source bundle has a manifest;
- the source is needed for a specific method test or proposed metric record;
- manual acquisition would be error-prone or unreproducible;
- licensing and storage posture are acceptable;
- the output is an archived artifact or reproducible manifest, not a production
  service.

Write platform/worker code only when:

- repeated collection is required;
- local scripts are insufficient;
- retention and monitoring requirements exist;
- Infra thread approves ownership, deployment, storage, and scheduling.

## Sidekiq Decision

Do not use Sidekiq for Thesis 2 formation-stage research.

Sidekiq becomes relevant only if ThesisRecord becomes an operational collector
for live or recurring data. That would be an Infra-owned architecture decision,
not a Thesis 2 research-thread decision.

## GTFS Realtime Decision

Do not start a GTFS Realtime archive yet.

Before any GTFS Realtime archive:

- identify a real MTR boundary;
- identify all relevant operators and feeds;
- verify feed stability and license;
- define observation window;
- define retention and storage volume;
- prove that reliability-adjusted access is required;
- check whether an existing archive is available.

Until then, reliability remains a method requirement and source-family note, not
a live data pipeline.

## Immediate Next Work

Prepare a first evidence manifest only after a source-led MTR boundary/source
bundle exists.

Before that, useful non-code work is:

- boundary/candidate-universe readiness;
- source-led MTR proposal intake;
- manifest template refinement;
- deciding what raw artifacts, if any, are acceptable to store in repo.
