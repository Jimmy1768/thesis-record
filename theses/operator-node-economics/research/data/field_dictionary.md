# Field Dictionary

Status: proposed field dictionary for future empirical work. Not a dataset.

Field names marked `verified_exact` were directly checked against a source note
or official API metadata in the current research record. Field names marked
`concept_field` must be mapped to exact table/API names before analysis.

## Common Panel Fields

| Field | Status | Type | Source(s) | Definition | Required For | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| `year` | concept_field | integer/string | all panel datasets | Reference year or survey year | all panel tests | Exact field differs: NES/AIES-NES use `YEAR`; BDS uses `time`/`YEAR`; BFS uses `time`. |
| `period` | concept_field | string | BFS, BTOS | Month, quarter, or survey collection period | BFS/BTOS panels | BFS exact field is `time`; BTOS exact field unresolved. Do not mix monthly and annual observations without aggregation rule. |
| `naics_code` | concept_field | string | NES, AIES-NES, SUSB, BDS, BFS, BTOS | NAICS industry code | all NAICS panels | NES uses `NAICS2022`; AIES-NES, BDS, and verified SUSB U.S./state layout use 2017 NAICS fields; BFS and BTOS public-use fields remain unresolved. |
| `naics_label` | concept_field | string | NES and other Census tables | Industry label | documentation/QA | NES exact field is `NAICS2022_LABEL`. |
| `naics_vintage` | concept_field | string | all NAICS datasets | NAICS version used by the dataset | all cross-dataset joins | Must be explicit before joining across years. |
| `naics_join_class` | concept_field | string | mixed-vintage panels | Harmonization status: `native_only`, `sector_stable`, `same_code_stable_or_title_only`, or `changed_blocked` | all cross-dataset joins | Defined in `research/data/naics_harmonization_rule.md`; required before mixed 2017/2022 analysis. |
| `naics_change_indicator` | concept_field | string | Census 2022 NAICS structure | Census 2022 change indicator: blank, `*`, `**`, `***`, or `****` | NAICS QA | Used only for harmonization QA; not an outcome variable. |
| `industry_level` | concept_field | integer/string | NES and other Census tables | Sector/subsector/industry detail level | all NAICS panels | NES exact field is `INDLEVEL`. |
| `geo_id` | concept_field | string | Census datasets | Geographic identifier | geography panels | NES exact field is `GEO_ID`; API `for`/`in` clauses vary. |
| `geo_name` | concept_field | string | Census datasets | Geography label | documentation/QA | NES exact field is `NAME`. |
| `state_fips` | concept_field | string | Census datasets | State FIPS code | geography panels | NES exact field is `STATE`. |
| `county_fips` | concept_field | string | NES, possibly other Census datasets | County FIPS code | county panels | NES exact field is `COUNTY`. |
| `cbsa` | verified_exact | string | NES | Metro/micro area code | metro panels | Exact NES field: `CBSA`. |
| `csa` | verified_exact | string | NES | Combined statistical area code | metro panels | Exact NES field: `CSA`. |

## NES Fields

| Field | Status | Type | Exact Source Field | Definition | Required For | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| `nes_establishments` | verified_exact | integer | `NESTAB` | Number of nonemployer establishments | TCE-P001, TCE-P009, TCE-P010 | No paid employees, not one-human status. |
| `nes_receipts_thousand` | verified_exact | integer | `NRCPTOT` | Nonemployer sales, value of shipments, or revenue in thousands of dollars | TCE-P001, TCE-P010 | Needs inflation adjustment before trend analysis. |
| `nes_receipts_noise_range` | verified_exact | integer | `NRCPTOT_N` | Noise range for nonemployer receipts/revenue | QA/sensitivity | Use for disclosure/noise caution. |
| `nes_receipts_noise_flag` | verified_exact | string | `NRCPTOT_N_F` | Attribute flag for nonemployer receipt noise range | QA/sensitivity | Preserve before numeric coercion. |
| `receipt_size_class` | verified_exact | string | `RCPSZES` | Sales, value of shipments, or revenue size of establishments code | TCE-P001, TCE-P009 | Needed for high-receipt nonemployer share. |
| `receipt_size_label` | verified_exact | string | `RCPSZES_LABEL` | Receipt-size class label | documentation/QA | Label for `RCPSZES`. |
| `legal_form_code` | verified_exact | string | `LFO` | Legal form of organization code | hidden-firm/legal-form checks | Does not establish one-human status. |
| `legal_form_label` | verified_exact | string | `LFO_LABEL` | Legal form of organization label | documentation/QA | Label for `LFO`. |
| `sector` | verified_exact | string | `SECTOR` | NAICS economic sector | sector aggregation | NES field. |
| `subsector` | verified_exact | string | `SUBSECTOR` | NAICS subsector | sector aggregation | NES field. |

