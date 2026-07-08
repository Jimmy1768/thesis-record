Research Artifact: MTR Boundary Source Scan

Thesis: Thesis 2 — Mobility Conversion
Date: 2026-06-28
Status: Source-discovery scan; not accepted as thesis evidence yet
Scope followed: source discovery and methodological comparison only; no city ranking, no candidate MTR selection, no scoring, no methodology decision. This follows the uploaded handoff constraints.  

Executive synthesis

The boundary problem has no single perfect answer. The strongest behavioral fit for a Metropolitan Transport Region is a functional urban area or commuting-based boundary, because it tries to capture where people actually live and work. The strongest comparability source is usually a harmonized statistical or gridded urban dataset, but those often capture built form or administrative reporting convenience rather than the full daily transport region.

For Thesis 2, the main boundary families separate into three roles:

Boundary family	Best role for Mobility Conversion
Functional urban areas	Strongest primary candidate where observed commuting-flow FUAs exist
Commuting zones / travel-to-work areas	Strong primary or validation source, but mostly national and non-harmonized
Official metropolitan statistical areas	Good fallback and statistical-data container
Built-up urban areas / urban agglomerations	Strong urban-core or urban-form context; weak as full MTR boundary
Transport authority / fare / planning boundaries	Governance-fit and operational context; only sometimes a primary boundary
GTFS / service-area-derived boundaries	Indicator input and operator-completeness check; not a primary MTR boundary
Accessibility dataset geographies	External validation and benchmark source; not usually a boundary source

The core tradeoff is: behavioral validity versus global comparability versus operational relevance. No source family maximizes all three.

⸻

1. Functional urban areas

Definition

A functional urban area usually consists of a dense urban core plus a surrounding commuting zone. Eurostat defines a city as a local administrative unit where most residents live in an urban centre of at least 50,000 people, and defines the commuting zone as surrounding travel-to-work areas where at least 15% of employed residents work in the city. A functional urban area is the city plus that commuting zone.  

The OECD similarly describes FUAs as capturing meaningful connections between cities and surrounding areas, using population density and travel-to-work flows.  

Authoritative examples

Key source examples:

* OECD Functional Urban Areas
* Eurostat cities, commuting zones, and FUAs
* Eurostat metropolitan regions, which are NUTS 3 approximations of FUAs with at least 250,000 inhabitants
* GHSL-OECD Functional Urban Areas, a global estimated FUA product based on urban centres and modelled travel-impedance variables rather than observed commuting flows

Eurostat explicitly handles polycentric cases: if cities are connected by commuting flows, a functional urban area may consist of multiple cities and a shared commuting zone. It also gives cross-border commuting rules where data exist.  

Coverage

OECD and Eurostat coverage is strongest for OECD and European countries. GHSL-OECD FUA coverage is global, but the GHS-FUA product represents estimated 2015 commuting areas for urban centres rather than current observed commuting regions.  

Update cadence / release pattern

Observed FUAs are typically tied to census, workplace, commuting-flow, or administrative-unit updates. GHSL’s older FUA product is based on 2015 urban centres, while GHSL’s Urban Centre Database has been updated more recently: UCDB R2024A is based on GHS-SMOD R2023A and has a v1.1 release date of 2025-07-31.  

Spatial unit and scale

Eurostat FUAs are commonly built from local administrative units. OECD notes that the United States may first define commuting zones at census-tract level and then match them to counties for data availability. GHSL-OECD estimated FUAs use 1 km grid cells.  

Boundary basis

Mostly travel behavior + population density. GHSL-OECD’s global estimated FUA product is modelled travel behavior, using travel time to urban centres, urban-centre area, local population, and country GDP per capita.  

Strengths for transport-access research

This is the best conceptual fit for MTRs because it approximates the daily mobility region rather than a political unit. It can capture suburbs, satellite settlements, and polycentric systems. It also prevents errors like scoring a small municipality separately when it is functionally part of a larger metro transport system.

Weaknesses for transport-access research

Commuting is only one travel purpose. It does not fully capture education, shopping, caregiving, leisure, medical, or non-work trips. It may also lag current behavior, especially after remote-work changes. Administrative aggregation can also distort the real catchment at the edge.

Comparability risks

The 15% commuting threshold is harmonized in Eurostat/OECD contexts, but implementation can still differ by source data, local administrative-unit size, census vintage, cross-border data quality, and whether the geography is observed or modelled.

