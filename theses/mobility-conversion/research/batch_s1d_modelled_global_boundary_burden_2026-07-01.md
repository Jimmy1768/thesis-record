# Batch S1D: Modelled Global Boundary Burden

Date: 2026-07-01

Status: formation-stage source-system burden decision. No MTR is selected. No
boundary record, evidence manifest, candidate-universe ledger, outcome metric
record, score, ranking, or MTR comparison is authorized.

Related intake:

- `theses/mobility-conversion/research/source_led_mtr_proposal_intake_2026-07-01.md`

Related source notes:

- `theses/mobility-conversion/research/source_notes/ghs_functional_urban_areas_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/ghs_pop_population_grid_2026-07-01.md`
- `theses/mobility-conversion/research/source_notes/ghsl_degree_of_urbanisation_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/ghsl_urban_centre_database_2026-06-28.md`

## Question

What additional burden should `modelled_functional_region` carry before it can
be compared with observed FUAs, national commuting zones, or official
statistical metros?

## Short Decision

`modelled_functional_region` remains eligible only as a high-burden fallback or
validation class.

It should not be rejected by default, because rejecting all modelled global
boundaries would bias Thesis 2 toward source-rich countries and regions.

It also should not advance to readiness review by default, because modelled
global boundaries are not observed commuting-flow geographies and may embed
inputs that overlap with explanatory axes.

## Modelled-Boundary Burden Rule

A modelled global FUA lead may move from
`needs_boundary_classification_review` to readiness-checklist review only after
all of the following are documented.

### 1. Fallback Justification

Record why a stronger boundary family is unavailable, unusable, stale, or less
appropriate:

- `observed_functional_region`;
- `national_commuting_zone`;
- `hybrid_functional_statistical_region`;
- `official_statistical_metro`.

The justification must be source-system based, not based on city fame,
megacity status, congestion reputation, or expected transport performance.

### 2. Exact Modelled Row Extraction

Record:

- exact GHS-FUA identifier;
- product name;
- product release;
- epoch;
- coordinate system;
- resolution;
- source URL or catalogue path;
- retrieval or inspection date;
- license/reuse note;
- known source caveats.

### 3. Model Input Disclosure

Record that GHS-FUA R2019A is modelled and estimated from inputs including:

- 2015 urban centres;
- travel time to urban centres;
- urban-centre area;
- local population;
- country GDP per capita;
- global friction matrix inputs.

This matters because GDP per capita overlaps with the economic-capacity
explanatory axis. Any later analysis must prevent model input from becoming a
hidden explanatory variable or outcome proxy.

### 4. Vintage And Growth Review

Record:

- boundary epoch;
- population target year;
- service-source vintage;
- built-form overlay vintage;
- growth/maturity caveat;
- whether rapid growth could make the boundary stale.

If the boundary is anchored to 2015 and service/population sources are much
newer, the lead must remain `not_admitted` until mismatch risk is reviewed.

### 5. Built-Form Overlay Review

Compare the modelled FUA with at least one GHSL built-form or urban-centre
overlay:

- GHS-SMOD / Degree of Urbanisation;
- GHS-UCDB;
- other official or inspected built-up extent source if stronger.

This is a validation/context step only. Built-up urban centres still cannot
become the primary MTR denominator.

### 6. Population Denominator Review

If GHS-POP is used, record:

- GHS-POP release;
- target year;
- resolution;
- projection or estimate status;
- summarization method;
- mismatch with GHS-FUA epoch;
- uncertainty and caveats.

GHS-POP can support a denominator, but it cannot validate the transport
boundary by itself.

### 7. Official Or National Context Search

Before using a modelled FUA as the primary denominator, search for official or
national boundary/context sources that may be better suited:

- metropolitan statistical regions;
- labour-market or commuting regions;
- planning regions;
- census metropolitan or urban-region products;
- official population denominators.

Governance or planning regions remain overlays unless an eligible boundary
source is verified.

### 8. Service-Source Completeness Review

Service/network sources must be reviewed separately:

- formal public-transport feeds or APIs;
- regional and municipal operators;
- access constraints or registration requirements;
- license/reuse constraints;
- informal, weakly documented, or privately operated service gaps;
- OSM or street-network source vintage if routing is tested.

Service geography cannot define the MTR denominator.

## Lead Implication

### `mtr_src_008` Sao Paulo GHS-FUA

Current status after S1D: remains `needs_boundary_classification_review`.

Reason:

- GHS-FUA and GHS-POP are plausible source systems, but the exact FUA row,
  GHS-POP target year, official/national context search, built-form overlay,
  and SPTrans/EMTU service-source completeness are not verified.

Allowed next output:

- boundary classification review for `modelled_functional_region`;
- GHS-FUA exact-row extraction plan;
- GHS-POP denominator review;
- official/national context source search;
- service-source trace for SPTrans/EMTU.

Not allowed:

- readiness checklist review;
- filled boundary record;
- treating modelled FUA as observed commuting geography;
- candidate admission;
- score or ranking.

## Evidence Manifest Decision

No evidence manifest is created in S1D.

Reason:

- S1D defines the burden for modelled global boundaries.
- A manifest becomes required only if GHS-FUA, GHS-POP, GHSL overlay files, or
  service/API artifacts are acquired, archived, transformed, or version-pinned.

## Methodology Implication

`modelled_functional_region` remains in the source hierarchy, but it carries a
stronger burden than observed FUAs, national commuting zones, and official
statistical metros.

This preserves global scope without pretending modelled source availability is
the same as observed behavioral evidence.

## Next Recommended Work

Proceed to Batch S1C: Commonwealth hybrid statistical regions. S1C should
compare Calgary CMA and Greater Melbourne GCCSA as hybrid statistical-region
source systems without treating municipal or state service feeds as
denominators.

## Closing Guardrail

This batch does not select, admit, score, rank, or compare MTRs. It only sets
the burden a modelled global boundary must meet before readiness review.
