# Source Note: Eurostat URB_LPOP1 FUA Population

Date inspected: 2026-07-01

Verification status: `directly_inspected_api_response`

Source:

- Title or dataset: Population on 1 January by age groups and sex -
  functional urban areas (`URB_LPOP1`)
- Authority or publisher: Eurostat / European Commission
- URL, DOI, document identifier, archive path, API endpoint, or access path:
  - `https://doi.org/10.2908/URB_LPOP1`
  - `https://ec.europa.eu/eurostat/api/dissemination/statistics/1.0/data/urb_lpop1`
  - `https://ec.europa.eu/eurostat/cache/metadata/en/urb_esms.htm`
- Release date, source vintage, or version:
  - API response `updated`: `2026-05-29T23:00:00+0200`
  - datastructure: `URB_LPOP1`, version `28.0`
  - overall observed period in response metadata: oldest `1989`, latest `2025`

Status: independently inspected source note. This note does not admit an MTR,
accept an outcome metric, create an evidence manifest, authorize raw data
archiving, calculate scores, rank MTRs, or make final paper claims.

## Source Authority

Eurostat publishes the dataset through its dissemination API. The response
metadata identifies `ESTAT` as source and agency.

## What The Source Defines

The inspected API response defines population observations for functional urban
areas using Eurostat Urban Audit indicators.

The relevant inspected fields are:

```yaml
dataset_id: URB_LPOP1
dataset_label: Population on 1 January by age groups and sex - functional urban areas
dimensions:
  - freq
  - indic_ur
  - cities
  - time
candidate_indicator:
  code: DE1001V
  label: Population on the 1st of January, total
geography_dimension:
  code: cities
```

The first probe using `geo=FI001F` failed because `GEO` is not a defined
dimension for this API query shape. The corrected query uses `cities=...`.

## Source Function For Mobility Conversion

- `population_denominator_source`
- `methodology_reference`

## Boundary / Denominator Role

- MTR boundary source: no.
- Resident-population denominator source: candidate source family for European
  FUA records when the FUA code, indicator, time period, status flags, and
  vintage alignment are verified for the specific lead.
- Overlay or input only: population denominator input only.
- Service-derived denominator risk: none in this source. It reduces risk by
  keeping the denominator separate from service-feed coverage.

## Outcome / Axis Role

- Outcome dimensions supported: denominator support only, not an outcome.
- Explanatory axes supported: demand intensity may later use population only
  through a separate axis source decision; this source note does not make that
  decision.
- Risk of confusing outcome with explanatory axis: medium. Population may be
  needed to normalize access metrics, but it is not transport quality.

## Data Availability

- Geography: Eurostat Urban Audit functional urban areas addressable through
  the `cities` dimension.
- Spatial unit: FUA code, where compatible with the Urban Audit/GISCO FUA code
  already verified for a lead.
- Time period or release vintage: queryable annual periods. The inspected
  response metadata reports an overall range from 1989 to 2025, but each FUA
  and indicator must be checked for missing years and status flags.
- Update frequency: annual dimension; no stable update cadence accepted here.
- Access method: Eurostat dissemination API.
- License or usage constraint: not resolved in this note. Any raw response
  archive or accepted denominator record requires an evidence manifest and
  license/reuse note.

## Inspected Lead Probes

No raw API response was archived in the repo. Temporary local API responses were
used only to inspect source shape and lead-specific availability.

```yaml
helsinki_fua_probe:
  code: FI001F
  label_returned: Helsinki/Helsingfors
  query_shape:
    cities: FI001F
    indic_ur: DE1001V
    sinceTimePeriod: 2020
  inspected_result: observations present for 2020, 2021, 2022, 2023, 2024
  missing_or_status_notes:
    - 2024 carries Eurostat status flag `b` / break in time series
    - 2025 position is present in the time dimension but has no observation

lyon_fua_probe:
  code: FR002F
  label_returned: Lyon
  query_shape:
    cities: FR002F
    indic_ur: DE1001V
    sinceTimePeriod: 2020
  inspected_result: observations present for 2020, 2021, 2022
  missing_or_status_notes:
    - 2023, 2024, and 2025 positions are present in the time dimension but have
      no observations
```

## Relevance To Mobility Conversion

This source appears to provide the right denominator family for European FUA
lead testing because the API uses the same FUA-code family as the GISCO Urban
Audit FUA boundary source and exposes a total-population indicator.

It does not solve vintage alignment. A lead can have a valid FUA geometry path
and still lack a denominator observation for the target analysis year.

## Limitations

- A valid API query does not make a denominator accepted evidence.
- Lead-specific missing years are material. `FR002F` has inspected observations
  for 2020-2022 but not 2023-2025 in the inspected query.
- `FI001F` has an inspected 2024 observation with a break-in-time-series flag,
  so the status flag must be carried into any later denominator record.
- The API geography dimension is named `cities`, which can be semantically
  misleading for FUA work. The FUA code and unit type must be verified against
  the GISCO boundary source before use.
- This source does not verify commuting-data vintage, LAU input vintage, service
  feed coverage, opportunity destinations, travel times, fares, safety, or
  universal-access conditions.
- No license/reuse acceptance is recorded here.

## Suitability Judgment

Suitability: `candidate_denominator_source`

Rationale:

Eurostat `URB_LPOP1` is suitable as a candidate denominator source family for
European FUA leads because it is official, FUA-code-addressable, and includes a
total-population indicator. It is not sufficient by itself for readiness review
because year availability and status flags vary by lead.

## Methodology Implication

European FUA denominator review must be lead-specific and vintage-specific.

Minimum required fields before any denominator is accepted:

- FUA code;
- GISCO boundary vintage;
- Eurostat `URB_LPOP1` query URL;
- `indic_ur` code and label;
- selected time period;
- observation presence;
- Eurostat status flag, if any;
- missing-year check over the intended vintage window;
- vintage alignment class;
- manifest and license/reuse note if the response is archived or transformed.

## Next Allowed Output

Allowed:

- denominator-path decision note;
- source-note follow-up for Eurostat license/reuse terms;
- lead-specific readiness checklist review only after boundary, denominator,
  service-source trace, and vintage-alignment fields are complete.

## Prohibited Outputs

This source note does not authorize:

- admitted MTR;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- raw data archive without manifest.