Data availability risks

Strong in Europe and OECD contexts; weaker globally. GHSL-OECD provides global estimated coverage, but it should be treated differently from observed commuting-flow boundaries.

Suitability

Primary MTR boundary where observed OECD/Eurostat/national FUA exists.
Fallback where only modelled global FUA exists.
Strong validation source for other boundary choices.

⸻

2. Commuting zones / travel-to-work areas

Definition

Commuting zones and travel-to-work areas are labor-market regions derived from commuting flows. The UK Office for National Statistics defines Travel to Work Areas as approximations of self-contained labor markets where relatively few commuters cross the boundary.  

The USDA Economic Research Service describes U.S. Commuting Zones as geographic units intended to identify labor markets, noting that county boundaries often reflect political boundaries rather than meaningful economic activity.  

Authoritative examples

Key examples:

* UK ONS Travel to Work Areas
* USDA ERS Commuting Zones
* U.S. Census county-to-county commuting-flow data
* Statistics Canada CMA/CA commuting-flow rules
* Australian Greater Capital City Statistical Areas, which represent labor markets and functional areas of capital cities

USDA’s 2020 Commuting Zones place 3,222 U.S. counties and county equivalents into 598 labor markets based on commuting flows.  

Coverage

Coverage is usually national, not global. Some countries provide strong official commuting-flow geographies; others do not.

Update cadence / release pattern

Cadence is generally census-linked or irregular. USDA ERS updated its Commuting Zones page on 2026-01-09 and now publishes 2020 Commuting Zones; earlier ERS vintages used 1980, 1990, and 2000 census journey-to-work data.  

The U.S. Census publishes commuting-flow tables from ACS 5-year data; the 2016–2020 flow tables are available as residence-county-to-workplace-county and workplace-county-to-residence-county tables.  

Spatial unit and scale

These boundaries are usually built from national statistical units: counties, census subdivisions, local authority districts, lower-level statistical areas, or similar. USDA CZs are county-based. UK TTWAs are statistical-analysis regions rather than administrative boundaries.  

Boundary basis

Primarily travel behavior, specifically work commuting.

Strengths for transport-access research

Commuting-zone methods are behaviorally meaningful and can reveal real metro catchments that cross administrative borders. They are especially useful for checking whether an official metro boundary is too small or too large.

Weaknesses for transport-access research

They may be too labor-market oriented for a thesis that cares about broader everyday access. They can over-include low-density hinterlands or underrepresent non-work travel patterns. They also vary substantially by country.

Comparability risks

High. Thresholds and algorithms differ. For example, Eurostat uses a 15% commuting rule for FUAs, Statistics Canada uses forward and reverse commuting-flow rules with 50% thresholds for surrounding census subdivisions, and UK TTWAs are based on self-containment logic rather than the Eurostat FUA rule.  

Data availability risks

Medium to high outside countries with strong census and workplace-flow systems. Remote work also weakens the stability of work-commuting boundaries; a 2024 Scientific Data paper on U.S. 2020 commuting zones explicitly notes that work-location changes during and after COVID-19 complicate commuting-based delineations.  

Suitability

Primary boundary when a strong national commuting-zone source exists and no harmonized FUA is available.
Excellent validation source.
Not suitable as the only global boundary standard without substantial harmonization work.

⸻

3. Official metropolitan statistical areas

Definition

Official metropolitan statistical areas are government-defined statistical geographies for metropolitan reporting. They often combine a population core with adjacent jurisdictions linked by commuting or economic integration.

In the United States, Core Based Statistical Areas consist of counties or county equivalents associated with at least one urban area of at least 10,000 people plus adjacent counties with social and economic integration measured through commuting ties. A U.S. Metropolitan Statistical Area specifically requires at least one urban area of 50,000 people.  

Authoritative examples

Examples include:

* U.S. OMB Core Based Statistical Areas / Metropolitan Statistical Areas
* Statistics Canada Census Metropolitan Areas and Census Agglomerations
* Eurostat metropolitan regions
* Australian Greater Capital City Statistical Areas
* National metropolitan or regional statistical classifications in other countries

OMB adopted its 2020 Standards for Delineating Core Based Statistical Areas in 2021 and planned delineations based on 2020 standards and 2020 Census data in 2023.  

