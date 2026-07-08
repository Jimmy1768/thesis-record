# Source-Led MTR Follow-Up Batch Plan

Date: 2026-07-01

Status: formation-stage follow-up plan. No MTR is selected. No boundary record,
candidate-universe ledger, evidence manifest, outcome metric record, score,
ranking, or MTR comparison is authorized.

Raw return:

- `theses/mobility-conversion/operator_records/external_query_tests/2026-07-01-source-led-mtr-boundary-source-bundle-proposals-raw-return.md`

Intake:

- `theses/mobility-conversion/research/source_led_mtr_proposal_intake_2026-07-01.md`

## Purpose

Sequence the next work after intake without privileging the first familiar or
source-rich proposal lead.

The unit of work is source-system verification, not city selection.

## Batch Principles

- Work by source family first, proposal lead second.
- Prefer batches that clarify rules used by multiple leads.
- Do not create filled boundary records until exact source rows, codes,
  vintages, and denominator implications are verified.
- Do not create raw data archives until an evidence manifest is needed.
- Do not run outcome metrics or score any MTR.

## Batch S1A: Eurostat/OECD FUA Exact-Row Feasibility

Related leads:

- `mtr_src_001` Helsinki FUA
- `mtr_src_002` Lyon FUA

Question:

- Can Thesis 2 trace exact FUA rows/codes, vintages, polygons, and population
  denominator options from Eurostat/OECD sources without relying on city
  reputation?

Required outputs:

- source-note update or follow-up note for Eurostat GISCO FUA exact-row
  extraction;
- list of required vintage fields;
- decision on whether exact FUA row extraction is required before readiness
  checklist review.

Prohibited outputs:

- Helsinki or Lyon boundary record;
- admitted MTR;
- candidate list;
- score or ranking.

Status: completed as source-system feasibility decision in
`theses/mobility-conversion/research/batch_s1a_eurostat_oecd_fua_exact_row_feasibility_2026-07-01.md`.

## Batch S1B: U.S. County-Based Boundary Mechanics

Related leads:

- `mtr_src_004` Minneapolis-St. Paul ERS CZ
- `mtr_src_007` Portland-Vancouver-Hillsboro MSA

Question:

- How should Thesis 2 treat county-based commuting zones and official
  statistical metros as possible MTR denominators when they may over-include
  territory?

Required outputs:

- readiness-checklist review limited to source-system mechanics;
- county coarseness caveat;
- rule for when ERS CZ or CBSA leads must remain `not_admitted`;
- confirmation that FTA/NTD/GTFS remains service input only.

Prohibited outputs:

- candidate-universe admission;
- agency/service geography as denominator;
- access metric record;
- score or ranking.

Status: completed as source-system mechanics decision in
`theses/mobility-conversion/research/batch_s1b_us_county_based_boundary_mechanics_2026-07-01.md`.

## Batch S1C: Commonwealth Hybrid Statistical Regions

Related leads:

- `mtr_src_005` Calgary CMA
- `mtr_src_006` Greater Melbourne GCCSA

Question:

- Can hybrid functional-statistical regions serve as MTR denominators without
  baking governance, source wealth, or service coverage into selection?

Required outputs:

- source-note review for exact boundary and population denominator paths;
- caveat comparison for CMA versus GCCSA logic;
- operator/service completeness questions for Calgary and Melbourne source
  bundles.

Prohibited outputs:

- treating municipal or state service feeds as denominators;
- candidate admission;
- score or ranking.

Status: completed as hybrid statistical-region mechanics decision in
`theses/mobility-conversion/research/batch_s1c_commonwealth_hybrid_statistical_regions_2026-07-01.md`.

## Batch S1D: Modelled Global Boundary Burden

Related lead:

- `mtr_src_008` Sao Paulo GHS-FUA

Question:

- What additional burden should `modelled_functional_region` carry before it
  can be compared with observed FUAs, national commuting zones, or official
  statistical metros?

Required outputs:

- boundary classification review;
- modelled-boundary caveat standard;
- rule for comparing GHS-FUA with GHS-POP, built-up extent, official statistical
  geography, and service-source coverage.

Prohibited outputs:

- treating modelled FUA as observed commuting geography;
- readiness promotion before classification burden is resolved;
- candidate admission;
- score or ranking.

Status: completed as modelled-boundary burden decision in
`theses/mobility-conversion/research/batch_s1d_modelled_global_boundary_burden_2026-07-01.md`.

## Batch S1E: Local Service-Source Verification Queue

Related leads:

- `mtr_src_001` HSL / Digitransit
- `mtr_src_002` France National Access Point local datasets
- `mtr_src_003` NaPTAN / BODS / non-bus modes
- `mtr_src_005` Calgary Transit and regional services
- `mtr_src_006` Victoria DTP GTFS
- `mtr_src_008` SPTrans / EMTU

Question:

- Which named service/network sources are traceable, current, licensed,
  reproducible, and complete enough to become indicator inputs after a separate
  MTR denominator is verified?

Required outputs:

- source-note queue;
- feed/source vintage fields;
- operator completeness checklist;
- registration/API-access caveat rule.

Prohibited outputs:

- service-derived denominator;
- raw feed archive without manifest;
- metric calculation;
- score or ranking.

Status: completed as local service-source verification queue in
`theses/mobility-conversion/research/batch_s1e_local_service_source_verification_queue_2026-07-01.md`.

## Recommended Order

1. Batch S1A, because it affects two returned leads and tests the preferred
   observed-functional-region source family.
2. Batch S1B, because it tests whether U.S. source-system convenience creates
   denominator overreach.
3. Batch S1D, because modelled-boundary burden must be clear before global
   modelled proposals can advance.
4. Batch S1C and S1E after the first boundary-family rules are clarified.

Current S1 status: complete.

Current next artifact:

- `theses/mobility-conversion/research/eurostat_oecd_fua_exact_row_extraction_workflow_2026-07-01.md`

## Closing Guardrail

This plan sequences source-system review only. It does not select, admit,
score, rank, or compare MTRs.
