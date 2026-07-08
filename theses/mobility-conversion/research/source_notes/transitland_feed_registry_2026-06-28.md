# Source Note: Transitland Feed Registry

Date inspected: 2026-06-28

Verification status: directly inspected official Transitland pages.

Sources:

- Transitland home page
- URL: `https://www.transit.land/`
- Transitland Documentation, "Feeds and feed versions"
- URL: `https://www.transit.land/documentation/datastore/feeds`

## Source Authority

Transitland / Interline Technologies.

## What The Source Defines

Transitland is an open-data platform and API service for bus, train, subway,
and ferry feeds.

Transitland documentation defines:

- feeds as unique GTFS data sources;
- feed versions as archived versions of GTFS archives;
- feed geometry as the convex hull of stops in the feed;
- feed license metadata;
- active feed versions;
- validation and statistics reports;
- update statistics for feed versions.

Transitland states that each time it fetches a GTFS feed, it stores a versioned
snapshot.

## Boundary Basis

Classification:

- boundary family: feed registry / service-derived data source;
- observed or modelled: registry of publicly available GTFS feeds and imported
  feed versions;
- basis type: agency/community contributed GTFS feed URLs and archived feed
  versions;
- spatial unit: feeds, feed versions, stops, routes, operators, convex hulls of
  stops, schedules, and APIs;
- geographic coverage: global where feeds are available and represented in
  Transitland;
- update cadence: Transitland documentation says feed URLs are checked roughly
  once per day.

## Relevance To Mobility Conversion

Transitland is useful for:

- discovering GTFS feeds;
- auditing operator/feed availability;
- retrieving historical feed versions when licensing permits;
- checking service frequency, stops, routes, and schedules;
- identifying feed license and update metadata;
- comparing service data over time where feed history is available.

## Limitations

- Transitland is not an authoritative MTR boundary source.
- Feed geometry is a convex hull of stops, not a travel region.
- Feed availability depends on public GTFS publication and Transitland catalog
  coverage.
- Feed archives may be restricted by license.
- Informal, non-published, non-fixed-route, or missing operators may be absent.
- Using feed geometry as a denominator would hide unserved populations and
  non-published services.

## Suitability Judgment

Suitability: `indicator_input_only` and `candidate_overlay`.

Boundary confidence class:

- `service_derived_boundary` for feed-derived geometry, but not acceptable as
  an MTR denominator.

## Methodology Implication

Transitland is useful for service data discovery and completeness audits inside
a separately defined MTR. It should not define the MTR boundary.
