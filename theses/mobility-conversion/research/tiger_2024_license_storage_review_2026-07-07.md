# TIGER 2024 License And Storage Review

Date: 2026-07-07

Status: license and repository-storage review for a draft evidence manifest.
This note does not accept evidence, admit an MTR, create a boundary record,
create an outcome metric record, accept population values, or authorize scores
or rankings.

Related manifest:

- `theses/mobility-conversion/evidence/manifests/tiger_2024_subcounty_geometry_overlay_manifest_2026-07-07.md`

Related source note:

- `theses/mobility-conversion/research/source_notes/us_census_acs_tiger_subcounty_overlay_sources_2026-07-06.md`

Official sources inspected:

- `https://www.census.gov/programs-surveys/geography/technical-documentation/complete-technical-documentation/tiger-geo-line.2024.html`
- `https://www2.census.gov/geo/pdfs/maps-data/data/tiger/tgrshp2024/TGRSHP2024_TechDoc_Ch1.pdf`
- `https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.2024.html`

## Review Findings

The official 2024 TIGER/Line technical documentation page exposes the 2024
documentation set and links Chapter 1 as "Legal Disclaimer, Citation
Information and Contact."

Chapter 1 states that no warranty is made for TIGER/Line Shapefile accuracy,
that the boundary information is for statistical data collection and tabulation
purposes, and that depicted boundaries are not legal land descriptions.

Chapter 1 also states that copyright protection is not available for U.S.
Government works under Title 17 U.S.C. Section 105, that census materials may
be reproduced, and that the Census Bureau asks users to cite the Census Bureau
as source.

TIGER/Line is a registered Census Bureau trademark. Repackaged TIGER/Line data
must not use TIGER/Line as a proprietary product name, and should include a
visible statement that TIGER/Line refers to the nature of the product.

## Storage Decision

```yaml
tiger_2024_license_storage_review:
  source_authority: U.S. Census Bureau
  source_vintage: TIGER/Line 2024
  reviewed_artifact: TIGER/Line tract and block group state ZIP files
  copyright_status: us_government_work_no_copyright_protection
  citation_required_by_project: true
  trademark_notice_required_by_project: true
  warranty_disclaimer_required_by_project: true
  redistribution_allowed: true
  repo_storage_allowed: true
  repo_storage_scope:
    - Minnesota tract ZIP
    - Minnesota block group ZIP
    - Wisconsin tract ZIP
    - Wisconsin block group ZIP
    - Oregon tract ZIP
    - Oregon block group ZIP
    - Washington tract ZIP
    - Washington block group ZIP
  approximate_total_remote_content_length_bytes: 95764945
  allowed_archive_root: theses/mobility-conversion/evidence/raw/us_census/tiger_2024_subcounty_geometry/
  acquisition_mode_allowed: bulk_file_download_under_existing_manifest
  accepted_for_method_test: false
  accepted_for_boundary_record: false
  accepted_for_metric_record: false
  accepted_for_final_evidence: false
```

Raw repository storage is allowed for this controlled snapshot because the
files are official public Census Bureau release artifacts, reproduction is
permitted with source citation, the total size is modest for a one-time
formation-stage geometry snapshot, and a draft evidence manifest already
exists.

This decision does not make the downloaded files evidence by itself. After raw
download, the next required checks are SHA-256 checksum capture and raw ZIP
content inspection.

## Required Citation / Notice

Future use notes should cite:

- U.S. Census Bureau, TIGER/Line Shapefiles, 2024 vintage.

Future redistributed or repackaged materials should include:

- TIGER/Line is a registered trademark of the U.S. Census Bureau.
- TIGER/Line boundary information is for statistical data collection and
  tabulation purposes and is not a legal land description.

## Prohibited Outputs

This review does not authorize:

- admitted MTR;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- accepted population value;
- accepted denominator value;
- filled boundary record;
- final paper claim.
