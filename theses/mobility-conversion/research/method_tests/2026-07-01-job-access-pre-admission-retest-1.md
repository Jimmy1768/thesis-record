# Method Test: Job-Access Metric Pre-Admission Retest 1

Date: 2026-07-01

Status: dry run retest. No outcome metric is accepted. No metric record is
filled. No score, ranking, weight, candidate MTR, or MTR comparison is
authorized.

## Purpose

Rerun the narrow scheduled-public-transport job-access pre-admission test after
creating the first blocker-resolution notes.

This is still a gate test, not a metric proposal.

## Inputs

Original test:

- `theses/mobility-conversion/research/method_tests/2026-07-01-job-access-pre-admission-test.md`

Pre-admission matrix:

- `theses/mobility-conversion/research/outcome_metric_pre_admission_matrix_2026-06-30.md`

New blocker-resolution notes:

- `theses/mobility-conversion/research/source_notes/us_census_acs_population_denominator_access_input_2026-07-01.md`
- `theses/mobility-conversion/research/travel_time_method_note_access_metrics_2026-07-01.md`
- `theses/mobility-conversion/research/source_vintage_alignment_rule_access_metrics_2026-07-01.md`
- `theses/mobility-conversion/research/distribution_plan_access_metrics_2026-07-01.md`

Existing source notes:

- `theses/mobility-conversion/research/source_notes/us_census_lehd_lodes_access_to_jobs_input_2026-06-30.md`
- `theses/mobility-conversion/research/source_notes/gtfs_schedule_outcome_input_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/gtfs_realtime_outcome_input_2026-06-28.md`

## Candidate Metric Idea Retested

Working idea:

> Share of resident population in an MTR that can reach a defined number or
> share of jobs within a fixed scheduled-public-transport travel-time threshold.

Required label:

- `scheduled_public_transport_job_access`

Required exclusions:

- not full access to opportunities;
- not observed travel time;
- not reliability-adjusted unless an archive exists;
- not car access;
- not affordability;
- not safety;
- not universal access;
- not final MTR performance.

## Retest Findings

### Previously Blocked: Population Denominator

Updated status: partial pass.

The ACS population denominator source note now provides a credible U.S.
resident-population denominator family for a U.S.-only scheduled public
transport job-access test.

Still unresolved:

- no specific ACS geography selected;
- no MTR boundary crosswalk;
- no margin-of-error rule for selected geography;
- no rule yet for daytime population or inbound commuters.

Pre-admission implication:

- no longer blocked by absence of a denominator source family;
- still blocked by MTR boundary and denominator geography.

### Previously Blocked: Travel-Time Method

Updated status: partial pass.

The travel-time method note now gives the required class for this retest:

- `scheduled_travel_time`

The retest should not include reliability adjustment unless an archived
GTFS Realtime or operations source exists.

Still unresolved:

- no routing engine or travel-time computation method selected;
- no service day or analysis window selected;
- no wait-time assumption selected;
- no transfer rule selected;
- no walking/egress network or speed assumption selected;
- no feed completeness review for any actual MTR.

Pre-admission implication:

- no longer blocked by absent travel-time class;
- still blocked by implementation method and feed/MTR specificity.

### Previously Blocked: Source-Vintage Alignment

Updated status: partial pass.

The source-vintage alignment rule now defines required vintage fields and
alignment classes.

For this idea, the minimum fields are known:

- MTR boundary vintage;
- LEHD / LODES job vintage;
- ACS population vintage;
- GTFS feed version or retrieval date;
- travel-time service day or analysis window;
- crosswalk vintage.

Still unresolved:

- no actual vintages can be recorded until a specific MTR and source bundle are
  selected;
- no alignment class can be assigned yet.

Pre-admission implication:

- generic method blocker resolved;
- MTR-specific vintage blocker remains.

### Previously Blocked: Distribution Plan

Updated status: partial pass.

The distribution plan now defines the minimum posture:

- resident population denominator;
- subarea reporting geography;
- regional average only alongside subarea distribution;
- low-access tail;
- subgroup availability assessment;
- suppressed-demand caveat;
- formal-employment and scheduled-service bias.

Still unresolved:

- no subarea geography selected;
- no low-access threshold selected;
- no subgroup table selected;
- no actual suppressed-demand treatment beyond caveat;
- no rule for small-area uncertainty in a specific source bundle.

Pre-admission implication:

- generic distribution blocker resolved;
- metric-specific distribution specification remains.

## Universal Gate Review After Retest

### U1. Outcome Fit

Gate result: partial pass.

The idea is admissible only as narrow job access by scheduled public transport.
It remains prohibited from standing in for full usable access.

### U2. Source Authority And Source Role

Gate result: partial pass.

Known source roles now exist:

- destination inventory: LEHD / LODES;
- population denominator: ACS;
- network or service input: GTFS Schedule;
- travel-time class: scheduled travel time.

Still missing:

- MTR-specific feed inventory;
- MTR-specific source vintages;
- routing/travel-time computation method;
- walking/egress network method.

### U3. MTR Boundary Fit

Gate result: fail.

No MTR boundary record exists for this test.

This remains the primary blocker.

### U4. Denominator And Exposure

Gate result: partial pass.

ACS now supplies a denominator source family, but no denominator geography or
MTR crosswalk is selected.

### U5. Distribution And Equity Visibility

Gate result: partial pass.

Distribution method requirements now exist, but no specific geography,
threshold, or subgroup implementation has been selected.

### U6. Missingness And Bias Class

Gate result: fail.

Missingness classes are known but cannot be assigned for a real test without:

- boundary;
- feed completeness;
- source vintages;
- subarea geography;
- method implementation.

Provisional missingness class remains:

- `available_but_access_barrier_undermeasured`

Provisional comparability class remains:

- `within_region_only`

## Pre-Admission Decision

Decision: `needs_boundary_crosswalk_first`

Secondary blocking decisions:

- `needs_missingness_plan_first`
- `needs_distribution_plan_first`

Resolved as generic blockers:

- population denominator source family exists;
- travel-time class exists;
- source-vintage alignment rule exists;
- distribution plan exists.

Not resolved for metric-record creation:

- no MTR boundary;
- no MTR-specific source bundle;
- no feed completeness review;
- no selected denominator geography;
- no selected routing/travel-time method;
- no actual source-vintage alignment class;
- no actual distribution implementation.

Do not create a filled outcome metric record.

## Recommendation

Do not retest this metric idea again in the abstract.

The generic method blockers have been narrowed enough. Further progress now
requires either:

1. a real MTR boundary record and source bundle; or
2. a source-bundle dry run that remains explicitly non-MTR and stops before
   record creation.

Preferred next step:

- return to boundary/candidate-universe readiness, or wait for a source-led MTR
  proposal before testing this metric further.

## Stop Point

Stop before metric record creation.

No file should be created under:

`theses/mobility-conversion/research/outcome_metric_records/`

for this idea.
