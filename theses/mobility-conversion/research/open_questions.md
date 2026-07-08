# Open Questions

Status: formation-stage research queue.

- What boundary rule defines a Metropolitan Transport Region?
- Should MTR boundaries follow commuting zones, transport agency service areas,
  metropolitan statistical regions, built-up areas, functional urban areas, or a
  thesis-specific rule?
- What minimum data standard is required without biasing the universe toward
  wealthy and source-rich regions?
- Which modes are in scope: public transport, road travel, walking, cycling,
  paratransit, ferries, informal transport, shared mobility, or freight impacts?
- What is the first accepted definition of usable access?
- The formation-stage decision is to start with a broader multi-dimensional
  usable-access framework with explicit missing-data flags. What evidence would
  justify narrowing the framework later?
- Should access to opportunities measure jobs, education, healthcare, essential
  services, social life, or a weighted opportunity bundle?
- How should travel time and reliability be measured across modes?
- How should affordability account for income distribution rather than nominal
  fare levels alone?
- How should universal access include disability access, age, gendered safety,
  sidewalk quality, cycling safety, and transfer friction?
- How should asset condition and resilience be measured across regions with
  incompatible reporting systems?
- What makes governance fit measurable instead of narrative?
- Can growth / maturity be separated from wealth, urban age, and inherited
  network structure?
- Which explanatory axes can be measured without becoming hidden outcome
  components?
- Which axis interactions are more plausible than single-axis explanations?
- What falsifies the conversion frame?
- What protocol selects candidate MTRs before any names are chosen?
- Formation-stage pre-testing rules now define the initial scale, temporal,
  missing-data, geographic-stratification, cross-border, and polycentric gates.
  What later evidence should convert those rules into final candidate-universe
  inclusion criteria?
- The first source-family dry run tested OECD FUAs without naming an MTR. Should
  Thesis 2 next run a proposed-MTR dry run, or wait until a real source-led
  proposal is ready?
- How should ChatGPT Deep Research returns be decomposed into source leads,
  open questions, verified source notes, and rejected material?
- Should observed commuting-flow FUAs and modelled global FUAs be separate
  boundary confidence classes?
- What maximum vintage gap is acceptable for commuting-based boundaries?
- Should post-2020 work-from-home disruption be a caveat or a hard adjustment
  in boundary validation?
- Should built-up urban cores, governance/service regions, and service-derived
  coverage always be stored as overlays even when they are not primary
  boundaries?
- What boundary-source metadata fields are required before any MTR can be
  admitted to the candidate universe?
- Do OECD and Eurostat FUA sources directly support behavioral-validity-first
  boundary design, or are they too narrow for global MTR methodology?
- Should every commuting-derived boundary source require a
  `commuting_data_vintage` field?
- Batch 2B supports requiring commute-derived boundary caveat fields. What exact
  values should be allowed for `pandemic_or_remote_work_caveat` and
  `source_authority_caveat`?
- Should U.S. GTFS Weblinks and the National Transit Map be separate source
  registry entries?
- Batch 2C supports adding `hybrid_functional_statistical_region` as a
  candidate confidence class. Should it be accepted in the first boundary
  decision record, and where should it sit in the source hierarchy?
- What official current ONS source should be archived for the full TTWA
  delineation algorithm, thresholds, spatial units, and boundary files?
- For Statistics Canada, what current CMA/CA detailed-methodology source should
  replace the archived glossary before Canadian boundaries are admitted?
- Batch O1 started with SDG 11.2.1 and GTFS because they touch multiple Tier 1
  dimensions.
- Batch O2A verified safety source families and found that safety cannot be
  represented by one source family.
- Batch O2B verified affordability source families and found that affordability
  requires cost, income, geography, and car-dependency context. What source
  quality should be required before any affordability metric can be accepted for
  candidate testing?
- Batch O2C verified access-to-opportunities source families and found that job
  access cannot stand in for full opportunity access. Should the first proposed
  access metric be narrow job access or a broader opportunity bundle?
- The outcome metric pre-admission matrix now defines gates before any Tier 1
  metric record can be filled.
