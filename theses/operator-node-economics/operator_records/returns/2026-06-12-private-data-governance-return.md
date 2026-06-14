# Private Data Governance Return

Date: 2026-06-12

Role: Research

Slice: private/platform data governance and schema design.

## Summary

This pass added the governance layer needed before direct private data can be
used for forecast tests. It did not ingest private data, add registry rows,
run analysis, promote claims, or edit paper prose.

The governance layer covers:

- `TCE-P011`: remote employee to node/vendor/owner-operator/contractor/
  AI-labor-service substitution;
- `TCE-P012`: creators, niche human providers, experiencers, paid evaluation,
  and human-preference validation;
- `TCE-P004`: transaction-cost metrics and comparison baselines.

## Files Changed

- `research/data/private_data_governance.md`
- `research/data/registry_population_policy.md`
- `research/data/living_forecast_registry_templates.md`
- `research/living_forecast_system.md`
- `research/data/remote_employment_measurement_design.md`
- `research/data/economic_class_measurement_design.md`
- `research/data/ai_exposure_node_feasibility_architecture.md`
- `research/data/field_dictionary.md`
- `research/empirical_strategy.md`
- `research/reading_queue.md`
- `research/open_questions.md`
- `docs/operator/returns/2026-06-12-private-data-governance-return.md`

## Governance Decisions

Private data may not be ingested until source-specific review defines:

- data owner;
- data source role;
- privacy classification;
- disclosure status;
- retention rule;
- public aggregation rule;
- identity-field removal or hashing;
- client/worker/evaluator confidentiality review;
- hidden-labor review;
- comparison baseline before outcome review;
- allowed claim status;
- human review requirement.

## Minimum Viable Schemas Defined

- HRIS / payroll role schema.
- Procurement / vendor schema.
- Node case schema.
- AI labor service schema.
- Experiencer / evaluation task schema.

These are schema designs only, not collected data.

## Registry Impact

The node-case and transaction-cost registry templates are now
governance-ready templates, but remain unpopulated.

No rows were added to:

- `data/manifests/node_case_registry_template.csv`
- `data/manifests/transaction_cost_metric_registry_template.csv`

No private storage location was selected.

## Claim Status

- `claim_support_updated=false`
- `private_data_ingested=false`
- `registry_rows_added=false`

No claim was promoted.

## Remaining Gap

The next gap is source-specific implementation:

- choose first governed source;
- choose private storage outside the repo;
- define source-role disclosure;
- define comparison baselines before outcome review;
- implement hidden-labor, confidentiality, and aggregation review workflows.

## Verification

Commands run:

```sh
git diff -- paper/draft.md
git diff --check
rg -n "private_data_governance|claim_support_updated=false|private_data_ingested=false|registry_rows_added=false|HRIS|procurement|node case|AI labor service|Experiencer|replacement_destination|buyer_decision_impact|baseline_defined_before_outcome_review|governance design available" research docs/operator/returns/2026-06-12-private-data-governance-return.md
rg -n "philosophical|religious|prophetic|lazy|unimaginative|deserving awards|Nobel|firm is dea[d]|end of the fir[m]" research/data/private_data_governance.md research/data/registry_population_policy.md research/data/living_forecast_registry_templates.md research/living_forecast_system.md research/data/remote_employment_measurement_design.md research/data/economic_class_measurement_design.md research/data/ai_exposure_node_feasibility_architecture.md research/data/field_dictionary.md research/empirical_strategy.md research/reading_queue.md research/open_questions.md
rg -n "[ \t]+$" research/data/private_data_governance.md research/data/registry_population_policy.md research/data/living_forecast_registry_templates.md research/living_forecast_system.md research/data/remote_employment_measurement_design.md research/data/economic_class_measurement_design.md research/data/ai_exposure_node_feasibility_architecture.md research/data/field_dictionary.md research/empirical_strategy.md research/reading_queue.md research/open_questions.md docs/operator/returns/2026-06-12-private-data-governance-return.md
```

Results:

- `paper/draft.md` remained untouched.
- `git diff --check` passed.
- Narrow scan showed governance fields and no claim promotion.
- Guardrail scan returned no matches.
- Trailing-whitespace scan returned no matches.

## Commit

Ready to commit as a research/data-governance slice.
