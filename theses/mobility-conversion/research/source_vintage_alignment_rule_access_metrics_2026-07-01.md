# Source-Vintage Alignment Rule For Access Metrics

Date: 2026-07-01

Status: formation-stage methodology rule. No outcome metric is accepted. No
metric record is filled. No score, ranking, weight, or MTR comparison is
authorized.

## Purpose

Define how source vintages must be handled before an access metric can pass
pre-admission.

This rule responds to the blocker identified in:

- `theses/mobility-conversion/research/method_tests/2026-07-01-job-access-pre-admission-test.md`

## Core Rule

An access metric must not combine jobs, population, boundary, service, and
travel-time inputs from materially different periods without an explicit
vintage alignment note.

The alignment note must state:

- source vintage for each input;
- whether the metric is same-year, windowed, or mixed-vintage;
- why the vintage mix is acceptable for the intended access question;
- which inputs are most likely to have changed;
- whether the result is eligible for cross-MTR comparison or only within-region
  testing.

## Required Vintage Fields

For access-to-opportunities metrics, record vintages for:

- MTR boundary;
- population denominator;
- destination inventory;
- service/network input;
- travel-time method input;
- fare or cost input, if used;
- safety or universal-access constraint, if used;
- crosswalk geography;
- observation window for any observed or reliability input.

## Alignment Classes

Allowed formation-stage alignment classes:

- `same_year_alignment`
- `short_window_alignment`
- `mixed_vintage_with_rationale`
- `historical_or_baseline_only`
- `not_aligned_do_not_compare`
- `unknown_vintage_do_not_use`

### Same-Year Alignment

Use when all major inputs refer to the same calendar year or reporting year.

This is preferred but not always possible.

### Short-Window Alignment

Use when major inputs fall within a documented short window.

For formation-stage testing, a two- to three-year window may be acceptable only
if:

- the access question is not sensitive to short-term shocks;
- service and population change are not known to be severe;
- the vintage mismatch is displayed in the metric record.

### Mixed-Vintage With Rationale

Use when inputs are outside a short window but still useful for a constrained
test.

Required:

- explain why the mismatch exists;
- identify the most volatile input;
- mark comparability as limited;
- prohibit final scoring from the result.

### Historical Or Baseline Only

Use when the metric intentionally describes a past condition or baseline.

Required:

- state the baseline year;
- do not mix with current-performance claims.

### Not Aligned Do Not Compare

Use when the metric may be useful for internal method development but should
not be compared across MTRs or used for candidate testing.

### Unknown Vintage Do Not Use

Use when any major input has unknown or unverifiable vintage.

This blocks record creation unless the record is explicitly a rejected or
quarantined method note.

## Volatility Flags

Every access metric should mark volatility risk for each input:

- `low_volatility`
- `medium_volatility`
- `high_volatility`
- `shock_affected`
- `unknown_volatility`

High-volatility inputs include:

- GTFS feeds and service calendars;
- real-time or reliability archives;
- fare policies;
- travel-time observations;
- fast-growth boundary edge areas;
- destinations affected by closures, remote work, or shocks.

Lower-volatility inputs may include:

- decennial or multi-year population baselines;
- stable official boundaries;
- fixed infrastructure networks.

Lower volatility does not eliminate the need to record vintage.

## Job-Access Retest Rule

For the first scheduled-public-transport job-access retest, minimum acceptable
vintage posture is:

- MTR boundary vintage recorded;
- LEHD / LODES job vintage recorded;
- ACS population estimate vintage recorded;
- GTFS feed version or retrieval date recorded;
- travel-time service day or analysis window recorded;
- crosswalk vintage recorded.

If these cannot be recorded, the test remains blocked.

Recommended pre-admission decision:

- `needs_boundary_crosswalk_first` if no MTR boundary exists;
- `needs_missingness_plan_first` if GTFS feed vintage or completeness is
  unclear;
- `eligible_for_proposed_metric_record` only if all major vintage fields are
  present and the result remains labelled as `scheduled_public_transport_job_access`.

## Prohibited Moves

Do not:

- combine current GTFS with old jobs and call it current access without caveat;
- combine old boundaries with current population without crosswalk review;
- treat missing source dates as neutral;
- compare MTRs when source vintages differ materially and the mismatch is not
  classified;
- use a mixed-vintage result for final scoring.

## Methodology Implication

Vintage alignment is not a polish step. It is part of the validity of the
metric. Access is a relationship among people, destinations, networks, and time;
if those inputs come from incompatible periods, the metric can describe a
fictional region.
