Raw process return — MTR boundary follow-up source verification

Thesis: Thesis 2 — Mobility Conversion
Date: 2026-06-28
Status: Raw process material for Codex intake; not accepted evidence and not a methodology decision.
Scope control: This follows the uploaded boundary-source-scan handoff: source discovery and methodological comparison only; no city ranking, no candidate MTR selection, no scoring, and no methodology decision.  

Verification summary

The strongest verified U.S. public GTFS feed-inventory source is the FTA / NTD General Transit Feed Specification Weblinks dataset, distributed through DOT/Data.gov and tied to NTD annual reporting. It is distinct from the BTS National Transit Map, which is a geospatial catalog built from GTFS Schedule data and published through NTAD/ROSA P. The GTFS weblinks inventory is refreshed monthly; the National Transit Map is updated quarterly.  

Authoritative post-2020 sources support a caveat for commuting-flow boundaries. The verified issue is not that FUA or commuting-zone boundaries are invalid, but that boundaries based on pre-pandemic, 2020, or 2021 commuting data may not represent stable post-pandemic travel behavior, especially where remote or hybrid work materially changed commute flows. The strongest explicit caveat found is from ONS, which states that 2021 travel-to-work data were collected under COVID restrictions and may be less representative for travel-to-work geographies.  

The national commuting-zone examples requested are all verifiable from official or authoritative sources: UK ONS Travel to Work Areas, USDA ERS Commuting Zones, Statistics Canada CMA/CA rules, and ABS Greater Capital City Statistical Areas / ASGS functional-region rationale. They are all useful boundary sources or validation layers, but they differ materially in spatial unit, thresholds, cadence, and intended statistical purpose.  

⸻

1. U.S. public GTFS feed-inventory sources

Source card 1 — NTD General Transit Feed Specification Weblinks

Source title: 2023 NTD Annual Data — General Transit Feed Specification Weblinks / General Transit Feed Specification Weblinks
Source authority: Federal Transit Administration / National Transit Database; distributed through U.S. DOT/Data.gov and data.transportation.gov
URL: https://catalog.data.gov/dataset/2023-ntd-annual-data-general-transit-feed-specification-gtfs-weblinks

Definition:
This is the NTD-linked public inventory of GTFS web links submitted by transit agencies. As of report year 2023, FTA requires fixed-route reporters to create and maintain a public-domain GTFS dataset that reflects fixed-route service. Agencies provide at least one GTFS weblink for each fixed-route bus mode/service and rail modes such as heavy rail, light rail, commuter rail, bus rapid transit, commuter bus, ferryboat, and trolleybus.  

Boundary basis:
Service provision and NTD reporting, not MTR boundary definition.

Observed vs modelled:
Observed agency-reported scheduled-service feed links. Not a modelled boundary product.

Spatial unit:
Agency / NTD reporter / mode / GTFS feed. The GTFS feed itself contains stop, route, trip, stop-time, calendar, and related schedule files.  

Vintage / update cadence:
The NTD data page identifies the GTFS weblinks database file as updated monthly. Agencies certify GTFS feeds annually through NTD reporting, but FTA FAQ material states they are not required to update the submitted feed every time service changes during the year.  

Coverage:
United States NTD fixed-route reporters. The dataset excludes demand response, vanpool, and other non-fixed-route modes. Rural and tribal fixed-route reporters are included where the reporting requirement applies.  

Limits for transport-access research:
Useful for discovering official GTFS sources, but not sufficient as an MTR denominator. It excludes non-fixed-route service and may omit informal or non-reporting services. Submitted links may become stale, invalid, or fail validation. FTA does not host or manage all agency websites, so the link inventory is not the same as an independently verified service archive.  

Suitability:
Indicator input only and service-completeness overlay. Not suitable as a primary or fallback MTR boundary.

⸻

Source card 2 — FTA NTD GTFS reporting requirement

