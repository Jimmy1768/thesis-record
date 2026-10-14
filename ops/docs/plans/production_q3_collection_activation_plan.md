# Production Q3 2026 Collection Activation Record

Status: the prior proposed activation plan is rejected and superseded on
2026-10-14 by explicit authorization for the minimal production deployment and
Q3 collection.

## Authorized approach

- Deploy the tested quarterly collector and its existing schema.
- Preserve the existing Day 0 baseline; register and verify it as part of the
  production run.
- Collect `2026-Q3`, save the resulting collection, and verify the saved
  records.
- Rely on the existing droplet backups for recovery.

No repeated full rehearsal, new operator-command framework, new scheduler, or
new provider/control-plane work is required for this activation. The collector
remains blocked in production by default and runs only when
`THESIS_RECORD_ALLOW_QUARTERLY_COLLECTION=true` is explicitly supplied to the
collection process.
