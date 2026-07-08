# Source Note: Statistics Canada 2021 CMA / CA Current Glossary Follow-Up

Date inspected: 2026-07-01

Verification status: `directly_inspected_documentation`

Source:

- Title or dataset: Illustrated Glossary - Census metropolitan area (CMA) and
  census agglomeration (CA)
- Authority or publisher: Statistics Canada
- URL, DOI, document identifier, archive path, API endpoint, or access path:
  - `https://www150.statcan.gc.ca/n1/pub/92-195-x/2021001/geo/cma-rmr/cma-rmr-eng.htm`
  - `https://www150.statcan.gc.ca/n1/pub/92f0138m/92f0138m2019002-eng.htm`
- Release date, source vintage, or version: 2021 Census glossary released
  2022-02-09; preliminary 2021 delineation working paper released 2019-11-13
  and marked archived.

Status: independently inspected source note. This note does not admit an MTR,
accept an outcome metric, create an evidence manifest, authorize raw data
archiving, calculate scores, rank MTRs, or make final paper claims.

## Source Authority

Statistics Canada.

## What The Source Defines

The 2021 illustrated glossary defines Census Metropolitan Areas (CMAs) and
Census Agglomerations (CAs) as adjacent municipalities centred on a population
centre core.

For a CMA:

- total population must be at least 100,000;
- at least 50,000 must live in the core.

For a CA:

- the core population must be at least 10,000.

Adjacent municipalities are included when they have a high degree of integration
with the core, measured by commuting flows from place-of-work data from the
previous Census Program.

The 2021 glossary lists the rule order for adding census subdivisions:

- delineation core rule;
- forward commuting flow rule;
- reverse commuting flow rule;
- spatial contiguity rule;
- historical comparability rule;
- manual adjustments;
- merging adjacent CMAs and CAs and secondary core rule.

## Source Function For Mobility Conversion

- `boundary_source_family`
- `population_denominator_source`
- `methodology_reference`

## Boundary / Denominator Role

- MTR boundary source: candidate, only after exact CMA code, boundary vintage,
  and limitations are verified.
- Resident-population denominator source: candidate, through Statistics Canada
  CMA/CA population tables or census population sources.
- Overlay or input only: MIZ and service/operator geography remain overlays.
- Service-derived denominator risk: medium if municipal transit coverage is
  mistaken for the full CMA denominator.

## Outcome / Axis Role

- Outcome dimensions supported: none directly.
- Explanatory axes supported: governance fit and urban form only as context,
  not as score components.
- Risk of confusing outcome with explanatory axis: medium, because official
  metro status and data availability can be mistaken for transport quality.

## Data Availability

- Geography: Canada.
- Spatial unit: census subdivisions / municipalities, CMA/CA geography.
- Time period or release vintage: 2021 Census geography and related population
  tables, subject to exact file/table verification.
- Update frequency: tied to Census/geography releases, not accepted here as a
  generic fixed rule.
- Access method: Statistics Canada pages and tables.
- License or usage constraint: Statistics Canada source terms must be recorded
  before raw artifact archiving.

## Relevance To Mobility Conversion

This source strengthens the classification of Canada CMA/CA as a
`hybrid_functional_statistical_region`: it is functional enough to matter for
MTR boundary testing, but it is not a pure observed travel boundary.

It directly supports source-led follow-up for `mtr_src_005` Calgary CMA without
selecting Calgary by reputation.

## Limitations

- CMA/CA uses municipalities/census subdivisions as building blocks.
- Historical comparability and manual adjustment rules can preserve or modify
  boundaries beyond direct current commuting evidence.
- Commuting flow rules use previous Census Program place-of-work data.
- CMA/CA geography does not define transport service coverage.
- Exact Calgary CMA code, boundary file, population table, and service-overlay
  fit are not verified by this note.

## Suitability Judgment

Suitability: `candidate_primary_boundary`

Rationale:

Statistics Canada CMA/CA is suitable as a candidate MTR denominator source only
under the `hybrid_functional_statistical_region` confidence class, with exact
boundary and population source verification.

## Methodology Implication

Canadian CMA leads require explicit fields for:

- CMA code;
- boundary vintage;
- census subdivision building blocks;
- previous-Census commuting-flow vintage;
- historical comparability rule impact;
- manual adjustment rule impact;
- merge or secondary-core rule impact;
- population denominator source;
- service-overlay completeness.

## Next Allowed Output

Allowed:

- S1C hybrid statistical-region decision;
- exact Calgary CMA source-note follow-up;
- later draft evidence manifest if raw boundary or population files are
  acquired.

## Prohibited Outputs

This source note does not authorize:

- admitted MTR;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- raw data archive without manifest.
