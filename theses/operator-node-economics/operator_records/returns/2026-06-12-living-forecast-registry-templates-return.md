---
record_id: return-2026-06-12-living-forecast-registry-templates
record_type: return
workflow_id: 2026-06-12-living-forecast-registry-templates
status: completed
created_at: 2026-06-12T16:15:00+08:00
owner: Research
---

# Return: Living Forecast Registry Templates

## Scope

This Research pass created the first registry templates for the living forecast
system:

- exposure-source registry;
- node-case registry;
- transaction-cost metric registry.

It also added a validator for template headers and allowed status values.

It did not populate registries, ingest data, implement jobs, run analysis,
update claim support, or write paper prose.

`paper/draft.md` was not edited.

## Files Changed

- `data/manifests/exposure_source_registry_template.csv`
- `data/manifests/node_case_registry_template.csv`
- `data/manifests/transaction_cost_metric_registry_template.csv`
- `research/data/living_forecast_registry_validator.py`
- `research/data/living_forecast_registry_templates.md`
- `research/data/ai_exposure_node_feasibility_architecture.md`
- `research/living_forecast_system.md`
- `research/reading_queue.md`
- `docs/operator/returns/2026-06-12-living-forecast-registry-templates-return.md`

## Command Result

```bash
python3 research/data/living_forecast_registry_validator.py
```

Output:

```text
registry_templates_validated=3
exposure_source_registry_template.csv_rows=0
node_case_registry_template.csv_rows=0
transaction_cost_metric_registry_template.csv_rows=0
data_ingested=false
claim_support_updated=false
```

## Guardrails Preserved

- Header-only templates.
- No data ingestion.
- No analysis.
- No claim support update.
- No paper prose.
- No `paper/draft.md` edit.
- No implementation jobs.

## Gap Reached

Registry templates now exist, but population requires decisions that are not
just implementation:

- accepted exposure-source candidates;
- company/node privacy and disclosure rules;
- transaction-cost comparison baselines and field definitions.

Recurring ingestion jobs should remain blocked until these registry rows and
review rules are defined.

## Verification Commands

Run after editing:

```bash
python3 research/data/living_forecast_registry_validator.py
git diff -- paper/draft.md
git diff --check
rg -n "registry_templates_validated=3|data_ingested=false|claim_support_updated=false|exposure-source registry|node-case registry|transaction-cost metric" data/manifests/exposure_source_registry_template.csv data/manifests/node_case_registry_template.csv data/manifests/transaction_cost_metric_registry_template.csv research/data/living_forecast_registry_validator.py research/data/living_forecast_registry_templates.md research/data/ai_exposure_node_feasibility_architecture.md research/living_forecast_system.md research/reading_queue.md docs/operator/returns/2026-06-12-living-forecast-registry-templates-return.md
rg -n "Buddh[i]sm|Tao[i]sm|Sun[y]ata|dependent[ -]originat[i]on|firm is dea[d]|end of the fir[m]" research/data/living_forecast_registry_validator.py research/data/living_forecast_registry_templates.md research/data/ai_exposure_node_feasibility_architecture.md research/living_forecast_system.md research/reading_queue.md docs/operator/returns/2026-06-12-living-forecast-registry-templates-return.md
rg -n "[ \t]+$" data/manifests/exposure_source_registry_template.csv data/manifests/node_case_registry_template.csv data/manifests/transaction_cost_metric_registry_template.csv research/data/living_forecast_registry_validator.py research/data/living_forecast_registry_templates.md research/data/ai_exposure_node_feasibility_architecture.md research/living_forecast_system.md research/reading_queue.md docs/operator/returns/2026-06-12-living-forecast-registry-templates-return.md
```

Expected results:

- Registry validator reports `registry_templates_validated=3`,
  `data_ingested=false`, and `claim_support_updated=false`.
- `git diff -- paper/draft.md`: no output.
- `git diff --check`: pass with no output.
- Registry scan returns expected matches.
- Prohibited-foundation/polemical-claim scan: no output.
- Trailing-whitespace scan: no output.
