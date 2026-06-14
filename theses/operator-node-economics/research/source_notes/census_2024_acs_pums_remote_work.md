# Census ACS PUMS, Remote Work And Worker-Class Measures

## Verification Status

Status: verified_primary_source

Verification source: U.S. Census Bureau ACS program page, ACS PUMS page, and
2024 ACS PUMS Data Dictionary directly inspected on 2026-06-12.

## Bibliographic Reference

U.S. Census Bureau, American Community Survey Public Use Microdata Sample
files and 2024 ACS PUMS Data Dictionary.

Official source paths inspected:

- https://www.census.gov/programs-surveys/acs
- https://www.census.gov/programs-surveys/acs/microdata.html
- https://www2.census.gov/programs-surveys/acs/tech_docs/pums/data_dict/PUMS_Data_Dictionary_2024.pdf

## Source Type

Official federal household survey microdata.

## Evidence Category

- Remote employment evidence: partial worked-from-home commuting measure.
- Worker-class evidence: yes.
- Contractor/vendor substitution evidence: weak proxy through class of worker
  and self-employment only.
- AI-labor-service evidence: no.
- Firm-boundary evidence: indirect context only.

## Core Claims

- ACS provides annual social, economic, housing, demographic, employment,
  income, and transportation information.
- ACS PUMS files allow custom estimates that are not available through
  pretabulated ACS products.
- The 2024 ACS PUMS data dictionary verifies `JWTRNS` as means of
  transportation to work, with value `11` for worked from home.
- The 2024 ACS PUMS data dictionary verifies `COW` as class of worker,
  including private wage/salary employees, government employees,
  unincorporated self-employed, incorporated self-employed, and unpaid family
  workers.
- The 2024 ACS PUMS data dictionary verifies `INDP` as industry recode and
  `OCCP` as occupation recode.

## Evidence Used

The ACS page states that the ACS is an ongoing Census Bureau survey and covers
employment, income, housing, transportation, and other topics. The ACS PUMS
page states that PUMS files enable custom estimates and are available as
1-year and 5-year files.

The 2024 ACS PUMS data dictionary verifies relevant fields: `JWTRNS`, `COW`,
`INDP`, and `OCCP`. It verifies `JWTRNS=11` as worked from home, `COW=1`
through `5` as private/government wage or salary employee categories, `COW=6`
as self-employed in a not-incorporated business, and `COW=7` as self-employed
in an incorporated business. It also notes that `JWTRNS` is out of universe for
people not currently working or not at work in the reference period.

## Relevance To TCE-P011

ACS PUMS is the strongest public candidate for a first remote-employment
classification panel because it can combine worked-from-home status,
occupation, industry, and class of worker. It can distinguish wage/salary from
self-employed workers better than many aggregate tables.

## Objections Or Limitations

- ACS "worked from home" is a usual-commute measure, not a full remote-work
  intensity measure.
- ACS does not identify AI use, AI-labor-service purchases, node services,
  vendor spend, output, productivity, or replacement events.
- Class of worker is not the same as supplier type, node status, or contractor
  firm-vendor status.
- PUMS geography is limited by disclosure protection.

## Useful Short Quotations

- "Worked from home"
- "Class of worker"

## Related Claims

- TCE-CLAIM-014
- TCE-P011