Coverage

Coverage is country- or region-specific. The United States, Canada, Australia, and Eurostat have strong systems, but there is no single global official metropolitan-statistical boundary standard.

Update cadence / release pattern

Usually census-linked, with revisions after decennial or national census cycles. For U.S. CBSAs, the 2020 standards superseded 2010 standards. For Canada, CMA/CA definitions use place-of-work data from the previous Census Program.  

Spatial unit and scale

Usually counties, municipalities, census subdivisions, NUTS 3 regions, or other official statistical units. Eurostat metropolitan regions are NUTS 3 approximations of FUAs.  

Boundary basis

A mixture of administrative/statistical rules + commuting/economic integration.

Strengths for transport-access research

These boundaries are stable and data-rich. They often align with official population, employment, income, safety, and infrastructure datasets. They are useful for business-oriented comparison because they are commonly used in statistical reporting.

Weaknesses for transport-access research

They are often too coarse. County- or NUTS-level approximations can include large rural areas or miss fine-grained commuting edges. They are not designed specifically around transport service, fare integration, walking access, or actual multimodal mobility.

Comparability risks

High across countries. The U.S. CBSA, Canadian CMA, Australian GCCSA, and Eurostat metro-region systems all have different thresholds, units, and institutional purposes.

Data availability risks

Low within countries that maintain them; medium to high for cross-country harmonization.

Suitability

Good fallback boundary and statistical-data container.
Potential primary boundary only when it closely approximates the functional MTR.
Strong explanatory context for data availability and administrative fit.

⸻

4. Built-up urban areas / urban agglomerations

Definition

Built-up or agglomeration boundaries identify contiguous urbanized territory, usually through density, built form, or gridded population. The World Bank’s WDI glossary, following UN language, describes an urban agglomeration as the de facto population within the contours of a contiguous territory inhabited at urban density levels, without regard to administrative boundaries.  

GHSL’s Degree of Urbanisation defines an urban centre as contiguous grid cells with density of at least 1,500 inhabitants per km² and a total population of at least 50,000, with gaps filled and edges smoothed.  

Authoritative examples

Key examples:

* GHSL Degree of Urbanisation
* GHSL Urban Centre Database
* UN World Urbanization Prospects / urban agglomeration concepts
* World Bank WDI urban-agglomeration series
* NASA SEDAC products based on JRC UCDB

The GHSL Urban Centre Database R2024A/R2025 describes global urban-centre entities using GHSL data plus other open datasets. The JRC data portal describes UCDB 2025 as covering 11,422 quality-controlled urban centres across 15 thematic domains.  

Coverage

Global.

Update cadence / release pattern

GHSL data are multi-temporal. The GHSL Degree of Urbanisation product covers 1975–2030 in five-year intervals and is produced by the European Commission Joint Research Centre.  

Spatial unit and scale

Usually 1 km or finer gridded cells, then aggregated to urban-centre polygons or raster classes. GHSL also includes 100 m and 1 km products for built-up surface and related settlement layers.  

Boundary basis

Built form + population density, not observed travel behavior.

Strengths for transport-access research

These sources are globally comparable, spatially explicit, and independent of administrative boundaries. They are excellent for defining urban cores, measuring urban form, calculating density, and building gridded accessibility denominators.

Weaknesses for transport-access research

A built-up area is not the same as a transport region. It can exclude commuting suburbs separated by greenbelt or low-density land, and it can include contiguous urbanization that is not part of one integrated mobility system. It also says little about fare systems, transport authorities, road networks, or actual daily flows.

Comparability risks

Lower than national statistical systems for built-form comparison, but still subject to remote-sensing accuracy, population-grid quality, edge smoothing, and treatment of informal or mixed-use areas.

Data availability risks

Low for global coverage; medium for local validation and temporal precision.

Suitability

Not ideal as the primary MTR boundary.
Strong fallback for urban-core delineation.
Strong explanatory context for urban form and density.
Useful denominator when no commuting boundary exists, but should be flagged as core/agglomeration rather than full MTR.

⸻

5. Transport authority, fare union, service planning, or governance boundaries

Definition

These are institutional regions: areas covered by a transport authority, fare union, regional planning body, concession system, service-planning agency, or metropolitan transport governance structure.

Examples include:

* A single integrated transport authority
* A regional fare union
* A metropolitan planning organization
* A statutory public transport authority
* A regional rail or bus contracting area