Source title: 2025 NTD Full Reporting Policy Manual; Recent NTD Developments FAQ
Source authority: Federal Transit Administration / National Transit Database
URLs:
https://www.transit.dot.gov/ntd/2025-ntd-full-reporting-policy-manual
https://www.transit.dot.gov/ntd/recent-ntd-developments-frequently-asked-questions-0

Definition:
The NTD policy manual defines GTFS reporting obligations for NTD reporters with fixed-route modes. FTA requires applicable reporters to create and maintain a public-domain GTFS dataset, submit a direct public link, and make the data machine-readable and accessible without password restriction.  

Boundary basis:
Regulatory/reporting requirement for fixed-route service data. Not a geographic boundary method.

Observed vs modelled:
Observed agency-reported schedule data; not modelled.

Spatial unit:
NTD reporter, agency feed, mode, GTFS files.

Vintage / update cadence:
Annual NTD reporting certification. Static GTFS links are required; GTFS-Realtime is optional. Regional GTFS feeds can satisfy the requirement if they represent all relevant services for each NTD reporter.  

Coverage:
Applies to NTD reporters with fixed-route modes, including Full Reporters and certain Reduced Reporters. It does not create complete coverage of every mobility service in an MTR.

Limits for transport-access research:
The policy supports GTFS collection, but it does not guarantee perfect real-time currency, full regional operator coverage, or inclusion of non-fixed-route mobility. Annual certification can lag intra-year service changes.  

Suitability:
Source-authentication layer for U.S. GTFS data. Indicator input only, not a primary boundary source.

⸻

Source card 3 — National Transit Map

Source title: National Transit Map
Source authority: Bureau of Transportation Statistics, U.S. Department of Transportation; using GTFS Schedule data submitted to NTD
URLs:
https://www.bts.gov/national-transit-map
https://rosap.ntl.bts.gov/view/dot/75925

Definition:
The National Transit Map is a nationwide catalog of fixed-guideway and fixed-route transit service generated from GTFS Schedule data. BTS publishes agency, route, and stop datasets through the National Transportation Atlas Database and archives versions through ROSA P.  

Boundary basis:
Service provision. It maps transit agency stops/routes/services, not full functional MTR regions.

Observed vs modelled:
Observed GTFS Schedule submissions, processed by BTS. Some route geometries are adjusted spatially using GTFS shapes or public information.  

Spatial unit:
Transit agencies, routes, stops, and route geometries.

Vintage / update cadence:
BTS says the National Transit Map is updated quarterly and archived in ROSA P. Since report year 2023, FTA has required NTD reporters to submit GTFS Schedule data.  

Coverage:
U.S. fixed-guideway and fixed-route service represented in submitted valid GTFS Schedule feeds. Historic coverage was incomplete when the NTM was voluntary; current coverage is stronger because of NTD reporting requirements, but invalid, missing, or late feeds can still affect inclusion.  

Limits for transport-access research:
The NTM is not a real-time navigation product and should not replace agency-facing customer information. Data can be absent from a quarterly release if submitted after the update window or if invalid for inclusion. It also does not define unserved populations outside fixed-route catchments.  

Suitability:
Service-completeness overlay and indicator input for U.S. fixed-route transit. Not suitable as an MTR primary or fallback boundary.

⸻

U.S. GTFS verification notes

Verified: The authoritative public GTFS feed-inventory source is the NTD/DOT General Transit Feed Specification Weblinks dataset, supported by NTD reporting policy and related FAQ material. The National Transit Map is a separate BTS geospatial product built from GTFS Schedule data.  

Unverified / requires infrastructure fetch: I did not verify the current row count, complete field list, validation status, or live feed reachability for the current Socrata dataset. That requires the infrastructure thread to fetch the current CSV/API metadata and archive it.

Important limitation: Neither the GTFS web links inventory nor the National Transit Map should define the denominator for MTR analysis. Both are service-derived and can hide unserved populations.

⸻

2. Post-2020 commuting disruption and boundary-caveat sources

