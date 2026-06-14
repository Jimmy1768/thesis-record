# Economic Class Measurement Design

Status: measurement design for `TCE-P012`. Not analysis, evidence, paper prose,
policy, or conclusion.

Run date: 2026-06-12.

## Purpose

Operationalize the economic-class implication forecast without promoting it.

`TCE-P012` asks whether, if AI-enabled production becomes abundant and firms
become smaller productivity nodes, economic roles shift toward:

- creators;
- niche human providers;
- experiencers.

This design defines candidate measurement boundaries, public proxies, private
data requirements, and failure conditions.

## Core Measurement Problem

The proposed categories are not current official labor-market categories.
Existing data usually classify people by:

- occupation;
- industry;
- class of worker;
- employment status;
- business ownership;
- wage or nonemployer receipts.

`TCE-P012` is different. It classifies economic function under a future
production regime. Therefore public data can only provide weak proxy baselines
until direct market, platform, payroll, vendor, or node data exist.

## Role Boundary Definitions

| Role | Minimum Classification Test | Exclusions | Stronger Evidence |
| --- | --- | --- | --- |
| Creator | Initiates, owns, designs, orchestrates, or compounds a productive system and captures upside from productive judgment | passive investor, ordinary employee, low-autonomy contractor, ordinary self-employment with no system orchestration | revenue/receipts, ownership, decision rights, node orchestration, durable clients, low payroll dependence |
| Niche human provider | Paid because human presence, rarity, embodied performance, care, trust, ritual, or prestige is part of the product | generic in-person service work, low-wage residual work, tasks retained only because automation is unavailable | explicit human-presence premium over automated substitute, high willingness-to-pay, scarce credential, repeat demand |
| Experiencer | Paid to evaluate, validate, compare, review, certify, test, or communicate whether outputs are desirable to humans | unpaid reviews, passive telemetry subject, synthetic-user simulation, internal QA only, ordinary customer support | structured task, compensation, reviewer quality scoring, domain credentials, buyer use of evaluation in product/service decisions |

## Public Proxy Sources

| Source | Verified Status | Proxy Use | Limit |
| --- | --- | --- | --- |
| BLS OEWS | verified primary source | Employment and wages by occupation for adjacent categories such as market research analysts and survey researchers | Occupation proxy only; not creator/experiencer class evidence |
| BLS OOH market research analysts | verified primary source | Describes preference, demand, survey, focus-group, interview, and consumer-research work | Descriptive source, not longitudinal class evidence |
| BLS OOH survey researchers | verified primary source | Describes survey work about opinions, preferences, beliefs, or desires | Does not isolate paid experiential validation |
| ACS PUMS | previously verified primary source | Worker class, occupation, industry, self-employment, remote status | No direct creator/experiencer category |
| NES/AIES-NES | previously verified primary source | Nonemployer counts and receipts for potential creator/operator baselines | No AI, ownership role, hidden labor, or preference-validation category |
| SUSB/BDS/BFS | previously verified primary source | Employer-side comparison, payroll formation, and firm dynamics | No direct class-implication fields |

## Candidate Public Baselines

### Creator Proxy

Possible public indicators:

- nonemployer receipts per establishment in high-AI-exposure digital sectors;
- high-receipt nonemployer share;
- self-employed incorporated and unincorporated worker shares in ACS PUMS;
- employer-firm formation or payroll-start proxies only as transition context.

Allowed interpretation:

- creator/operator baseline candidate;
- not proof of productive system orchestration;
- not proof of AI-enabled node status.

### Niche Human Provider Proxy

Possible public indicators:

- occupational employment and wage trends in human-presence or performance
  categories selected before analysis;
- wage premia for occupations where human presence is plausibly part of the
  product;
- private willingness-to-pay comparisons against automated substitutes, where
  governed.

Allowed interpretation:

- scarcity-premium monitoring design;
- not proof that ordinary work disappeared;
- not proof that humanness is the causal reason for premium unless directly
  measured.

### Experiencer Proxy

Possible public indicators:

- BLS OEWS employment/wages for market research analysts and survey
  researchers as adjacent formal preference-research occupations;
- private/platform counts of paid product testers, UX research participants,
  AI-output evaluators, taste-panel participants, certification reviewers, or
  domain-specific evaluators;
- task-level compensation by difficulty, credential, duration, and review
  quality.

Allowed interpretation:

- weak public proxy and stronger private measurement design;
- not evidence that a new class exists;
- not support for `TCE-P012` without growth, compensation, durability, and
  linkage to AI-produced or node-produced output.

## Private Or Platform Fields Required

Direct `TCE-P012` testing likely needs nonpublic data:

- evaluation task ID;
- output being evaluated;
- producer type: node, firm, AI labor service, human worker, mixed;
- evaluator human status;
- evaluator compensation;
- task duration;
- task difficulty;
- credential requirement;
- embodied-experience requirement;
- reviewer reliability or usefulness score;
- buyer decision impact;
- repeat evaluator demand;
- synthetic-user or telemetry substitution flag;
- comparable automated-evaluation cost;
- product/service revenue or adoption after evaluation.

Governance policy:

- `research/data/private_data_governance.md`

The direct test remains blocked until a specific platform, company, partner, or
buyer-side source passes storage, disclosure, confidentiality, baseline, and
aggregation review.

## Falsifier Design

`TCE-P012` weakens if:

- paid evaluation markets remain small or low-paid;
- human evaluation is mostly unpaid consumer review work;
- preference validation is captured through telemetry, A/B testing, synthetic
  users, recommendation systems, or elite tastemakers;
- niche human provision has high prestige but remains too narrow to matter as
  an economic class;
- creator/operator gains are mostly passive ownership, capital returns, or
  ordinary self-employment rather than active productive-system orchestration;
- ordinary wage employment remains the main mass economic role despite
  abundant AI production.

## Current Decision

There is enough source architecture to create a weak public monitoring baseline
around adjacent preference-research occupations and nonemployer creator
proxies.

There is not enough evidence or data architecture to treat creators, niche
human providers, or experiencers as observed economic classes.

`TCE-P012` remains `forecast_taxonomy`, with `claim_support_updated=false`.
