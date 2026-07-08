# Source Note: France NAP / Lyon TCL Service Sources

Date inspected: 2026-07-01

Verification status: `directly_inspected_catalog_api_response`

Source:

- Title or dataset: France National Access Point `Réseau urbain TCL`
- Authority or publisher:
  - Point d'Accès National transport.data.gouv.fr
  - SYTRAL Mobilités
- URL, DOI, document identifier, archive path, API endpoint, or access path:
  - `https://transport.data.gouv.fr/`
  - `https://doc.transport.data.gouv.fr/outils/outils-disponibles-sur-le-pan/api`
  - `https://transport.data.gouv.fr/api/datasets`
  - `https://transport.data.gouv.fr/api/datasets/5de42c4d8b4c417a10e62ec9`
  - `https://transport.data.gouv.fr/datasets/horaires-theoriques-du-reseau-transports-en-commun-lyonnais`
- Release date, source vintage, or version:
  - NAP dataset API inspected 2026-07-01
  - dataset `updated`: `2026-05-12T22:15:44.378000Z`
  - dataset `created_at`: `2019-12-01`

Status: independently inspected source note. This note does not admit an MTR,
accept an outcome metric, create an evidence manifest, authorize raw data
archiving, calculate scores, rank MTRs, or make final paper claims.

## Source Authority

The French National Access Point (`transport.data.gouv.fr`) catalogs transport
datasets and resources. The inspected API documentation states that the API
publishes dataset, resource, authority, history, and validation information in
JSON without authentication or quota.

The inspected `Réseau urbain TCL` dataset identifies SYTRAL Mobilités as both
publisher and legal owner.

## What The Source Defines

The inspected dataset record defines a public-transport data catalog entry for
the Lyon TCL urban network.

Key inspected catalog fields:

```yaml
dataset_id: 5de42c4d8b4c417a10e62ec9
title: Réseau urbain TCL
slug: horaires-theoriques-du-reseau-transports-en-commun-lyonnais
type: public-transit
publisher: SYTRAL Mobilités
legal_owner: SYTRAL Mobilités
license: mobility-licence
sub_types:
  - urban
tags:
  - licence-mobilités
  - authentification_requise
offer:
  nom_commercial: TCL Lyon
  type_transport: Transport collectif urbain
  nom_aom: SM des transports pour le Rhône et l'agglomération lyonnaise (SYTRAL)
```

The inspected dataset resources include:

- SIRI Lite `estimated-timetables.json`, available;
- SIRI Lite `situation-exchange.json`, available;
- SIRI Lite `vehicle-monitoring.json`, available;
- PDF documentation, unavailable in the inspected catalog response;
- NeTEx archive, unavailable in the inspected catalog response;
- GTFS archive, unavailable in the inspected catalog response.

## Source Function For Mobility Conversion

- `service_or_network_source`
- `outcome_indicator_source_family`, only after a metric-specific method note
- `methodology_reference`

## Boundary / Denominator Role

- MTR boundary source: no.
- Resident-population denominator source: no.
- Overlay or input only: yes, as service/network source candidate after an
  independent MTR boundary is defined.
- Service-derived denominator risk: high if TCL/SYTRAL service geography,
  resource coverage, route extent, stop buffers, or catalog covered areas are
  used to define the Lyon MTR.

## Outcome / Axis Role

- Outcome dimensions supported:
  - network coverage and service availability, if static schedule resources are
    obtainable or SIRI Lite can be methodologically converted/queried;
  - travel time and reliability only after a method note handles dynamic SIRI
    data and archive reproducibility.
- Explanatory axes supported: governance fit only through separate governance
  documentation, not from the service feed itself.
- Risk of confusing outcome with explanatory axis: high. TCL/SYTRAL data
  availability is not transport performance.

## Data Availability

- Geography: catalog covered areas include multiple EPCI territories including
  Metropole de Lyon and surrounding communities. These covered areas are not
  accepted as the Eurostat/GISCO Lyon FUA.
- Spatial unit:
  - SIRI Lite feed entities for estimated timetables, situation exchange, and
    vehicle monitoring;
  - unavailable GTFS and NeTEx resources listed by the catalog;
  - catalog-level covered areas and offer metadata.
- Time period or release vintage:
  - dataset updated 2026-05-12 in the inspected catalog response;
  - listed GTFS metadata, from the unavailable catalog resource, reports a
    2022-04-14 to 2022-07-12 validity range and should not be treated as a
    current feed without re-acquisition.
- Update frequency: unresolved from inspected source note.
- Access method:
  - NAP catalog API;
  - dataset resource URLs;
  - underlying Grand Lyon SIRI Lite endpoints listed in the catalog response.