Source card 4 — U.S. Census commuting and home-based work sources

Source titles:
Commuting (Journey to Work); Commuting Flows; Commuting in the United States: 2022; Home-Based Workers: 2019–2021
Source authority: U.S. Census Bureau
URLs:
https://www.census.gov/topics/employment/commuting.html
https://www.census.gov/data/tables/2020/demo/metro-micro/commuting-flows-2020.html
https://www.census.gov/library/publications/2024/acs/acsbr-018.html
https://www.census.gov/library/publications/2023/demo/p70br-184.html

Definition:
The Census Bureau’s commuting data describe where people work, whether they work from home, travel mode, departure time, travel time, and residence-to-workplace flows. Commuting-flow tables support OMB metropolitan and micropolitan delineations and are produced every five years from non-overlapping ACS 5-year estimates.  

Boundary basis:
Observed survey-based commuting behavior.

Observed vs modelled:
Observed ACS/Census survey estimates, not modelled boundaries by themselves.

Spatial unit:
Residence and workplace geographies such as counties for commuting-flow tables; household/person survey responses for ACS journey-to-work variables.

Vintage / update cadence:
Commuting-flow tables are produced every five years from ACS 5-year data. The 2016–2020 tables are available.  

Coverage:
United States and relevant Census/ACS geographies.

Limits for transport-access research:
Census commuting data are work-trip focused. They do not represent all everyday mobility purposes. COVID-era ACS windows and remote-work changes may alter residence-workplace relationships relative to pre-pandemic or post-pandemic norms. The Census Bureau’s 2022 commuting brief explicitly says COVID-19 substantially changed commuting behavior between 2019 and 2021, especially home-based work.  

Suitability:
Validation layer and commuting-boundary caveat source. Useful for boundary construction in U.S. contexts, but not enough by itself to define all-purpose MTR access.

⸻

Source card 5 — U.S. Census Home-Based Workers: 2019–2021

Source title: Home-Based Workers: 2019–2021
Source authority: U.S. Census Bureau
URL: https://www.census.gov/library/publications/2023/demo/p70br-184.html

Definition:
This Census brief describes workers who perform work duties at home rather than traveling to a separate workplace. The ACS identifies home-based workers when respondents report “work from home” as the method usually used to get to work.  

Boundary basis:
Observed survey response about work location and commute mode.

Observed vs modelled:
Observed survey estimate.

Spatial unit:
Household/person survey response; reported geographically through Census products.

Vintage / update cadence:
The cited brief covers 2019–2021.

Coverage:
United States.

Limits for transport-access research:
The brief supports a caveat that work-from-home adoption changed commuting relationships. It does not directly prescribe how MTR boundaries should be redrawn. It is a caveat source, not a boundary method.

Suitability:
Boundary-caveat source for commuting-flow-derived regions.

⸻

Source card 6 — ONS Census 2021 travel-to-work quality information

Source title: Travel to work quality information for Census 2021
Source authority: UK Office for National Statistics
URL: https://www.ons.gov.uk/census/censustransformationprogramme/questiondevelopment/traveltoworkqualityinformationforcensus2021

Definition:
ONS documents quality issues for Census 2021 travel-to-work data. Travel-to-work data estimate workplace flows and inform public-transport planning, Travel to Work Areas, and Workplace Zones.  

Boundary basis:
Observed census travel-to-work responses, but collected under abnormal COVID conditions.

Observed vs modelled:
Observed census responses; ONS also discusses research into alternative administrative, survey, and modelled sources.

Spatial unit:
Census travel-to-work flows and related workplace geographies.

Vintage / update cadence:
Census 2021. The key issue is that Census Day was 21 March 2021, during lockdown restrictions, work-from-home guidance, furlough, and public-transport avoidance.  

Coverage:
England and Wales for the cited ONS Census 2021 travel-to-work quality material.

Limits for transport-access research:
This is one of the strongest caveat sources found. ONS states that 2021 travel-to-work data may be less representative of where people live and work, and advises continuing to use 2011 Travel to Work Areas while alternative data and methods are researched.  