Derived NES fields:

| Field | Inputs | Definition | Required For | Guardrail |
| --- | --- | --- | --- | --- |
| `receipts_per_nonemployer_establishment` | `NRCPTOT`, `NESTAB` | Nonemployer receipts per establishment | TCE-P001, TCE-P009 | Not profit, not income, not revenue per human. |
| `high_receipt_nonemployer_share` | `RCPSZES`, `NESTAB` | Share of nonemployer establishments in selected high-receipt classes | TCE-P001, TCE-P007, TCE-P009 | Threshold must be declared before analysis. |

## AIES-NES Fields To Map

| Field | Status | Definition | Required For | Notes |
| --- | --- | --- | --- | --- |
| `aies_nes_industry_code` | verified_exact | Industry code in AIES-NES table | TCE-P001, TCE-P010 | Exact field: `NAICS2017`; label appears as `NAICS2017_LABEL` in examples/attributes. |
| `aies_nes_year` | verified_exact | Reference year | TCE-P001, TCE-P010 | Exact field: `YEAR`; inspected endpoint is 2023. |
| `aies_employer_revenue_thousand` | verified_exact | Employer sales, value of shipments, or revenue in $1,000 | TCE-P001, TCE-P010 | Exact field: `RCPT_TOT_VAL`; coefficient of variation field is `RCPT_TOT_CV`. |
| `aies_employer_revenue_cv` | verified_exact | Coefficient of variation for employer sales, value of shipments, or revenue | QA/sensitivity | Exact field: `RCPT_TOT_CV`; preserve before employer/nonemployer comparison. |
| `aies_nonemployer_revenue_thousand` | verified_exact | Nonemployer sales, value of shipments, or revenue in $1,000 | TCE-P001, TCE-P010 | Exact field: `RCPT_TOT_VAL_NS`; noise range field is `RCPT_TOT_VAL_NS_N`. |
| `aies_nonemployer_revenue_noise_flag` | verified_exact | Attribute flag for nonemployer revenue noise range | QA/sensitivity | Exact field: `RCPT_TOT_VAL_NS_N_F`; preserve before numeric coercion. |
| `aies_industry_level` | verified_exact | Industry level | TCE-P001, TCE-P010 | Exact field: `INDLEVEL`; `SECTOR`, `SUBSECTOR`, and `INDGROUP` also available. |
| `business_class` | concept_field | Employer/nonemployer indicator | TCE-P001, TCE-P010 | Not a direct AIES-NES field; derive from employer vs nonemployer revenue columns. |
| `establishment_or_firm_count` | concept_field | Count field if present | TCE-P001, TCE-P010 | No exact count field verified in AIES-NES endpoint. |

## BFS Fields To Map

| Field | Status | Definition | Required For | Guardrail |
| --- | --- | --- | --- | --- |
| `bfs_time` | verified_exact | ISO-8601 Date/Time value | TCE-P007, TCE-P009 | Exact field: `time`; supports year and month. |
| `bfs_data_type_code` | verified_exact | Item type | TCE-P007, TCE-P009 | Exact field: `data_type_code`; target monthly value-code mapping verified. |
| `bfs_category_code` | verified_exact | Industry list | TCE-P007, TCE-P009 | Exact field: `category_code`; monthly sector/aggregate category mapping verified. |
| `bfs_cell_value` | verified_exact | Data value | TCE-P007, TCE-P009 | Exact field: `cell_value`; preserve raw values because Census may return non-numeric suppression markers such as `D`. |
| `bfs_seasonally_adj` | verified_exact | Seasonally adjusted yes/no | TCE-P007, TCE-P009 | Exact field: `seasonally_adj`. |
| `bfs_time_slot_id` | verified_exact | Time slot | TCE-P007, TCE-P009 | Exact field: `time_slot_id`; supplemental period identifier. |
| `bfs_program_code` | verified_exact | Component name | TCE-P007, TCE-P009 | Exact field: `program_code`. |
| `bfs_geo_level_code` | verified_exact | Geography level code | TCE-P007, TCE-P009 | Exact field: `geo_level_code`; inspected geography metadata showed U.S. only. |
| `business_applications` | verified_exact | Business applications from EIN filings | TCE-P009 | Target API value `BA_BA`; staged rows only, no metric yet. |
| `high_propensity_applications` | verified_exact | Applications likely to become payroll employers | TCE-P009, TCE-P007 | Target API value `BA_HBA`; staged rows only, no metric yet. |
| `business_formations_4q` | verified_exact | Employer wage-paying formations within four quarters | TCE-P007 | Target API value `BF_BF4Q`; payroll-transition proxy only; staged rows only, no metric yet. |
| `business_formations_8q` | verified_exact | Employer wage-paying formations within eight quarters | TCE-P007 | Target API value `BF_BF8Q`; payroll-transition proxy only; staged rows only, no metric yet. |
| `projected_business_formations` | verified_exact | Projected employer formations | TCE-P007, TCE-P009 | Target API values `BF_PBF4Q` and `BF_PBF8Q`; staged rows only, no metric yet. |

