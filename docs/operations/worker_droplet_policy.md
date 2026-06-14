# Worker Droplet Policy

## Decision

ThesisRecord does not need a dedicated worker droplet for its current workload.
Its Sidekiq jobs are low-frequency evidence and checkpoint jobs, and they are
safe to run on the current private web droplet while load remains light.

Product worker droplets should stay dedicated. Do not merge Source Combatives,
TempleMate, AppRelay, or other product-specific worker queues into a shared
worker host.

The one planned exception is a future SourceGrid Ops Agent droplet.

## SourceGrid Ops Agent

A future `sourcegrid-agent` or equivalent droplet may be intentionally shared
for SourceGrid internal operations jobs. It is a company control-plane worker,
not a product worker pool.

Allowed work:

- repo health checks;
- droplet health checks;
- failed service detection;
- stale deploy detection;
- backup verification checks;
- notification and warning jobs;
- low-frequency ThesisRecord evidence checks;
- AppRelay reasoning requests over structured findings.

Disallowed work:

- Source Combatives product jobs;
- customer-facing product queues;
- high-volume media or data processing;
- private raw data processing without a dedicated boundary;
- jobs whose failure blocks a product's core runtime;
- jobs whose load can threaten a public web/API droplet.

## ThesisRecord Placement

Current placement:

- Puma: `sourcecombatives-web`, private `127.0.0.1:3400`;
- Sidekiq: same host, supervised separately;
- Redis: same host, isolated DB namespace;
- job cadence: weekly, quarterly, and annual checks.

This is acceptable because ThesisRecord currently runs only a small number of
low-frequency jobs.

Move ThesisRecord Sidekiq to `sourcegrid-agent` only if all of these remain
true:

- jobs are lightweight and non-critical;
- no public user workflow depends on job latency;
- private raw data processing is not introduced;
- database connectivity is explicit and tested;
- failed ThesisRecord jobs cannot degrade other products.

Create a dedicated ThesisRecord worker droplet if any of these become true:

- ingestion becomes frequent or memory-heavy;
- jobs become latency-sensitive;
- publication/update workflows depend on background completion;
- the number of active theses materially increases;
- ThesisRecord becomes a customer-facing product runtime;
- worker failures or load can threaten shared internal ops jobs.

## Monitoring Rule

The SourceGrid Ops Agent may observe product droplets, but observation does not
mean workload sharing. Product workers remain product-owned unless an explicit
infrastructure decision says otherwise.
