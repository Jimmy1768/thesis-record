# Forecast Versioning Framework

Status: research-method framework. Not evidence, results, conclusion, or paper
prose.

Run date: 2026-06-12.

Purpose: define Operator Node Economics as a versioned forecast research
program. V1 should publish the thesis, mechanisms, predictions, evidence
requirements, and failure conditions before the answer is known. Later versions
should update the record whether the thesis is supported, narrowed,
contradicted, or rejected.

## Core Reframe

The central thesis is a forward prediction about a possible organizational
form. Current evidence is not expected to prove the full thesis at V1.

V1 should not claim that Operator Nodes already exist at scale or that the
corporation is declining. V1 should state the forecast clearly enough that V2
and V3 can test it.

Class-structure implications should also be framed as forecast taxonomy, not
as conclusion. If the thesis predicts a shift toward creators, niche human
providers, and experiencers, those categories must be defined as measurable
roles with failure conditions before they enter prose.

The research program should publish honest updates even when evidence moves
against the thesis. A wrong forecast is useful if it was explicit, falsifiable,
and updated without concealment.

Recognition should be treated as a trailing indicator, not a target. The
program should not optimize for awards, prestige, historical placement, or
public reputation. It should optimize for clarity, falsifiability,
measurement, criticism, and honest updates.

## Entity Separation

Separate three levels:

| Level | Role | Evidence Standard |
| --- | --- | --- |
| Operator Node thesis | Broad forecast about AI-enabled production and coordination units. | Mechanisms, predictions, leading indicators, falsifiers, and longitudinal evidence. |
| User's company | One implementation attempt: enabling entities to create nodes and managing a node network. | Case-study or feasibility evidence only, not sole proof of the broad thesis. |
| Any successful case | External or internal evidence that a node-like form works in some sector. | Can support feasibility or diffusion depending on scale, durability, and independence from hidden labor. |

The company can be a useful laboratory, but the thesis should not depend on
that specific network succeeding. A different company, protocol network,
platform, or institutional form could provide stronger evidence.

## Forecast Clock

Current V1 cadence values are controlled by the canonical policy file:

- `living_dissertation_app/config/living_dissertation_policy.yml`

Research prose may describe the clock, but adjustable quarter counts and
scheduler cadence should be changed in that policy file first.

The forecast clock should use quarters as the smallest measurement atom and
multi-year checkpoints as the thesis-verdict unit.

Reason:

- AI tooling can change faster than quarterly.
- Business budgets, headcount reviews, vendor substitution, and procurement
  decisions often move on quarterly or annual cycles.
- Public firm-boundary datasets often arrive annually and with reporting lag.
- Business-cycle noise can dominate any single quarter.

Default clock, as currently represented in policy:

- `T0`: V1 publication date and frozen forecast baseline.
- `T0 + 4 quarters`: annual evidence snapshot 1.
- `T0 + 8 quarters`: annual evidence snapshot 2.
- `T0 + 12 quarters`: V2, the 3-year early structural-signal checkpoint.
- `T0 + 16 quarters`: annual evidence snapshot 4.
- `T0 + 20 quarters`: V3, the 5-year intermediate thesis checkpoint.
- `T0 + 40 quarters`: V4, the 10-year major structural-verdict checkpoint.

Quarterly updates are measurement updates, not thesis verdicts. Annual
snapshots may report whether indicators are directionally consistent, mixed,
adverse, or inconclusive. V2/V3/V4 are the scheduled thesis checkpoints.

If V1 is published other than on a quarter end, the forecast clock should use
the first full calendar quarter after publication as the first measurement
quarter while preserving the V1 publication date as `T0`.

## Version Structure

### V1: Forecast Baseline

Purpose:

- Define the thesis.
- Define the Operator Node category.
- State mechanisms and boundary conditions.
- Publish predictions across 3-, 5-, and 10-year horizons.
- Publish evidence requirements and failure conditions.
- Record the current evidence base and gaps.

Allowed claim status:

