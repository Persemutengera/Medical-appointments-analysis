# Data Quality Report — Medical Appointments

## 1. Purpose

This report documents the data-quality checks performed on the medical appointment dataset used in the Power BI attendance analysis. The goal is to make quality issues visible, explain how they were handled, and confirm that SQL results agree with the report's KPI cards.

## 2. Dataset Summary

- Source file: `KaggleV2-May-2016.csv`
- Database schema: `medical_appointments`
- Total records: **110,527**
- Main analysis table: `cleaned_medical_appointments`
- Quality-flag table: `medical_appointments_clean`
- Quality reporting view: `vw_appointments_with_quality`

The quality view joins the cleaned appointment records and their quality flags using `AppointmentID`.

## 3. Record Count and Outcome Validation

| Check | Count | Percentage of all records |
|---|---:|---:|
| Total appointments | 110,527 | 100.00% |
| Attended (`No-show = "No"`) | 88,208 | 79.81% |
| No-show (`No-show = "Yes"`) | 22,319 | 20.19% |

The attended and no-show counts sum to 110,527. The percentages are rounded to two decimal places.

## 4. Age Quality

The `Age_Quality_Flag` column is used to classify age values.

| Age quality category | Count | Percentage |
|---|---:|---:|
| Valid age range | 110,519 | 99.9928% |
| Invalid negative age | 1 | 0.0009% |
| Age above 100 — review | 7 | 0.0063% |
| **Total** | **110,527** | **100.0000%** |

### Handling and interpretation

- One record had `Age = -1`. In the cleaned data, the age was set to `NULL`, and the quality flag retained the reason: `Invalid negative age`.
- Seven records had ages above 100 and were flagged as `Age above 100 - review`.
- Ages above 100 are treated as review cases, not automatically confirmed errors.
- The counts were verified in SQL and reflected in Power BI cards:
  - `Valid Age Records` = 110,519
  - `Invalid Negative Ages` = 1
  - `Ages Above 100` = 7
  - `Age Review Count` = 8

The three mutually exclusive age categories sum to the full dataset total.

## 5. Date Quality

The `Date_Quality_Flag` column identifies whether the scheduling date precedes or matches the appointment date in the expected order, or whether the scheduled date is after the appointment date.

| Date quality category | Count | Percentage |
|---|---:|---:|
| Valid date order | 110,522 | 99.9955% |
| Scheduled after appointment | 5 | 0.0045% |
| **Total** | **110,527** | **100.0000%** |

### Handling and interpretation

- Five records were flagged because the scheduled date was later than the appointment date.
- These records should be reviewed and excluded from date-sensitive analysis when the project’s business rule requires valid date order.
- The quality view and Power BI cards were checked against SQL:
  - `Valid Date Records` = 110,522
  - `Invalid Date Records` = 5

## 6. Text Encoding Validation

Neighbourhood values were inspected for possible character-encoding corruption, including names containing Portuguese accented characters. A targeted corruption check returned **0 remaining corrupted rows**.

Examples of names checked included `CONSOLAÇÃO`, `FORTE SÃO JOÃO`, `ILHAS OCEÂNICAS DE TRINDADE`, `REDENÇÃO`, `ROMÃO`, `SÃO BENEDITO`, `SÃO CRISTÓVÃO`, `SÃO JOSÉ`, and `SÃO PEDRO`.

The check supports the conclusion that the inspected neighbourhood names were readable in the database. It does not, by itself, prove that every possible text field is free from encoding issues.

## 7. SQL Validation Queries

### Age quality distribution

```sql
SELECT
    Age_Quality_Flag,
    COUNT(*) AS Record_Count
FROM medical_appointments.medical_appointments_clean
GROUP BY Age_Quality_Flag
ORDER BY Record_Count DESC;
```

### Date quality distribution

```sql
SELECT
    Date_Quality_Flag,
    COUNT(*) AS Record_Count
FROM medical_appointments.vw_appointments_with_quality
GROUP BY Date_Quality_Flag
ORDER BY Record_Count DESC;
```

### Total records in the quality view

```sql
SELECT COUNT(*) AS Total_Records
FROM medical_appointments.vw_appointments_with_quality;
```

### Check for duplicate appointment identifiers

```sql
SELECT
    AppointmentID,
    COUNT(*) AS Record_Count
FROM medical_appointments.vw_appointments_with_quality
GROUP BY AppointmentID
HAVING COUNT(*) > 1;
```

The duplicate check should return no rows if `AppointmentID` is unique in the view.

## 8. Power BI Data Quality Page

The Data Quality page should include the following cards:

| Card | Expected value |
|---|---:|
| Total Appointment Records | 110,527 |
| Valid Age Records | 110,519 |
| Invalid Negative Ages | 1 |
| Ages Above 100 | 7 |
| Valid Date Records | 110,522 |
| Invalid Date Records | 5 |

Recommended charts:

- **Age Quality Breakdown:** Y-axis = `Age_Quality_Flag`; X-axis = record count.
- **Date Quality Breakdown:** Y-axis = `Date_Quality_Flag`; X-axis = record count.

Recommended slicers are Age Quality Status and Date Quality Status. A Gender slicer may be added if it supports the intended investigation and space allows.

Use the quality-flag table/view for quality charts. Avoid filtering out flagged records from these charts, because the purpose is to display both valid and flagged records.

## 9. Important Counting Note

Age and date quality checks are independent. A single appointment could potentially have both an age issue and a date issue. Therefore, **do not add the 8 age-review records to the 5 date-issue records and report 13 unique affected appointments** unless you query the overlap and count distinct `AppointmentID` values.

## 10. Limitations and Follow-up

- Confirm the five date-order records against the original source before deciding whether to correct or exclude them.
- Review ages above 100 against the source or domain context before treating them as errors.
- Keep the original source data unchanged and document transformations in SQL.
- Re-run record-count, uniqueness, age, date, and encoding checks after any refresh or additional cleaning.
- Confirm that Power BI measures use a consistent appointment grain and that slicers do not unintentionally hide data-quality exceptions.

## 11. Conclusion

The current validation confirms 110,527 records in the quality view, with 8 age records flagged for review and 5 date-order records flagged for review. The age and date category totals reconcile to the full dataset independently. SQL results and Power BI KPI cards agree for the checks documented above.

