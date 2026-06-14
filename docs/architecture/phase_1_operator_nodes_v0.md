# Phase 1: Operator Nodes V0

## Direction

ThesisRecord's immediate objective is not to become a public-facing product.
Phase 1 is to make Thesis 1, Operator Nodes, a durable living thesis record.

The target is:

1. publish an initial v0 thesis record;
2. freeze the v0 thesis state;
3. establish the forecast timeline;
4. start controlled evidence collection and assimilation;
5. let scheduled jobs accumulate records toward 3, 5, and 10 year checkpoints;
6. defer public product/workspace features until after Thesis 1 has a stable
   operating loop.

## V0 Publication Target

The v0 publication should define:

- the public title, subtitle, category, and slug;
- the frozen v0 thesis claims and predictions;
- the source-truth rules that govern evidence interpretation;
- the evidence already available at publication time;
- known limitations and falsifiers;
- the checkpoint clock start date.

The v0 thesis does not need to prove Operator Nodes are real or inevitable. It
must state the thesis, evidence standard, forecast commitments, and review
boundaries clearly enough that future updates can be compared against it.

## Forecast Timeline

The current policy source of truth defines forecast measurement by calendar
quarter:

- first measurement period: first full calendar quarter after v0 publication;
- 3-year checkpoint: 12 quarters after v0 publication;
- 5-year checkpoint: 20 quarters after v0 publication;
- 10-year checkpoint: 40 quarters after v0 publication;
- annual snapshot candidates every 4 quarters.

The exact calendar dates should be derived from the v0 publication date and
recorded before v0 is published.

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
