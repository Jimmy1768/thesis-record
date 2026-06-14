# NES And AIES-NES API Ingestion Readiness

Status: ingestion-readiness record only. Not an ingestion script and not
analysis.

Run date: 2026-06-11.

Purpose: define safe query and parsing rules for Census NES 2023 and
AIES-NES 2023 API responses before any transformation, joining, or analysis.

## Scope

Datasets:

- NES 2023 API: `https://api.census.gov/data/2023/nonemp`
- AIES-NES 2023 API: `https://api.census.gov/data/2023/aiesnonemp`

Evidence role:

- NES is nonemployer establishment and receipt measurement.
- AIES-NES is national employer/nonemployer revenue comparison measurement.
- Neither source measures AI use, one-human status, hidden contractors,
  survival, churn, transaction costs, or firm-boundary transition.

## Query Construction

Use the key-first query construction already verified in schema smoke tests:

```text
https://api.census.gov/data/2023/nonemp?key=${CENSUS_API_KEY}&get=...&...
https://api.census.gov/data/2023/aiesnonemp?key=${CENSUS_API_KEY}&get=...&...
```

Do not print, log, or commit the API key. Load it from ignored `.env.local`
only at execution time.

## NES Default-Class Checks

Official API variable metadata confirms:

- `LFO`: Legal form of organization code.
- `LFO_LABEL`: attribute label for `LFO`.
- `RCPSZES`: Sales, value of shipments, or revenue size of establishments
  code.
- `RCPSZES_LABEL`: attribute label for `RCPSZES`.

Tiny label probes confirmed:

| Field | Code | Label |
| --- | --- | --- |
| `LFO` | `001` | All establishments |
| `RCPSZES` | `001` | All establishments |

Default all-class NES query predicates:

- `LFO=001`
- `RCPSZES=001`

These are safe as all-class defaults for the inspected 2023 U.S. all-sector
queries. They still do not identify one-human businesses.

## NES Noise Fields

Official API variable metadata confirms:

- `NRCPTOT`: nonemployer sales, value of shipments, or revenue in thousands of
  dollars.
- `NRCPTOT_N`: noise range for nonemployer sales, value of shipments, or
  revenue.
- `NRCPTOT_N_F`: attribute flag for `NRCPTOT_N`.

Schema-only U.S. all-class NAICS query:

```text
get=NAICS2022,NAICS2022_LABEL,NESTAB,NRCPTOT,NRCPTOT_N,NRCPTOT_N_F
&LFO=001&RCPSZES=001&for=us:1
```

Observed response shape:

- Rows excluding header: 452.
- Rows with unexpected column count: 0.
- Header fields:
  `NAICS2022`, `NAICS2022_LABEL`, `NESTAB`, `NRCPTOT`, `NRCPTOT_N`,
  `NRCPTOT_N_F`, appended predicates `LFO`, `RCPSZES`, and `us`.
- Observed `NRCPTOT_N_F` flag counts: `G` = 452.

These are schema and noise-flag QA checks only, not receipt findings.

## AIES-NES Noise Fields

Official API variable metadata confirms:

- `RCPT_TOT_VAL`: employer sales, value of shipments, or revenue in thousands
  of dollars.
- `RCPT_TOT_VAL_NS`: nonemployer sales, value of shipments, or revenue in
  thousands of dollars.
- `RCPT_TOT_CV`: coefficient of variation for employer sales, value of
  shipments, or revenue.
- `RCPT_TOT_VAL_NS_N`: noise range for nonemployer sales, value of shipments,
  or revenue.
- `RCPT_TOT_VAL_NS_N_F`: attribute flag for `RCPT_TOT_VAL_NS_N`.

Cleaner schema-only query form:

```text
get=NAICS2017,NAICS2017_LABEL,GEO_ID,RCPT_TOT_VAL,RCPT_TOT_VAL_NS,
RCPT_TOT_CV,RCPT_TOT_VAL_NS_N,RCPT_TOT_VAL_NS_N_F,INDLEVEL,SECTOR,
SUBSECTOR,INDGROUP&YEAR=2023&for=us:1
```

Observed response shape:

- Rows excluding header: 425.
- Rows with unexpected column count: 0.
- Header fields:
  `NAICS2017`, `NAICS2017_LABEL`, `GEO_ID`, `RCPT_TOT_VAL`,
  `RCPT_TOT_VAL_NS`, `RCPT_TOT_CV`, `RCPT_TOT_VAL_NS_N`,
  `RCPT_TOT_VAL_NS_N_F`, `INDLEVEL`, `SECTOR`, `SUBSECTOR`, `INDGROUP`,
  appended predicates `YEAR` and `us`.
- Observed `RCPT_TOT_VAL_NS_N_F` flag counts: `G` = 425.

These are schema and noise-flag QA checks only, not employer/nonemployer share
findings.

## Predicate Column Rules

Census API responses append predicate columns to the response header.

Parser rules:

- Prefer not to request a field in `get=` when the same field is also supplied
  as an API predicate, unless duplicate headers are explicitly handled.
- Preserve appended predicate columns because they document the query cell.
- If a duplicate header appears, retain both raw columns during ingestion and
  map one canonical field only after verifying identical values.
- For AIES-NES, use the cleaner query form that does not request `YEAR` in
  `get=` when `YEAR=2023` is already a predicate.
- For NES, carry `LFO`, `RCPSZES`, and geography predicates from the appended
  predicate columns.

## Minimum Future Ingestion QA

Before creating any processed panel:

- Verify API response is JSON, not an HTML key or redirect error.
- Verify the exact header.
- Verify row widths match the header.
- Preserve noise fields and noise-flag attributes before numeric coercion.
- Preserve query predicates as fields in the raw parsed table.
- Verify all-class predicates `LFO=001` and `RCPSZES=001` where used.
- Keep NES 2022 NAICS and AIES-NES 2017 NAICS vintages separate until a
  crosswalk rule is selected.
- Do not compute shares, ratios, growth, rankings, or prediction outcomes in
  ingestion.

## Guardrails

- NES and AIES-NES are business-boundary measurement sources, not AI exposure
  sources.
- NES no-paid-employee status is not the same as one-human Operator Node
  status.
- AIES-NES employer and nonemployer values are separate fields, not row-level
  business classes.
- AIES-NES is national only in inspected API metadata.
- Do not treat nonemployer receipt growth or employer/nonemployer revenue
  comparisons as Operator Node evidence unless a separate verified AI exposure
  and hidden-labor design is added.