Suitability:
High-value caveat source for post-2020 commuting-boundary reliability. Not a primary MTR boundary source by itself.

⸻

Source card 7 — ONS Data Science Campus travel-to-work matrix estimation

Source title: Technical report: estimation of travel-to-work matrices
Source authority: ONS Data Science Campus
URL: https://datasciencecampus.ons.gov.uk/projects/technical-report-estimation-of-travel-to-work-matrices/

Definition:
This work addresses travel-to-work matrix estimation after Census 2021, noting that Census 2021 captured a mixture of pre-pandemic and mid-pandemic travel behavior.  

Boundary basis:
Commuting-flow estimation; observed and modelled approaches under review.

Observed vs modelled:
Hybrid research context; ONS notes that Census 2021 travel-to-work data could not directly reflect either pre- or post-pandemic commuting patterns.

Spatial unit:
Origin-destination travel-to-work matrices.

Vintage / update cadence:
Post-Census 2021 research response.

Coverage:
UK-focused.

Limits for transport-access research:
Strong warning that a single pandemic-period census matrix may be inappropriate for defining stable travel-to-work geographies. This supports using vintage/confidence metadata for commute-derived MTR boundaries.

Suitability:
Boundary-caveat source and methodology-risk source. Not a primary boundary source.

⸻

Source card 8 — OECD remote-work and post-COVID mobility sources

Source titles:
Implications of Remote Working Adoption on Place Based Policies; Shaping Post-Covid Mobility in Cities
Source authority: OECD; International Transport Forum / OECD
URLs:
https://www.oecd.org/en/publications/implications-of-remote-working-adoption-on-place-based-policies_b12f6b85-en.html
https://www.itf-oecd.org/shaping-post-covid-mobility-cities

Definition:
OECD’s remote-working report analyzes how COVID accelerated remote-work adoption and its implications for mobility, settlement patterns, and place-based policy. The ITF/OECD urban-mobility work emphasizes that commute trips are only part of total urban mobility and that post-COVID teleworking changes trip patterns.  

Boundary basis:
Not a boundary method. These are policy and mobility-change sources.

Observed vs modelled:
Mixed evidence base, including subnational mobility data, labor surveys, and policy analysis.

Spatial unit:
Regions, cities, settlement patterns, and urban mobility systems depending on report section.

Vintage / update cadence:
Pandemic and post-pandemic policy research; not a periodically updated boundary dataset.

Coverage:
OECD-oriented, but conceptually relevant beyond OECD countries.

Limits for transport-access research:
These sources support the need for caveats around work commuting and post-COVID mobility, but they do not prescribe a specific MTR boundary correction. They also do not replace observed travel-flow data.

Suitability:
Contextual caveat source for growth/maturity and commuting-boundary interpretation. Not a boundary source.

⸻

Source card 9 — New U.S. Commuting Zone delineation based on 2020 data

Source title: New Commuting Zone delineation for the U.S. based on 2020 data
Source authority: Peer-reviewed article in Scientific Data
URL: https://www.nature.com/articles/s41597-024-03829-5

Definition:
This paper delineates 2020 U.S. Commuting Zones using county-to-county commuting flows and hierarchical clustering. It updates earlier CZ definitions and provides quality measures for comparing commuting-zone delineations.  

Boundary basis:
Observed commuting flows processed through a clustering algorithm.

Observed vs modelled:
Observed commuting-flow data used in an analytical delineation model.

Spatial unit:
U.S. counties and county equivalents.

Vintage / update cadence:
2020-based delineation; published in 2024. Not an official recurring government dataset, but built from official commuting-flow data.

Coverage:
United States.

Limits for transport-access research:
The paper explicitly notes that changing work and residence patterns during and after COVID-19 can substantially affect commuting-based delineation quality. It is useful for caveating commute-flow boundaries, but it is not an official MTR standard.  

