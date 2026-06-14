# BFS Value-Code Mapping

Status: schema/code-set verification record. Not data ingestion, quantitative
analysis, export, claim support, paper prose, or thesis evidence.

Run date: 2026-06-13.

## Official Sources Inspected

- Census BFS monthly data dictionary:
  `https://www.census.gov/econ/bfs/pdf/bfs_monthly_data_dictionary.pdf`
- Census BFS API examples:
  `https://api.census.gov/data/timeseries/eits/bfs/examples.json`
- Census BFS definitions:
  `https://www.census.gov/econ/bfs/definitions.html`
- Census BFS variables:
  `https://api.census.gov/data/timeseries/eits/bfs/variables.json`
- Census BFS geography:
  `https://api.census.gov/data/timeseries/eits/bfs/geography.json`

## API Metadata Findings

`variables.json` verifies exact fields but does not expose value labels for
`data_type_code` or `category_code`.

Variable-specific metadata endpoints:

- `variables/data_type_code.json`
- `variables/category_code.json`

Both expose only field labels.

Common value-list paths tried:

- `variables/data_type_code/values.json`
- `variables/category_code/values.json`
- `values/data_type_code.json`
- `values/category_code.json`

All returned HTTP 404.

## Official Example Query Shape

`examples.json` gives:

```text
get=data_type_code,time_slot_id,seasonally_adj,category_code,cell_value,error_data
time=2012
for=us:*
```

A keyed query using that shape returned:

- 5,544 rows excluding header;
- observed `time_slot_id=0`;
- observed `seasonally_adj` values `no` and `yes`;
- observed `data_type_code` values listed below;
- observed `category_code` values listed below except `NAICS92`, which is in
  the monthly data dictionary but did not appear in the 2012 observed set.

This was a schema/code-set check only. No BFS rows were stored in the database.

## Verified Data Type Codes

| Code | Meaning |
| --- | --- |
| `BA_BA` | Business Applications |
| `BA_CBA` | Business Applications from Corporations |
| `BA_HBA` | High-Propensity Business Applications |
| `BA_WBA` | Business Applications with Planned Wages |
| `BF_BF4Q` | Business Formations within Four Quarters |
| `BF_BF8Q` | Business Formations within Eight Quarters |
| `BF_PBF4Q` | Projected Business Formations within Four Quarters |
| `BF_PBF8Q` | Projected Business Formations within Eight Quarters |
| `BF_SBF4Q` | Spliced Business Formations within Four Quarters |
| `BF_SBF8Q` | Spliced Business Formations within Eight Quarters |
| `BF_DUR4Q` | Average Duration from Business Application to Formation within Four Quarters |
| `BF_DUR8Q` | Average Duration from Business Application to Formation within Eight Quarters |

## Target Measure Mapping

| Research Concept | BFS API Code |
| --- | --- |
| Business applications | `BA_BA` |
| High-propensity business applications | `BA_HBA` |
| Business formations within four quarters | `BF_BF4Q` |
| Business formations within eight quarters | `BF_BF8Q` |
| Projected business formations within four quarters | `BF_PBF4Q` |
| Projected business formations within eight quarters | `BF_PBF8Q` |

## Verified Category Codes

| Code | Meaning |
| --- | --- |
| `TOTAL` | Total for All NAICS |
| `NAICS11` | Agriculture |
| `NAICS21` | Mining |
| `NAICS22` | Utilities |
| `NAICS23` | Construction |
| `NAICSMNF` | Manufacturing |
| `NAICS42` | Wholesale Trade |
| `NAICSRET` | Retail Trade |
| `NAICSTW` | Transportation and Warehousing |
| `NAICS51` | Information |
| `NAICS52` | Finance and Insurance |
| `NAICS53` | Real Estate |
| `NAICS54` | Professional Services |
| `NAICS55` | Management of Companies |
| `NAICS56` | Administrative and Support |
| `NAICS61` | Educational Services |
| `NAICS62` | Health Care and Social Assistance |
| `NAICS71` | Arts and Entertainment |
| `NAICS72` | Accommodation and Food Services |
| `NAICS81` | Other Services |
| `NAICS92` | Public Administration |
| `NONAICS` | No NAICS Assigned |

## Remaining Blockers

- Inspected API geography metadata remains U.S.-only.
- Monthly CSV documentation includes states and regions, but API geography for
  those levels remains unverified.
- A later ingestion design must decide whether to use seasonally adjusted or
  not adjusted data.
- A later ingestion design must decide whether to include only target measure
  codes or also spliced/duration series.
- NAICS panel use remains blocked until sector-category handling,
  aggregate-category handling, `NONAICS` handling, and harmonization rules are
  explicit.

## Guardrail

BFS employer formations remain only an indirect payroll-transition proxy. BFS
is not nonemployer-to-employer conversion evidence and does not measure AI use,
Operator Nodes, one-human firms, nonemployer survival, hidden contractors,
management layers, transaction costs, or productivity.
