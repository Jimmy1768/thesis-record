# Batch 2A Boundary Verification Summary

Date: 2026-06-28

Status: source-family verification summary. No MTRs selected. No final boundary
methodology accepted.

## Sources Inspected

- FTA / NTD GTFS Weblinks dataset
- Federal Register final notice on NTD reporting changes
- FTA Recent NTD Developments FAQ
- BTS National Transit Map
- ROSA P National Transit Map archive page

Source notes:

- `theses/mobility-conversion/research/source_notes/fta_ntd_gtfs_weblinks_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/bts_national_transit_map_2026-06-28.md`

Prior related note:

- `theses/mobility-conversion/research/source_notes/fta_ntd_service_area_and_gtfs_lead_2026-06-28.md`

## Core Finding

Batch 2A closes the open Batch 1C U.S. GTFS inventory item.

The authoritative U.S. fixed-route GTFS feed-link inventory is the FTA / NTD
GTFS Weblinks dataset distributed through Data.gov / DOT data portal.

The BTS National Transit Map is a separate geospatial service catalog derived
from GTFS Schedule data and published through NTAD / archived in ROSA P.

Both are useful service inputs and overlays. Neither should define the MTR
denominator.

## Verified Position Updates

### FTA / NTD GTFS Weblinks

Verified role:

- official U.S. GTFS feed-link inventory for NTD fixed-route reporters;
- source-authentication layer for U.S. GTFS feeds;
- monthly refreshed current dataset, according to Data.gov page;
- annual NTD reporting and certification context;
- static GTFS required, GTFS Realtime optional;
- fixed-route focus with non-fixed-route exclusions.

Suitability:

- `indicator_input_only`;
- `candidate_overlay`;
- not primary boundary;
- not fallback boundary;
- not MTR denominator.

### BTS National Transit Map

Verified role:

- U.S. geospatial service catalog;
- built from GTFS Schedule data;
- includes NTM Agencies, Routes, and Stops datasets;
- quarterly updates, according to BTS page;
- archived through ROSA P.

Suitability:

- `indicator_input_only`;
- `candidate_overlay`;
- not primary boundary;
- not fallback boundary;
- not MTR denominator.

## Registry Implication

U.S. GTFS Weblinks and National Transit Map should be separate registry entries:

- GTFS Weblinks: feed inventory / source-authentication layer.
- National Transit Map: processed geospatial service catalog.

Do not collapse them into one source because they answer different questions.

## Remaining Risks

- The live row count, complete field list, validation status, and current feed
  reachability require a later data/API fetch and archive.
- GTFS Weblinks exclude demand response, vanpool, and other non-fixed-route
  modes.
- National Transit Map can omit agencies if data are late or invalid for a
  quarterly update.
- Annual certification and monthly/quarterly release cadences do not guarantee
  current service accuracy at every point in time.
- Both products can reward data legibility if used without a separately defined
  MTR denominator.

## Formation-Stage Decision

The service-derived denominator guardrail is strengthened:

GTFS feed inventories, GTFS feeds, Transitland, FTA / NTD GTFS Weblinks, BTS
National Transit Map, and similar service-derived products may support service
availability, coverage, span, frequency, feed completeness, and accessibility
analysis inside an independently defined MTR.

They must not define the MTR denominator.

## Next Verification Batch

Proceed to Batch 2B: post-2020 commuting-boundary caveats.