Suitability:
Validation layer and commuting-boundary caveat source for U.S. analysis. Potential fallback research source, not a primary official boundary.

⸻

Post-2020 commuting caveat synthesis

Verified: Official and authoritative sources support treating post-2020 commuting boundaries cautiously. The strongest operational warning is from ONS: Census 2021 travel-to-work data were collected during lockdown and may be less representative for travel-to-work geography; ONS advises continued use of 2011 TTWAs while alternative methods are researched.  

Verified: U.S. Census material shows substantial changes in home-based work and commuting behavior between 2019 and 2021, with continuing implications into 2022.  

Verified: OECD/ITF sources support a broader conceptual caveat: commuting is only a subset of urban mobility, and post-COVID teleworking changed the relationship between residence, workplace, and daily travel.  

Unverified: I did not find an official OECD/Eurostat statement saying all FUA boundaries must be redrawn because of remote work. The evidence supports a boundary-vintage caveat, not a universal rejection of FUA or commuting-zone methods.

⸻

3. National commuting-zone / travel-to-work-area methods

Source card 10 — UK ONS Travel to Work Areas

Source title: Travel to Work Area analysis in Great Britain: 2016
Source authority: UK Office for National Statistics, with methodology developed by Newcastle University
URL: https://www.ons.gov.uk/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/articles/traveltoworkareaanalysisingreatbritain/2016

Definition:
Travel to Work Areas approximate self-contained labor markets where relatively few commuters cross the boundary. ONS describes them as statistical-analysis geographies, not administrative boundaries.  

Boundary basis:
Observed commuting flows and labor-market self-containment.

Observed vs modelled:
Observed Census 2011 origin-destination commuting flows processed through a delineation method.

Spatial unit:
Lower-layer Super Output Areas in England and Wales, Data Zones in Scotland, and Super Output Areas in Northern Ireland.  

Vintage / update cadence:
The inspected TTWAs use 2011 Census commuting data. ONS notes a long-run trend toward fewer TTWAs as commutes lengthened: 308 in 1991, 243 in 2001, and 228 in 2011.  

Coverage:
UK-wide non-overlapping TTWAs, with caveats around Northern Ireland–Republic of Ireland cross-border commuting.  

Limits for transport-access research:
TTWAs are work-commuting labor-market areas, not all-purpose transport-access regions. They may miss non-work mobility patterns and are currently based on pre-pandemic 2011 commuting data. ONS’s separate Census 2021 quality work cautions that 2021 data are not straightforward replacements.  

Suitability:
Primary boundary candidate where a UK MTR is being analyzed and labor-market catchment is the desired behavioral basis; validation layer for administrative or transport-authority boundaries; not an indicator input.

⸻

Source card 11 — USDA ERS Commuting Zones

Source title: Commuting Zones and Labor Market Areas
Source authority: U.S. Department of Agriculture, Economic Research Service
URL: https://www.ers.usda.gov/data-products/commuting-zones-and-labor-market-areas

Definition:
USDA ERS Commuting Zones are geographic units intended to identify labor markets. ERS notes that counties often reflect political boundaries rather than meaningful economic activity, and that other delineations can exclude rural counties.  

Boundary basis:
Observed county-to-county commuting flows and labor-market integration.

Observed vs modelled:
Observed commuting flows processed into delineated labor-market regions. The 2020 ERS version adds a contiguity constraint to commuting-zone delineations.  

Spatial unit:
Counties and county equivalents. The 2020 ERS dataset groups 3,222 U.S. counties and county equivalents into 598 labor markets.  

Vintage / update cadence:
ERS provides 2020 Commuting Zones and older vintages. The inspected page was updated 2026-01-09. Earlier CZ vintages include 1980, 1990, and 2000; 2010 and 2020 delineations were developed by Penn State researchers and incorporated by ERS.  

Coverage:
United States and Puerto Rico.