Authoritative examples

In the United States, MPOs are required for urbanized areas with populations above 50,000 and are designated to carry out metropolitan transportation planning.  

U.S. Metropolitan Planning Area boundaries must at minimum cover the existing urbanized area plus contiguous territory expected to become urbanized within a 20-year forecast period, and they may expand to cover the whole OMB metropolitan or combined statistical area.  

Transport for London is described by London City Hall as London’s integrated transport authority, responsible for delivering the Mayor’s transport strategy, operating public transport across London, and managing London’s main roads.  

In the Berlin-Brandenburg example, VBB’s tariff area includes Berlin and Brandenburg, and EMTA describes VBB as responsible for common fare-system development, fare distribution among roughly 40 operators, and regional rail/S-Bahn planning responsibilities.  

Coverage

Highly uneven. Some regions have strong integrated authorities; others have fragmented municipal, private, informal, or national operators.

Update cadence / release pattern

Depends on law, governance reform, fare policy, concession cycles, planning cycles, or census-triggered planning-area updates. In the U.S., MPO planning-area boundaries are reviewed after each census to determine whether they meet statutory requirements.  

Spatial unit and scale

Administrative polygons, fare zones, operator service areas, planning areas, states/provinces, concession territories, or combinations of these.

Boundary basis

Governance and service provision, sometimes with urbanized-area or statistical-area influence.

Strengths for transport-access research

These boundaries explain who can plan, fund, integrate, contract, and operate transport. They are critical for the governance-fit axis and for interpreting fare integration, operator completeness, asset responsibility, and planning authority.

Weaknesses for transport-access research

They may not match the real travel region. A fare union can be larger than the MTR; a city transport authority can be smaller than the commuting catchment. Fragmented regions may have multiple overlapping authorities. Using authority boundaries as the MTR boundary can confuse governance capacity with transport outcome.

Comparability risks

Very high. Institutional design varies radically by country.

Data availability risks

Medium. Official documents often exist, but machine-readable boundaries and consistent historical versions may not.

Suitability

Strong explanatory context.
Possible primary boundary only when the governance boundary closely approximates the functional MTR.
Not suitable as a general global primary boundary.

⸻

6. GTFS or transport-service-area-derived boundaries

Definition

These are boundaries derived from transport service itself: stops, routes, trips, shapes, frequencies, schedules, agency feeds, or service catchments. A GTFS-derived boundary might be a convex hull of stops, an 800 m walk buffer around frequent service, or an isochrone generated from scheduled service.

GTFS is a common format for describing public transportation services. MobilityData’s GTFS best-practice documentation describes it as a format for public transportation services, with recommendations organized around dataset structure and files.  

Authoritative examples

Examples and source classes:

* Official agency GTFS feeds
* U.S. FTA National Transit Database GTFS weblinks
* MobilityData GTFS specification and validator ecosystem
* Transitland feed archive and APIs
* National or regional GTFS repositories

The U.S. FTA requires agencies with fixed-route service to maintain a public GTFS feed and submit a corresponding GTFS link or file to the National Transit Database.  

The U.S. public GTFS weblinks dataset says GTFS allows mapping and geospatial analysis of stops, routes, and trips, but excludes demand-response, vanpool, and other non-fixed-route modes.  

Transitland describes itself as an open-data platform for bus, train, subway, and ferry feeds, with versioned snapshots and GTFS Realtime feeds from agencies around the world.  

Coverage

Uneven globally. Strongest where agencies publish GTFS; weaker where transit is informal, semi-formal, privately operated without open data, or fragmented across many small operators.

Update cadence / release pattern

Potentially very frequent. Transitland says it fetches new feed versions, validates, and imports data daily.  

Spatial unit and scale

Stops, routes, shapes, trips, calendars, agencies, and service frequencies. Boundaries are derived analytically rather than officially defined.

Boundary basis

Transport service provision.

Strengths for transport-access research

Excellent for measuring actual service coverage, frequency, span, and accessibility. GTFS is central to indicators like frequent transit coverage, evening/weekend coverage, travel-time accessibility, and operator completeness.

Weaknesses for transport-access research

GTFS-derived boundaries are outcome-adjacent. If the boundary is defined only by where service exists, then unserved residents can disappear from the denominator. That would bias the Mobility Conversion score upward. GTFS also omits walking, private vehicles, roads, informal transport, missing operators, and non-fixed-route service.