- License or usage constraint:
  - dataset license listed as `mobility-licence`;
  - dataset tags include `authentification_requise`;
  - terms and authentication implications require follow-up before any raw
    service archive.

## Relevance To Mobility Conversion

This source resolves the first Lyon service-source trace gap: there is an
official catalog record for TCL Lyon, owned/published by SYTRAL Mobilités, with
resource URLs and availability status.

It does not complete the Lyon source bundle. Current static GTFS/NeTEx resources
are not available in the inspected catalog response, and available SIRI Lite
resources require method and archive decisions before they can support a metric.

## Service Source Review

```yaml
service_source_review:
  source_name: France NAP / Réseau urbain TCL
  source_authority: transport.data.gouv.fr; SYTRAL Mobilités
  source_url_or_access_path:
    - https://transport.data.gouv.fr/api/datasets/5de42c4d8b4c417a10e62ec9
    - https://transport.data.gouv.fr/datasets/horaires-theoriques-du-reseau-transports-en-commun-lyonnais
  format:
    available:
      - SIRI Lite estimated timetables
      - SIRI Lite situation exchange
      - SIRI Lite vehicle monitoring
    listed_but_unavailable_in_catalog_response:
      - GTFS
      - NeTEx
      - PDF documentation
  static_or_realtime: mixed_or_unresolved
  publication_or_feed_date: dataset updated 2026-05-12
  feed_validity_window: unresolved for available SIRI Lite resources
  retrieval_or_inspection_date: 2026-07-01
  license_or_reuse_terms: mobility-licence, details unresolved
  registration_required: catalog tag says authentification_requise
  authentication_required: unresolved for actual resource retrieval
  archive_required: true before metric use
  evidence_manifest_required: true before raw feed/archive use
  modes_covered:
    from_unavailable_gtfs_metadata:
      - tramway
      - bus
      - subway
      - funicular
    accepted_current_modes: unresolved
  operators_covered: TCL SYTRAL in historical/unavailable GTFS metadata; current coverage unresolved
  operators_missing_or_unknown:
    - regional rail
    - airport connector / Rhônexpress if material
    - regional coach or interurban services inside FR002F
    - demand-responsive or paratransit services
  geography_covered: catalog EPCI coverage, not accepted as FUA
  coverage_against_independent_mtr_boundary: unresolved
  unserved_population_visibility: unresolved
  non_fixed_route_or_informal_service_gaps: unresolved
  accessibility_fields_available: historical GTFS metadata reports wheelchair fields; current availability unresolved
  fare_fields_available: historical GTFS metadata reports no fares; current availability unresolved
  realtime_fields_available: SIRI Lite situation exchange and vehicle monitoring listed available
  validation_status: source_family_verified_with_access_and_static_feed_risk
  source_limitations:
    - GTFS and NeTEx listed but unavailable in inspected response
    - SIRI Lite requires method work before scheduled-service metric use
    - catalog covered areas cannot define the MTR
    - authentication/licence details unresolved
  denominator_prohibited: true
```

## Limitations

- The catalog record traces TCL Lyon, not the full `FR002F` FUA service bundle.
- Available resources are SIRI Lite; static GTFS/NeTEx resources were listed
  but unavailable in the inspected response.
- Historical GTFS metadata exists in the catalog response but should not be used
  as current service evidence.
- The catalog covered areas are administrative/service areas, not independent
  commuting-region boundaries.
- Authentication and licence details require follow-up before raw resource
  acquisition.
- Additional material services may exist inside `FR002F`, including regional
  rail, airport connector, interurban coach, and demand-responsive services.

## Suitability Judgment

Suitability: `source_lead_pending`

Rationale:

France NAP / `Réseau urbain TCL` is suitable as a traced source lead for Lyon
service-source work, but not yet suitable as a candidate indicator source family
because current static schedule reproducibility, mode/operator completeness,
licence detail, and FUA coverage remain unresolved.

## Methodology Implication

Lyon should not advance to readiness review until static schedule source
availability is resolved or a defensible SIRI Lite method is documented.

The next Lyon-specific source work should:

- verify `mobility-licence` terms;
- test whether listed GTFS/NeTEx resources are recoverable from the source or
  only stale catalog records;
- decide whether SIRI Lite can support scheduled-service/access work;
- identify material non-TCL operators inside `FR002F`;
- reconcile source coverage against `FR002F`, not against SYTRAL/TCL coverage.

## Next Allowed Output

Allowed:

- Lyon service-source trace decision note;
- France NAP licence/authentication follow-up;
- static-feed availability follow-up;
- non-TCL operator scan for `FR002F`.

## Prohibited Outputs

This source note does not authorize:

- admitted MTR;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- raw data archive without manifest.