Limits for transport-access research:
County-based CZs can be too coarse for urban transport analysis. They are designed around labor markets, including rural labor markets, not multimodal metropolitan access. Post-2020 remote-work changes also require caveats for commuting-flow delineations.  

Suitability:
Validation layer or fallback boundary for U.S. labor-market catchments. Usually not ideal as a precise primary MTR boundary for transport-access scoring unless no finer functional boundary is available.

⸻

Source card 12 — Statistics Canada Census Metropolitan Areas and Census Agglomerations

Source title: Illustrated Glossary: Census metropolitan area and census agglomeration; Preliminary 2021 CMA/CA delineation rules
Source authority: Statistics Canada
URLs:
https://www150.statcan.gc.ca/n1/pub/92-195-x/2021001/geo/cma-rmr/cma-rmr-eng.htm
https://www150.statcan.gc.ca/n1/pub/92f0138m/92f0138m2019002-eng.htm

Definition:
A Census Metropolitan Area or Census Agglomeration is formed by adjacent municipalities centered on a population centre core. A CMA has total population of at least 100,000, with at least 50,000 in the core. Adjacent municipalities are included based on high integration with the core, measured by commuting flows from the previous Census.  

Boundary basis:
Official statistical metropolitan delineation using commuting-flow integration, population-core thresholds, contiguity, historical comparability, and manual adjustment rules.

Observed vs modelled:
Observed Census commuting data embedded in official statistical rules.

Spatial unit:
Census subdivisions, generally corresponding to municipalities.  

Vintage / update cadence:
Census-linked. For 2021 boundaries, Statistics Canada used 2016 population centres and 2016 place-of-work data adjusted to 2021 census-subdivision boundaries.  

Coverage:
Canada.

Limits for transport-access research:
CMA/CA boundaries are official and data-rich, but they are not pure transport-service regions. The municipality-based building blocks and historical/manual rules can make them coarser than actual travel catchments. They are still work-commuting-oriented and may not reflect all everyday access purposes.

Suitability:
Fallback or primary candidate boundary in Canada depending on whether CMA/CA geography closely matches the intended MTR. Strong statistical container and validation layer.

⸻

Source card 13 — ABS Greater Capital City Statistical Areas and ASGS functional regions

Source title: Australian Statistical Geography Standard; Greater Capital City Statistical Areas; Statistical Area Level 4
Source authority: Australian Bureau of Statistics
URLs:
https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/latest-release
https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/main-structure-and-greater-capital-city-statistical-areas/greater-capital-city-statistical-areas
https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/main-structure-and-greater-capital-city-statistical-areas/statistical-area-level-4

Definition:
Greater Capital City Statistical Areas represent the functional area of each Australian state and territory capital city. They are built from Statistical Area Level 4 regions. ABS says GCCSAs are designed to represent the socio-economic extent of capital cities and include people who regularly interact with the city through work, shopping, social, or economic activity.  

Boundary basis:
Official statistical geography with labor-market and functional-region rationale. SA4s are designed to represent labor markets and functional areas, with Census travel-to-work data and expert consultation used in their design.  

Observed vs modelled:
Hybrid official statistical geography: not purely modelled, not purely direct commuting-flow threshold. It incorporates Census travel-to-work evidence, functional-labor-market reasoning, design stability, and ABS statistical criteria.  

Spatial unit:
GCCSAs are built from SA4s; SA4s are built from SA3s. Destination Zones are a separate ASGS non-ABS structure co-designed with transport authorities for commuting and transport-policy analysis.  

Vintage / update cadence:
ASGS Edition 3 covers July 2021 to June 2026. ABS has scheduled ASGS Edition 4 releases beginning in 2026.  

Coverage:
Australia. GCCSAs cover the eight capital-city functional areas and the rest of each state/territory.  

Limits for transport-access research:
GCCSAs are useful functional/statistical containers, but they may be coarse for detailed MTR access analysis. ABS explicitly warns that ASGS urban approximations may differ from official or commonly understood city definitions. GCCSAs may include surrounding towns or rural areas that interact with the capital city but are not part of the contiguous urban transport system.  