Comparability risks

High. Feed completeness, data quality, agency fragmentation, update practices, and informal transport representation differ widely.

Data availability risks

Medium to high. Even when GTFS exists, the full MTR may require dozens of agencies. Some public feeds may be stale, incomplete, or not legally reusable.

Suitability

Not suitable as a primary MTR boundary.
Highly suitable as an indicator input and service-completeness audit.
Useful overlay for checking whether a chosen MTR boundary includes all material operators.

⸻

7. Accessibility dataset geographies

Definition

These are not boundary systems in the strict sense. They are analytical frameworks that calculate access to opportunities within a chosen geography, often using grids, transport networks, GTFS, road networks, and POI datasets.

The EC–ITF–OECD Urban Access Framework measures access to opportunities provided by the urban transport network and calculates accessibility, proximity, and transport performance. It works on a 500 m by 500 m grid and can use opportunities such as people, schools, hospitals, food shops, restaurants, recreational activities, and green spaces.  

Authoritative examples

Examples include:

* EC–ITF–OECD Urban Access Framework
* OECD FUA transport-performance datasets
* UN SDG 11.2.1 public-transport access reporting
* NASA SEDAC SDG Indicator 11.2.1 Urban Access to Public Transport
* European urban mobility indicator work
* Peer-reviewed GTFS-based accessibility methods

NASA SEDAC’s 2023 SDG 11.2.1 dataset computes public-transport access as the proportion of WorldPop gridded population within 0.5 km walking distance of low-capacity OSM public-transport points or 1 km of high-capacity points, using JRC UCDB city delineations. It covers 5,749 urban centres across 178 countries.  

A peer-reviewed GTFS accessibility paper argues that GTFS plus demographic data enables comparable public-transport accessibility analysis across different urban areas.  

Coverage

Varies by product:

* OECD Urban Access Framework: large European/OECD-type coverage depending on release.
* NASA SEDAC SDG 11.2.1: global urban-centre coverage.
* UN SDG reporting: city-level or national/local authority reporting.
* Local accessibility studies: case-specific.

Update cadence / release pattern

Project-based and inconsistent. NASA SEDAC’s SDG 11.2.1 product is a 2023 release. UNEP’s SDG page notes SDG indicator 11.2.1 as of 2025 reporting context, with national and local authorities supplying data to UN-Habitat.  

Spatial unit and scale

Common units include 500 m grids, UCDB urban centres, FUAs, city boundaries, and population grids.

Boundary basis

Analytical framework + selected underlying geography.
This family usually inherits a boundary from FUA, urban centre, or city definitions rather than creating a boundary itself.

Strengths for transport-access research

Very useful for external validation. These datasets show how other institutions operationalize accessibility and can help test whether our indicators are plausible.

Weaknesses for transport-access research

The geography may not match our MTR definition. For example, UCDB urban centres are built-form cores, not full commuting catchments. OECD accessibility indicators may use opportunity categories, time windows, and vintages different from Mobility Conversion’s V1 registry.

Comparability risks

Medium to high. Results depend on POI completeness, OSM quality, GTFS availability, grid method, population raster, and the chosen boundary.

Data availability risks

Medium. Global datasets exist but may be older, coarser, or methodologically incompatible with our MTR frame.

Suitability

Strong external validation source.
Useful indicator-methodology precedent.
Not suitable as the primary MTR boundary unless its underlying geography independently matches the chosen MTR rule.

⸻

Decision-support comparison

Option A — Behavioral validity first

Rule concept: Use observed functional or commuting-based boundaries as primary. Use statistical boundaries and built-up areas only as fallbacks or overlays.

Evidence that would support this choice:

* The thesis prioritizes “experienced mobility region” over uniform global coverage.
* Most selected MTRs have official or harmonized FUA, commuting-zone, or travel-to-work boundaries.
* Candidate batches remain small enough that boundary verification can be done manually.
* Cross-border and polycentric cases can be handled with explicit rules.

Strengths:

* Best match to the MTR concept.
* Reduces city-proper and province/state distortions.
* Makes outer-region transport performance visible.

Risks:

* Harder global comparability.
* Uneven source quality.
* Work commuting may not represent all everyday mobility.
* Post-pandemic remote-work changes can make older commute data less representative.