- The first job-access pre-admission test blocked before metric record
  creation.
- ACS population denominator and travel-time method notes now resolve two
  blockers from the first job-access pre-admission test. What source-vintage
  alignment rule and distribution plan are needed before retesting?
- Source-vintage alignment and distribution rules now exist for access metric
  retesting. Does the job-access idea still block on MTR boundary crosswalk and
  feed completeness after retest?
- Job-access retest 1 still blocks on MTR boundary and MTR-specific source
  bundle. Should the next work return to boundary/candidate-universe readiness
  instead of more abstract metric retesting?
- Data acquisition strategy now defaults to release-based and snapshot-based
  manifests, not Sidekiq or live collectors. What source-led MTR boundary/source
  bundle should be the first candidate for a filled evidence manifest?
- Boundary/candidate-universe readiness checklist now defines the gate before
  filled boundary records or evidence manifests. What source-led proposals
  should be requested from the research thread?
- Source-led MTR proposal handoff has been prepared. Which returned leads pass
  raw-return intake, source-note verification, and readiness-gate screening?
- Source-led MTR proposal return intake protocol is now defined. Which returned
  leads, if any, are ready for source-note review versus quarantine?
- Source-led MTR lead review template now exists. Which returned leads, if any,
  merit individual lead review after the complete return has been classified?
- Source-led MTR proposal intake 2026-07-01 classified eight returned leads.
  Should the first follow-up source-note batch focus on Eurostat/OECD FUA exact
  row extraction, U.S. county-based source systems, or modelled-boundary burden?
- Batch S1A determined Eurostat/OECD FUA exact-row extraction is source-system
  feasible and required before readiness review. What exact extraction workflow
  should identify unit code, official name, geometry path, denominator source,
  and license/download provisions without archiving raw geometry prematurely?
- Batch S1B determined U.S. county-based boundary systems can enter mechanics
  review but must remain `not_admitted` until county coarseness, source
  authority caveats, exact membership, and service-overlay limits are resolved.
  What threshold distinguishes acceptable county coarseness from denominator
  overreach?
- Batch S1D determined modelled global boundaries remain eligible only as
  high-burden fallback or validation classes. What evidence threshold proves
  that no stronger observed, national, hybrid, or official statistical boundary
  is available before a modelled FUA can advance?
- Batch S1C determined hybrid functional-statistical regions remain eligible
  under a distinct confidence class. What exact rule decides when a hybrid
  official statistical region outranks a modelled global FUA or a stale
  commuting-flow boundary?
- Batch S1E defined the local service-source queue. Which service-source family
  should receive the first independent source-note review only after an
  independent boundary extraction workflow exists?
- Eurostat/OECD FUA exact-row extraction workflow now exists. Should the first
  extraction note test Helsinki FUA, Lyon FUA, or a non-returned control row to
  avoid privileging returned names?
- Eurostat/OECD FUA exact-row extraction note confirmed `FI001F` as Helsinki
  and corrected Lyon to `FR002F`, with `FR003F` identified as Lille. What
  population denominator source should be tested before any European FUA lead
  can move toward readiness review?
- Eurostat `URB_LPOP1` is now identified as a candidate FUA population
  denominator source family. Which lead-specific analysis vintage should be
  tested first, given inspected missingness/status differences between
  `FI001F` and `FR002F`?
- Should Eurostat observations carrying status flag `b` / break in time series
  be allowed for denominator use in formation-stage tests, or should they force
  an earlier unflagged vintage?
- Helsinki HSL/Digitransit service sources are now source-family verified. What
  coverage reconciliation method should compare HSL feed geography against
  `FI001F` without turning service coverage into the MTR boundary?
- Lyon France NAP source trace found `Réseau urbain TCL`, but GTFS/NeTEx were
  unavailable in the inspected catalog response. Should Lyon remain blocked
  until a current static schedule archive is recoverable, or can SIRI Lite be
  method-tested as a substitute?
- What operator-completeness scan is required for `FR002F` beyond TCL/SYTRAL,
  including regional rail, airport connector, interurban coach, and
  demand-responsive services?