Suitability:
Fallback or primary candidate boundary for Australian capital-region MTRs, depending on fit. Strong statistical container and governance/functional-region context. Destination Zones may be useful as an indicator input or validation layer for commuting analysis.

⸻

4. Cross-source notes for Codex intake

Verified source classifications

Source	Best verified classification for Thesis 2
NTD GTFS Weblinks	Indicator input / service-completeness overlay
FTA NTD GTFS reporting requirement	Source-authentication and reporting-rule layer
BTS National Transit Map	Indicator input / service-completeness overlay
U.S. Census commuting flows	Boundary input or validation layer; caveat source
ONS Census 2021 travel-to-work quality note	Strong commuting-boundary caveat source
OECD remote-work / ITF post-COVID mobility	Contextual caveat source
UK ONS TTWA	Primary candidate or validation layer for UK labor-market/MTR boundaries
USDA ERS Commuting Zones	U.S. labor-market fallback / validation layer
Statistics Canada CMA/CA	Canadian official metro boundary / statistical container / validation layer
ABS GCCSA / ASGS	Australian official functional/statistical container / candidate MTR boundary

Main uncertainty to preserve

1. Single U.S. GTFS inventory source: Verified best candidate is NTD GTFS Weblinks, with NTM as the geospatial downstream product. I did not verify a single combined product that includes all GTFS links, validation status, NTM geometries, reporting metadata, and current reachability in one authoritative table.
2. Remote-work boundary correction: Verified sources support a caveat for commuting-based boundaries. I did not verify an official rule saying FUAs or commuting zones must be redrawn because of remote work.
3. Observed vs modelled distinction: UK TTWA, USDA CZ, and Statistics Canada CMA/CA use observed commuting data within statistical methods. ABS GCCSA/SA4 is more hybrid: functional/statistical design with travel-to-work evidence and stability considerations, not a pure commuting-flow threshold product.
4. Transport-access denominator risk: Service-derived sources remain inappropriate as denominators because they can erase unserved people from the analysis. They are inputs and overlays, not boundaries.

⸻

5. Suggested Codex intake targets

Suggested raw artifact path:

theses/thesis-2-mobility-conversion/research-artifacts/raw/2026-06-28-boundary-follow-up-gtfs-commuting-caveats-national-methods.md

Suggested source-note candidates:

theses/thesis-2-mobility-conversion/source-notes/us-ntd-gtfs-weblinks.md
theses/thesis-2-mobility-conversion/source-notes/us-bts-national-transit-map.md
theses/thesis-2-mobility-conversion/source-notes/post-2020-commuting-boundary-caveats.md
theses/thesis-2-mobility-conversion/source-notes/uk-ons-travel-to-work-areas.md
theses/thesis-2-mobility-conversion/source-notes/usda-ers-commuting-zones.md
theses/thesis-2-mobility-conversion/source-notes/statcan-cma-ca-boundaries.md
theses/thesis-2-mobility-conversion/source-notes/abs-gccsa-asgs-functional-regions.md

Suggested infrastructure registry fields for GTFS/feed sources:

source_id
authority
dataset_name
source_url
retrieval_date
ntd_report_year
update_cadence_claim
mode_coverage
fixed_route_only
gtfs_static_required
gtfs_rt_optional
feed_url
feed_host
feed_validation_status
last_successful_fetch
license_or_public_domain_status
raw_archive_path
processed_archive_path
notes

Suggested infrastructure registry fields for boundary/caveat sources:

source_id
authority
source_title
source_url
boundary_family
observed_or_modelled
spatial_unit
commuting_data_vintage
geography_release_vintage
coverage
update_cadence
pandemic_or_remote_work_caveat
transport_access_limitations
raw_archive_path
processed_note_path
confidence_notes

No scoring, candidate selection, or boundary-method decision should be triggered from this raw return alone.