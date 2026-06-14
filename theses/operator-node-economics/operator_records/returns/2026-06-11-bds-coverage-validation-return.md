---
record_id: return-2026-06-11-bds-coverage-validation
record_type: return
workflow_id: 2026-06-11-bds-coverage-validation
status: completed
created_at: 2026-06-11T22:05:00+08:00
owner: Research
---

# Return: BDS Coverage Validation

## Scope

This Research pass validated the broader coverage envelope for Census BDS
`BDSFAGEFSIZE` before any full age/size pull. It tested year, geography, and
NAICS coverage using small official Census API calls. It did not run
quantitative analysis, create an analysis dataset, or write paper prose.

`paper/draft.md` was not edited.

## Files Changed

- `research/data/bds_coverage_validation.md`
- `research/data/acquisition_scaffold.md`
- `research/data/schema_mapping.md`
- `research/data/naics_panel_inventory.md`
- `research/empirical_strategy.md`
- `research/reading_queue.md`
- `paper/evidence_requirements.md`
- `docs/operator/returns/2026-06-11-bds-coverage-validation-return.md`

## Exact Verification Performed

All API checks used key-first query construction and loaded `CENSUS_API_KEY`
from ignored `.env.local`. The key was not printed or recorded.

Year checks for U.S. all-industry/all-age/all-size context:

- 2019: HTTP 204, no rows.
- 2020: HTTP 204, no rows.
- 2021: HTTP 204, no rows.
- 2022: HTTP 200 JSON, one row excluding header.
- 2023: HTTP 204, no rows.

Geography checks for 2022 all-industry/all-age/all-size context:

- U.S.: HTTP 200 JSON, one row excluding header.
- All states: HTTP 200 JSON, 51 rows excluding header.
- California counties: HTTP 200 JSON, 58 rows excluding header.
- Metro/micro: HTTP 200 JSON, 925 rows excluding header.

NAICS checks for 2022 U.S. all-age/all-size context:

- NAICS-label query: HTTP 200 JSON, 394 rows excluding header.
- `NAICS=54`: HTTP 200 JSON, one row excluding header.
- `NAICS=5415`: HTTP 200 JSON, one row excluding header.
- `NAICS=541511`: HTTP 204, no rows.

## Blockers Closed

- `BDSFAGEFSIZE` is now schema-validated for 2022 U.S., state, selected county,
  and metro/micro geography query forms in the tested all-industry/all-age/all-
  size context.
- 2022 U.S. NAICS label coverage is validated as a returned code set.
- Selected 2022 U.S. NAICS levels are validated for row shape: sector `54` and
  industry group `5415`.

## Blockers Remaining

- Multi-year firm-age-by-size coverage remains unresolved. Tested U.S.
  all-industry/all-age/all-size contexts outside 2022 returned no rows.
- Do not assume six-digit NAICS coverage in `BDSFAGEFSIZE`; tested
  `NAICS=541511` returned no rows.
- Direct employer firm-startup/birth field distinct from establishment entry
  remains unresolved.
- Future ingestion must handle duplicate predicate/requested columns in Census
  API responses.
- This pass does not support any Operator Node claim.

## Guardrails Preserved

- No `paper/draft.md` edit.
- No paper prose.
- No quantitative analysis.
- No API key or secret recorded.
- No raw API response committed.
- No Operator Node claim promoted.
- No decision about the Operator Node hypothesis.
- No prohibited philosophical or religious foundation.

## Verification Commands

Run after editing:

```bash
git diff -- paper/draft.md
git diff --check
git check-ignore .env.local data/raw/susb/2022/us_state_6digitnaics_2022.txt
rg -n "BDSFAGEFSIZE|2019|2020|2021|2022|2023|metro/micro|541511|multi-year|coverage_validated_2022_contexts_only" research/data/bds_coverage_validation.md research/data/acquisition_scaffold.md research/data/schema_mapping.md research/data/naics_panel_inventory.md research/empirical_strategy.md research/reading_queue.md paper/evidence_requirements.md docs/operator/returns/2026-06-11-bds-coverage-validation-return.md
rg -n "Buddh[i]sm|Tao[i]sm|Sun[y]ata|dependent[ -]originat[i]on|man[i]festo|conclus[i]ons?|firm is dea[d]|end of the fir[m]" research/data/bds_coverage_validation.md research/data/acquisition_scaffold.md research/data/schema_mapping.md research/data/naics_panel_inventory.md research/empirical_strategy.md research/reading_queue.md paper/evidence_requirements.md docs/operator/returns/2026-06-11-bds-coverage-validation-return.md
rg -n "[ \t]+$" research/data/bds_coverage_validation.md research/data/acquisition_scaffold.md research/data/schema_mapping.md research/data/naics_panel_inventory.md research/empirical_strategy.md research/reading_queue.md paper/evidence_requirements.md docs/operator/returns/2026-06-11-bds-coverage-validation-return.md
```

Results:

- `git diff -- paper/draft.md`: no output.
- `git diff --check`: passed with no output.
- `git check-ignore`: returned `.env.local` and the SUSB raw file path.
- Coverage scan returned expected matches.
- Prohibited-foundation/polemical-language scan: no output.
- Trailing-whitespace scan: no output.

## Commit Status

No commit or push was performed for this slice.
