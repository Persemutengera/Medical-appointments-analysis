# Medical Appointment Attendance Analysis

## Project Overview

This project analyses medical appointment records to understand appointment attendance and no-shows, examine data quality, and communicate findings through SQL and a Power BI report.

The project uses the Kaggle **Medical Appointment No Shows** dataset, commonly distributed as `KaggleV2-May-2016.csv`. The dataset contains appointment and patient attributes, scheduling dates, neighbourhood, scholarship status, SMS reminder information, and the `No-show` outcome.

The report is designed to answer questions such as:

- What proportion of appointments were attended or missed?
- How do attendance patterns vary by appointment lead time and day of the week?
- How do no-show rates compare for patients who did and did not receive SMS reminders?
- Do attendance patterns differ across patient groups or neighbourhoods?
- What data-quality issues should be considered before interpreting the results?

## Tools and Technologies

- **MySQL Workbench 8.0.47** — data storage, SQL validation, and data-quality checks
- **MySQL** — staging and cleaned tables, quality flags, and a reporting view
- **Microsoft Power BI** — KPI cards, slicers, charts, and report pages
- **DAX** — attendance, no-show, and data-quality measures
- **CSV** — original source data

## Dataset

Source file: `KaggleV2-May-2016.csv`

The dataset contains **110,527 appointment records** in the current project. The source fields include appointment and patient identifiers, gender, scheduled and appointment dates, age, neighbourhood, scholarship status, hypertension, diabetes, alcoholism, handicap status, SMS receipt, and the no-show outcome.

## Project Workflow

1. Import the original CSV into a staging table.
2. Validate column types, record counts, identifiers, date fields, age values, and text encoding.
3. Create cleaned appointment data for analysis.
4. Preserve data-quality findings in quality flags.
5. Use SQL to investigate data-quality categories and validate totals.
6. Connect Power BI to the cleaned data and the quality view.
7. Build appointment overview, attendance analysis, data-quality, and insight pages.
8. Document findings and recommendations, and avoid presenting associations as proof of causation.

## Database Objects

The project has used the following objects in the `medical_appointments` schema:

| Object | Purpose |
|---|---|
| `stg_medical_appointments` | Staging table for imported source data |
| `cleaned_medical_appointments` | Cleaned appointment data used by the existing Power BI report |
| `medical_appointments_clean` | Cleaned/validated data containing `Age_Quality_Flag` and `Date_Quality_Flag` |
| `vw_appointments_with_quality` | SQL view combining the cleaned appointment records with the age and date quality flags |

The view is based on matching records by `AppointmentID`. The current Power BI model includes a table named `medical_appointments vw_appointments_with_quality` for the quality visuals.

## Key Validated Results

Current SQL and Power BI checks have confirmed the following:

| Check | Result |
|---|---:|
| Total appointment records | 110,527 |
| Attended appointments (`No-show = "No"`) | 88,208 |
| Missed appointments (`No-show = "Yes"`) | 22,319 |
| Attendance rate | 79.81% |
| No-show rate | 20.19% |
| Valid age records | 110,519 |
| Negative ages flagged for review | 1 |
| Ages above 100 flagged for review | 7 |
| Valid date-order records | 110,522 |
| Records where scheduled date is after appointment date | 5 |

The age categories total 110,527 records. The date categories also total 110,527 records. Age and date issues are separate checks, so their issue counts must not be added to claim a count of unique affected appointments without checking overlap.

## Data Quality Approach

- The single negative age was changed to `NULL` in the cleaned data and retained as a flagged quality issue.
- Seven records with ages above 100 are flagged for review rather than automatically assumed to be errors.
- Five records have a scheduled date later than the appointment date and are flagged for review.
- Neighbourhood text was checked for encoding corruption; targeted checks returned zero remaining corrupted rows.
- Counts were compared between SQL and Power BI to verify the quality cards.

See [`data_quality_report.md`](data_quality_report.md) for the current quality results and interpretation.

## Power BI Report

The report contains pages for appointment overview, attendance analysis, data quality, and insights/recommendations. The exact page names and order can be adjusted to match the final `.pbix` file.

Suggested report components:

- KPI cards for total appointments, attendance rate, and no-show rate
- Attendance analysis by lead time, day of week, SMS reminder status, scholarship status, age group, and neighbourhood where relevant
- Data-quality cards for valid and flagged age/date records
- Slicers that support the analysis without hiding the quality issues being reported
- A key findings and recommendations section

## Example DAX Measures

Adjust field names if your local Power BI model uses different names.

```dax
Total Appointments =
DISTINCTCOUNT('cleaned_medical_appointments'[AppointmentID])
```

```dax
Attendance Rate (%) =
DIVIDE(
    CALCULATE(
        COUNTROWS('cleaned_medical_appointments'),
        'cleaned_medical_appointments'[No-show] = "No"
    ),
    COUNTROWS('cleaned_medical_appointments'),
    0
)
```

```dax
No-show Rate (%) =
DIVIDE(
    CALCULATE(
        COUNTROWS('cleaned_medical_appointments'),
        'cleaned_medical_appointments'[No-show] = "Yes"
    ),
    COUNTROWS('cleaned_medical_appointments'),
    0
)
```

Format the rate measures as percentages with two decimal places. If the report uses filters that can create duplicate rows, verify that the numerator and denominator use a consistent appointment grain.

## Repository Structure
``` text
medical-appointments-analysis/
├── README.md
├── LICENSE
├── .gitignore
├── data/
│   ├── README.md
│   └── data_dictionary.md
├── sql/
│   ├── 01_create_database_and_tables.sql
│   ├── 02_data_import.sql
│   ├── 03_data_cleaning.sql
│   ├── 04_data_quality_checks.sql
│   ├── 05_exploratory_analysis.sql
│   └── 06_business_insights.sql
├── powerbi/
│   ├── Medical_Appointments_Dashboard.pbix
│   ├── dax_measures.md
│   ├── calculated_columns.md
│   └── data_model.md
├── images/
|   ├── insights and recommendations.png
│   ├── data-quality.png
│   ├── appointment-overview.png
│   └── attendance-analysis.png
└── reports/
    ├── data_quality_report.md
    ├── key_findings.md
    └── recommendations.md
```

## Reproducing the project

1.  Download the source dataset from its original source.
2.  Create the `medical_appointments` schema in MySQL Workbench.
3.  Follow the SQL scripts in numeric order, adapting table names and
    import paths to your machine.
4.  Connect Power BI Desktop to the cleaned table.
5.  Confirm the `Valid Appointment = 1` filter is applied consistently.
6.  Recheck the KPI totals and rates against the figures above.
7.  Save the final report as
    `powerbi/Medical_Appointments_Dashboard.pbix` and export screenshots
    to `images/`.

## Limitations

-   The dataset is observational; differences between groups do not
    establish causation.
-   SMS receipt should not be interpreted as the cause of a no-show
    based on this analysis alone.
-   Neighbourhood patterns may reflect factors not included in the
    dataset.
-   Age anomalies and missing values require explicit handling and
    disclosure.
-   Do not publish patient-level exports or personal identifiers.

## Author

/**Perseverance Mutengera**\
Data Analytics Portfolio Project