## BDS Fields To Map

Living dissertation app status: BDS has a metadata-only public-file scaffold
for the official sector by firm age by firm size CSV. Field statuses below
remain source/schema statuses, not ingested metrics or claim support.

| Field | Status | Definition | Required For | Guardrail |
| --- | --- | --- | --- | --- |
| `firm_count` | verified_exact | Employer firm count | TCE-P010 | Exact BDS field: `FIRM`; employer firms only. |
| `firm_shutdowns` | verified_exact | Firms that exited during the last 12 months | TCE-P009, TCE-P010 | Exact BDS field: `FIRMDEATH_FIRMS`; employer firms only. |
| `firm_startups` | concept_field | Employer firm startups | TCE-P007, TCE-P009, TCE-P010 | Direct exact field not identified in extracted BDS field set or 2026-06-11 variable scan; `ESTABS_ENTRY` is establishment entry, not firm startup. |
| `establishment_births` | verified_exact | Establishments born during the last 12 months | TCE-P009, TCE-P010 | Exact BDS field: `ESTABS_ENTRY`; employer establishments only. |
| `establishment_deaths` | verified_exact | Establishments exited during the last 12 months | TCE-P009, TCE-P010 | Exact BDS field: `ESTABS_EXIT`; employer establishments only. |
| `establishment_count` | verified_exact | Employer establishment count | TCE-P010 | Exact BDS field: `ESTAB`. |
| `job_creation` | verified_exact | Jobs created from expanding and opening establishments | TCE-P010 | Exact BDS field: `JOB_CREATION`; not management-layer evidence. |
| `job_creation_births` | verified_exact | Jobs created from opening establishments | TCE-P010 | Exact BDS field: `JOB_CREATION_BIRTHS`. |
| `job_destruction` | verified_exact | Jobs lost from contracting and closing establishments | TCE-P010 | Exact BDS field: `JOB_DESTRUCTION`; not management-layer evidence. |
| `job_destruction_deaths` | verified_exact | Jobs lost from closing establishments | TCE-P010 | Exact BDS field: `JOB_DESTRUCTION_DEATHS`. |
| `net_job_creation` | verified_exact | Net jobs created | TCE-P010 | Exact BDS field: `NET_JOB_CREATION`. |
| `employment` | verified_exact | Employer employment | TCE-P010 | Exact BDS field: `EMP`; needs firm-size/age context. |
| `firm_age` | verified_exact | Firm age category | TCE-P007, TCE-P010 | Exact BDS field: `FAGE`; label attribute is `FAGE_LABEL`; 2022 U.S. value set verified in `research/data/bds_value_sets.md`. |
| `firm_size` | verified_exact | Firm employment-size category | TCE-P010 | Exact BDS field: `EMPSZFI`; label attribute is `EMPSZFI_LABEL`; 2022 U.S. value set verified in `research/data/bds_value_sets.md`. |
| `establishment_size` | verified_exact | Establishment employment-size category | TCE-P010 | Exact BDS field: `EMPSZES`; label attribute is `EMPSZES_LABEL`. |
| `bds_naics` | verified_exact | 2017 NAICS code | TCE-P010 | Exact BDS field: `NAICS`; label attribute is `NAICS_LABEL`. |

## SUSB Fields To Map

