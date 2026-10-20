SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT AppointmentID) AS unique_appointments,
    SUM(ScheduledDay IS NULL) AS null_scheduled_dates,
    SUM(AppointmentDay IS NULL) AS null_appointment_dates,
    MIN(ScheduledDay) AS earliest_scheduled,
    MAX(ScheduledDay) AS latest_scheduled,
    MIN(AppointmentDay) AS earliest_appointment,
    MAX(AppointmentDay) AS latest_appointment
FROM medical_appointments.cleaned_medical_appointments;

DESCRIBE medical_appointments.cleaned_medical_appointments;

SELECT
    Gender,
    COUNT(*) AS total_records
FROM medical_appointments.cleaned_medical_appointments
GROUP BY Gender
ORDER BY total_records DESC;

SELECT
    COUNT(*) AS total_records,
    MIN(Age) AS minimum_age,
    MAX(Age) AS maximum_age,
    SUM(Age < 0) AS negative_ages,
    SUM(Age = 0) AS zero_ages,
    SUM(Age IS NULL) AS missing_ages
FROM medical_appointments.cleaned_medical_appointments;

SELECT
    Gender,
    `No-show`,
    COUNT(*) AS total_records
FROM medical_appointments.cleaned_medical_appointments
WHERE Age = 0
GROUP BY Gender, `No-show`
ORDER BY Gender, `No-show`;

UPDATE medical_appointments.cleaned_medical_appointments
SET Age = NULL
WHERE Age = 0;

SELECT
    COUNT(*) AS total_records,
    SUM(Age = 0) AS zero_ages,
    SUM(Age < 0) AS negative_ages,
    SUM(Age IS NULL) AS missing_ages
FROM medical_appointments.cleaned_medical_appointments;

SELECT
    'Scholarship' AS column_name,
    SUM(Scholarship NOT IN (0, 1)) AS unexpected_values,
    SUM(Scholarship IS NULL) AS missing_values
FROM medical_appointments.cleaned_medical_appointments

UNION ALL

SELECT
    'Hipertension',
    SUM(Hipertension NOT IN (0, 1)),
    SUM(Hipertension IS NULL)
FROM medical_appointments.cleaned_medical_appointments

UNION ALL

SELECT
    'Diabetes',
    SUM(Diabetes NOT IN (0, 1)),
    SUM(Diabetes IS NULL)
FROM medical_appointments.cleaned_medical_appointments

UNION ALL

SELECT
    'Alcoholism',
    SUM(Alcoholism NOT IN (0, 1)),
    SUM(Alcoholism IS NULL)
FROM medical_appointments.cleaned_medical_appointments

UNION ALL

SELECT
    'Handcap',
    SUM(Handcap NOT IN (0, 1)),
    SUM(Handcap IS NULL)
FROM medical_appointments.cleaned_medical_appointments

UNION ALL

SELECT
    'SMS_received',
    SUM(SMS_received NOT IN (0, 1)),
    SUM(SMS_received IS NULL)
FROM medical_appointments.cleaned_medical_appointments;

SELECT
    Handcap,
    COUNT(*) AS total_records
FROM medical_appointments.cleaned_medical_appointments
GROUP BY Handcap
ORDER BY Handcap;

SELECT
    `No-show` AS appointment_outcome,
    COUNT(*) AS total_records
FROM medical_appointments.cleaned_medical_appointments
GROUP BY `No-show`
ORDER BY `No-show`;

SELECT
    COUNT(*) AS total_records,
    SUM(PatientId IS NULL) AS missing_patient_ids,
    SUM(AppointmentID IS NULL) AS missing_appointment_ids,
    COUNT(DISTINCT PatientId) AS unique_patients,
    COUNT(DISTINCT AppointmentID) AS unique_appointments
FROM medical_appointments.cleaned_medical_appointments;

SELECT
    PatientId,
    AppointmentID,
    COUNT(*) AS record_count
FROM medical_appointments.cleaned_medical_appointments
GROUP BY PatientId, AppointmentID
HAVING COUNT(*) > 1;

SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT Neighbourhood) AS unique_neighbourhoods,
    SUM(Neighbourhood IS NULL) AS missing_neighbourhoods,
    SUM(TRIM(Neighbourhood) = '') AS blank_neighbourhoods
FROM medical_appointments.cleaned_medical_appointments;

SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT AppointmentID) AS unique_appointments,
    COUNT(DISTINCT PatientId) AS unique_patients,
    COUNT(DISTINCT Neighbourhood) AS unique_neighbourhoods,
    SUM(Age IS NULL) AS missing_ages,
    SUM(Age < 0) AS negative_ages,
    SUM(Age = 0) AS zero_ages,
    SUM(`No-show` IS NULL) AS missing_outcomes,
    SUM(ScheduledDay IS NULL) AS missing_scheduled_dates,
    SUM(AppointmentDay IS NULL) AS missing_appointment_dates
FROM medical_appointments.cleaned_medical_appointments;

SELECT
    SUM(Scholarship NOT IN (0, 1)) AS invalid_scholarship,
    SUM(Hipertension NOT IN (0, 1)) AS invalid_hipertension,
    SUM(Diabetes NOT IN (0, 1)) AS invalid_diabetes,
    SUM(Alcoholism NOT IN (0, 1)) AS invalid_alcoholism,
    SUM(Handcap NOT BETWEEN 0 AND 4) AS invalid_handcap,
    SUM(SMS_received NOT IN (0, 1)) AS invalid_sms_received
FROM medical_appointments.cleaned_medical_appointments;
