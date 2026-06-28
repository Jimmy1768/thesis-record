# ThesisRecord

ThesisRecord is a SourceGrid Labs platform for versioned thesis projects with
evidence records, source verification, forecast checkpoints, audit trails, and
publication/update workflows.

The first migrated thesis is:

- Title: Operator Nodes
- Subtitle: AI, Transaction Costs, and the Future of the Firm
- Category: Economics / Organizational Theory
- Slug: `operator-node-economics`

## Structure

- `thesis_record_app/` - Rails application, initially migrated from the living
  dissertation prototype with naming cleanup only.
- `theses/operator-node-economics/` - Thesis 1 research, evidence records,
  source truth, paper scaffolding, and operator records.
- `docs/` - platform-level architecture, operations, source verification, audit,
  and thread-role guidance.
- `templates/` - reusable thesis scaffolding and process templates.
- `data/` - shared non-thesis fixtures only.

Thesis-specific public source manifests live under the relevant thesis slug, not
under root `data/`.

## Current Direction

The immediate goal is Phase 1: publish and operate Thesis 1, not launch a
public product. Operator Nodes should reach a v0 thesis record, frozen forecast
timeline, and scheduled evidence collection/checkpoint loop before
multi-workspace or third-party product work begins.

See `docs/architecture/phase_1_operator_nodes_v0.md`.
