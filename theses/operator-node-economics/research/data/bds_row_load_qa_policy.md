# BDS Row-Load QA Policy

Status: policy gate defined and used for source-native row loading. Not metric
computation, quality review, export, prediction-link creation, analysis, claim
support, or paper prose.

Date: 2026-06-14.

## Purpose

Define the minimum quality gate that a future BDS source-row load must satisfy
before any persistence can be authorized.

This policy authorizes source-native row loading only. It does not authorize
metric definitions, metric observations, quality reviews, exports, prediction
links, analysis, or claim support.

## Policy Source

Canonical values live in:

- `thesis_record_app/config/thesis_record_policy.yml`
  under
  `public_ingestion_v1.bds_sector_age_size_public_file.parser_design_v1.row_load_qa_policy_v1`.

Rails guardrail:

```sh
bin/rails public_sources:bds:verify_row_load_policy
```

## Required Pre-Load Conditions

A future row load must preserve and reconcile against the full-file parser dry
run recorded in `research/data/bds_parser_dry_run.md`:

- dry run required before load;
- expected source rows: 104,880;
- zero bad-width rows;
- zero duplicate row-grain keys;
- observed year range: 1978-2023;
- sector count: 19;
- firm-age count: 12;
- firm-size count: 10;
- publication flags `D`, `S`, `X`, and `N` preserved before numeric coercion;
- source row hash required;
- load ID required;
- cleanup strategy required;
- rollback strategy required;
- idempotency required;
- post-load reconciliation required.

## Current Authorization State

The current policy still requires:

- `row_load_gate_v1.status = source_row_load_authorized`;
- `row_load_authorized = true`;
- `full_file_parser_authorized = true`;
- `parser_authorized = true`;
- `metric_definitions_authorized = false`;
- `metric_observations_authorized = false`;
- `quality_reviews_authorized = false`;
- `exports_authorized = false`;
- `prediction_links_authorized = false`;
- `analysis_authorized = false`;
- `claim_status_effect = unchanged`;
- loaded-table reconciliation against 104,880 source rows.

## Boundary

BDS remains employer-firm dynamics context only. This policy does not measure
AI adoption, nonemployers, hidden contractors, management layers, transaction
costs, Operator Nodes, one-person firms, or firm-boundary change.

## Next Gate

The source-row loader is recorded in `research/data/bds_source_row_load.md`.
The next slice can define draft-disabled BDS source-native metric definitions.
