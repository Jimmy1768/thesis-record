# Batch 2B Boundary Verification Summary

Date: 2026-06-28

Status: source-family verification summary. No MTRs selected. No final boundary
methodology accepted.

## Sources Inspected

- U.S. Census commuting topic page
- U.S. Census 2016-2020 ACS commuting-flow tables
- U.S. Census "Commuting in the United States: 2022"
- U.S. Census "Home-Based Workers: 2019-2021"
- ONS "Travel to work quality information for Census 2021"
- ONS Data Science Campus travel-to-work matrix estimation report
- OECD remote-work/place-based policy report
- Scientific Data 2020 U.S. commuting-zone paper

Source notes:

- `theses/mobility-conversion/research/source_notes/us_census_commuting_and_home_based_work_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/ons_travel_to_work_caveats_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/oecd_remote_work_place_based_policies_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/scientific_data_us_2020_commuting_zones_2026-06-28.md`

## Core Finding

Batch 2B verifies that post-2020 commuting changes require explicit caveats for
commute-derived MTR boundaries.

The evidence supports caution and metadata, not automatic rejection.

## Verified Position Updates

### U.S. Census

U.S. Census sources verify:

- commuting data are work-trip focused;
- commuting data include work from home;
- 2016-2020 ACS commuting-flow tables are county-to-county work-flow tables;
- the COVID-19 pandemic substantially changed commuting behavior between 2019
  and 2021, especially home-based work;
- home-based work expanded materially between 2019 and 2021.

Methodology implication:

- U.S. commuting-flow boundary use should record `commuting_data_vintage`;
- 2016-2020 and post-2020 commuting data should carry a
  `pandemic_or_remote_work_caveat`.

### ONS

ONS is the strongest inspected operational caveat source.

ONS verifies:

- Census 2021 travel-to-work data were collected during lockdown and abnormal
  travel conditions;
- travel-to-work data underlie Travel to Work Areas;
- those geographies may be less representative of where people live and work;
- ONS advised continued use of 2011 Travel to Work Areas while future methods
  were researched.

Methodology implication:

- source-authority caveats should override a generic confidence assumption;
- pandemic-era travel-to-work data should not be treated as normal commuting
  behavior without caveat.

### OECD

OECD verifies a broader contextual caveat:

- remote work changed mobility and settlement patterns;
- changes may affect commuting zones and infrastructure policy;
- future patterns remain uncertain.

Methodology implication:

- remote-work caveats should be recorded, but OECD does not provide a boundary
  replacement rule.

### Scientific Data 2020 U.S. CZ Paper

The paper verifies a research-method caveat:

- commuting-zone quality can be affected by changing work and residence
  patterns;
- commute-derived delineations benefit from quality metrics;
- 2020 U.S. CZs are a research data product, not official government MTR
  boundaries.

Methodology implication:

- commute-derived regions should carry confidence/quality metadata.

## Formation-Stage Decision

Add mandatory caveat fields for commute-derived boundary sources:

- `commuting_data_vintage`;
- `geography_release_vintage`;
- `pandemic_or_remote_work_caveat`;
- `source_authority_caveat`;
- `boundary_quality_notes`.

These fields should apply to:

- observed functional regions;
- national commuting zones;
- official statistical metro regions that use commute-flow integration;
- modelled or hybrid sources that depend on commuting assumptions.

## What This Does Not Mean

This does not mean:

- observed FUAs are invalid;
- commuting zones are unusable;
- all boundaries must be redrawn after 2020;
- remote work replaces the need for travel-flow geography;
- commute-derived boundaries should be rejected by default.

The correct stance is:

```text
commute-flow boundary methods remain useful, but every use must carry source
vintage, pandemic/remote-work caveat, and authority-specific warnings.
```

## Remaining Risks

- Remote-work effects differ by occupation, region, and time.
- Work commuting remains only one part of usable access.
- Some agencies may continue using older boundaries for continuity even if newer
  travel behavior has changed.
- Post-2020 data may reflect unstable adjustment rather than settled behavior.
- No inspected source provides a universal replacement for commute-flow
  boundaries.

## Next Verification Batch

Proceed to Batch 2C: national functional / commuting boundary methods.
