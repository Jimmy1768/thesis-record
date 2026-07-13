# ACS 2024 5-Year Tract Population Capture And Join Review

Date: 2026-07-13

Status: bounded Phase 4 evidence review. Technical integrity is verified.
Authority remains provisional and non-admitted.

## Inputs Reviewed

- `theses/mobility-conversion/evidence/raw/us_census/acs_2024_5year_tract_population/index.json`
- 20 county JSON files under
  `theses/mobility-conversion/evidence/raw/us_census/acs_2024_5year_tract_population/`
- `theses/mobility-conversion/evidence/processed/us_census/acs_2024_5year_tract_population/acs_2024_5year_tract_population_join.csv`
- `theses/mobility-conversion/evidence/processed/us_census/acs_2024_5year_tract_population/acs_2024_5year_tract_population_join_summary.json`
- `theses/mobility-conversion/research/tools/acs_tract_population_join.py`
- `theses/mobility-conversion/evidence/manifests/tiger_2024_subcounty_geometry_overlay_manifest_2026-07-07.md`

## Technical Integrity

Verified facts:

- raw capture retrieval timestamp: `2026-07-12T09:35:22.327850Z`;
- raw capture contains 20 county JSON files plus `index.json`;
- raw capture index SHA-256:
  `f03527a73b1c976efe79d9f9f450926d9c7d7f40584c81712228911d92594699`;
- processed joined CSV SHA-256:
  `6fa719485f31276bf688afe7b8d0b5ccc539b9917dbca8952de789cfd410d6d3`;
- processed summary SHA-256:
  `06a2fc9f55cf47ed138d9437eb25cc511185e6394d791df72e8050eca5e6909f`;
- every indexed county checksum was independently reverified;
- total raw tract-row count is 1,413;
- rerunning the repository joiner from the repository raw bytes reproduced both
  processed artifacts byte-for-byte.

This is sufficient to classify the capture/join pipeline result as technically
intact and reproducible.

## Geometry Coverage

Coverage recheck:

- Minneapolis tract layer: 845 geometry rows, 845 raw ACS rows, 845 joined rows;
- Portland tract layer: 568 geometry rows, 568 raw ACS rows, 568 joined rows;
- total coverage: 1,413/1,413;
- one-to-one coverage: `true`.

The tract overlay therefore passed the bounded Phase 4 one-to-one join gate for
the committed Minneapolis and Portland tract layers.

## Evidence Authority

This review authorizes only the following narrow conclusion:

- the manifested ACS tract population capture and read-only TIGER join
  succeeded as a provisional overlay input for Phase 4.

This review does not authorize:

- an accepted population value;
- an accepted denominator value;
- a filled boundary record;
- a filled metric record;
- candidate admission;
- comparison, scoring, or ranking;
- publication claims.

## Allowed Uses

- preserve an auditable raw and processed evidence trail for the bounded Phase 4
  tract overlay;
- cite tract-level coverage and reproducibility when deciding whether tract
  visibility is technically usable as provisional input;
- keep estimate and MOE columns available for later guarded methodology review;
- support later source-truth discussion about whether additional non-scoring
  gate design is needed before any future metric retest.

## Prohibited Uses

- treat ACS tract estimates as admitted population or denominator values;
- aggregate tract populations into an accepted boundary total;
- create or fill an outcome metric record;
- create a candidate list or candidate-universe ledger entry from this overlay;
- use this overlay to score, compare, rank, or recommend MTRs;
- convert tract coverage success into a publication conclusion.

## Residual Limitations

- tract geometry remains a provisional first-pass visibility layer only;
- block-group escalation remains open if tract coarseness later proves material;
- the candidate scheduled-public-transport job-access idea remains blocked
  because no admitted MTR boundary/source bundle and no admitted service or
  travel-time methodology are yet in force;
- this review is limited to the committed Minneapolis and Portland U.S. tract
  overlays and does not generalize beyond that bounded scope.
