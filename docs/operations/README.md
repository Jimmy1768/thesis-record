# Operations

Production operations are part of ThesisRecord, but committed examples must stay
sanitized.

The first deployment target is a private droplet runtime, documented in
`production_deployment_runbook.md`. Nginx is not required until a public web
surface is approved.

Operator Nodes v0 operating checks are documented in
`operator_nodes_v0_operating_runbook.md`.

Worker placement policy is documented in `worker_droplet_policy.md`. Product
worker droplets stay dedicated; the only planned shared worker is a future
SourceGrid Ops Agent for internal operations jobs.

Allowed:

- `.env.production.example`
- systemd example units
- nginx or Caddy example config
- documented environment variable names without secret values

Excluded:

- real `.env` files
- credentials keys
- logs and tmp files
- database dumps
- private raw data
- machine-specific paths
