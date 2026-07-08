# Batch O1 Outcome Source Verification Summary

Date: 2026-06-28

Status: source-family verification summary. No outcome metric is accepted. No
metric record is filled. No score, ranking, weight, or MTR comparison is
authorized.

## Sources Inspected

- UN SDG indicator 11.2.1 metadata
- GTFS Schedule reference
- GTFS Realtime reference
- GTFS fare-related schedule references

Source notes:

- `theses/mobility-conversion/research/source_notes/un_sdg_11_2_1_public_transport_access_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/gtfs_schedule_outcome_input_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/gtfs_realtime_outcome_input_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/gtfs_fares_outcome_input_2026-06-28.md`

## Core Finding

Batch O1 confirms that public transport access, service supply, scheduled
travel time, real-time reliability, and fare inputs are measurable source
families, but none of them alone measures usable access.

The verified sources support the broad usable-access framework rather than a
single early score.

## Verified Position Updates

### SDG 11.2.1

SDG 11.2.1 is a useful official precedent for public transport access coverage.
It supports measuring population access to public transport, but it should not
be treated as the whole Mobility Conversion outcome.

It is strongest for:

- network coverage and service availability;
- population denominator discipline;
- highlighting vulnerable-population and accessibility concerns.

### GTFS Schedule

GTFS Schedule is a strong source family for scheduled service availability,
frequency, span, stops, routes, trips, transfers, and scheduled travel-time
inputs.

It remains an indicator input inside an independently defined MTR boundary.

### GTFS Realtime

GTFS Realtime is a high-value source family for reliability where archival
collection and feed quality are documented.

It should not become a universal requirement during candidate formation because
availability is uneven and live feeds do not automatically provide historical
evidence.

### GTFS Fares

GTFS fare data can support public transport fare inputs, but it is not
affordability by itself.

Affordability requires income, expenditure, concession, transfer, and
car-dependency context.

## Outcome-Design Implications

Batch O1 supports the following formation-stage rules:

- service coverage must not be equated with usable access;
- scheduled service must be separated from delivered service;
- fare data must be separated from affordability;
- real-time reliability data must carry archive and feed-quality metadata;
- every source-family use must be mapped back to an independently defined MTR
  boundary.

## Recommended Next Batch

Batch O2 should verify Tier 1 source families that prevent public-transport
data from dominating the outcome design:

- safety: national and local crash databases, transit safety reporting, and
  exposure denominators;
- affordability: household expenditure, income distribution, and car-dependency
  cost sources;
- access to opportunities: job and essential-destination data plus
  accessibility-model precedents.

Priority order:

1. safety source-family verification;
2. affordability source-family verification;
3. access-to-opportunities source-family verification.

## What This Batch Does Not Authorize

Batch O1 does not authorize:

- filling outcome metric records;
- accepting any metric for candidate testing;
- calculating scores;
- comparing MTRs;
- using GTFS presence as a proxy for access quality;
- using fare tables as a proxy for affordability;
- using SDG 11.2.1 as the full outcome.
