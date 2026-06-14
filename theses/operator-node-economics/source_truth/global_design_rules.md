# Global Design Rules

Status: source-truth design rule. Not evidence, conclusion, paper prose, or
implementation approval for data ingestion.

Run date: 2026-06-12.

## Single Source Of Truth Rule

Adjustable thresholds, cadence values, and operating defaults must have one
canonical source before they are used in app code, research workflow, or
evidence-review logic.

Current canonical machine-readable file:

- `living_dissertation_app/config/living_dissertation_policy.yml`

Docs may explain the purpose of a value, but they should not become the source
that must be edited when a value changes. If a document needs the current value,
it should reference the canonical policy file rather than duplicating the
number unless the document is a historical return record.

## V1 Threshold Defaults

The V1 values in the canonical policy file are starting defaults for
measurement and operations. They are not evidence that the thesis is true.

The policy file currently covers:

- forecast-clock cadence and scheduled checkpoint rules;
- Sidekiq scheduler cadence;
- production operations defaults;
- private/public export thresholds;
- Operator Node classification defaults.

## Change Rule

Changing a threshold or cadence value requires:

- editing the canonical policy file;
- updating any app tests that assert the policy is wired correctly;
- updating docs only where they describe the meaning of the policy;
- recording the change in an operator return;
- not retroactively changing historical snapshots.

Forecast or evidence thresholds must not be moved after seeing favorable or
adverse data unless the revision is explicitly documented as a revision.

## Guardrail

Centralizing thresholds is an anti-drift rule, not a shortcut around evidence
review. It does not authorize:

- private data ingestion;
- claim-status promotion;
- paper prose;
- thesis conclusions;
- publication/export;
- secret storage in Git.
