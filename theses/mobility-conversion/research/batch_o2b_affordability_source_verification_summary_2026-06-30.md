# Batch O2B Affordability Source Verification Summary

Date: 2026-06-30

Status: source-family verification summary. No outcome metric is accepted. No
metric record is filled. No score, ranking, weight, or MTR comparison is
authorized.

## Sources Inspected

- U.S. BLS Consumer Expenditure Surveys
- Eurostat Household Budget Surveys
- U.S. Census American Community Survey
- Eurostat income and living conditions / EU-SILC source family
- Existing GTFS fares source note from Batch O1

Source notes:

- `theses/mobility-conversion/research/source_notes/bls_consumer_expenditure_transport_affordability_input_2026-06-30.md`
- `theses/mobility-conversion/research/source_notes/eurostat_hbs_transport_affordability_input_2026-06-30.md`
- `theses/mobility-conversion/research/source_notes/us_census_acs_income_affordability_denominator_2026-06-30.md`
- `theses/mobility-conversion/research/source_notes/eurostat_eu_silc_income_affordability_denominator_2026-06-30.md`
- `theses/mobility-conversion/research/source_notes/gtfs_fares_outcome_input_2026-06-28.md`

## Core Finding

Affordability is not a fare metric.

The inspected sources separate into three affordability roles:

- household transport expenditure;
- income and distributional denominators;
- fare or trip-price inputs.

Each role is necessary, but none is sufficient alone. A later affordability
metric must connect transport costs to household resources and MTR geography
while preserving car-dependency, fare-policy, concession, and suppressed-demand
caveats.

## Verified Position Updates

### Household Transport Expenditure

BLS Consumer Expenditure Surveys and Eurostat Household Budget Surveys can
support transport cost-burden context. They are stronger than nominal fare
tables because they can include non-fare transport costs, but their published
geographies may not align with MTR boundaries.

### Income Denominators

ACS and Eurostat income/living-conditions data can support income and
distributional denominators. They do not measure transport cost, but they are
required to interpret whether a cost is affordable.

### Fare Inputs

GTFS fare data can support public transport price inputs where complete, but
fare data must be checked against agency fare policy documents and paired with
income or expenditure data before affordability claims are made.

### Car Dependency

Household transport expenditure is important because car-dependent access can
be expensive even where public transport fares are low or irrelevant. However,
high expenditure can mean poor access, constrained choice, long distances, or
forced vehicle ownership. It is not automatically high transport quality.

## Outcome-Design Implications

Batch O2B supports the following formation-stage rules:

- affordability must pair cost with income or household resources;
- nominal fare levels are not affordability;
- household transport expenditure is not access quality by itself;
- car-dependency costs must be visible where car travel is structurally
  necessary;
- expenditure geographies and income geographies must be crosswalked to the
  MTR boundary before metric testing;
- concession eligibility, fare caps, transfer rules, and eligibility friction
  need separate review where public transport fare burden is tested;
- suppressed trips and unaffordable foregone access must be treated as a
  missingness risk.

## Required Metadata For Later Affordability Metric Records

Any later proposed affordability metric record should include:

- cost type: fare, household expenditure, car cost, generalized cost,
  housing-plus-transport, or other;
- income or resource denominator;
- household unit and equivalization method, if any;
- covered modes;
- covered trip purposes;
- geography and MTR crosswalk method;
- data vintage and observation window;
- distributional breakdown availability;
- concession and fare-cap treatment;
- car-dependency caveat;
- suppressed-demand caveat;
- whether the metric measures observed spending, required spending, or
  modeled cost.

## Recommended Next Batch

Batch O2C should verify access-to-opportunities source families:

- employment location and worker-flow datasets;
- education, healthcare, grocery, public-service, and civic destination
  sources;
- population denominators;
- accessibility-model precedents;
- network/travel-time source dependencies.

## What This Batch Does Not Authorize

Batch O2B does not authorize:

- filling outcome metric records;
- accepting any affordability metric for candidate testing;
- calculating affordability scores;
- comparing MTRs;
- treating fares as affordability;
- treating household expenditure as access quality;
- treating income as transport performance;
- ignoring car-dependency or suppressed-demand costs.
