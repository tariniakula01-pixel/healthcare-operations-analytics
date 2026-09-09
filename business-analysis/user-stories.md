# User Stories & Acceptance Criteria

## Purpose

The following user stories translate the identified business requirements into actionable analytical and reporting capabilities.

---

## US-001 — Executive Performance Overview

**As a** healthcare operations leader,  
**I want** to view key appointment performance metrics in one place,  
**so that** I can quickly understand overall operational performance and identify areas requiring attention.

**Related Requirement:** BR-001, BR-002

### Acceptance Criteria

- Total appointment volume is displayed.
- Completed appointment volume is displayed.
- Completion rate is displayed.
- Cancellation rate is displayed.
- No-show rate is displayed.
- Metrics are calculated consistently using documented KPI definitions.
- Users can identify the overall operational performance without reviewing raw data.

---

## US-002 — Analyze Missed Appointments

**As a** clinic manager,  
**I want** to analyze cancellation and no-show patterns by specialty, location, and appointment type,  
**so that** I can identify areas with higher levels of missed appointments.

**Related Requirement:** BR-003, BR-004

### Acceptance Criteria

- Cancellation and no-show rates can be compared across specialties.
- Cancellation and no-show rates can be compared across locations.
- Appointment types can be analyzed separately.
- Results clearly identify higher-performing and lower-performing segments.
- The analysis uses a consistent calculation method.

---

## US-003 — Analyze Patient Wait Times

**As a** clinic manager,  
**I want** to compare patient wait times across locations and specialties,  
**so that** I can identify operational bottlenecks affecting patient experience.

**Related Requirement:** BR-005

### Acceptance Criteria

- Average wait time is calculated for completed appointments.
- Wait time can be analyzed by location.
- Wait time can be analyzed by specialty.
- Areas with relatively high wait times can be identified.
- Cancelled and no-show appointments do not distort the completed-appointment wait-time metric.

---

## US-004 — Evaluate Scheduling Lead Time

**As a** patient access manager,  
**I want** to understand how scheduling lead time relates to missed appointments,  
**so that** I can identify potential opportunities to improve appointment scheduling practices.

**Related Requirement:** BR-004, BR-007

### Acceptance Criteria

- Appointments can be grouped by scheduling lead-time ranges.
- No-show rates can be compared across lead-time ranges.
- Cancellation rates can be compared across lead-time ranges.
- The analysis clearly distinguishes correlation from causation.
- Findings are supported by the available dataset.

---

## US-005 — Analyze Provider Workload

**As a** provider operations manager,  
**I want** to view appointment volume and appointment duration by provider,  
**so that** I can understand workload patterns and identify potential capacity issues.

**Related Requirement:** BR-006

### Acceptance Criteria

- Appointment volume can be analyzed by provider.
- Appointment duration can be analyzed by provider.
- Provider-level results can be compared.
- The analysis highlights meaningful differences in workload patterns.

---

## US-006 — Monitor Appointment Trends

**As a** healthcare operations leader,  
**I want** to view appointment performance trends over time,  
**so that** I can identify changes in demand and operational performance.

**Related Requirement:** BR-001, BR-002

### Acceptance Criteria

- Appointment volume can be viewed over time.
- Completion, cancellation, and no-show rates can be viewed over time.
- Trends can be filtered by relevant business dimensions.
- Significant changes can be identified from the visualization.

---

## US-007 — Review Patient Satisfaction

**As a** healthcare operations leader,  
**I want** to understand how patient satisfaction varies with wait time,  
**so that** I can evaluate the potential impact of operational delays on patient experience.

**Related Requirement:** BR-005, BR-008

### Acceptance Criteria

- Average satisfaction is calculated for completed appointments.
- Satisfaction can be compared across wait-time ranges.
- The analysis identifies observable patterns between wait time and satisfaction.
- Findings are presented as analytical observations rather than unsupported causal claims.

---

## US-008 — Identify Improvement Opportunities

**As a** business operations stakeholder,  
**I want** the analysis to identify the most significant operational improvement opportunities,  
**so that** leadership can prioritize potential actions.

**Related Requirement:** BR-008

### Acceptance Criteria

- Improvement opportunities are supported by analysis.
- Each recommendation references an identified business issue or KPI.
- Recommendations are specific and actionable.
- Recommendations are prioritized based on potential business impact.
- Recommendations do not claim outcomes that have not been validated.

---

# Definition of Done

A user story is considered complete when:

1. The related data is available and validated.
2. The required KPI or analysis has been defined.
3. The SQL analysis has been completed where applicable.
4. The required dashboard visualization has been created where applicable.
5. Results have been reviewed for accuracy.
6. The resulting insight or recommendation is documented.
