# Living Forecast System

Status: system architecture for recurring evidence collection and forecast
updates. Not implementation code, empirical results, claim support, or paper
prose.

Run date: 2026-06-12.

Purpose: define how Operator Node Economics can become a living forecast
program: a recurring data and evidence pipeline that supports v0, v1, v2, v3,
and later updates without allowing automation to silently convert indicators
into claims.

## Core Principle

Automated jobs may update data, manifests, quality checks, and indicators.

Automated jobs must not update claim status, thesis status, or paper
interpretation without human review.

## Evidence Gate Pipeline

Evidence must move through locked gates before it can affect a prediction,
claim, snapshot, or publication.

Required order:

`collect -> verify -> validate -> compute -> classify -> review -> publish`

The forbidden shortcut is:

`collect -> interpret -> write`

### Gate 1: Collection

Question: do we have data or a source record?

Allowed outputs:

- raw public dataset fetched into approved storage;
- private source registered without raw public exposure;
- retrieval timestamp;
- checksum;
- access path;
- source metadata;
- collection status.

Not allowed:

- claim support;
- thesis interpretation;
- paper prose.

Example statuses:

- `raw_collected`
- `source_registered`
- `access_pending`
- `collection_failed`

### Gate 2: Verification

Question: is the source real, inspectable, and usable?

Required checks:

- primary source or reputable secondary source classification;
- exact citation;
- access path;
- source-note status;
- date or version;
- field or schema documentation where relevant;
- limitations.

Not allowed:

- treating source existence as support for the thesis.

Example statuses:

- `verified_primary_source`
- `verified_secondary_source`
- `metadata_verified_full_text_pending`
- `citation_needs_correction`
- `unverified`

### Gate 3: Validation

Question: is the data structurally usable?

Required checks:

- expected fields exist;
- units are known;
- time period is known;
- geography and industry granularity are known;
- missing or suppressed cells are handled;
- private identifiers are removed, hashed, or protected;
- schema version is recorded.

Not allowed:

- interpretation of directional meaning.

Example statuses:

- `schema_validated`
- `schema_partial`
- `validation_failed`
- `privacy_blocked`

### Gate 4: Metric Calculation

Question: what did the approved formula produce?

Metric calculation is math only. It can produce measures such as nonemployer
receipts by sector-year, revenue per employee, remote-work share, support-staff
ratio, vendor substitution share, transaction-cost measures, or node
feasibility indicators.

Not allowed:

- good-for-thesis or bad-for-thesis language.

Example statuses:

- `metric_computed`
- `metric_missing`
- `metric_not_comparable`
- `metric_suppressed`

### Gate 5: Evidence Classification

Question: what kind of evidence can this be?

Classification says what the evidence can speak to. It still does not decide
the thesis.

Allowed categories:

- `context`
- `forecast_baseline`
- `leading_indicator`
- `feasibility_case`
- `diffusion_evidence`
- `transaction_cost_evidence`
- `contradictory_evidence`
- `not_evidence`

### Gate 6: Human Review

Question: does this change a prediction or claim?

Only human review can decide:

- prediction remains unchanged;
- prediction becomes directionally consistent;
- prediction is weakened;
- prediction is contradicted;
- claim remains unsupported;
- claim gets weak support;
- claim gets support;
- claim is rejected.

Automation must not perform these changes.

### Gate 7: Publication

Question: what can be written publicly?

Only reviewed findings can enter:

- annual evidence snapshot;
- v1/v2/v3 checkpoint;
- appendix;
- dashboard;
- paper update.

Paper prose comes last.

Definition:

Evidence is not allowed to become interpretation until its source, schema,
metric, limitation, and review status are explicit. Until then, it is only
collected material.

## System Layers

| Layer | Role | Automation Status | Human Review Requirement |
| --- | --- | --- | --- |
| Theory layer | Versioned thesis, mechanisms, predictions, falsifiers, and update schedule. | Manual. | Required for any change. |
| Source layer | Source notes, bibliographic verification, source status, and access paths. | Partially automatable for metadata checks. | Required for source-truth promotion. |
| Data ingestion layer | Public datasets, company/node data, procurement/platform data, and case evidence. | Automatable with manifests and checksums. | Required when adding a new source class. |
| Measurement layer | Stable indicators, denominators, missing cells, and QA flags. | Automatable after design approval. | Required for new metrics or changed formulas. |
| Analysis layer | Descriptive summaries, comparison tests, forecast checks, and sensitivity runs. | Automatable after analysis design approval. | Required before interpretation. |
| Evidence registry | Links sources and metrics to predictions, criticisms, and claim candidates. | Partially automatable for traceability. | Required for status changes. |
| Publication layer | v0/v1/v2/v3 reports, appendices, dashboards, and update notes. | Partially automatable for tables. | Required for prose and claims. |

