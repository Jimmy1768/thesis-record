# Pre-Testing Rules

Date: 2026-06-28

Status: formation-stage rules. These rules permit disciplined boundary-record
testing. They do not approve candidate MTRs, final inclusion, scores, rankings,
or paper claims.

## Purpose

This file defines the remaining rules that must exist before any named
Metropolitan Transport Region can be tested through a boundary record:

- minimum scale;
- temporal window;
- missing-data failure;
- geographic stratification;
- cross-border handling;
- polycentric handling.

These rules work with:

- `theses/mobility-conversion/research/candidate_universe_testing_workflow.md`
- `theses/mobility-conversion/research/boundary_record_template.md`
- `theses/mobility-conversion/research/boundary_source_decision_record_2026-06-28.md`

## Rule 1: Minimum Scale

Do not use a single universal population cutoff during formation-stage testing.

Reason:

- verified source systems use different thresholds, building blocks, and
  purposes;
- a hard global cutoff would look objective while silently privileging some
  national statistical systems;
- the thesis unit is functional metropolitan transport geography, not city
  population size alone.

Formation-stage scale rule:

```text
A proposed MTR may be tested only if an eligible boundary source treats the
unit as a metropolitan, functional urban, commuting, labour-market, capital-city
functional, or official metropolitan statistical region.
```

The boundary record must still capture scale metadata:

- population estimate;
- population source and vintage;
- land area, if available;
- density or settlement pattern source, if available;
- source authority's own threshold, if any;
- whether the proposed unit is city-proper, urban core, functional region,
  statistical metro, or wider labour-market area.

Stop condition:

- reject or quarantine any proposal whose only support is city-proper identity,
  local familiarity, service area, built-up core, or reputation.

Open later decision:

- after source-led testing creates a set of records, decide whether the thesis
  needs population bands or a numeric lower bound.

## Rule 2: Temporal Window

Use source-vintage discipline instead of pretending all dimensions can share
one perfect year.

Formation-stage temporal rule:

```text
Boundary records must distinguish boundary vintage, geography release vintage,
source inspection date, and indicator data vintage.
```

Boundary source expectations:

- use the latest official or authority-recommended boundary release where
  possible;
- older authority-recommended boundaries may be used when the source authority
  explicitly warns against newer data or continues recommending the older
  geography;
- commute-derived boundaries must record `commuting_data_vintage`,
  `geography_release_vintage`, and `pandemic_or_remote_work_caveat`;
- post-2020 commute-derived boundaries require explicit remote-work and
  pandemic caveats;
- pre-2020 commute-derived boundaries require staleness caveats.

Indicator source expectations:

- record the year or period for every outcome or explanatory data source;
- do not mix pre-pandemic, pandemic, and post-pandemic values without flags;
- do not make trend claims unless the time series is deliberately constructed;
- prefer the most recent comparable data window for cross-region testing;
- allow dimension-specific vintages only when mismatch is recorded.

Stop condition:

- a proposed MTR cannot be admitted if its boundary vintage or geography
  release cannot be identified.

## Rule 3: Missing-Data Failure

Missing data is not neutral.

Formation-stage missing-data rule:

```text
Missing required boundary metadata blocks admission. Missing indicator data
creates a visible missingness flag and may block later comparison, but must not
be treated as zero, average, or high performance.
```

Boundary-level hard failures:

- no traceable boundary source;
- source class not allowed for denominator testing;
- missing source authority;
- missing geography release or source vintage;
- missing confidence class;
- missing caveats for commute-derived boundaries;
- service-derived boundary used as denominator;
- unexplained switch from one geography to another for convenience.

Indicator-level missingness categories:

- `available_on_boundary`
- `available_with_documented_crosswalk`
- `available_only_on_misaligned_geography`
- `available_but_not_comparable`
- `not_found`
- `not_applicable_with_rationale`

Admission implication:

- boundary hard failure means `not_admitted`, `needs_source_verification`,
  `needs_methodology_decision`, or `rejected_boundary_basis`;
- indicator missingness does not automatically reject boundary admission, but it
  must be recorded before any comparative analysis;
- if missingness systematically excludes weakly served populations, the record
  must be flagged for methodology review.

## Rule 4: Geographic Stratification

Do not stratify by country wealth, city reputation, transit reputation, or
livability standing.

Formation-stage stratification rule:

