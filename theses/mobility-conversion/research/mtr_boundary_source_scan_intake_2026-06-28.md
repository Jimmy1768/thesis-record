# MTR Boundary Source Scan Intake

Date: 2026-06-28

Status: Deep Research return intake. Not evidence. Not source truth. Not final
methodology.

Raw process artifact:

- `theses/mobility-conversion/operator_records/external_query_tests/2026-06-28-mtr-boundary-source-scan-raw-return.md`

## Intake Judgment

The return is useful as source discovery and methodological comparison. It
largely supports the internal first-principles position already recorded in
Thesis 2:

- no single boundary source solves the MTR problem;
- behavioral validity and cross-region comparability are in tension;
- observed functional or commuting-flow boundaries are conceptually strongest;
- official statistical metropolitan boundaries are useful fallbacks and data
  containers;
- built-up urban areas are urban-form context, not full MTRs;
- governance and service boundaries are explanatory context;
- GTFS/service-derived boundaries are indicator inputs, not denominators;
- accessibility datasets are validation and method precedents, not usually MTR
  boundary sources.

The return should not be treated as evidence because its source claims have not
yet been independently inspected.

## Source Leads

The following are source leads requiring independent inspection before use.

### Functional Urban Areas

- OECD Functional Urban Areas
- Eurostat cities, commuting zones, and functional urban areas
- Eurostat metropolitan regions
- GHSL-OECD Functional Urban Areas

Intake note: distinguish observed commuting-flow FUAs from modelled global FUA
products.

### Commuting Zones / Travel-To-Work Areas

- UK ONS Travel to Work Areas
- USDA ERS Commuting Zones
- U.S. Census commuting-flow tables
- Statistics Canada CMA/CA commuting-flow rules
- Australian Greater Capital City Statistical Areas

Intake note: useful where national methods are strong, but cross-country
comparability risk is high.

### Official Metropolitan Statistical Boundaries

- U.S. OMB Core Based Statistical Areas / Metropolitan Statistical Areas
- Statistics Canada Census Metropolitan Areas
- Eurostat metropolitan regions
- ABS ASGS / Greater Capital City Statistical Areas

Intake note: strong fallback and statistical-data container, but not a global
primary method.

### Built-Up / Agglomeration Boundaries

- GHSL Degree of Urbanisation
- GHSL Urban Centre Database
- UN World Urbanization Prospects urban agglomeration concepts
- World Bank WDI urban agglomeration metadata
- NASA SEDAC products based on JRC urban-centre delineations

Intake note: strong urban-form overlay, weak full-MTR boundary.

### Governance / Authority Boundaries

- U.S. Metropolitan Planning Organization / Metropolitan Planning Area
  boundaries
- Transport for London
- Verkehrsverbund Berlin-Brandenburg
- National or regional transport authorities
- Fare unions and regional service-planning bodies

Intake note: important for governance fit; generally not primary MTR boundary.

### GTFS / Service-Area Sources

- MobilityData GTFS specification and best practices
- U.S. FTA National Transit Database GTFS weblinks
- Transitland
- Official agency feeds
- National or regional GTFS repositories

Intake note: useful for service coverage, frequency, span, and operator
completeness. Should not define the denominator because unserved populations
can disappear.

### Accessibility Geographies

- EC-ITF-OECD Urban Access Framework
- OECD FUA transport-performance datasets
- UN SDG 11.2.1 public transport access reporting
- NASA SEDAC SDG 11.2.1 Urban Access to Public Transport
- Peer-reviewed GTFS accessibility methods

Intake note: useful validation and methodology precedent; not usually a
boundary source.

## Methodology Candidates

### Boundary Confidence Classes

The return strengthens the case for explicit boundary confidence classes:

- `observed_functional_region`
- `national_commuting_zone`
- `official_statistical_metro`
- `modelled_functional_region`
- `built_up_urban_core`
- `governance_or_service_region`
- `service_derived_boundary`
- `accessibility_dataset_geography`

These classes should not imply equal validity.

### Hybrid Boundary Rule

The strongest practical candidate remains:

- use observed FUAs or commuting zones where available;
- use official statistical metropolitan boundaries as fallback;
- use GHSL/UCDB or equivalent built-up areas as urban-form overlays;
- use governance and GTFS/service areas as overlays and completeness checks;
- permit composite boundaries only under written adjustment rules.

### Mandatory Overlays

Even when not used as primary boundaries, the following overlays may be useful
for every MTR record:

- built-up urban core;
- governance/service region;
- operator/service coverage layer where available.

This is a candidate design, not yet accepted methodology.

## Open Questions Created Or Reinforced

- Should observed commuting-flow FUAs and modelled global FUAs be separate
  boundary confidence classes?
- What is the maximum acceptable vintage gap for commuting-based boundaries?
- Should work-from-home disruption after 2020 be a formation-stage caveat or a
  hard methodological adjustment?
- Should built-up urban areas be required overlays for all MTRs?
- Should governance/service boundaries be mandatory metadata for all MTRs?
- Should GTFS-derived service areas be explicitly forbidden from defining the
  denominator?
- What boundary-source metadata fields are required before any MTR can be
  admitted to the candidate universe?

## Quarantined Or Rejected Items

The return suggests a target path using `theses/thesis-2-mobility-conversion/`.
That does not match the accepted ThesisRecord folder:

- accepted folder: `theses/mobility-conversion/`

The return also includes several specific factual claims about release dates,
thresholds, coverage counts, and update cadences. These remain unverified source
leads until independently inspected.

## Immediate Thesis 2 Use

The return is strong enough to refine methodology design, but not to support
claims about any source.

Immediate updates justified at formation stage:

- add boundary confidence classes as a candidate design;
- add source-registry metadata fields as a candidate design;
- reinforce the rule that service-derived boundaries cannot define the MTR
  denominator;
- add source leads to a candidate source registry for later verification.
