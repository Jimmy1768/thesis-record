---
record_id: return-2026-06-12-ai-exposure-node-feasibility-architecture
record_type: return
workflow_id: 2026-06-12-ai-exposure-node-feasibility-architecture
status: completed
created_at: 2026-06-12T15:55:00+08:00
owner: Research
---

# Return: AI Exposure And Node Feasibility Architecture

## Scope

This Research pass defined the data architecture for solving the AI-exposure
linkage gap through three separate tracks:

- public exposure proxy;
- node feasibility;
- transaction-cost evidence.

It did not ingest new data, implement jobs, run analysis, update claim support,
or write paper prose.

`paper/draft.md` was not edited.

## Files Changed

- `research/data/ai_exposure_node_feasibility_architecture.md`
- `research/data/field_dictionary.md`
- `research/living_forecast_system.md`
- `research/empirical_strategy.md`
- `research/predictions.md`
- `research/open_questions.md`
- `research/reading_queue.md`
- `paper/evidence_requirements.md`
- `paper/outline.md`
- `paper/argument_map.md`
- `docs/operator/returns/2026-06-12-ai-exposure-node-feasibility-architecture-return.md`

## Core Decision

The exposure problem should not be solved by forcing a single weak proxy.

Use three separate tracks:

- Public exposure proxies identify where to look.
- Node feasibility data tests whether a node-like unit can work.
- Transaction-cost data tests the Coasean/TCE mechanism.

## Field Architecture Added

The field dictionary now includes concept fields for:

- public AI exposure proxy data;
- node feasibility and classification;
- transaction-cost measures.

These are concept fields only. They are not verified public-use fields and do
not authorize claim support.

## Remaining Gaps

- No exposure-source registry exists yet.
- No node-case registry schema exists yet.
- No transaction-cost metric schema exists yet.
- BTOS public-use schema and variable names remain unresolved.
- No verified nonemployer AI-use source exists.

## Guardrails Preserved

- No `paper/draft.md` edit.
- No paper prose.
- No new data ingestion.
- No analysis.
- No claim support update.
- No claim that the thesis is true.
- No philosophical or religious foundation.

## Verification Commands

Run after editing:

```bash
git diff -- paper/draft.md
git diff --check
rg -n "public exposure proxy|Node Feasibility|Transaction-Cost|exposure_tier|node_status|claim support|human review" research/data/ai_exposure_node_feasibility_architecture.md research/data/field_dictionary.md research/living_forecast_system.md research/empirical_strategy.md research/predictions.md research/open_questions.md research/reading_queue.md paper/evidence_requirements.md paper/outline.md paper/argument_map.md docs/operator/returns/2026-06-12-ai-exposure-node-feasibility-architecture-return.md
rg -n "philosophical|religious|firm is dea[d]|end of the fir[m]" research/data/ai_exposure_node_feasibility_architecture.md research/data/field_dictionary.md research/living_forecast_system.md research/empirical_strategy.md research/predictions.md research/open_questions.md research/reading_queue.md paper/evidence_requirements.md paper/outline.md paper/argument_map.md docs/operator/returns/2026-06-12-ai-exposure-node-feasibility-architecture-return.md
rg -n "[ \t]+$" research/data/ai_exposure_node_feasibility_architecture.md research/data/field_dictionary.md research/living_forecast_system.md research/empirical_strategy.md research/predictions.md research/open_questions.md research/reading_queue.md paper/evidence_requirements.md paper/outline.md paper/argument_map.md docs/operator/returns/2026-06-12-ai-exposure-node-feasibility-architecture-return.md
```

Expected results:

- `git diff -- paper/draft.md`: no output.
- `git diff --check`: pass with no output.
- Architecture scan returns expected matches.
- Prohibited-foundation/polemical-claim scan: no output.
- Trailing-whitespace scan: no output.

## Next Slice

The next Research slice should create the first registry templates:

- exposure-source registry;
- node-case registry;
- transaction-cost metric registry.

No ingestion jobs should be implemented until those registries and review
statuses are defined.