- European FUA gate status now blocks both Helsinki and Lyon. What should the
  minimum coverage-reconciliation protocol require before a service source can
  support readiness review?
- The European FUA coverage reconciliation protocol now exists. Which lead
  should receive the first blocked readiness dry review, Helsinki as the cleaner
  source path or Lyon as the harder static-feed stress test?
- European FUA blocked readiness dry review now confirms both Helsinki and Lyon
  are blocked by denominator vintage/status policy. What rule should govern
  Eurostat `URB_LPOP1` missing years and break-in-time-series flags?
- Eurostat FUA population vintage/status policy now blocks current-comparison
  claims when denominator postures differ. Should the first lead-specific
  worksheet test Helsinki's short-window path or Lyon's historical/baseline
  stress case?
- European FUA denominator vintage worksheet gives Helsinki a
  `short_window_candidate_unflagged_2023` posture and blocks Lyon current
  comparison. What exact operator/coverage fields should the first Helsinki
  coverage reconciliation worksheet require?
- Helsinki coverage reconciliation now blocks on operator inventory and FUA
  coverage. Which source-led operator inventory sources can verify whether
  HSL/Digitransit covers all material public transport inside `FI001F`?
- Helsinki operator-inventory handoff is ready. What should Thesis 2 work on
  while waiting for that return: Lyon static-feed feasibility, Helsinki manifest
  planning, or another source-family lead?
- Lyon static-feed follow-up confirms GTFS/NeTEx are still unavailable in the
  refreshed catalog metadata. Is SIRI Lite method feasibility worth testing, or
  should Lyon wait for a current static feed recovery path?
- Lyon SIRI Lite method feasibility now blocks substitution until schema,
  snapshot, archive, completeness, vintage, license, and denominator gates are
  resolved. Should the next handoff ask for current GTFS/NeTEx recovery first
  or SIRI Lite schema/licence proof first?
- Lyon source-recovery handoff is ready. What non-European source-family branch
  should Thesis 2 work on while waiting for Helsinki and Lyon research returns?
- Calgary CMA source paths are identified but exact row/code and population
  field remain unresolved. Should Thesis 2 create an extraction workflow or
  hand this exact-row task to external research?
- Calgary CMA exact-row workflow and handoff are ready. Which remaining
  source-family branch should be worked while Helsinki, Lyon, and Calgary
  returns are pending?
- Greater Melbourne GCCSA exact-row workflow and handoff are ready. Which
  remaining source-family branch should be worked while European and
  Commonwealth returns are pending?
- Bristol TTWA exact-row workflow and handoff are ready. What official current
  ONS TTWA boundary/product source and population-denominator path should be
  accepted before any UK national commuting-zone lead can move to readiness
  review?
- For Bristol TTWA, what threshold distinguishes acceptable labour-market
  hinterland from denominator overreach, given the 2011 commuting-flow vintage
  and post-2020 work-from-home caveats?
- Minneapolis-St. Paul ERS CZ exact-membership workflow and handoff are ready.
  What county-coarseness threshold should prevent a U.S. ERS CZ from moving
  beyond `not_admitted` boundary review?
- For U.S. ERS CZ leads, when should FTA/NTD GTFS Weblinks be considered
  sufficient fixed-route source discovery, and what non-fixed-route exclusions
  must remain explicit caveats?
- Portland-Vancouver-Hillsboro CBSA exact-boundary workflow and handoff are
  ready. What rule decides when an official U.S. statistical metro is too coarse
  for MTR use even if ACS and Census boundary products align cleanly?
- For cross-state U.S. CBSA leads, what minimum service-operator completeness
  scan is required before any fixed-route overlay can support readiness review?
- Sao Paulo GHS-FUA high-burden workflow and handoff are ready. What evidence
  threshold proves that no stronger observed, national, hybrid, or official
  statistical boundary should outrank a modelled GHS-FUA lead?
- For modelled global boundary leads, how should Thesis 2 prevent GDP per
  capita or travel-friction model inputs from becoming hidden explanatory-axis
  or outcome proxies?
