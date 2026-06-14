# Remote Employment Source Discovery Return

Date: 2026-06-12

Role: Research

Slice: TCE-P011 public-source discovery and measurement design.

## Summary

This pass identified public sources for a conservative remote-employment
monitoring baseline. It did not run quantitative analysis and did not promote
any Operator Node claim.

Core result: public sources can monitor remote work, worker class, occupation,
industry, work-location intensity, and alternative-arrangement context. They
cannot directly test whether firms replaced remote employees with nodes,
vendors, owner-operators, or AI labor services while preserving output.

## Files Changed

- `research/source_notes/bls_2024_american_time_use_survey_remote_work.md`
- `research/source_notes/census_2024_acs_pums_remote_work.md`
- `research/source_notes/bls_2023_contingent_alternative_employment_arrangements.md`
- `research/data/remote_employment_measurement_design.md`
- `research/data/field_dictionary.md`
- `research/predictions.md`
- `research/empirical_strategy.md`
- `research/reading_queue.md`
- `paper/evidence_requirements.md`
- `docs/operator/returns/2026-06-12-remote-employment-source-discovery-return.md`

## Sources Inspected

Verified primary sources:

- U.S. Bureau of Labor Statistics, American Time Use Survey home page:
  https://www.bls.gov/tus/
- U.S. Bureau of Labor Statistics, ATUS data files:
  https://www.bls.gov/tus/data.htm
- U.S. Bureau of Labor Statistics, ATUS data dictionaries:
  https://www.bls.gov/tus/dictionaries.htm
- U.S. Bureau of Labor Statistics, ATUS tables:
  https://www.bls.gov/tus/tables.htm
- U.S. Bureau of Labor Statistics, ATUS Handbook of Methods overview:
  https://www.bls.gov/opub/hom/atus/
- U.S. Bureau of Labor Statistics, 2024 ATUS interview-data dictionary:
  https://www.bls.gov/tus/dictionaries/atusintcodebk24.pdf
- U.S. Census Bureau, American Community Survey program page:
  https://www.census.gov/programs-surveys/acs
- U.S. Census Bureau, ACS PUMS page:
  https://www.census.gov/programs-surveys/acs/microdata.html
- U.S. Census Bureau, 2024 ACS PUMS Data Dictionary:
  https://www2.census.gov/programs-surveys/acs/tech_docs/pums/data_dict/PUMS_Data_Dictionary_2024.pdf
- U.S. Bureau of Labor Statistics, Contingent and Alternative Employment
  Arrangements, July 2023, table of contents:
  https://www.bls.gov/news.release/conemp.toc.htm
- U.S. Bureau of Labor Statistics, Contingent and Alternative Employment
  Arrangements, July 2023, Table 6:
  https://www.bls.gov/news.release/conemp.t06.htm

## Exact Fields Verified

ACS PUMS 2024:

- `JWTRNS`: means of transportation to work; value `11` is worked from home.
- `COW`: class of worker; values `1` through `5` cover private/government
  wage or salary employee categories; values `6` and `7` cover unincorporated
  and incorporated self-employment.
- `OCCP`: occupation recode for 2018 and later based on 2018 occupation codes.
- `INDP`: industry recode for 2023 and later based on 2022 industry codes.

ATUS 2024:

- `TEWHERE`: activity location; values include respondent home or yard and
  respondent workplace.
- `TRCODE`: six-digit activity code.
- `TUACTDUR24`: activity duration in minutes.
- `TRDTIND1`: detailed industry recode for main job.
- `TRDTOCC1`: detailed occupation recode for main job.

BLS Contingent and Alternative Employment Arrangements:

- Public table categories verified: independent contractors, on-call workers,
  temporary help agency workers, workers provided by contract firms,
  traditional arrangements, occupation, industry, class of worker, and
  multiple jobholding.
- Microdata field names were not mapped in this slice.

## Measurement Design Decision

Public-source baseline:

- Unit candidate: occupation-industry-year.
- Remote wage/salary proxy: ACS PUMS worked-from-home by class of worker.
- Work-location intensity proxy: ATUS work activities by location, duration,
  occupation, and industry.
- Alternative-arrangement context: BLS contingent and alternative-arrangement
  table categories.
- Boundary context: existing NES/AIES-NES/SUSB/BDS sector architecture.

Allowed interpretation:

- descriptive monitoring baseline;
- possible falsifier-direction monitoring for durable or growing remote
  wage/salary employment in AI-exposed, output-measurable roles.

Not allowed:

- claim that AI displaced remote employees;
- claim that node substitution occurred;
- claim that public data prove support for TCE-P011.

## Claims Changed

No claim status was promoted.

TCE-P011 remains `candidate/falsifier` and blocked for support. The docs now
distinguish public monitoring fields from the private/direct substitution
fields required for stronger evidence.

## Remaining Gap

The next gap is measurement governance for direct substitution data:

- private HRIS/payroll fields for remote employee roles;
- procurement/vendor-master fields for vendor or contractor replacement;
- AI-labor-service usage and spend fields;
- node-case fields and hidden-labor checks;
- role-level output metrics;
- disclosure, aggregation, and comparison-baseline rules before ingestion.

## Verification

Commands run:

```sh
git diff -- paper/draft.md
git diff --check
rg -n "TCE-P011|JWTRNS|COW|TEWHERE|TRCODE|TUACTDUR24|TRDTIND1|TRDTOCC1|candidate/falsifier|claim_support_updated=false" research paper docs/operator/returns/2026-06-12-remote-employment-source-discovery-return.md
rg -n "philosophical|religious|man[i]festo|write paper conclus[i]ons?|paper conclus[i]ons?|firm is dea[d]|end of the fir[m]" research/data/remote_employment_measurement_design.md research/data/field_dictionary.md research/predictions.md research/empirical_strategy.md research/reading_queue.md paper/evidence_requirements.md docs/operator/returns/2026-06-12-remote-employment-source-discovery-return.md
rg -n "[ \t]+$" research/source_notes/bls_2024_american_time_use_survey_remote_work.md research/source_notes/census_2024_acs_pums_remote_work.md research/source_notes/bls_2023_contingent_alternative_employment_arrangements.md research/data/remote_employment_measurement_design.md research/data/field_dictionary.md research/predictions.md research/empirical_strategy.md research/reading_queue.md paper/evidence_requirements.md docs/operator/returns/2026-06-12-remote-employment-source-discovery-return.md
```

Results:

- `paper/draft.md` remained untouched.
- `git diff --check` passed.
- Narrow scan showed TCE-P011 remains a candidate/falsifier with public
  monitoring fields and no claim-support promotion.
- Prohibited-foundation scan returned no matches.
- Trailing-whitespace scan returned no matches.

## Commit

Ready to commit as a research/data-architecture slice.
