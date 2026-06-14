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
- `data/` - platform-level templates or shared non-thesis fixtures only.

Thesis-specific public source manifests live under the relevant thesis slug, not
under root `data/`.
