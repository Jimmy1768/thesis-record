# Economic Class Measurement Design Return

Date: 2026-06-12

Role: Research

Slice: operationalize `TCE-P012` measurement design.

## Summary

This pass converted the economic-class implication forecast into a measurement
design. It did not run analysis, add paper prose, or promote claim support.

Core result: public sources can provide only weak proxy baselines. Direct
testing requires private or platform data on compensated human evaluation,
buyer decision impact, creator/operator roles, niche human-presence premiums,
and substitution by telemetry or synthetic users.

## Files Changed

- `research/source_notes/bls_oews_ooh_preference_validation_proxies.md`
- `research/data/economic_class_measurement_design.md`
- `research/economic_class_implications.md`
- `research/data/field_dictionary.md`
- `research/predictions.md`
- `research/empirical_strategy.md`
- `research/reading_queue.md`
- `docs/operator/returns/2026-06-12-economic-class-measurement-design-return.md`

## Sources Inspected

Verified primary sources:

- U.S. Bureau of Labor Statistics, Occupational Employment and Wage Statistics:
  https://www.bls.gov/oes/
- U.S. Bureau of Labor Statistics, Occupational Outlook Handbook, Market
  Research Analysts:
  https://www.bls.gov/ooh/business-and-financial/market-research-analysts.htm
- U.S. Bureau of Labor Statistics, Occupational Outlook Handbook, Survey
  Researchers:
  https://www.bls.gov/ooh/life-physical-and-social-science/survey-researchers.htm

## Exact Measurement Decisions

`TCE-P012` now has three minimum classification tests:

- Creator: active productive-system orchestration plus upside participation,
  not passive ownership or ordinary self-employment alone.
- Niche human provider: paid human presence, performance, care, trust, ritual,
  prestige, or embodied experience as part of the product.
- Experiencer: structured compensated human evaluation plus buyer use of the
  evaluation.

## Public Proxy Baseline

- BLS OEWS employment and wage trends for adjacent occupations such as market
  research analysts and survey researchers.
- ACS PUMS worker-class, occupation, industry, and self-employment context.
- NES/AIES-NES nonemployer receipts and counts for creator/operator proxy
  baselines.

Public proxies are not support for the claim. They are only measurement
architecture.

## Remaining Blockers

- No public dataset directly defines creators, niche human providers, or
  experiencers as economic classes.
- No public dataset directly measures paid experiential validation as a new
  labor category.
- No public dataset links preference validation to AI-produced or node-produced
  output.
- Private/platform data governance is needed for evaluator compensation, task
  difficulty, credentials, duration, review quality, buyer decision impact, and
  synthetic/telemetry substitution.

## Claim Status

- `TCE-P012`: remains `forecast_taxonomy`.
- `TCE-CLAIM-015`: remains `hypothesis`.
- `claim_support_updated=false`.

## Verification

Commands run:

```sh
git diff -- paper/draft.md
git diff --check
rg -n "TCE-P012|TCE-CLAIM-015|claim_support_updated=false|partially operationalized|economic class|creator|niche human provider|experiencer|preference validation|OEWS|market research analysts|survey researchers" research docs/operator/returns/2026-06-12-economic-class-measurement-design-return.md
rg -n "Buddh[i]sm|Tao[i]sm|Sun[y]ata|dependent[ -]originat[i]on|prophetic|lazy|unimaginative|deserving awards|Nobel|firm is dea[d]|end of the fir[m]" research/source_notes/bls_oews_ooh_preference_validation_proxies.md research/data/economic_class_measurement_design.md research/economic_class_implications.md research/data/field_dictionary.md research/predictions.md research/empirical_strategy.md research/reading_queue.md
rg -n "[ \t]+$" research/source_notes/bls_oews_ooh_preference_validation_proxies.md research/data/economic_class_measurement_design.md research/economic_class_implications.md research/data/field_dictionary.md research/predictions.md research/empirical_strategy.md research/reading_queue.md docs/operator/returns/2026-06-12-economic-class-measurement-design-return.md
```

Results:

- `paper/draft.md` remained untouched.
- `git diff --check` passed.
- Narrow scan showed the `TCE-P012` measurement design and no claim promotion.
- Guardrail scan returned no matches.
- Trailing-whitespace scan returned no matches.

## Commit

Ready to commit as a research measurement-design slice.
