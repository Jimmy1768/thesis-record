---
record_id: return-2026-06-12-remote-employment-falsifier
record_type: return
workflow_id: 2026-06-12-remote-employment-falsifier
status: completed
created_at: 2026-06-12T17:20:00+08:00
owner: Research
---

# Return: Remote Employment Falsifier Update

## Scope

This Research pass corrected the architecture around remote work.

Remote work is no longer treated as a generic risk factor or competing
explanation. The docs now distinguish:

- office-to-remote work as location unbundling;
- remote salaried employment as still inside the firm boundary;
- persistence or growth of remote salaried employment in AI-exposed,
  output-measurable roles as a falsifier for the strong employment-unbundling
  thesis.

This pass did not add empirical support, run analysis, edit `paper/draft.md`,
or write paper prose.

## Files Changed

- `docs/source_truth/core_hypothesis.md`
- `docs/source_truth/falsifiability_contract.md`
- `research/forecast_versioning_framework.md`
- `research/predictions.md`
- `research/empirical_strategy.md`
- `research/criticisms.md`
- `research/claims_index.md`
- `research/open_questions.md`
- `research/data/field_dictionary.md`
- `paper/evidence_requirements.md`
- `paper/outline.md`
- `paper/argument_map.md`
- `docs/operator/returns/2026-06-12-remote-employment-falsifier-return.md`

## Correction Made

Added TCE-P011:

- remote employment is a transitional form;
- in AI-exposed, output-measurable digital roles, remote salaried employee
  share should decline if firms substitute node, vendor, owner-operator, or AI
  labor-service capacity;
- durable or growing remote salaried employment in those roles is a falsifier
  for the strong thesis.

Added TCE-CLAIM-014 as a hypothesis in the claims index with no current
empirical support.

## Guardrails

- No claim that the thesis is true.
- No claim that remote employment has already declined.
- No source support added.
- No paper prose written.
- Human residual categories such as novelty, performance, care, trust, and
  legal authority are treated as expected boundary cases, not automatic
  disconfirmation.

## Verification Commands

Run after editing:

```bash
git diff -- paper/draft.md
git diff --check
rg -n "TCE-P011|TCE-CLAIM-014|remote employment|remote salaried|location unbundling|employment-unbundling|falsifier" docs/source_truth/core_hypothesis.md docs/source_truth/falsifiability_contract.md research/forecast_versioning_framework.md research/predictions.md research/empirical_strategy.md research/criticisms.md research/claims_index.md research/open_questions.md research/data/field_dictionary.md paper/evidence_requirements.md paper/outline.md paper/argument_map.md docs/operator/returns/2026-06-12-remote-employment-falsifier-return.md
rg -n "remote work, post-pandemic|digitization, remote work|is a risk factor" research paper docs/source_truth
rg -n "Buddh[i]sm|Tao[i]sm|Sun[y]ata|dependent[ -]originat[i]on|firm is dea[d]|end of the fir[m]" docs/source_truth/core_hypothesis.md docs/source_truth/falsifiability_contract.md research/forecast_versioning_framework.md research/predictions.md research/empirical_strategy.md research/criticisms.md research/claims_index.md research/open_questions.md research/data/field_dictionary.md paper/evidence_requirements.md paper/outline.md paper/argument_map.md docs/operator/returns/2026-06-12-remote-employment-falsifier-return.md
rg -n "[ \t]+$" docs/source_truth/core_hypothesis.md docs/source_truth/falsifiability_contract.md research/forecast_versioning_framework.md research/predictions.md research/empirical_strategy.md research/criticisms.md research/claims_index.md research/open_questions.md research/data/field_dictionary.md paper/evidence_requirements.md paper/outline.md paper/argument_map.md docs/operator/returns/2026-06-12-remote-employment-falsifier-return.md
```

Expected results:

- `paper/draft.md`: no output.
- `git diff --check`: pass with no output.
- Remote-employment scan returns expected matches.
- Old-risk-language scan returns no output.
- Prohibited-foundation/polemical-claim scan: no output.
- Trailing-whitespace scan: no output.