| Field | Status | Definition | Required For | Guardrail |
| --- | --- | --- | --- | --- |
| `susb_firm_count` | verified_exact | Number of employer firms | TCE-P001, TCE-P010 | Exact U.S./state annual layout field: `FIRM`; employer firms only. |
| `susb_establishment_count` | verified_exact | Number of employer establishments | TCE-P010 | Exact U.S./state annual layout field: `ESTB`. |
| `susb_employment` | verified_exact | Paid employment with noise | TCE-P001, TCE-P010 | Exact U.S./state annual layout field: `EMPL`; does not identify management layers. |
| `susb_annual_payroll` | verified_exact | Annual payroll in $1,000 with noise | TCE-P001, TCE-P010 | Exact U.S./state annual layout field: `PAYR`; needs inflation adjustment. |
| `susb_enterprise_size_class` | verified_exact | Enterprise employment-size category | TCE-P001, TCE-P010 | Exact U.S./state annual layout field: `ENTRSIZE`; in years ending in 2 and 7 this can also indicate enterprise receipt size depending on table. |
| `susb_naics` | verified_exact | Industry code, 6-digit NAICS | TCE-P001, TCE-P010 | Exact U.S./state annual layout field: `NAICS`; 2022 page states 2017 NAICS. |
| `susb_state` | verified_exact | U.S./state geographic area code | TCE-P001, TCE-P010 | Exact U.S./state annual layout field: `STATE`; use file vintage for year unless a year field is verified in a specific extract. |
| `susb_employment_noise_flag` | verified_exact | Employment noise flag | QA/sensitivity | Exact U.S./state annual layout field: `EMPLFL_N`; `EMPLFL_R` is a legacy range/suppression flag no longer used starting with 2018. |
| `susb_payroll_noise_flag` | verified_exact | Annual payroll noise flag | QA/sensitivity | Exact U.S./state annual layout field: `PAYRFL_N`. |
| `susb_receipts_thousand` | verified_exact | Receipts in $1,000 with noise | comparison context | Exact U.S./state annual layout field: `RCPT`; available only in years ending in 2 and 7 in verified layout. |
| `susb_receipts_noise_flag` | verified_exact | Receipts noise flag | QA/sensitivity | Exact U.S./state annual layout field: `RCPTFL_N`; available only in years ending in 2 and 7 in verified layout. |

## BTOS AI Supplement Fields To Map

| Field | Status | Definition | Required For | Guardrail |
| --- | --- | --- | --- | --- |
| `current_ai_use` | concept_field | Whether business currently uses AI | TCE-P001, TCE-P010 | Official AI-supplement questionnaire question 23 verified; public-use variable name unresolved. Employer businesses only. |
| `expected_ai_use` | concept_field | Expected AI use in next six months | exposure sensitivity | Official AI-supplement questionnaire questions 33-34 verified; public-use variable names unresolved. Forward-looking survey response only. |
| `ai_business_function` | concept_field | Business function where AI is used | exposure refinement | Official AI-supplement questionnaire question 24 verified; public-use variable names unresolved. Wording changed Nov. 17, 2025. |
| `ai_operational_change` | concept_field | Training, workflow, technology, or vendor/consulting change for AI | mechanism context | Official AI-supplement questionnaire question 29 verified; public-use variable names unresolved. Not a boundary outcome. |
| `btos_size_class` | concept_field | Business employment-size category | TCE-P006, TCE-P010 | BTOS data page verifies expanded employment size classes after September 2023; public-use field name unresolved. Employer-business size only. |
| `btos_industry` | concept_field | Industry or sector | TCE-P001, TCE-P010 | BTOS data page verifies 2017 NAICS sector and three-digit subsector tabulations; public-use field name unresolved. |
| `btos_survey_period` | concept_field | Survey collection period | all BTOS exposure | Public-use field name unresolved. Do not compare across wording change without caveat. |

## Bonney Et Al. 2026 Concepts

| Field | Status | Definition | Required For | Guardrail |
| --- | --- | --- | --- | --- |
| `employer_ai_use_rate` | concept_field | Employer-firm AI use rate | TCE-P010 | Associational context only. |
| `employment_weighted_ai_use_rate` | concept_field | AI use rate weighted by employment | TCE-P010 | Indicates large-firm concentration. |
| `function_breadth` | concept_field | Breadth of business-function AI use | exposure refinement | Not causal. |
| `task_breadth` | concept_field | Breadth of worker-task AI use | exposure refinement | Firm-reported worker use. |
| `augmentation_substitution_mode` | concept_field | Reported augmentation/substitution effect | disconfirming context | Self-reported. |
| `reported_employment_change` | concept_field | Reported employment increase/decrease/no change | TCE-P010, criticisms | Not management-layer evidence. |

## Exposure, Node, And Transaction-Cost Architecture Fields

Source architecture:

- `research/data/ai_exposure_node_feasibility_architecture.md`

These fields are concept fields for future living-forecast ingestion. They are
not verified exact public-use fields and do not authorize claim support.

### Public Exposure Proxy Fields

