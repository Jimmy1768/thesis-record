# BFS API Ingestion Scaffold

Status: metadata scaffold. Not API data collection, metric computation,
quantitative analysis, export, claim support, paper prose, or thesis evidence.

Run date: 2026-06-13.

## Purpose

Register the official Census Business Formation Statistics API as a future
public-source candidate while preserving existing schema blockers.

## Rails Task

```sh
bin/rails public_sources:bfs:scaffold
```

The task registers:

- `DataSource`
- `SourceAccessPath`
- `IntakeManifest`
- `SchemaVersion`

It does not query BFS data rows.

## Verified Exact API Metadata Fields

- `time`
- `data_type_code`
- `time_slot_id`
- `seasonally_adj`
- `program_code`
- `category_code`
- `geo_level_code`
- `time_slot_date`
- `time_slot_name`
- `cell_value`
- `error_data`

## Blockers Preserved

- `data_type_code` value mapping is verified for monthly BFS dictionary/API
  codes, but no data ingestion or metric computation is authorized.
- `category_code` mapping is verified for monthly BFS sector and aggregate
  codes, but no NAICS panel transformation is authorized.
- Inspected geography metadata remains U.S.-only.
- NAICS panel joins remain blocked until an ingestion design chooses sector
  categories, treatment of aggregate categories, and harmonization rules.

## Verified Code Mappings

Detailed mapping record:

- `research/data/bfs_value_code_mapping.md`

Target `data_type_code` mappings:

| Concept | API Code |
| --- | --- |
| Business applications | `BA_BA` |
| High-propensity business applications | `BA_HBA` |
| Business formations within four quarters | `BF_BF4Q` |
| Business formations within eight quarters | `BF_BF8Q` |
| Projected business formations within four quarters | `BF_PBF4Q` |
| Projected business formations within eight quarters | `BF_PBF8Q` |

The 2012 official API example-shape query returned 5,544 rows and observed
`time_slot_id=0` with `seasonally_adj` values `no` and `yes`. This was a
schema/code-set check only, not ingestion or analysis.

## Ingestion Design

Staging-schema design is documented in:

- `research/data/bfs_ingestion_design.md`

The design adds a `bfs_api_rows` staging table and a guardrail task, but it
does not authorize API pulls or row loading in this slice.

## Guardrail

BFS employer formations are only an indirect payroll-transition proxy. BFS is
not nonemployer-to-employer conversion evidence and does not measure AI use,
Operator Nodes, one-human firms, nonemployer survival, hidden contractors,
management layers, transaction costs, or productivity.
