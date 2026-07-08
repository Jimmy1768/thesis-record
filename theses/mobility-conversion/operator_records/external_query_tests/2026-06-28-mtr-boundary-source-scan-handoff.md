# Deep Research Handoff: MTR Boundary Source Scan

Date: 2026-06-28

Status: outbound research handoff. Smoke-test/source-discovery use only.

## Role

You are supporting a formation-stage research thesis called Mobility Conversion.
Your task is source discovery and methodological comparison only.

Do not rank cities. Do not recommend candidate Metropolitan Transport Regions.
Do not calculate scores. Do not decide the thesis methodology.

## Thesis Context

Mobility Conversion studies why some Metropolitan Transport Regions convert
capacity, pressure, shape, governance, and growth into usable access better than
others.

Use the term "Metropolitan Transport Region" or "MTR."

Do not use "Metropolitan Transit Region."

The research team is currently deciding how to define the MTR boundary before
any regions are selected.

## Research Question

What authoritative boundary definitions and datasets are suitable for comparing
metropolitan-scale transport regions across countries?

## Boundary Families To Investigate

Investigate source classes and examples for:

- functional urban areas;
- commuting zones or travel-to-work areas;
- official metropolitan statistical areas;
- built-up urban area or urban agglomeration boundaries;
- transport authority, fare union, service planning, or regional transport
  governance boundaries;
- GTFS or transport-service-area-derived boundaries;
- accessibility dataset geographies.

## Required Output

Return a structured source scan with one section per boundary family.

For each boundary family, include:

- definition;
- authoritative source or dataset examples;
- geographic coverage;
- update cadence or latest known release pattern;
- spatial unit and scale;
- whether boundaries are based on travel behavior, administrative/statistical
  rules, built form, governance, or service provision;
- strengths for transport-access research;
- weaknesses for transport-access research;
- comparability risks across countries;
- data availability risks;
- whether it is suitable as a primary MTR boundary, fallback boundary,
  explanatory context, or not suitable.

## Required Source Types

Prioritize:

- official statistical agencies;
- OECD, Eurostat, UN, World Bank, ITF, or similar intergovernmental sources;
- transport agencies or metropolitan planning organizations;
- peer-reviewed transport or urban geography literature;
- well-documented open datasets with clear methods.

Avoid relying on:

- travel blogs;
- livability rankings;
- best-transit-city lists;
- relocation guides;
- unsourced encyclopedia summaries;
- city reputation.

## Explicit Non-Goals

Do not:

- rank countries;
- rank cities;
- select candidate MTRs;
- score transport systems;
- evaluate livability;
- recommend where to live;
- treat transit reputation as evidence;
- treat GDP as the outcome;
- merge explanatory axes into outcome scores.

## Decision Support Needed

The final synthesis should help Thesis 2 decide between:

- behavioral validity first: travel-flow or functional-region boundaries as
  primary, statistical boundaries as fallback;
- comparability first: official statistical metro boundaries as primary,
  travel-flow boundaries as validation/context;
- a hybrid rule with strict adjustment limits.

Do not choose for us. Explain the tradeoffs and what evidence would support
each choice.

## Expected Use Inside ThesisRecord

Your output will not be accepted as evidence. It will be decomposed into source
leads, open questions, verified source notes, methodology candidates, or
rejected material.