| Field | Status | Definition | Required For | Guardrail |
| --- | --- | --- | --- | --- |
| `exposure_source` | concept_field | Source used for AI exposure context | TCE-P001, TCE-P010 | Must distinguish BTOS/Bonney, occupation-weighted proxy, direct node data, or theoretical scoring. |
| `exposure_tier` | concept_field | Exposure ladder tier: direct, observed employer adoption, occupation-weighted proxy, or theoretical prior | all forecast checks | Tier alone is not evidence of boundary change. |
| `exposure_period` | concept_field | Time period for exposure observation | all forecast checks | Must align or be explicitly lagged against outcome period. |
| `exposure_unit` | concept_field | Sector, occupation, firm, node, transaction, or worker unit | all forecast checks | Unit mismatch must be documented. |
| `occupation_weight` | concept_field | Industry or sector employment share for an occupation | occupation-weighted exposure | Requires accepted occupation-to-industry source. |
| `occupation_weighted_exposure_score` | concept_field | Sector exposure score from occupation mix and GenAI exposure | TCE-P001, TCE-P010 | Proxy only; not observed business AI use. |
| `theoretical_exposure_score` | concept_field | V1 forecast-prior score based on task and sector properties | V1 forecast targeting | Not evidence. |
| `exposure_limit` | concept_field | Plain-language limitation for the exposure measure | all exposure tables | Required before interpretation. |

### Node Feasibility Fields

| Field | Status | Definition | Required For | Guardrail |
| --- | --- | --- | --- | --- |
| `node_id` | concept_field | Stable internal identifier for a node candidate | feasibility/case evidence | Public outputs should avoid identifying operators unless disclosure is approved. |
| `case_id` | concept_field | Case-study identifier | feasibility/case evidence | Case evidence is not diffusion evidence by itself. |
| `node_operator_count` | concept_field | Number of humans operating the node | node classification | Must include founders/operators, not only employees. |
| `employee_count` | concept_field | Payroll employees attached to the node/entity | node-becomes-firm tests | Payroll start may indicate conversion into a firm. |
| `manager_count` | concept_field | Managers or coordination roles attached to the node/entity | TCE-P005, node classification | Requires role definition. |
| `subcontractor_count` | concept_field | Known subcontractors supporting output | hidden-labor checks | Hidden subcontracting can invalidate one-human classification. |
| `hidden_labor_flag` | concept_field | Indicator that labor inputs are uncertain or concealed | node classification | Must block strong feasibility claims until resolved. |
| `payroll_started_flag` | concept_field | Whether payroll employment began | TCE-P007 | Does not prove failure; may indicate node-to-firm transition. |
| `legal_entity_type` | concept_field | Legal wrapper for the node or case | classification | Legal form is not equivalent to productive architecture. |
| `ai_systems_used` | concept_field | AI systems materially used in production or coordination | feasibility evidence | Tool list alone is not outcome evidence. |
| `workflow_automation_level` | concept_field | Degree of automated workflow support | mechanism evidence | Requires predefined scale. |
| `institutional_memory_system` | concept_field | Persistent memory/documentation system used by the node | node architecture | Must distinguish ad hoc notes from reusable organizational memory. |
| `audit_trail_available` | concept_field | Whether actions, outputs, or decisions are traceable | transaction-cost and quality evidence | Audit trail availability is not proof of quality. |
| `client_count` | concept_field | Number of clients served in period | feasibility/diffusion | Client identity handling requires privacy review. |
| `repeat_client_count` | concept_field | Number of repeat clients in period | durability | Needs period definition. |
| `project_count` | concept_field | Number of projects or deliverables in period | output baseline | Must define project unit. |
| `revenue_period` | concept_field | Revenue measurement period | feasibility | Revenue without labor-boundary verification is not node evidence. |
| `revenue_amount` | concept_field | Revenue in measurement period | feasibility | Requires currency and accounting basis. |
| `output_unit` | concept_field | Unit of output or deliverable | output measurement | Must be comparable within case class. |
| `output_count` | concept_field | Number of output units | output measurement | Quantity without quality is insufficient. |
| `quality_measure` | concept_field | Quality or acceptance metric | feasibility | Must avoid self-serving undefined quality labels. |
| `node_status` | concept_field | Candidate, verified, partial, hidden firm, converted to firm, or insufficient evidence | classification | Status changes require human review. |

### Transaction-Cost Fields

