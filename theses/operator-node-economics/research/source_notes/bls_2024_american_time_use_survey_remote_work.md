# BLS American Time Use Survey, Remote Work Measures

## Verification Status

Status: verified_primary_source

Verification source: U.S. Bureau of Labor Statistics American Time Use Survey
home page, data files page, data dictionaries page, tables page, Handbook of
Methods overview, 2024 ATUS home-page chart, and 2024 ATUS interview-data
dictionary directly inspected on 2026-06-12.

## Bibliographic Reference

U.S. Bureau of Labor Statistics, American Time Use Survey, 2024 annual
estimates and public microdata documentation.

Official source paths inspected:

- https://www.bls.gov/tus/
- https://www.bls.gov/tus/data.htm
- https://www.bls.gov/tus/dictionaries.htm
- https://www.bls.gov/tus/tables.htm
- https://www.bls.gov/opub/hom/atus/
- https://www.bls.gov/tus/dictionaries/atusintcodebk24.pdf

## Source Type

Official federal household time-use survey.

## Evidence Category

- Remote employment evidence: partial work-at-home measurement.
- Contractor/vendor substitution evidence: no.
- AI-labor-service evidence: no.
- Firm-boundary evidence: no direct evidence.

## Core Claims

- ATUS measures how people spend time, including paid work.
- BLS publishes ATUS data files and data dictionaries.
- The 2024 ATUS home-page chart reports the percent of employed people who
  worked at home and at their workplace on days worked.
- ATUS microdata can identify work activities and location, including
  respondent home/yard and workplace.

## Evidence Used

The ATUS home page reports 2024 annual averages for employed people who worked
at home or at a workplace on days worked and notes that work at home includes
both scheduled and unscheduled work done at home.

The ATUS data-files page lists single-year microdata files through 2024 and
multi-year files through 2003-2024.

The 2024 ATUS interview-data dictionary states that the activity file includes
activity-level information including activity code, location, duration, and
start/stop times. It verifies `TEWHERE` as the edited activity-location field,
with value `1` for respondent home or yard and value `2` for respondent
workplace. It verifies `TRCODE` as the six-digit activity code and
`TUACTDUR24` as activity duration in minutes. It also verifies `TRDTIND1` as
the detailed industry recode for the main job and `TRDTOCC1` as the detailed
occupation recode for the main job.

## Relevance To TCE-P011

ATUS is a candidate public source for measuring whether remote/work-at-home
activity changes by occupation or industry over time. It is strongest as a
remote-work intensity and location source, not as an employment-boundary or
substitution source.

## Objections Or Limitations

- ATUS observes people and activities, not firms, vendor spend, node services,
  or AI labor services.
- Work at home is not identical to remote salaried employment; self-employed
  and other classes must be separated with linked CPS fields.
- ATUS does not prove AI caused any work-location change.
- ATUS does not measure output, productivity, transaction costs, or
  replacement of employees by nodes or AI labor services.

## Useful Short Quotations

- "Work at home"
- "respondent's workplace"

## Related Claims

- TCE-CLAIM-014
- TCE-P011
