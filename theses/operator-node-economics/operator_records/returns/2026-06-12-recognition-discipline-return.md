# Recognition Discipline Return

Date: 2026-06-12

Role: Research

Slice: add governance policy for recognition and awards.

## Summary

This pass added a small governance-policy update: recognition, awards, and
historical importance are possible trailing outcomes, not research objectives.

The rule is scoped to research conduct. It does not add policy economics,
paper prose, thesis evidence, or conclusions.

## Files Changed

- `docs/source_truth/research_contract.md`
- `docs/source_truth/falsifiability_contract.md`
- `research/forecast_versioning_framework.md`
- `docs/operator/returns/2026-06-12-recognition-discipline-return.md`

## Policy Added

Label: `Recognition Discipline`

Core rule:

- optimize for truth value, falsifiability, explanatory power, public
  usefulness, measurement, criticism, and honest updates;
- do not optimize for awards, prestige, historical placement, or public
  reputation;
- treat recognition as a possible trailing indicator only.

## Guardrails

- Do not frame the work as deserving awards.
- Do not let prestige soften falsification.
- Do not use historical-importance framing as evidence.
- Do not hide or downplay adverse evidence to protect reputation.

## Verification

Commands run:

```sh
git diff -- paper/draft.md
git diff --check
rg -n "Recognition Discipline|trailing indicator|truth value|falsifiability|awards|prestige|historical importance" docs/source_truth/research_contract.md docs/source_truth/falsifiability_contract.md research/forecast_versioning_framework.md docs/operator/returns/2026-06-12-recognition-discipline-return.md
rg -n "deserving awards|Nobel|prize-worthy|historical status|grandiose|manifesto|firm is dea[d]|end of the fir[m]" docs/source_truth/research_contract.md docs/source_truth/falsifiability_contract.md research/forecast_versioning_framework.md docs/operator/returns/2026-06-12-recognition-discipline-return.md
rg -n "[ \t]+$" docs/source_truth/research_contract.md docs/source_truth/falsifiability_contract.md research/forecast_versioning_framework.md docs/operator/returns/2026-06-12-recognition-discipline-return.md
```

Results:

- `paper/draft.md` remained untouched.
- `git diff --check` passed.
- Recognition-discipline scan showed the new governance language.
- Overclaim scan returned only expected guardrail text in the return and
  research contract.
- Trailing-whitespace scan returned no matches.

## Commit

Ready to commit as a governance-policy update.
