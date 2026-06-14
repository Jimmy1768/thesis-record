---
record_id: return-2026-06-12-registry-population-policy
record_type: return
workflow_id: 2026-06-12-registry-population-policy
status: completed
created_at: 2026-06-12T16:45:00+08:00
owner: Research
---

# Return: Registry Population Policy

## Scope

This Research pass figured out the safest path forward from registry templates
to living-forecast implementation.

It created a conservative policy and seeded only public exposure-source rows
from already verified source notes. It did not add node cases,
transaction-cost metric rows, private data, quantitative analysis, claim
support, paper prose, or paper conclusions.

`paper/draft.md` was not edited.

## Files Changed

- `data/manifests/exposure_source_registry.csv`
- `research/data/registry_population_policy.md`
- `research/data/living_forecast_registry_validator.py`
- `research/data/living_forecast_registry_templates.md`
- `research/data/ai_exposure_node_feasibility_architecture.md`
- `research/living_forecast_system.md`
- `research/reading_queue.md`
- `docs/operator/returns/2026-06-12-registry-population-policy-return.md`

## Path Forward Chosen

The best path is staged registry population:

1. Seed verified public exposure-source candidates.
2. Keep node cases blocked until privacy, disclosure, hidden-labor, and
   field-collection rules are accepted.
3. Keep transaction-cost metrics blocked until comparison baselines and metric
   definitions are fixed before observing outcomes.
4. Implement recurring jobs only after registry rows and review gates exist.

## Sources Reused

- Census BTOS "AI Use at U.S. Businesses" source note.
- Bonney et al. 2026 source note.
- Bick, Blandin, and Deming source note.

No new source-truth claims were created.

## Registry Rows Added

`data/manifests/exposure_source_registry.csv`:

- `EXP-001`: Census BTOS employer-business AI adoption context.
- `EXP-002`: Bonney et al. employer-firm AI diffusion context.
- `EXP-003`: Bick, Blandin, and Deming worker-level GenAI adoption context.

All three rows are `accepted_for_baseline` with
`claim_status_allowed=forecast_baseline`.

They do not show nonemployer AI use, node use, firm-boundary change, or
transaction-cost change.

## Gaps Remaining

- Company/node privacy and disclosure policy.
- Hidden-labor and subcontractor evidence requirements for node cases.
- Transaction-cost comparison baselines.
- Direct/proxy metric definitions for procurement, contracting, monitoring,
  dispute, rework, payment delay, repeat purchase, and retention.
- Decision on whether public exposure monitoring should start before private
  node and transaction-cost data collection is ready.

## Verification Commands

Run after editing:

```bash
python3 research/data/living_forecast_registry_validator.py
git diff -- paper/draft.md
git diff --check
rg -n "EXP-001|EXP-002|EXP-003|forecast_baseline|claim_support_updated=false|populated_registries_validated=1" data/manifests/exposure_source_registry.csv research/data/living_forecast_registry_validator.py research/data/registry_population_policy.md research/data/living_forecast_registry_templates.md research/data/ai_exposure_node_feasibility_architecture.md research/living_forecast_system.md research/reading_queue.md docs/operator/returns/2026-06-12-registry-population-policy-return.md
rg -n "philosophical|religious|firm is dea[d]|end of the fir[m]" data/manifests/exposure_source_registry.csv research/data/living_forecast_registry_validator.py research/data/registry_population_policy.md research/data/living_forecast_registry_templates.md research/data/ai_exposure_node_feasibility_architecture.md research/living_forecast_system.md research/reading_queue.md docs/operator/returns/2026-06-12-registry-population-policy-return.md
rg -n "[ \t]+$" data/manifests/exposure_source_registry.csv research/data/living_forecast_registry_validator.py research/data/registry_population_policy.md research/data/living_forecast_registry_templates.md research/data/ai_exposure_node_feasibility_architecture.md research/living_forecast_system.md research/reading_queue.md docs/operator/returns/2026-06-12-registry-population-policy-return.md
```

Expected results:

- Registry validator reports three templates and one populated registry.
- `data_ingested=false`.
- `claim_support_updated=false`.
- `git diff -- paper/draft.md`: no output.
- `git diff --check`: pass with no output.
- Registry scan returns expected matches.
- Prohibited-foundation/polemical-claim scan: no output.
- Trailing-whitespace scan: no output.
