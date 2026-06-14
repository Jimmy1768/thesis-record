# ThesisRecord Architecture

ThesisRecord separates the generic platform from thesis-specific evidence.

Platform code owns identities, source registries, intake manifests, evidence
snapshots, metric observations, forecast checkpoints, claim reviews, privacy
reviews, export artifacts, and audit events.

Each thesis owns its source truth, research notes, evidence manifests, source
limitations, paper scaffolding, and operator records under `theses/<slug>/`.

The initial migration keeps the Rails prototype effectively focused on Thesis 1.
A later phase should introduce a first-class `Thesis` model and attach existing
evidence rows to `operator-node-economics`.

The current architecture direction is Phase 1: publish and operate Thesis 1 as
a durable living thesis record before public productization. See
`phase_1_operator_nodes_v0.md`.