| Field | Status | Definition | Required For | Guardrail |
| --- | --- | --- | --- | --- |
| `transaction_id` | concept_field | Procurement/project/contract transaction identifier | TCE-P004, TCE-P008 | Public outputs should hash or remove identifiers. |
| `supplier_type` | concept_field | Node, firm vendor, internal team, platform worker, or other supplier class | transaction-cost comparison | Supplier classification must be reviewed. |
| `supplier_size` | concept_field | Human or employee count for supplier | TCE-P002, TCE-P004 | Must distinguish employees from operators/subcontractors. |
| `service_category` | concept_field | Type of service or deliverable | sector boundary tests | Needs stable taxonomy. |
| `asset_specificity_score` | concept_field | Degree of client-specific investment or dependency | TCE-P003 | Requires predefined scoring rule. |
| `liability_risk_score` | concept_field | Legal, regulatory, brand, or operational risk | TCE-P003 | Requires predefined scoring rule. |
| `output_measurability_score` | concept_field | Ease of evaluating output quality | TCE-P002, TCE-P008 | Requires predefined scoring rule. |
| `search_time` | concept_field | Time to identify supplier/options | TCE-P004 | Must define start and end. |
| `proposal_cost` | concept_field | Cost or time spent preparing/evaluating proposal | TCE-P004 | Proxy must be labeled. |
| `lead_to_contract_time` | concept_field | Time from lead to signed agreement | TCE-P004 | Date definitions required. |
| `legal_review_time` | concept_field | Legal review effort or duration | TCE-P004 | May be absent for small transactions. |
| `procurement_cycle_time` | concept_field | End-to-end procurement duration | TCE-P004 | Must be compared with a baseline. |
| `monitoring_time` | concept_field | Client or manager monitoring effort | TCE-P004 | Task supervision is not always transaction cost. |
| `change_order_count` | concept_field | Number of scope-change events | TCE-P004 | Needs contract baseline. |
| `dispute_count` | concept_field | Number of disputes | TCE-P004, TCE-P008 | Dispute definition required before analysis. |
| `payment_delay_days` | concept_field | Days payment is delayed after invoice or milestone | TCE-P004 | Requires payment terms. |
| `repeat_purchase_flag` | concept_field | Whether client buys again from supplier | durability/trust | Repeat purchase does not prove lower transaction cost by itself. |
| `comparison_vendor_type` | concept_field | Baseline supplier class for comparison | transaction-cost tests | Required before mechanism claims. |

### Private Governance Fields

Private governance fields are required before any private, company, partner,
platform, payroll, procurement, node, AI-labor-service, or evaluator data is
ingested. They are defined in `research/data/private_data_governance.md`.

| Field | Status | Definition | Required For | Guardrail |
| --- | --- | --- | --- | --- |
| `data_owner` | governance_field | Owner or controller of the private source | all private tracks | Must be recorded outside public identifiers where sensitive. |
| `data_source_role` | governance_field | Role of the source: company operator network, partner company, external platform, buyer procurement, seller node, or public proxy | all private tracks | Required to separate company-case evidence from thesis-level evidence. |
| `privacy_classification` | governance_field | Public, aggregated public, redacted public, internal, or confidential | all private tracks | Confidential and internal data cannot be committed raw. |
| `disclosure_status` | governance_field | Whether source role and evidence origin may be disclosed | all private tracks | Company-derived evidence must be identified when used publicly. |
| `retention_rule` | governance_field | How long private source data may be retained | all private tracks | Must be set before ingestion. |
| `public_aggregation_rule` | governance_field | Aggregation or redaction rule for any public artifact | all private tracks | Minimum public cell size is controlled by `living_dissertation_app/config/living_dissertation_policy.yml` unless explicit approval exists. |
| `identity_fields_removed` | governance_field | Whether client, worker, evaluator, supplier, and account identifiers were removed or hashed | all private tracks | Public artifacts must not expose raw identities. |
| `baseline_defined_before_outcome_review` | governance_field | Whether comparison baseline was recorded before outcomes were evaluated | TCE-P004, TCE-P011, TCE-P012 | Prevents ex post baseline selection. |

### Remote Employment Falsifier Fields

Remote employment is not a generic confounder here; it is a transition signal
or falsifier depending on direction. Public sources can monitor remote
wage/salary work and alternative-arrangement context. Strong substitution
claims still require private or administrative fields that observe destination
of work, output, and replacement events.

