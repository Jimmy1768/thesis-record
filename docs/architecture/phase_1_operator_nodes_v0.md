# Phase 1: Operator Nodes V0

## Direction

ThesisRecord's immediate objective is not to become a public-facing product.
Phase 1 is to make Thesis 1, Operator Nodes, a durable living thesis record.

The target is:

1. establish an internal v0 baseline record;
2. freeze the v0 thesis state;
3. establish the forecast timeline;
4. start controlled evidence collection and assimilation;
5. let scheduled jobs accumulate records toward v1, v2, and v3 checkpoints;
6. defer public product/workspace features until after Thesis 1 has a stable
   operating loop.

## V0 Publication Target

The v0 record should define:

- the public title, subtitle, category, and slug;
- the frozen v0 thesis claims and predictions;
- the candidate indicator universe and indirect proxy boundaries;
- the source-truth rules that govern evidence interpretation;
- the evidence already available at publication time;
- known limitations and falsifiers;
- the checkpoint clock start date.

V0 is an internal baseline and precommitment, not a public checkpoint. It does
not need to prove Operator Nodes are real or inevitable. It must state the
thesis, evidence standard, forecast commitments, indicator universe, and review
boundaries clearly enough that future updates can be compared against it.

The scheduled public checkpoint ladder is:

- v1: 3-year checkpoint, expected to be noisy and potentially weakened by an AI
  bubble cycle or delayed adoption;
- v2: 5-year signal-strength checkpoint, where the thesis should be narrowed,
  weakened, or treated as wrong if directional evidence fails;
- v3: 10-year confirmation checkpoint, suitable for peer-review submission only
  if the forecast record survives earlier checkpoints.

## Forecast Timeline

The current policy source of truth defines forecast measurement by calendar
quarter:

- first measurement period: first full calendar quarter after v0 publication;
- v1 3-year checkpoint: 12 quarters after v0 publication;
- v2 5-year checkpoint: 20 quarters after v0 publication;
- v3 10-year checkpoint: 40 quarters after v0 publication;
- annual snapshot candidates every 4 quarters.

The exact calendar dates should be derived from the v0 publication date and
recorded before v0 is published.

Current operating assumption: ThesisRecord sets internal canonical v0 on
2026-06-15 UTC. This makes 2026-Q3 the first full measurement quarter and yields
v1, v2, and v3 checkpoint targets in 2029-Q2, 2031-Q2, and 2036-Q2.
Public prose can lag this internal v0 record; claim, forecast, and prose
approval remain separate gates.

## Evidence Automation

The Rails app already has Sidekiq scheduler scaffolds for:

- weekly source-release checks;
- quarterly indicator checkpoints;
- annual snapshot candidates.

Phase 1 should turn those scaffolds into controlled collection and assimilation
jobs. These jobs should collect records, summarize source health, and prepare
checkpoint candidates. They must not automatically promote claims, change thesis
verdicts, publish prose, or infer that the thesis is true.

Human approval remains required for:

- claim support changes;
- publication/update decisions;
- thesis verdicts;
- evidence interpretation beyond source-native context;
- prose changes.

## Product Boundary

Phase 2 may turn ThesisRecord into a public SourceGrid product for teams,
workspaces, reviewers, and third-party thesis projects.

Phase 1 should avoid premature multi-workspace, SaaS, billing, public UI, and
generic third-party workflow work unless it directly supports publishing and
operating Thesis 1.

## Next Engineering Gate

Before v0 publication, run the operator readiness check:

```bash
bin/rails operator:v0_readiness
```

It reports:

- v0 publication artifact path;
- draft/prose status;
- frozen prediction/checkpoint status;
- forecast timeline dates;
- evidence table counts;
- Sidekiq schedule status;
- canonical data-promotion status;
- blockers that prevent v0 publication.

The current pre-v0 scaffolds are:

- `theses/operator-node-economics/publication/v0.md`;
- `theses/operator-node-economics/publication/v0_timeline.yml`;
- `theses/operator-node-economics/publication/v0_claim_set.yml`;
- `theses/operator-node-economics/publication/v0_forecast_set.yml`;
- `theses/operator-node-economics/publication/v0_frozen_claim_set_review.yml`;
- `theses/operator-node-economics/publication/v0_frozen_forecast_set_review.yml`;
- `theses/operator-node-economics/publication/v0_indicator_universe.yml`;
- `theses/operator-node-economics/publication/v0_source_truth_review.yml`;
- `theses/operator-node-economics/publication/v0_prohibited_foundations_review.yml`;
- `theses/operator-node-economics/publication/v0_prose_review.yml`;
- `theses/operator-node-economics/publication/v0_public_release_review.yml`;
- `theses/operator-node-economics/publication/v0_collection_plan.yml`;
- `theses/operator-node-economics/publication/v0_approval_packet.yml`;
- `theses/operator-node-economics/evidence/assimilation_plan.md`;
- `docs/operations/operator_nodes_v0_operating_runbook.md`.

These scaffolds are intentionally unapproved. They let ThesisRecord rehearse
the operating loop while leaving publication date, prose, frozen claims, and
frozen forecasts as explicit human decision gaps.
