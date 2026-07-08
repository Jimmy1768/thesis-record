# ACS API Access Recheck

Date: 2026-07-07

Status: local access recheck. No ACS rows were archived or accepted.

Related source note:

- `theses/mobility-conversion/research/source_notes/us_census_acs_tiger_subcounty_overlay_sources_2026-07-06.md`

## Recheck

ACS API access remains blocked in the current local environment.

```yaml
acs_api_access_recheck:
  target_source_family: American Community Survey 5-year API
  attempted_queries:
    - url: https://api.census.gov/data/2024/acs/acs5/groups/B01003.json
      purpose: verify B01003 group metadata availability
      local_result: curl_exit_code_35
      archived_response: false
    - url: https://api.census.gov/data/2024/acs/acs5?get=NAME&for=us:*
      purpose: verify minimal 2024 ACS API row response
      local_result: curl_exit_code_35
      archived_response: false
  decision: acs_api_still_blocked_in_current_environment
  accepted_population_value: false
  accepted_denominator_value: false
```

The block is local access/TLS behavior, not a method decision against ACS. ACS
tables remain deferred until a working environment can verify live rows,
variables, geography keys, vintage, and margin-of-error fields.

## Next Allowed Output

- external-environment ACS API row verification source-note follow-up; or
- local TLS/API fix followed by a successful row-response capture; or
- continue TIGER geometry-only tooling work without population joins.

## Prohibited Outputs

This recheck does not authorize accepted population values, accepted
denominators, boundary records, metric records, scores, rankings, or final
claims.
