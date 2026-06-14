# Operations

Production operations are part of ThesisRecord, but committed examples must stay
sanitized.

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