```text
Geographic stratification, if used, must be based on source-system coverage and
methodological comparability before it is based on region names.
```

Allowed formation-stage strata:

- source-system family, such as OECD/Eurostat FUA, national commuting zone,
  hybrid functional statistical region, official metro statistical region, or
  modelled functional region;
- world region or continent for coverage diagnostics;
- income-data availability class, if used only to audit bias and not to rank;
- data completeness class;
- governance-documentation availability class;
- urban-form documentation availability class.

Prohibited strata:

- famous transit cities;
- congested cities;
- highly ranked livability cities;
- "rich country" versus "poor country" as a selection device;
- places chosen because the expected result seems interesting.

Stop condition:

- if stratification would produce a list of familiar cities before boundary
  records exist, stop and return to source-family eligibility.

## Rule 5: Cross-Border Handling

Cross-border MTRs are allowed only as documented edge cases during formation.

Formation-stage cross-border rule:

```text
A cross-border proposed MTR may be tested only if the primary boundary source
or a documented fallback/validation source explicitly supports the cross-border
functional relationship.
```

Required documentation:

- countries or jurisdictions involved;
- whether the source geometry crosses the border or splits the region;
- commuting, travel-flow, service, or governance evidence for cross-border
  integration;
- indicator-data availability on both sides;
- currency, fare, income, safety, and service-data comparability issues;
- governance bodies and legal boundaries affecting transport access;
- whether border controls or legal constraints materially shape access.

Stop condition:

- do not merge adjacent national regions by intuition or map appearance;
- do not split a source-defined cross-border functional region without recording
  the source conflict and effect on access measurement.

Default status:

- `needs_methodology_decision` unless the source authority already defines the
  cross-border unit clearly enough for boundary testing.

## Rule 6: Polycentric Handling

Polycentric MTRs are not errors. They must be documented rather than forced
into a monocentric city model.

Formation-stage polycentric rule:

```text
A polycentric proposed MTR may be tested when the eligible boundary source
defines the region as one functional unit or when a documented source shows
material commuting, travel, service, or governance integration across centres.
```

Required documentation:

- main centres or nodes;
- source treatment of multiple cores;
- whether centres are merged by observed flows, statistical rules, or manual
  adjustment;
- whether one centre dominates the data or service geography;
- whether access indicators can be computed region-wide and by sub-centre;
- risk that averaging hides intra-region access inequality.

Stop condition:

- do not split a polycentric source-defined region merely to make the case look
  like a familiar city;
- do not merge nearby centres merely because they are close on a map or share
  a transit brand;
- do not let one famous centre stand in for the full MTR.

Default status:

- admissible only if the boundary record explains how polycentricity affects
  access measurement and later interpretation.

## Rule 7: Conflict Resolution

Boundary sources may disagree.

Formation-stage conflict rule:

```text
When sources disagree, prefer the highest-confidence eligible source class only
after documenting what the lower-confidence or overlay sources include and
exclude.
```

Default hierarchy:

1. observed functional region;
2. national commuting zone;
3. hybrid functional statistical region;
4. official statistical metro;
5. modelled functional region;
6. built-up urban core as overlay;
7. governance or service region as overlay;
8. service-derived source as indicator input only;
9. accessibility dataset geography as method precedent or validation.

Conflict notes must record:

- source that includes the largest functional area;
- source that best matches observed travel behaviour;
- source that best aligns with indicator data;
- source that best matches governance authority;
- populations included or excluded by each source;
- reason for choosing the test denominator.

## Rule 8: Pre-Testing Readiness

A named proposed MTR can be tested only after:

- source-family eligibility is established;
- a direct source note exists or is explicitly required;
- the non-selection filter is passed;
- the boundary record begins as `not_admitted`;
- scale metadata can be recorded;
- temporal metadata can be recorded;
- missing-data failure rules are applied;
- cross-border and polycentric issues are reviewed if relevant.

This readiness rule allows testing a proposed boundary. It does not approve
final inclusion.

## Updates To Open Questions

These rules answer the process-level question of what must exist before named
testing begins. They do not close all substantive methodology questions.

Still open:

- numeric scale threshold or population bands;
- maximum acceptable vintage gap;
- exact values for commute caveat fields;
- full current ONS TTWA method source;
- current Statistics Canada CMA/CA method source;
- final treatment of modelled functional regions;
- final candidate-universe ledger design.