- Forecast.
- Hypothesis.
- Measurement baseline.
- Feasibility criteria.

Not allowed:

- Claiming the thesis is proven.
- Claiming current Census baselines show AI-caused boundary shifts.
- Treating the user's company as proof of the broad thesis.

### V2: First Evidence Check

Trigger:

- 12 full quarters after V1, with data-release lags documented in the snapshot.

Purpose:

- Compare observed evidence against V1 predictions.
- Publish supportive, mixed, null, or adverse results.
- Identify whether errors were measurement errors, timing errors, sector-scope
  errors, mechanism errors, or core-theory errors.

Allowed outcomes:

- Strengthen.
- Narrow.
- Revise.
- Defer.
- Contradict.
- Reject.

### V3: Revision, Narrowing, Or Rejection

Trigger:

- 20 full quarters after V1, with data-release lags documented in the snapshot.

Purpose:

- Decide whether the thesis is becoming stronger, sector-limited, transformed
  into a different thesis, or wrong.
- Publish the decision and the evidence behind it.

Possible outcomes:

- Broader thesis supported.
- Thesis narrowed to specific sectors or transaction types.
- Company/network implementation failed but broader thesis remains viable.
- Broader thesis contradicted and should be scrapped or replaced.

### V4: Major Structural Verdict

Trigger:

- 40 full quarters after V1, with business-cycle conditions, data-release lags,
  and major measurement changes documented.

Purpose:

- Test whether the thesis has produced macro-relevant or sector-structural
  evidence rather than only feasibility cases, isolated pilots, or
  task-productivity evidence.
- Decide whether the original thesis is supported, narrowed, replaced, or
  rejected.

Possible outcomes:

- Broad structural support.
- Sector-limited support.
- Feasibility without diffusion.
- Timing error with surviving leading indicators.
- Corporate-absorption alternative stronger than the thesis.
- Core-theory rejection.

## Verdict Categories

Every annual snapshot and checkpoint should use predeclared categories.

| Category | Meaning | Guardrail |
| --- | --- | --- |
| `directionally_consistent` | Indicators move in the predicted direction but are insufficient for claim support. | Do not call this proof. |
| `mixed` | Some indicators support the forecast while others support alternatives or remain unresolved. | Preserve conflicting evidence. |
| `adverse` | Indicators move against a prediction or toward a falsifier. | Do not reclassify after seeing the result. |
| `inconclusive` | Data are missing, too lagged, too noisy, or not comparable. | Do not treat absence of evidence as support. |
| `checkpoint_supported` | At a scheduled checkpoint, predeclared evidence thresholds are met. | Requires human review and source-status checks. |
| `checkpoint_weakened` | At a scheduled checkpoint, evidence is partial, delayed, or narrower than predicted. | Specify timing, scope, mechanism, or measurement error. |
| `checkpoint_contradicted` | At a scheduled checkpoint, falsifiers or alternatives are stronger. | Publish the adverse result. |

## Business-Cycle Control Rule

The program should not treat recessions, booms, inflation shocks, credit
conditions, or sector demand shocks as automatic evidence for or against the
thesis.

Each scheduled checkpoint should record:

- current macro regime;
- sector demand shocks;
- labor-market tightness;
- interest-rate and financing conditions;
- post-pandemic or regulatory shocks;
- whether observed headcount, outsourcing, formation, or survival changes are
  plausibly explained by non-AI forces.

Claims should strengthen only when evidence survives these alternative
explanations or when the limitation is explicitly recorded.

## Publication Rule

Publish all scheduled versions whether the evidence is favorable or adverse.

Do not hide negative results, null results, or failed predictions. If the
thesis is wrong, publish why it was wrong and what the data showed.

Failure-output policy is defined in:

- `research/data/failure_as_first_class_output_policy.md`

## Living Forecast System

The versioned forecast should be supported by a living evidence system rather
than one-time manual data pulls.