## Suggested Job Families

If implemented in a Rails stack, recurring Sidekiq jobs could include:

| Job Family | Purpose | Writes | Must Not Write |
| --- | --- | --- | --- |
| `FetchPublicDatasetJob` | Pull approved public datasets such as Census/NES/SUSB/BDS/BTOS when schemas are verified. | Raw ignored files, manifests, retrieval logs. | Claims or prose. |
| `ValidateDatasetManifestJob` | Verify checksums, row counts, headers, timestamps, and API-key redaction. | QA manifests and validation logs. | Data interpretation. |
| `IngestNodeNetworkMetricsJob` | Pull approved company/node operational metrics. | Private or permissioned raw data, privacy-filtered manifests. | Public claims before disclosure review. |
| `IngestExternalCaseEvidenceJob` | Track verified external node-like cases. | Case registry entries and source notes. | Feasibility or diffusion claim status without review. |
| `ComputeSectorIndicatorsJob` | Recompute approved descriptive indicators. | Ignored analysis outputs and tracked manifests. | Claim status. |
| `ComputeExposureIndicatorsJob` | Recompute approved AI-exposure variables after source design approval. | Exposure tables, manifests, QA reports. | Causal labels or sector rankings unless authorized. |
| `UpdateForecastDashboardJob` | Refresh dashboards from reviewed metrics. | Dashboard data artifacts. | Paper prose or thesis verdicts. |
| `GenerateEvidenceSnapshotJob` | Freeze a reproducible evidence snapshot for v1/v2/v3 review. | Snapshot manifests and appendix tables. | Final interpretation. |

## Data Tracks

Detailed data architecture for public exposure proxies, node feasibility, and
transaction-cost evidence is defined in
`research/data/ai_exposure_node_feasibility_architecture.md`.

### Public Baseline Track

Purpose:

- Track nonemployer/employer outcomes and firm dynamics over time.

Examples:

- NES.
- AIES-NES.
- SUSB.
- BDS.
- BFS when value-code and industry mappings are verified.
- BEA/BLS or concentration data after separate verification.

Use:

- Macro signal tracking.
- Boundary-outcome baselines.

Limit:

- Public baseline data usually does not identify AI use, hidden labor, or
  one-human operation.

### AI Exposure Track

Purpose:

- Track observed or proxied AI exposure by sector, occupation, firm size,
  function, or business unit.

Examples:

- BTOS/Bonney employer AI adoption after extract schema is verified.
- Occupation-weighted GenAI exposure after source acceptance.
- Direct node/company AI-use metrics where available.

Use:

- Exposure layer for forecast checks.

Limit:

- Employer AI adoption can support corporate-absorption alternatives as much
  as Operator Node predictions.

### Node Feasibility Track

Purpose:

- Test whether a node-like production unit can work in a bounded context.

Possible fields:

- human count;
- AI systems used;
- automated workflows;
- institutional memory;
- client count;
- revenue or output;
- repeat-client rate;
- delivery time;
- quality/rework;
- support labor;
- subcontractors;
- payroll/employees;
- management layers.

Use:

- Feasibility evidence.
- Case evidence.

Limit:

- A feasibility case does not prove broad diffusion.

### Transaction-Cost Track

Purpose:

- Measure whether market/protocol coordination costs fall relative to firm
  vendor or internal organization costs.

Possible fields:

- lead-to-contract time;
- proposal cost;
- legal-review time;
- procurement-cycle time;
- monitoring cost;
- dispute rate;
- rework rate;
- payment delay;
- change-order frequency;
- repeat-client rate.

Use:

- Strongest test of the Coasean/TCE mechanism.

Limit:

- Likely requires private procurement, platform, or company data.

## Evidence Registry Model

Every automated indicator should be traceable to:

