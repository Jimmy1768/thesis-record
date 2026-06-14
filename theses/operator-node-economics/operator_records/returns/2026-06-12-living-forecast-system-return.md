---
record_id: return-2026-06-12-living-forecast-system
record_type: return
workflow_id: 2026-06-12-living-forecast-system
status: completed
created_at: 2026-06-12T15:35:00+08:00
owner: Research
---

# Return: Living Forecast System

## Scope

This Research pass added the architecture for a living forecast system: a
recurring evidence and indicator pipeline that can support V1, V2, V3, and
later updates without letting automation update claims.

It did not implement Sidekiq jobs, database schemas, API clients, dashboards,
paper prose, or claim-status changes.

`paper/draft.md` was not edited.

## Files Changed

- `research/living_forecast_system.md`
- `research/forecast_versioning_framework.md`
- `research/empirical_strategy.md`
- `research/predictions.md`
- `paper/evidence_requirements.md`
- `paper/outline.md`
- `paper/argument_map.md`
- `docs/operator/returns/2026-06-12-living-forecast-system-return.md`

## Core Architecture

The living forecast system separates:

- theory layer;
- source layer;
- data ingestion layer;
- measurement layer;
- analysis layer;
- evidence registry;
- publication layer.

Suggested recurring job families include:

- public dataset fetches;
- manifest validation;
- node-network metric ingestion;
- external case evidence ingestion;
- sector-indicator computation;
- AI-exposure indicator computation;
- forecast-dashboard refresh;
- evidence snapshot generation.

## Core Rule

Automated jobs may update:

- data;
- manifests;
- validation checks;
- indicators;
- dashboards;
- reproducible snapshots.

Automated jobs must not update:

- claim status;
- thesis status;
- paper interpretation;
- publication prose.

Claim-status changes require human review.

## Guardrails Preserved

- No `paper/draft.md` edit.
- No paper prose.
- No implementation code for jobs or databases.
- No empirical result.
- No claim support update.
- No claim that the thesis is true.
- No philosophical or religious foundation.

## Verification Commands

Run after editing:

```bash
git diff -- paper/draft.md
git diff --check
rg -n "living forecast|Automated jobs|claim status|human review|Sidekiq|snapshot|evidence registry" research/living_forecast_system.md research/forecast_versioning_framework.md research/empirical_strategy.md research/predictions.md paper/evidence_requirements.md paper/outline.md paper/argument_map.md docs/operator/returns/2026-06-12-living-forecast-system-return.md
rg -n "Buddh[i]sm|Tao[i]sm|Sun[y]ata|dependent[ -]originat[i]on|firm is dea[d]|end of the fir[m]" research/living_forecast_system.md research/forecast_versioning_framework.md research/empirical_strategy.md research/predictions.md paper/evidence_requirements.md paper/outline.md paper/argument_map.md docs/operator/returns/2026-06-12-living-forecast-system-return.md
rg -n "[ \t]+$" research/living_forecast_system.md research/forecast_versioning_framework.md research/empirical_strategy.md research/predictions.md paper/evidence_requirements.md paper/outline.md paper/argument_map.md docs/operator/returns/2026-06-12-living-forecast-system-return.md
```

Expected results:

- `git diff -- paper/draft.md`: no output.
- `git diff --check`: pass with no output.
- Living-system scan returns expected matches.
- Prohibited-foundation/polemical-claim scan: no output.
- Trailing-whitespace scan: no output.

## Next Gap

The next research gap remains AI-exposure linkage. The living forecast system
defines how recurring evidence should be collected and reviewed, but the
approved BTOS/public-use exposure schema and nonemployer AI-use source remain
unresolved.
