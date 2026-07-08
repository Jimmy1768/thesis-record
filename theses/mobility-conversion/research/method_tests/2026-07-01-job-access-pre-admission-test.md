# Method Test: Job-Access Metric Pre-Admission

Date: 2026-07-01

Status: dry run. No outcome metric is accepted. No metric record is filled. No
score, ranking, weight, candidate MTR, or MTR comparison is authorized.

## Purpose

Test the outcome metric pre-admission matrix against one narrow candidate metric
idea before creating any filled metric record.

This is a gate test, not a metric proposal.

## Inputs

Pre-admission matrix:

- `theses/mobility-conversion/research/outcome_metric_pre_admission_matrix_2026-06-30.md`

Relevant source notes:

- `theses/mobility-conversion/research/source_notes/us_census_lehd_lodes_access_to_jobs_input_2026-06-30.md`
- `theses/mobility-conversion/research/source_notes/gtfs_schedule_outcome_input_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/gtfs_realtime_outcome_input_2026-06-28.md`

Relevant source-family summary:

- `theses/mobility-conversion/research/batch_o2c_access_to_opportunities_source_verification_summary_2026-06-30.md`

## Candidate Metric Idea

Working idea:

> Share of resident population in an MTR that can reach a defined number or
> share of jobs within a fixed travel-time threshold by scheduled public
> transport.

This idea is intentionally narrow:

- outcome dimension: `access_to_opportunities`;
- opportunity class: jobs only;
- network mode: scheduled public transport only;
- likely destination source: LEHD / LODES, for U.S. use only;
- likely network input: GTFS Schedule, if complete and current feeds exist;
- reliability modifier: GTFS Realtime only if archived and feed quality is
  documented.

This idea does not claim to measure:

- full access to opportunities;
- non-work access;
- car access;
- walking or cycling access beyond access/egress assumptions;
- affordability;
- safety;
- universal access;
- final MTR performance.

## Universal Gate Review

### U1. Outcome Fit

Gate result: partial pass.

The idea can measure one narrow access question: whether residents can reach
jobs within a travel-time threshold.

It does not measure full usable access because jobs are only one opportunity
class and scheduled public transport is only one mode.

Required label if ever recorded:

- `job_access_only`
- `scheduled_public_transport_only`
- `not_full_access_to_opportunities`

### U2. Source Authority And Source Role

Gate result: partial pass.

Known source roles:

- destination inventory: LEHD / LODES source note exists;
- network or service input: GTFS Schedule source note exists;
- travel-time or reliability input: GTFS Schedule can support scheduled travel
  time; GTFS Realtime can support reliability only with archival proof.

Missing or unresolved:

- population denominator source note for resident population at the required
  geography;
- specific GTFS feed inventory for any MTR;
- travel-time modelling method;
- access/egress walking-network source;
- source vintage alignment between jobs, population, boundary, and service.

### U3. MTR Boundary Fit

Gate result: fail.

No MTR boundary record is attached to this test.

Blocked items:

- no MTR geography;
- no boundary record dependency;
- no source-to-MTR crosswalk method;
- no test of LEHD geography against an MTR boundary;
- no test of GTFS service area against the same MTR boundary;
- no protection yet against service-derived geography becoming the denominator.

### U4. Denominator And Exposure

Gate result: fail.

The likely denominator is resident population inside the MTR, possibly by
small-area geography.

Blocked items:

- no population denominator source note selected for this metric idea;
- no denominator geography selected;
- no rule for residents outside scheduled public transport service areas;
- no treatment of students, non-workers, job seekers, informal workers, or
  workers with schedule constraints;
- no denominator vintage alignment.

### U5. Distribution And Equity Visibility

Gate result: fail.

The idea could hide distributional gaps if expressed only as an MTR average.

Blocked items:

- no distribution groups selected;
- no subgroup denominator selected;
- no treatment of low-income, disabled, age, caregiver, gendered, or shift-work
  access constraints;
- no suppressed-demand plan;
- no rule for reporting severe subarea failures alongside regional averages.

### U6. Missingness And Bias Class

Gate result: fail.

Known missingness and bias risks:

- U.S.-specific job source;
- formal-employment bias;
- scheduled-service bias;
- GTFS feed completeness bias;
- no informal transport treatment;
- no non-work opportunity treatment;
- no public transport affordability, safety, or universal-access constraints.

Provisional missingness class:

- `available_but_access_barrier_undermeasured`

Provisional comparability class:

- `within_region_only` until a boundary and source-family comparability plan is
  written.

## Dimension Gate Review: Access To Opportunities

Required source roles:

- destination inventory: partial pass through LEHD / LODES;
- population denominator: fail;
- network or service input: partial pass through GTFS Schedule source family;
- travel-time method or source: fail.

Required documentation before record:

- opportunity class: pass, jobs only;
- destination source: partial pass, LEHD / LODES;
- denominator: fail;
- boundary fit: fail;
- travel-time method: fail.

Common failure checks:

- jobs silently stand in for all opportunities: blocked by required label;
- destination presence treated as access: blocked, because travel-time method is
  missing;
- modelled accessibility score imported without decomposing inputs: not
  applicable yet;
- open POI completeness assumed neutral: not applicable to this narrow idea.

## Pre-Admission Decision

Decision: `needs_boundary_crosswalk_first`

Secondary blocking decisions:

- `needs_denominator_first`
- `needs_distribution_plan_first`
- `needs_missingness_plan_first`

Do not create a filled outcome metric record.

Rationale:

The source-family lead is real, but the idea cannot pass pre-admission without
an MTR boundary, denominator, source vintage alignment, distribution plan, and
travel-time method. Creating a metric record now would invite a false sense of
methodological readiness.

## Required Follow-Up Before Retest

Before this idea can be retested, Thesis 2 needs:

- a population denominator source note for access metrics;
- a generic source-vintage alignment rule for jobs, population, boundary, and
  service;
- a travel-time method note distinguishing scheduled, observed, modelled, and
  reliability-adjusted access;
- a distribution plan for regional averages versus subgroup/subarea results;
- a rule that public-transport-only job access cannot stand in for full
  usable access;
- eventually, a real MTR boundary record before any MTR-specific test.

## Stop Point

Stop before metric record creation.

No file should be created under:

`theses/mobility-conversion/research/outcome_metric_records/`

for this idea until the blocking gates are resolved and the pre-admission test
is rerun.
