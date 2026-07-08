# Distribution Plan For Access Metrics

Date: 2026-07-01

Status: formation-stage methodology plan. No outcome metric is accepted. No
metric record is filled. No score, ranking, weight, or MTR comparison is
authorized.

## Purpose

Define minimum distributional visibility before an access metric can pass
pre-admission.

This plan responds to the blocker identified in:

- `theses/mobility-conversion/research/method_tests/2026-07-01-job-access-pre-admission-test.md`

## Core Rule

An MTR-wide average is not sufficient by itself.

Any proposed access metric must state how it will show:

- regional average;
- subarea distribution;
- population-weighted exposure;
- low-access tail;
- subgroup visibility where source support exists;
- suppressed-demand and undermeasurement risks.

If distribution cannot be reported, the metric may still be useful for method
development, but it should not be eligible for candidate testing without a
specific rationale.

## Required Distribution Fields

Every access metric idea must document:

- denominator population;
- smallest feasible reporting geography;
- whether results are population weighted;
- whether regional averages are reported;
- whether subarea distribution is reported;
- whether low-access percentiles or thresholds are reported;
- subgroup dimensions available;
- subgroup dimensions unavailable;
- suppressed-demand caveat;
- source-rich-area bias risk;
- rule for displaying severe access gaps.

## Default Reporting Structure

A proposed access metric should aim to report:

1. MTR-wide population-weighted result.
2. Distribution across small-area residential geographies.
3. Low-access tail, such as bottom quintile or share below threshold.
4. Subgroup results where source support exists.
5. Missingness and undermeasurement notes.

The exact thresholds are not set here. They must be chosen in the specific
metric record or method test.

## Subarea Distribution

Subarea reporting should use the smallest geography that can be responsibly
crosswalked to the MTR boundary and denominator source.

For U.S. ACS-based tests, possible geographies may include tract, block group,
or other Census summary geographies depending on estimate quality, margin of
error, and source compatibility.

Subarea reporting must not:

- switch numerator and denominator geographies without disclosure;
- exclude unserved areas because network data are missing;
- smooth away boundary-edge gaps without caveat;
- hide source uncertainty in small-area estimates.

## Subgroup Visibility

Subgroup reporting should be used when source support permits.

Candidate subgroup dimensions:

- income or poverty status;
- age;
- disability;
- household vehicle access;
- household type;
- race/ethnicity, where ethically and legally appropriate;
- commute mode or worker status, where relevant;
- caregiver or household composition proxies, where available.

Subgroup reporting must include caveats for:

- margin of error;
- privacy suppression;
- incompatible geographies;
- categories that do not capture lived access barriers;
- missing gendered safety, harassment, disability, or language-access barriers.

## Low-Access Tail

Each access metric should try to identify the low-access tail.

Candidate approaches:

- share of population below an access threshold;
- bottom quintile of small-area access;
- population in areas with no feasible service;
- population with access only outside relevant time windows;
- subgroup share below threshold.

The low-access tail must be reported alongside any regional average when
available.

## Suppressed Demand

Access metrics can miss people who do not travel because travel is unsafe,
unaffordable, too slow, physically inaccessible, or unreliable.

Every access metric should state whether suppressed demand is:

- directly measured;
- indirectly flagged;
- likely but unmeasured;
- not applicable with rationale.

For first-pass job-access tests, suppressed demand is likely undermeasured.

## Job-Access Retest Rule

For the first scheduled-public-transport job-access retest, minimum
distribution posture is:

- resident population denominator selected;
- subarea reporting geography selected;
- regional average allowed only alongside subarea distribution;
- low-access tail rule selected;
- subgroup availability assessed, at least for income and vehicle access if ACS
  geography permits;
- suppressed-demand caveat recorded;
- formal-employment and scheduled-service bias recorded.

If these cannot be documented, the test remains blocked by:

- `needs_distribution_plan_first`
- `needs_missingness_plan_first`

## Prohibited Moves

Do not:

- report only a regional average and call it MTR access;
- allow served-population share to replace total resident denominator;
- hide unserved areas outside feed/service geography;
- treat no observed trips as no access problem;
- treat missing subgroup data as equal access;
- use distribution fields as ranking weights during formation.

## Methodology Implication

Mobility Conversion cannot honestly test usable access if regional averages
hide who is excluded. Distribution is not an optional equity add-on; it is part
of whether an MTR converts transport resources into usable access for its
population.
