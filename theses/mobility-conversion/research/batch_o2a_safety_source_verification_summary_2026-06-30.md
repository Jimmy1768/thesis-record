# Batch O2A Safety Source Verification Summary

Date: 2026-06-30

Status: source-family verification summary. No outcome metric is accepted. No
metric record is filled. No score, ranking, weight, or MTR comparison is
authorized.

## Sources Inspected

- WHO Global status report on road safety 2023
- NHTSA Fatality Analysis Reporting System / FARS Encyclopedia
- FTA / NTD transit safety and security source family
- UK Department for Transport road accidents and safety statistics / STATS19
  source family

Source notes:

- `theses/mobility-conversion/research/source_notes/who_global_road_safety_2023_outcome_input_2026-06-30.md`
- `theses/mobility-conversion/research/source_notes/nhtsa_fars_safety_outcome_input_2026-06-30.md`
- `theses/mobility-conversion/research/source_notes/fta_ntd_safety_security_outcome_input_2026-06-30.md`
- `theses/mobility-conversion/research/source_notes/uk_dft_stats19_safety_outcome_input_2026-06-30.md`

## Core Finding

Transportation safety cannot be represented by one source family.

The inspected sources separate into four safety roles:

- global or national safety context;
- fatal road crash event data;
- transit safety and security incident data;
- police-reported casualty data with non-fatal injury detail.

Each role is useful, but each requires boundary, exposure, reporting, and
undermeasurement caveats before metric testing.

## Verified Position Updates

### WHO Road Safety

WHO road-safety reporting is useful for global and national context. It should
not be used as direct MTR safety performance because it is too coarse for MTR
boundary analysis.

### FARS

FARS is a strong U.S. fatal-crash source family. It can support fatal road
safety analysis where event locations can be crosswalked to an MTR boundary,
but it cannot represent serious injury, perceived safety, or all vulnerable
road-user harms by itself.

### FTA / NTD Safety And Security

FTA / NTD safety and security data are a separate transit safety source family.
They should not be collapsed into road crash sources, and they require
multi-agency completeness checks for MTR use.

### UK DfT / STATS19-Style Casualty Data

Police-reported casualty data can add non-fatal injury detail and vulnerable
road-user detail, but underreporting, severity definitions, and boundary
crosswalks must be documented.

## Outcome-Design Implications

Batch O2A supports the following formation-stage rules:

- safety is a Tier 1 usable-access dimension, not a secondary narrative issue;
- national road-safety context is not MTR performance;
- fatality-only metrics are incomplete and must be labelled as such;
- transit safety must be separated from road safety;
- pedestrian and cyclist safety should be separable where source fields allow;
- exposure denominators are required before rates are interpreted;
- underreporting and perceived-safety gaps must be explicit missingness
  classes, not hidden assumptions.

## Required Metadata For Later Safety Metric Records

Any later proposed safety metric record should include:

- event type: fatality, serious injury, injury, incident, security event,
  perceived safety, or other;
- covered modes and road users;
- reporting authority;
- reporting threshold and severity definition;
- geography and MTR crosswalk method;
- data vintage and observation window;
- exposure denominator source;
- underreporting caveat;
- vulnerable-road-user availability;
- transit-versus-road scope;
- whether suppressed demand is likely undermeasured.

## Recommended Next Batch

Batch O2B should verify affordability source families:

- household expenditure surveys;
- income distribution sources;
- public transport fare-policy sources beyond GTFS fares;
- car ownership and operating-cost sources;
- housing-plus-transport cost methods, if source and method are inspectable.

## What This Batch Does Not Authorize

Batch O2A does not authorize:

- filling outcome metric records;
- accepting any safety metric for candidate testing;
- calculating safety scores;
- comparing MTRs;
- treating WHO national data as MTR safety performance;
- treating fatality data as complete safety performance;
- treating transit safety data as a replacement for road-user safety;
- ignoring perceived safety, underreporting, or suppressed demand.