| Field | Status | Definition | Required For | Guardrail |
| --- | --- | --- | --- | --- |
| `acs_worked_from_home` | verified_exact | ACS PUMS means of transportation to work; exact field `JWTRNS`, value `11` for worked from home | TCE-P011 public baseline | Usual-commute proxy, not full remote intensity and not substitution evidence. |
| `acs_class_of_worker` | verified_exact | ACS PUMS class of worker; exact field `COW` | TCE-P011 public baseline | Use values `1`-`5` for private/government wage or salary employees and values `6`-`7` for self-employment; not vendor/node status. |
| `acs_occupation` | verified_exact | ACS PUMS occupation recode; exact field `OCCP` | TCE-P011 public baseline | 2024 dictionary says 2018-and-later occupation recode based on 2018 occupation codes. |
| `acs_industry` | verified_exact | ACS PUMS industry recode; exact field `INDP` | TCE-P011 public baseline | 2024 dictionary says 2023-and-later industry recode based on 2022 industry codes. |
| `atus_activity_location` | verified_exact | ATUS activity location; exact field `TEWHERE`, value `1` respondent home or yard, value `2` respondent workplace | TCE-P011 work-location intensity | Person/activity time-use measure, not employment-boundary evidence. |
| `atus_activity_code` | verified_exact | ATUS six-digit activity code; exact field `TRCODE` | TCE-P011 work-location intensity | Must filter to work activities before interpretation. |
| `atus_activity_duration_minutes` | verified_exact | ATUS activity duration in minutes; exact field `TUACTDUR24` | TCE-P011 work-location intensity | Last activity is truncated at 4:00 a.m.; survey weights and multi-year changes must be handled. |
| `atus_industry_recode` | verified_exact | ATUS detailed industry recode for main job; exact field `TRDTIND1` | TCE-P011 work-location intensity | Uses 2017 Census Industry Classification beginning January 2020. |
| `atus_occupation_recode` | verified_exact | ATUS detailed occupation recode for main job; exact field `TRDTOCC1` | TCE-P011 work-location intensity | Occupation category, not firm role or vendor category. |
| `bls_cws_alternative_arrangement_category` | verified_table_category | BLS Contingent and Alternative Employment Arrangements public table categories: independent contractors, on-call workers, temporary help agency workers, workers provided by contract firms, and traditional arrangements | TCE-P011 context | Public table categories verified; microdata field names not mapped in this slice. |
| `remote_employee_count` | concept_field | Count of salaried/wage employees working remotely in a role, firm, sector, or period | TCE-P011 | Must distinguish employees from contractors, vendors, and owner-operators. |
| `remote_employee_share` | concept_field | Remote employees as share of relevant role, occupation, firm, or sector employment | TCE-P011 | Persistence/growth can falsify the strong thesis only in AI-exposed, output-measurable roles. |
| `remote_capable_role` | concept_field | Role or occupation that can be performed away from employer premises | TCE-P011 | Remote-capable does not mean AI-substitutable. |
| `ai_labor_service_spend` | concept_field | Spend on autonomous or semi-autonomous AI labor services | TCE-P011, TCE-P004 | Must distinguish software subscription, tool spend, consulting, and labor-service capacity. |
| `node_or_vendor_substitution_flag` | concept_field | Indicator that work shifted from remote employee role to node, vendor, owner-operator, or AI labor service | TCE-P011 | Requires baseline role and replacement category definition before analysis. |
| `remote_role_output_measure` | concept_field | Output metric for the remote-capable role or service category | TCE-P011 | Declining employment without output stability is not support. |
| `remote_role_human_residual_category` | concept_field | Classification for roles retained because humanness is part of the product, such as novelty, performance, care, trust, or legal authority | boundary conditions | Residual human roles are expected exceptions, not automatic falsifiers. |
| `replacement_destination` | concept_field | Destination for work after a remote role changes: internal employee, node, firm vendor, owner-operator, contractor, AI labor service, offshore vendor, automation only, no replacement, or unknown | TCE-P011 | Required before remote role decline can be interpreted as substitution. |
| `replacement_event_flag` | concept_field | Whether a role, supplier, or task changed source of production during the period | TCE-P011 | Must be paired with output and destination fields. |

### Economic Class Implication Fields

These fields are concept fields for `TCE-P012`. They are not verified exact
public-use fields and do not authorize claim support.