System architecture is defined in `research/living_forecast_system.md`.
Adjustable operating defaults and thresholds are defined in
`living_dissertation_app/config/living_dissertation_policy.yml`.

Core boundary:

- automated jobs may update data, manifests, validation checks, and indicators;
- automated jobs must not update claim status, thesis status, or paper
  interpretation without human review.
- evidence must pass the locked gate sequence in
  `research/living_forecast_system.md`: collect, verify, validate, compute,
  classify, review, publish.

Each V2/V3 publication should freeze a reproducible snapshot of code, manifests,
ignored-output hashes, source statuses, prediction tables, criticism tables,
and claim-review records.

## Error Taxonomy

When evidence diverges from V1, classify the error:

| Error Type | Meaning | Response |
| --- | --- | --- |
| Timing error | Direction may be right, but horizon was too short. | Extend only if leading indicators remain credible and falsifiers are not triggered. |
| Scope error | Thesis works in narrower sectors than expected. | Narrow sector claims and update predictions. |
| Mechanism error | AI changes productivity but not the predicted transaction or governance costs. | Revise mechanism; do not preserve original claim. |
| Measurement error | Proxy failed to observe the intended phenomenon. | Improve data design, but do not treat missing proof as support. |
| Implementation error | One company or network failed for execution reasons. | Separate case failure from thesis failure. |
| Alternative-dominance error | Corporate absorption, regulation, capital, trust, compliance, or other alternatives explain evidence better than the Operator Node mechanism. | Weaken, contradict, narrow, or reject affected prediction. |
| Core-theory error | Firms absorb the gains or transaction costs remain too high. | Reject or replace the thesis. |

## Forecast Horizons

V1 should distinguish:

- 3-year signals: early feasibility, case evidence, adoption context, and
  measurable precursor indicators, including remote-work unbundling metrics
  where available.
- 5-year signals: repeated cases, sector-specific diffusion, employer/vendor
  substitution evidence, remote-employment substitution evidence, and durable
  nonemployer or node-like revenue.
- 10-year signals: macro-relevant shifts in firm boundaries, network
  governance, concentration, management layers, remote employment, or
  production-unit structure.

## Evidence Classes

| Evidence Class | What It Can Show | What It Cannot Show Alone |
| --- | --- | --- |
| Feasibility case | A node-like structure can work in a specific context. | Broad diffusion or macroeconomic relevance. |
| Repeated case evidence | Pattern across multiple sectors or clients. | Causal AI effect without comparison group. |
| Public-sector baseline data | Nonemployer/employer outcomes and firm dynamics. | AI use, hidden labor, one-human status, or transaction costs. |
| AI adoption evidence | Employer AI exposure or adoption context. | Nonemployer AI use or boundary change. |
| Linked administrative data | Strongest test when AI use, outcomes, survival, and boundary changes are linked. | Still needs confounder control and comparison groups. |
| Economic-class implication data | Possible movement into creator, niche human provider, or experiencer roles. | Proof of Operator Node diffusion unless linked to AI-enabled production and firm-boundary change. |

## Minimum V1 Prediction Fields

Every V1 prediction should specify:

- horizon: 3, 5, or 10 years;
- unit: firm, node, sector, transaction, network, or labor market;
- expected direction;
- necessary precursor signal;
- evidence source or planned source;
- failure condition;
- what would cause revision rather than rejection;
- strongest alternative explanation.

## Method Ethos

The research program should be open, cooperative, and adversarial toward its
own claims.

Principles:

- No hiding.
- No pretending evidence is stronger than it is.
- No conclusion before the evidence.
- Publish negative updates.
- Treat being wrong as information.
- Keep company outcome, thesis outcome, and category outcome separate.
- Treat recognition as a possible trailing indicator, not a research goal.

## Immediate Implication For The Paper

The paper should be structured as V1: a forecast baseline and evidence agenda.
It can argue the thesis as a directional forecast, but it should state that the
current evidence base is incomplete and that future versions will test,
revise, narrow, or reject the thesis.
