# Remote Employment Measurement Design

Status: research/data-source discovery and measurement design. Not analysis,
claim support, or paper prose.

Run date: 2026-06-12.

Purpose: identify the best path for testing `TCE-P011`, the strong-thesis
falsifier that remote salaried employment should decline in AI-exposed,
output-measurable digital roles if firms substitute node, vendor,
owner-operator, or AI-labor-service capacity.

## Core Measurement Problem

`TCE-P011` requires a chain that no verified public source currently observes
end to end:

1. remote salaried employee roles;
2. AI exposure or direct AI-labor-service availability;
3. substitution into nodes, vendors, owner-operators, contractors, or AI labor
   services;
4. stable or rising output;
5. sector/role comparability and confounder controls.

Public sources can measure pieces of this chain. They cannot yet prove
employment unbundling.

## Source Classes Inspected

| Source | Status | Best Use | Missing Link |
| --- | --- | --- | --- |
| BLS ATUS 2024 | verified_primary_source | Work-at-home/workplace activity by worker characteristics, occupation, and industry through tables or microdata. | No vendor/node/AI-labor-service substitution, output, or firm boundary. |
| Census ACS PUMS 2024 | verified_primary_source | Worked-from-home plus occupation, industry, and class-of-worker cells. | No AI use, output, vendor spend, or replacement event. |
| BLS CPS Contingent and Alternative Employment Arrangements 2023 | verified_primary_source | Independent-contractor, temporary-help, contract-firm, and traditional-arrangement shares by occupation/industry/class. | No remote-work location, AI use, output, or firm procurement. |
| Existing NES/AIES/SUSB/BDS sector panel | verified_primary_source from prior slices | Nonemployer and employer-side sector baselines. | No remote employment, AI use at nonemployers, contractor/vendor spend, or output per role. |
| Company/private HRIS-procurement-node data | governance design available; source-specific ingestion blocked | Direct substitution and output test if privacy/baseline rules are applied to a specific source. | Requires private storage, disclosure, confidentiality, hidden-labor review, aggregation rules, and comparison baselines before ingestion. |

## Candidate Public Test

The best public-only first pass is a weak, non-claim baseline:

- Unit: occupation-industry-year.
- Remote employment proxy: ACS PUMS `JWTRNS=11` among wage/salary workers
  defined by `COW` values for private and government employees.
- Owner-operator proxy: ACS PUMS self-employed `COW` values, split by
  incorporated and unincorporated self-employment.
- Alternative-arrangement proxy: BLS CPS contingent/alternative arrangement
  occupation and industry shares.
- AI exposure: BTOS/Bonney sector exposure or a later accepted
  occupation-weighted AI exposure source.
- Boundary context: NES/SUSB/AIES sector nonemployer/employer baselines where
  industry mappings permit.
- Public-source status: descriptive monitoring only. It can detect whether
  remote wage/salary work persists, grows, or declines in candidate roles, but
  cannot identify the destination of any displaced work.

Allowed interpretation:

- measurement baseline;
- forecast-monitoring design;
- possible early warning if remote salaried employment remains durable in
  high-exposure roles.

Not allowed:

- claim that AI displaced remote employees;
- claim that node substitution occurred;
- claim that remote work has already falsified or supported the thesis.

## Candidate Private Test

The strongest test likely requires company or partner data:

- HRIS/payroll role table: employee status, remote status, role, department,
  start/end dates, compensation, output unit if available.
- Procurement/vendor table: supplier type, service category, contract value,
  repeat purchase, project dates, dispute/rework/payment fields.
- AI-labor-service table: service purchased, capacity measure, usage period,
  human oversight, output unit, quality/rework.
- Node-case table: node operator count, employees, subcontractors, hidden
  labor, output, revenue, repeat clients, disclosure status.

This requires privacy/disclosure policy and baseline definitions before any
data ingestion.

Governance policy:

- `research/data/private_data_governance.md`

The private test remains blocked until a specific source passes storage,
disclosure, confidentiality, hidden-labor, baseline, and aggregation review.

## Exact Fields Verified

### ACS PUMS

Source note: `research/source_notes/census_2024_acs_pums_remote_work.md`

- `JWTRNS`: means of transportation to work; value `11` is worked from home.
- `COW`: class of worker. Values `1` through `5` cover private and government
  wage/salary employment; values `6` and `7` cover unincorporated and
  incorporated self-employment.
- `OCCP`: occupation recode for 2018 and later based on 2018 occupation codes.
- `INDP`: industry recode for 2023 and later based on 2022 industry codes.

### ATUS

Source note:
`research/source_notes/bls_2024_american_time_use_survey_remote_work.md`

- `TEWHERE`: activity location; value `1` is respondent home or yard and
  value `2` is respondent workplace.
- `TRCODE`: six-digit activity code.
- `TUACTDUR24`: activity duration in minutes.
- `TRDTIND1`: detailed industry recode.
- `TRDTOCC1`: detailed occupation recode.

### BLS CWS / Alternative Arrangements

Source note:
`research/source_notes/bls_2023_contingent_alternative_employment_arrangements.md`

The inspected public table verifies categories but not microdata field names:

- independent contractors;
- on-call workers;
- temporary help agency workers;
- workers provided by contract firms;
- traditional work arrangements;
- occupation, industry, class-of-worker, and multiple-jobholding tabulations.

## Compatibility Matrix

| Needed For TCE-P011 | ATUS | ACS PUMS | BLS CWS | NES/SUSB/AIES/BDS | Private Data |
| --- | --- | --- | --- | --- | --- |
| Remote work location | yes | yes, usual commute proxy | no | no | yes if collected |
| Salaried employee distinction | partial through linked CPS/class fields | yes via `COW` | yes in table categories | employer-side only | yes |
| Occupation | yes | yes | yes | no | yes if collected |
| Industry/sector | yes | yes | yes | yes | yes |
| Contractor/alternative arrangement | limited | weak self-employment proxy | yes | no | yes |
| Vendor spend | no | no | no | no | yes |
| Node/AI-labor-service use | no | no | no | no | yes if designed |
| Output per role | no | no | no | no | possible |
| Direct replacement event | no | no | no | no | possible |

## Decision

There is enough verified source architecture to implement a public
remote-employment monitoring baseline later. There is not enough public data to
test the strong substitution claim.

The public baseline can monitor a falsifier direction. If remote wage/salary
work remains durable or grows in AI-exposed, output-measurable roles, the
strong employment-unbundling thesis is under pressure. If remote wage/salary
work falls, the public data alone still cannot say whether the work moved to
nodes, vendors, owner-operators, AI labor services, offshoring, layoffs, or
ordinary office work.

The next gap is measurement governance, not source discovery:

- define private HRIS/procurement/node/AI-labor-service fields;
- decide disclosure and aggregation rules;
- define comparison baselines before data are observed;
- decide whether to build a public-only weak baseline first or wait for
  private substitution data.

Until that gap is closed, `TCE-P011` remains `candidate/falsifier` with no
claim support.