| Field | Status | Definition | Required For | Guardrail |
| --- | --- | --- | --- | --- |
| `creator_role_flag` | concept_field | Indicator for a person or entity that initiates, owns, designs, orchestrates, or compounds productive systems | TCE-P012 | Must distinguish founder/operator income from passive ownership or ordinary self-employment. |
| `niche_human_provider_flag` | concept_field | Indicator for paid work where humanness, rarity, performance, care, embodied presence, trust, ritual, or prestige is part of the product | TCE-P012 | Do not assume all in-person service work is niche human provision. |
| `experiencer_role_flag` | concept_field | Indicator for compensated human evaluation, validation, review, certification, testing, or preference communication | TCE-P012 | Must distinguish paid structured evaluation from unpaid reviews or passive telemetry. |
| `human_preference_validation_revenue` | concept_field | Revenue or compensation for structured human preference, quality, comfort, trust, desirability, or experience validation | TCE-P012 | Needs taxonomy before data collection. |
| `evaluation_task_difficulty` | concept_field | Difficulty tier for a human evaluation task | TCE-P012 | Some tasks may require certification, embodied experience, domain expertise, or long-duration exposure. |
| `evaluation_reviewer_quality` | concept_field | Quality or reliability score for human review/evaluation output | TCE-P012 | Must avoid circular scoring based only on agreement with buyer preference. |
| `niche_human_scarcity_premium` | concept_field | Wage, price, or revenue premium paid for human presence or performance over automated substitute | TCE-P012 | Requires comparable automated or non-human substitute baseline. |
| `synthetic_or_telemetry_substitution_flag` | concept_field | Indicator that preference validation is done by synthetic users, passive telemetry, or automated behavioral inference instead of paid humans | TCE-P012 criticism | A key failure pathway for the experiencer-market forecast. |
| `preference_research_occupation_employment` | source_proxy | Employment in adjacent preference-research occupations such as market research analysts or survey researchers | TCE-P012 public baseline | Proxy only; existing occupations are not the same as experiencers. |
| `preference_research_occupation_wage` | source_proxy | Wage levels for adjacent preference-research occupations | TCE-P012 public baseline | Wage growth may reflect ordinary demand for marketing or research, not AI-production abundance. |
| `paid_evaluation_task_count` | concept_field | Count of compensated human evaluation, testing, review, certification, or experience-validation tasks | TCE-P012 | Requires platform/private task data. |
| `paid_evaluator_count` | concept_field | Count of humans compensated for structured evaluation tasks in a period | TCE-P012 | Must distinguish unique humans from tasks/accounts. |
| `automated_preference_validation_share` | concept_field | Share of validation performed by telemetry, A/B testing, synthetic users, automated scoring, or recommendation systems | TCE-P012 criticism | Rising automated share can falsify broad experiencer-market claims. |
| `buyer_decision_impact` | concept_field | Whether human evaluation changed product, service, purchase, launch, certification, or ranking decisions | TCE-P012 | Required before compensated evaluation counts as meaningful experiencer evidence. |
| `producer_type` | concept_field | Producer of evaluated output: node, firm, AI labor service, human worker, or mixed | TCE-P012 | Needed to link evaluation work to AI or node production rather than generic research. |

## Bick/Blandin/Deming 2024 Fields

| Field | Status | Definition | Required For | Guardrail |
| --- | --- | --- | --- | --- |
| `worker_genai_use` | concept_field | Worker/adult GenAI use | adoption context | Worker-level context only. |
| `work_use_frequency` | concept_field | Use for work in previous week/every workday | adoption context | Not business outcome. |
| `self_reported_time_savings` | concept_field | Respondent-reported time savings | task/adoption context | Not transaction-cost or boundary evidence. |

## Blocked Fields

These fields are required for stronger claims but are not available in the
verified public sources inventoried here:

- `nonemployer_ai_use`
- `hidden_contractor_count`
- `unpaid_family_labor`
- `offshore_labor_use`
- `nonemployer_survival`
- `nonemployer_exit`
- `nonemployer_to_employer_transition`
- `client_retention`
- `repeat_revenue`
- `supplier_size`
- `vendor_substitution_flag`
- `procurement_cycle_time`
- `contracting_cost`
- `dispute_rate`
- `rework_rate`
- `payment_delay`
- `manager_headcount`
- `nonmanager_headcount`
- `manager_to_worker_ratio`
- `average_span_of_control`
- `org_chart_depth`
- `support_staff_ratio`
- `ai_labor_service_spend`
- `node_or_vendor_substitution_flag`

## Derived Outcome Candidates

| Field | Inputs | Required For | Interpretation Limit |
| --- | --- | --- | --- |
| `nonemployer_receipts_share` | NES/AIES-NES nonemployer revenue and employer revenue | TCE-P010 | Requires comparable employer/nonemployer table concepts. |
| `receipts_per_establishment_growth` | NES receipts per establishment by year | TCE-P001, TCE-P009 | Not revenue per human and not profit. |
| `small_employer_payroll_per_employee` | SUSB payroll and employment | TCE-P001, TCE-P010 | Employer baseline only. |
| `employer_formation_rate_proxy` | BFS formations and applications | TCE-P007, TCE-P009 | Not nonemployer conversion. |
| `employer_startup_shutdown_balance` | BDS startups and shutdowns | TCE-P009, TCE-P010 | Employer dynamics only. |
| `ai_exposure_cell` | BTOS/Bonney AI adoption by industry/size or verified exposure score | TCE-P001, TCE-P010 | Must identify source and unit before use. |

## Join-Key Candidates

| Join Key | Fields | Use | Risk |
| --- | --- | --- | --- |
| NAICS-year | `naics_code`, `year`, `naics_vintage` | First-pass panel | NAICS vintage changes and differing industry detail. |
| geography-NAICS-year | `geo_id`, `naics_code`, `year` | Subnational panel | Geography availability differs by source. |
| employer/nonemployer comparison cell | `naics_code`, `year`, `business_class` | AIES-NES comparison | Concepts and counts differ by class. |
| exposure cell | `naics_code`, `year`, `ai_exposure_cell` | Link adoption/exposure to outcomes | BTOS employer adoption may not represent nonemployer AI use. |