Option B — Comparability first

Rule concept: Use a globally harmonized statistical or gridded geography, such as GHSL urban centres or a global estimated FUA product, as the primary boundary.

Evidence that would support this choice:

* The project needs broad global coverage before precision.
* The batches include many countries without reliable commuting-zone data.
* The goal is a high-level screening index rather than detailed metropolitan diagnosis.
* Consistent geospatial processing matters more than local behavioral accuracy.

Strengths:

* Global coverage.
* Reproducible.
* Easier automation.
* Useful for urban-form comparisons.

Risks:

* Built-up urban centres are not full transport regions.
* Estimated FUAs may be stale or modelled rather than observed.
* Service catchments, commuting suburbs, and governance boundaries may be misrepresented.

Option C — Hybrid rule with strict adjustment limits

Rule concept: Use observed FUAs or commuting zones where available; use official statistical metro boundaries as fallback; use GHSL/UCDB built-up areas for core definition and urban-form context; use transport authority and GTFS boundaries only as overlays. Adjust boundaries only under explicit, documented rules.

Evidence that would support this choice:

* The project wants both defensibility and practical data collection.
* The thesis accepts confidence grades and boundary classes.
* The sample includes a mix of OECD-style, global south, city-state, polycentric, and fragmented-governance cases.
* The repo can preserve boundary provenance, versioning, and confidence metadata.

Strengths:

* Best practical balance.
* Keeps behavioral validity where possible.
* Avoids pretending that one global dataset is equally valid everywhere.
* Allows transparent confidence grading.

Risks:

* More methodological complexity.
* Requires careful decision logs.
* Comparisons must show boundary confidence next to scores.
* Harder to automate without source registry discipline.

⸻

Immediate source leads for ThesisRecord

Recommended source-registry categories:

Source family	Initial source leads
Functional urban areas	OECD FUA; Eurostat FUA; Eurostat metro regions; GHSL-OECD FUA
Commuting zones	ONS TTWA; USDA ERS CZ; U.S. Census commuting flows; Statistics Canada CMA/CA rules; ABS GCCSA
Official metro statistical areas	U.S. OMB CBSA/MSA; Statistics Canada CMA; Eurostat metropolitan regions; ABS ASGS/GCCSA
Built-up / agglomeration	GHSL Degree of Urbanisation; GHSL UCDB; UN WUP; World Bank WDI urban agglomeration metadata
Governance / authority	MPO/MPA boundaries; TfL; VBB; national/regional transport authorities
GTFS / service area	MobilityData GTFS; FTA NTD GTFS weblinks; Transitland; official agency feeds
Accessibility geography	EC–ITF–OECD Urban Access Framework; NASA SEDAC SDG 11.2.1; UN-Habitat/UN SDG 11.2.1

Open questions for Codex thesis thread

1. Should “observed commuting-flow FUA” and “modelled global FUA” be treated as separate boundary confidence classes?
2. What is the maximum acceptable vintage gap for commuting-based boundaries?
3. Should work-from-home adjustments be a V1 concern, or only a caveat?
4. Should built-up urban areas be stored as required overlays for every MTR, even when not used as the primary boundary?
5. Should governance/service boundaries be mandatory metadata for every MTR, even when they do not define the MTR?
6. Should GTFS-derived service areas be explicitly forbidden from defining the denominator, to avoid hiding unserved populations?
7. What exact metadata fields should the infrastructure thread store for each boundary source?

Codex target

Suggested repo target:

theses/thesis-2-mobility-conversion/research-artifacts/2026-06-28-mtr-boundary-source-scan.md

Suggested follow-on repo updates:

theses/thesis-2-mobility-conversion/01-definitions.md
theses/thesis-2-mobility-conversion/09-source-registry.md
theses/thesis-2-mobility-conversion/10-decision-log.md
theses/thesis-2-mobility-conversion/11-open-questions.md

Infra implications

The infrastructure thread should eventually create a boundary-source registry with at least:

boundary_source_id
boundary_family
source_name
source_authority
source_url
source_vintage
latest_known_release
geographic_coverage
spatial_unit
geometry_type
observed_or_modelled
basis_type
license
raw_archive_path
processed_geometry_path
confidence_grade
notes

No recurring collection is needed yet. The next infrastructure task should be source registry design, not automated scoring.