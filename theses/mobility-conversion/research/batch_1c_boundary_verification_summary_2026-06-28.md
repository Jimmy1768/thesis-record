# Batch 1C Boundary Verification Summary

Date: 2026-06-28

Status: source-family verification summary. No MTRs selected. No final boundary
methodology accepted.

## Sources Inspected

- MobilityData / GTFS documentation
- FTA NTD glossary
- Transitland feed registry documentation

Source notes:

- `theses/mobility-conversion/research/source_notes/mobilitydata_gtfs_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/fta_ntd_service_area_and_gtfs_lead_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/transitland_feed_registry_2026-06-28.md`

## Core Finding

Batch 1C confirms the service-derived boundary guardrail.

GTFS and feed registries are strong inputs for service indicators, operator
completeness checks, service-frequency analysis, and schedule-based
accessibility. They are weak and biased as MTR boundary sources.

Service-derived geometries should not define the MTR denominator because they
can exclude unserved populations, missing operators, informal services, and
non-published services.

## Verified Position Updates

### MobilityData / GTFS

GTFS describes public transit service data such as schedules, stops, fares,
routes, service calendars, geography, vehicle positions, trip updates, and
alerts.

GTFS is suitable as `indicator_input_only`.

It should measure service inside an independently defined MTR boundary.

### FTA NTD

The inspected NTD glossary verifies that service-area concepts are access /
coverage measures and are reporter-defined or mode-specific.

This supports treating service areas as overlays or indicator inputs, not
metropolitan boundaries.

The specific FTA/BTS public GTFS web links source remains an open verification
item.

### Transitland

Transitland is useful for GTFS feed discovery, feed version archives, validation
reports, schedule data, stops, routes, operators, and feed update metadata.

Transitland feed geometry is a convex hull of stops in a feed. That is not an
MTR boundary.

## Boundary Confidence Implications

Batch 1C supports keeping `service_derived_boundary` as a separate low-boundary
confidence class.

This class should be allowed only as:

- `indicator_input_only`;
- `candidate_overlay`;
- service-completeness audit;
- operator/feed discovery layer.

It should not be accepted as:

- `candidate_primary_boundary`;
- `candidate_fallback_boundary`;
- MTR denominator.

## Remaining Risks

- GTFS publication is uneven across countries, agencies, modes, and operators.
- Feed presence can measure data legibility rather than service completeness.
- Some feeds may be stale, partial, invalid, or license-restricted.
- Informal, semi-formal, demand-responsive, paratransit, road, walking, cycling,
  and private-vehicle access may be absent.
- Feed-derived coverage can make inaccessible or unserved people disappear from
  the denominator.

## Formation-Stage Decision

Upgrade the service-derived denominator rule from warning to formation-stage
guardrail:

Service-derived boundaries should not define MTR denominators.

GTFS, Transitland, FTA/NTD service-area data, and similar sources may be used
inside independently defined MTR boundaries for service availability,
frequency, span, coverage, feed completeness, and accessibility analysis.

This is not final methodology, but it is a stronger candidate rule after direct
inspection of Batch 1C sources.

## Next Verification Work

The first boundary-source verification cycle is now sufficient to draft a
candidate boundary decision record.

Open follow-up:

- inspect the specific FTA/BTS public GTFS web links or National Transit Map
  source before relying on U.S. GTFS feed-inventory coverage claims.