- source;
- source status;
- retrieval time;
- schema version;
- transformation script;
- analysis script;
- manifest hash;
- metric definition;
- prediction link;
- criticism link;
- review status.

Minimum audit design is defined in:

- `research/data/audit_trail_minimum_design.md`

Suggested review statuses:

- `raw_collected`
- `schema_validated`
- `indicator_computed`
- `review_pending`
- `accepted_for_baseline`
- `accepted_for_forecast_check`
- `rejected_or_superseded`

Claim statuses should remain separate:

- `not_evidence`
- `forecast_baseline`
- `leading_indicator`
- `feasibility_case`
- `diffusion_evidence`
- `mixed`
- `adverse`
- `weak_support`
- `supported`
- `contradicted`

Only human review should move a claim status.

Failure-output policy:

- `research/data/failure_as_first_class_output_policy.md`

## Version Snapshot Rule

Current cadence and threshold values are controlled by the canonical policy
file:

- `thesis_record_app/config/thesis_record_policy.yml`

This document describes the rule structure. The policy file is the value source
for adjustable cadence and threshold settings.

Each publication version should freeze a snapshot:

- code commit;
- data manifests;
- ignored-output hashes;
- source-note statuses;
- prediction table;
- criticism table;
- open questions;
- accepted metrics;
- rejected metrics;
- claim-status review record.

Cadence, currently represented in policy:

- quarterly measurement updates;
- annual public evidence snapshots;
- v1 at 12 full quarters after v0;
- v2 at 20 full quarters after v0;
- v3 at 40 full quarters after v0.

v1, v2, and v3 should compare against prior snapshots, not against a moving
dashboard. Annual snapshots can report directional movement, but thesis
verdicts should wait for the scheduled checkpoints.

## Privacy And Disclosure Rules

Company/node data may be valuable but sensitive.

Detailed private-data governance is defined in
`research/data/private_data_governance.md`.

Before any company-derived metric becomes public evidence:

- remove client-identifying information;
- separate internal operational metrics from publishable aggregate metrics;
- document hidden labor and subcontractor handling;
- document whether the company is the subject, data provider, or
  implementation case;
- disclose when evidence comes from the user's company;
- avoid treating internal case evidence as broad market proof.
- apply the minimum public-cell rule and publish only aggregate, redacted, or
  hashed outputs after review.

## Implementation Build Plan

The implementation bridge from this research architecture to an application is
defined in:

- `research/data/living_dissertation_application_build_plan.md`

The build plan specifies a Rails, PostgreSQL, and Sidekiq system for private
evidence intake, validation, audit logs, reviewed exports, and versioned
evidence snapshots. It does not authorize data ingestion, claim promotion, or
paper prose.

## Failure Handling

If indicators move against the thesis:

- keep the data;
- publish the adverse update at the next scheduled version;
- classify the error using `research/forecast_versioning_framework.md`;
- decide whether to narrow, revise, defer, or reject the thesis.

Do not change definitions after seeing adverse data unless the revision is
explicitly documented.

## Implementation Boundary

This file does not implement Sidekiq, database schemas, dashboards, or API
clients.

It defines the research architecture a future implementation should obey.

Minimum implementation prerequisites:

- approved data-source registry;
- manifest schema;
- source-status workflow;
- indicator registry;
- private evidence storage and access-control design;
- claim-review workflow;
- privacy/disclosure policy for company or node data;
- source-specific private-data governance for HRIS, payroll, procurement,
  node, AI-labor-service, and experiencer/evaluation data;
- scheduled snapshot policy for v0/v1/v2/v3.

First selected private-data pilot:

- company operator network;
- governed by `research/data/company_operator_network_pilot_intake_plan.md`;
- no ingestion until private storage and empty intake manifest are created.

Current registry templates and validator:

- `data/manifests/exposure_source_registry_template.csv`
- `data/manifests/node_case_registry_template.csv`
- `data/manifests/transaction_cost_metric_registry_template.csv`
- `research/data/living_forecast_registry_templates.md`
- `research/data/living_forecast_registry_validator.py`

Current population policy and public baseline registry:

- `research/data/registry_population_policy.md`
- `data/manifests/exposure_source_registry.csv`

The populated exposure-source registry is forecast-baseline context only. It
does not authorize node, transaction-cost, diffusion, or firm-boundary claims.
