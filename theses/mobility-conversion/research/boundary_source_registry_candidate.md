# Boundary Source Registry Candidate

Status: candidate registry design. No source is verified or accepted yet.

## Purpose

This file defines the candidate structure for tracking MTR boundary source
families before any MTR is selected.

The registry should prevent silent boundary drift by recording source family,
vintage, basis, confidence, and known limitations.

Formation-stage hierarchy and minimum admission fields are defined in:

- `theses/mobility-conversion/research/boundary_source_decision_record_2026-06-28.md`

## Candidate Metadata Fields

- `boundary_source_id`
- `boundary_family`
- `source_name`
- `source_authority`
- `source_url_or_access_path`
- `source_vintage`
- `latest_known_release`
- `geographic_coverage`
- `spatial_unit`
- `geometry_type`
- `observed_or_modelled`
- `basis_type`
- `license`
- `raw_archive_path`
- `processed_geometry_path`
- `confidence_class`
- `known_limitations`
- `verification_status`
- `notes`

## Candidate Boundary Caveat Fields

- `commuting_data_vintage`
- `geography_release_vintage`
- `pandemic_or_remote_work_caveat`
- `source_authority_caveat`
- `boundary_quality_notes`
- `transport_access_limitations`
- `confidence_notes`

## Candidate GTFS / Feed Registry Fields

- `source_id`
- `authority`
- `dataset_name`
- `source_url`
- `retrieval_date`
- `ntd_report_year`
- `update_cadence_claim`
- `mode_coverage`
- `fixed_route_only`
- `gtfs_static_required`
- `gtfs_rt_optional`
- `feed_url`
- `feed_host`
- `feed_validation_status`
- `last_successful_fetch`
- `license_or_public_domain_status`
- `raw_archive_path`
- `processed_archive_path`
- `notes`

## Candidate Boundary Families

### Functional Urban Areas

Candidate source leads:

- OECD Functional Urban Areas
- Eurostat functional urban areas
- Eurostat metropolitan regions
- GHSL-OECD Functional Urban Areas

Candidate role:

- primary boundary where observed commuting-flow FUA exists;
- fallback or validation where only modelled FUA exists.

### Commuting Zones / Travel-To-Work Areas

Candidate source leads:

- UK ONS Travel to Work Areas
- USDA ERS Commuting Zones
- U.S. Census commuting-flow tables

Candidate role:

- primary or validation boundary where national methods are strong;
- not sufficient as a global standard without harmonization.

### Official Metropolitan Statistical Areas

Candidate source leads:

- U.S. OMB Core Based Statistical Areas / Metropolitan Statistical Areas
- Statistics Canada Census Metropolitan Areas
- Eurostat metropolitan regions
- ABS ASGS / Greater Capital City Statistical Areas

Candidate role:

- fallback boundary and statistical-data container;
- potential primary only when it closely matches the functional MTR.

### Hybrid Functional Statistical Regions

Candidate source leads:

- Australian Greater Capital City Statistical Areas
- Australian Statistical Area Level 4
- Statistics Canada Census Metropolitan Areas / Census Agglomerations
- U.S. OMB Core Based Statistical Areas

Candidate role:

- fallback boundary or validation layer where the source explicitly uses
  functional criteria but also embeds statistical-output, stability,
  population, administrative, or manual-adjustment rules;
- not equivalent to an observed functional region unless the method and source
  justify that treatment.

### Built-Up Urban Areas / Urban Agglomerations

Candidate source leads:

- GHSL Degree of Urbanisation
- GHSL Urban Centre Database
- UN World Urbanization Prospects urban agglomeration concepts
- World Bank WDI urban agglomeration metadata
- NASA SEDAC products based on JRC urban-centre delineations

Candidate role:

- urban-form and density overlay;
- not primary full-MTR boundary unless scope narrows to urban cores.

### Governance / Authority Boundaries

Candidate source leads:

- U.S. Metropolitan Planning Organization / Metropolitan Planning Area
  boundaries
- Transport for London
- Verkehrsverbund Berlin-Brandenburg
- national or regional transport authorities
- fare unions and service-planning bodies

Candidate role:

- governance-fit context;
- possible primary only when governance boundary closely approximates
  functional MTR.

### GTFS / Service-Area Sources

Candidate source leads:

- MobilityData GTFS
- U.S. FTA National Transit Database GTFS weblinks
- Transitland
- official agency feeds
- national or regional GTFS repositories

Candidate role:

- indicator input;
- service completeness audit;
- not primary boundary or denominator.

### Accessibility Dataset Geographies

Candidate source leads:

- EC-ITF-OECD Urban Access Framework
- OECD FUA transport-performance datasets
- UN SDG 11.2.1 public transport access reporting
- NASA SEDAC SDG 11.2.1 Urban Access to Public Transport
- peer-reviewed GTFS accessibility methods

Candidate role:

- validation and methodology precedent;
- not usually a primary boundary source.

## Verification Status

All entries are unverified source leads until independently inspected.

Initial direct inspection completed on 2026-06-28 for:

- OECD Functional Urban Areas;
- Eurostat functional urban areas;
- Eurostat metropolitan regions.
- GHS Functional Urban Areas;
- GHSL Degree of Urbanisation / GHS-SMOD;
- GHSL Urban Centre Database.
- MobilityData GTFS;
- FTA NTD service-area definitions;
- Transitland feed registry.
- FTA / NTD GTFS Weblinks;
- BTS National Transit Map.
- U.S. Census commuting and home-based-work sources;
- ONS travel-to-work caveat sources;
- OECD remote-work place-based policy source;
- Scientific Data 2020 U.S. commuting-zone paper.
- U.S. OMB Core Based Statistical Area standards;
- USDA ERS Commuting Zones;
- Statistics Canada CMA / CA / MIZ sources;
- ABS ASGS SA4 / GCCSA sources;
- ONS Travel To Work Areas national-method position sources.

See:

- `theses/mobility-conversion/research/batch_1a_boundary_verification_summary_2026-06-28.md`
- `theses/mobility-conversion/research/batch_1b_boundary_verification_summary_2026-06-28.md`
- `theses/mobility-conversion/research/batch_1c_boundary_verification_summary_2026-06-28.md`
- `theses/mobility-conversion/research/batch_2a_boundary_verification_summary_2026-06-28.md`
- `theses/mobility-conversion/research/batch_2b_boundary_verification_summary_2026-06-28.md`
- `theses/mobility-conversion/research/batch_2c_boundary_verification_summary_2026-06-28.md`
- `theses/mobility-conversion/research/boundary_source_decision_record_2026-06-28.md`

Follow-up raw return processed on 2026-06-28:

- `theses/mobility-conversion/research/boundary_followup_source_verification_intake_2026-06-28.md`
