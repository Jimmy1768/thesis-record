# Outcome Metric Pre-Admission Matrix

Date: 2026-06-30

Status: formation-stage methodology gate. No outcome metric is accepted. No
metric record is filled. No score, ranking, weight, or MTR comparison is
authorized.

## Purpose

This matrix defines what must be true before Thesis 2 creates a filled outcome
metric record under:

`theses/mobility-conversion/research/outcome_metric_records/`

The matrix is a pre-admission gate. It prevents raw source ideas, convenient
datasets, or familiar transport indicators from becoming proposed metrics
before their source role, boundary fit, missingness, and access interpretation
are documented.

## Inputs

This matrix synthesizes:

- `theses/mobility-conversion/research/batch_o1_outcome_source_verification_summary_2026-06-28.md`
- `theses/mobility-conversion/research/batch_o2a_safety_source_verification_summary_2026-06-30.md`
- `theses/mobility-conversion/research/batch_o2b_affordability_source_verification_summary_2026-06-30.md`
- `theses/mobility-conversion/research/batch_o2c_access_to_opportunities_source_verification_summary_2026-06-30.md`
- `theses/mobility-conversion/research/outcome_metric_registry_template.md`

## Pre-Admission Decision Values

Every candidate metric idea must receive one of these pre-admission decisions
before a metric record is filled:

- `do_not_create_metric_record`
- `needs_source_note_first`
- `needs_boundary_crosswalk_first`
- `needs_denominator_first`
- `needs_distribution_plan_first`
- `needs_missingness_plan_first`
- `eligible_for_proposed_metric_record`

`eligible_for_proposed_metric_record` means only that a filled record may be
created with `metric_status: proposed_not_accepted`.

It does not mean:

- accepted for candidate testing;
- accepted for scoring;
- accepted for comparison;
- accepted as paper evidence.

## Universal Gates

A metric idea is not eligible for a proposed metric record unless all universal
gates are answered.

### U1. Outcome Fit

Required:

- assigned outcome dimension;
- plain-language access question;
- explanation of why the idea measures usable access rather than reputation,
  wealth, data availability, governance, or urban form.

Reject or quarantine if:

- it duplicates an explanatory axis;
- it measures city reputation, transit fame, or livability;
- it rewards one mode without measuring access usefulness.

### U2. Source Authority And Source Role

Required:

- source authority;
- source note path;
- source vintage or inspection date;
- source role:
  - `destination_inventory`
  - `population_denominator`
  - `network_or_service_input`
  - `travel_time_or_reliability_input`
  - `safety_event_input`
  - `exposure_denominator`
  - `cost_input`
  - `income_or_resource_denominator`
  - `method_precedent`
  - `context_only`

Reject or quarantine if:

- source authority is unclear;
- method is proprietary and cannot be inspected;
- source is only a ranking or scorecard.

### U3. MTR Boundary Fit

Required:

- geographic unit of source;
- expected MTR boundary compatibility;
- crosswalk requirement;
- boundary record dependency;
- known unit-switching risk.

Reject or quarantine if:

- the metric cannot be mapped to an MTR boundary or documented approximation;
- service-derived geography would silently become the denominator;
- geography is changed between numerator and denominator.

### U4. Denominator And Exposure

Required:

- population, household, trip, passenger, vehicle, area, or event denominator;
- source for denominator;
- denominator geography;
- denominator caveat.

Reject or quarantine if:

- numerator exists but denominator is missing;
- denominator excludes unserved or hard-to-measure populations;
- missing denominator would make high performance appear by omission.

### U5. Distribution And Equity Visibility

Required:

- whether only a regional average is available;
- distribution groups, if available;
- subgroup missingness;
- suppressed-demand risk.

Reject or quarantine if:

- severe access gaps are hidden behind a regional average;
- source-rich or high-income subareas dominate the measurement;
- unavailable or unreported demand is treated as no problem.

### U6. Missingness And Bias Class

Required:

- comparability class;
- missingness class;
- source-rich-region bias risk;
- informal, unreported, or inaccessible activity risk.

Reject or quarantine if:

- missing data is treated as zero, average, or high performance;
- source availability becomes a proxy for transport quality;
- informal or non-official services are structurally erased without caveat.

## Tier 1 Dimension Gates

### Access To Opportunities

Pre-admission questions:

- What opportunity class is measured?
- Is the metric narrow, such as job access, or a broader bundle?
- What destination inventory is used?
- What population denominator is used?
- What network and travel-time method is used?
- Are cost, safety, eligibility, hours, capacity, or physical usability included
  or explicitly excluded?
- Is open POI completeness audited if OpenStreetMap or similar sources are used?

Required source roles:

- destination inventory;
- population denominator;
- network or service input;
- travel-time method or source.

Common pre-admission failures:

- jobs silently stand in for all opportunities;
- destination presence is treated as access;
- modelled accessibility score is imported without decomposing inputs;
- open POI completeness is assumed neutral.

Minimum decision for record creation:

- `eligible_for_proposed_metric_record` only if the opportunity class,
  destination source, denominator, boundary fit, and travel-time method are all
  documented.

### Network Coverage And Service Availability

Pre-admission questions:

- Does the idea measure service presence, service quality, or usable coverage?
- Is scheduled service separated from delivered service?
- Does the denominator include unserved populations inside the MTR?
- Are service frequency, span, transfers, and mode coverage defined?
- Does the idea depend on GTFS or agency feeds, and if so, what feed
  completeness caveat is recorded?

Required source roles:

- network or service input;
- population denominator;
- MTR boundary crosswalk.

Common pre-admission failures:

- stop proximity is treated as full access;
- GTFS feed presence is treated as service quality;
- service-derived geography becomes the denominator;
- informal or non-fixed-route service is erased without caveat.

Minimum decision for record creation:

- `eligible_for_proposed_metric_record` only if coverage denominator,
  service-quality scope, feed completeness, and boundary fit are documented.

### Travel Time And Reliability

Pre-admission questions:

- Is travel time scheduled, observed, surveyed, modelled, or real-time derived?
- Is reliability measured directly or inferred?
- What modes and trip purposes are covered?
- Is GTFS Realtime archived or only live?
- Are peak, off-peak, transfer, wait-time, and disruption assumptions explicit?

Required source roles:

- travel-time or reliability input;
- network or service input;
- population or trip denominator;
- observation window.

Common pre-admission failures:

- scheduled time is treated as delivered time;
- live real-time data is treated as historical reliability without archive;
- commute time is treated as all-purpose travel time;
- proprietary road speed data is used without inspectable method.

Minimum decision for record creation:

- `eligible_for_proposed_metric_record` only if time source, observation window,
  mode scope, trip-purpose scope, and reliability interpretation are documented.

### Transportation Safety

Pre-admission questions:

- What safety event is measured?
- Is the source road safety, transit safety, security, perceived safety, or
  another safety class?
- What exposure denominator is used?
- Are pedestrian and cyclist harms separable?
- Are underreporting, suppressed demand, and perceived safety caveats recorded?

Required source roles:

- safety event input;
- exposure denominator;
- geography and MTR crosswalk;
- reporting-threshold definition.

Common pre-admission failures:

- national road-safety context is treated as MTR performance;
- fatality-only data is treated as full safety;
- transit safety replaces road-user safety;
- no exposure denominator is available;
- underreporting is ignored.

Minimum decision for record creation:

- `eligible_for_proposed_metric_record` only if event type, exposure
  denominator, reporting authority, geography, and underreporting caveat are
  documented.

### Affordability

Pre-admission questions:

- What cost is measured?
- Is the metric based on fares, household expenditure, modeled cost, car cost,
  housing-plus-transport, or another cost type?
- What income or resource denominator is used?
- Does the metric distinguish observed spending from required spending?
- Are concession, fare-cap, transfer, eligibility, and car-dependency caveats
  recorded?

Required source roles:

- cost input;
- income or resource denominator;
- geography and MTR crosswalk;
- household unit or equivalization rule, if relevant.

Common pre-admission failures:

- nominal fare is treated as affordability;
- household transport expenditure is treated as access quality;
- income is treated as transport performance;
- car-dependency costs are omitted;
- suppressed trips are invisible.

Minimum decision for record creation:

- `eligible_for_proposed_metric_record` only if cost type, income/resource
  denominator, geography, distribution, and car-dependency caveat are documented.

## Pre-Admission Matrix

| Dimension | Minimum source roles | Must document before record | Common block | Default pre-admission posture |
| --- | --- | --- | --- | --- |
| Access to opportunities | destination inventory; population denominator; network/travel-time input | opportunity class; destination source; denominator; boundary fit; travel-time method | jobs or POIs treated as full access | `needs_denominator_first` or `needs_boundary_crosswalk_first` |
| Network coverage/service availability | service input; population denominator; boundary crosswalk | service-quality scope; feed completeness; unserved denominator; mode coverage | service geography becomes denominator | `needs_boundary_crosswalk_first` |
| Travel time/reliability | travel-time input; network input; denominator; observation window | scheduled vs observed; archive; mode/trip scope; reliability interpretation | scheduled time treated as delivered time | `needs_missingness_plan_first` |
| Transportation safety | safety event input; exposure denominator; geography crosswalk | event type; exposure; reporting threshold; underreporting caveat | fatality-only or national data treated as full MTR safety | `needs_denominator_first` |
| Affordability | cost input; income/resource denominator; geography crosswalk | cost type; income/resource denominator; distribution; car-dependency caveat | fares treated as affordability | `needs_denominator_first` |

## Record Creation Rule

Create a filled metric record only when:

- the dimension-specific minimum source roles are present;
- all universal gates have a documented answer;
- pre-admission decision is `eligible_for_proposed_metric_record`;
- the record will begin with `metric_status: proposed_not_accepted`;
- no score, ranking, weighting, or MTR comparison will be calculated from it.

If any gate is unresolved, do not create a filled metric record. Instead, create
or update a source note, boundary review, missingness note, or methodology
decision record.

## Next Work

Use this matrix to test candidate metric ideas one at a time.

The first test should be narrow and explicit, not a final metric. A reasonable
first candidate is a job-access metric idea, because LEHD / LODES gives a clear
source family, but it must be labelled as job access only and blocked from
standing in for full access-to-opportunities.
