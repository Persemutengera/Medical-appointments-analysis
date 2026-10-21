# Medical Appointment Data Analysis: Key Findings

This document summarizes the core data metrics and quality findings from the initial analysis of the medical appointment dataset. **The total number of scheduled appointments analyzed is 110,527.**

## Executive Summary
The primary focus of this analysis is to evaluate attendance rates and identify data quality anomalies to optimize scheduling efficiency. 

* **Total Appointments:** 110,527
* **Attended Appointments:** 88,208 (79.81%)
* **Missed Appointments:** 22,319 (20.19%)

---

## Data Quality Findings (Verified SQL Results)
The following data integrity issues were definitively identified and flagged during the SQL data profiling phase:

### 1. Age Anomalies
* **Negative Age:** 1 record was flagged with an age below 0 (-1).
* **Extreme Ages:** 7 records were flagged with patient ages recorded as above 100.
* *Status:* **Verified.** These 8 records require immediate manual review or data cleaning.

### 2. Chronological Inconsistencies
* **Date Mismatch:** 5 records were discovered where the `ScheduledDate` occurs *after* the actual `AppointmentDate`.
* *Status:* **Verified.** This is a logical impossibility likely caused by system logging errors or manual entry overrides.

---

## Hypotheses & Patterns to Investigate (Power BI Validation Needed)
While the baseline metrics are verified, the following operational patterns require deeper exploration and confirmation using Power BI visual charts:

* **Lead Time Impact:** Investigate if longer waiting periods between the booking date and the actual appointment correlate with higher no-show rates.
* **SMS Reminders:** Analyze whether sending text alerts reliably reduces missed appointments, and determine the optimal timing for these reminders.
* **Weekday Variance:** Evaluate attendance trends across different days of the week to pinpoint specific days (e.g., Mondays or Fridays) that experience a spike in missed appointments.
* **Social Benefits (Scholarship Status):** Explore if enrollment in welfare or scholarship programs affects a patient's ability to keep their appointments.
* **Demographic Clusters (Age Groups & Neighbourhoods):** Map out no-show rates across specific age brackets and geographical locations to identify localized or age-specific barriers to attendance.
