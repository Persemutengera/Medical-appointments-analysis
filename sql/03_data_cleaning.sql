USE medical_appointments;

SELECT DISTINCT
    Neighbourhood AS original_name
FROM medical_appointments_clean
WHERE
    CAST(Neighbourhood AS BINARY)
        LIKE CAST('%Ã%' AS BINARY)
    OR CAST(Neighbourhood AS BINARY)
        LIKE CAST('%Â%' AS BINARY)
ORDER BY original_name;

USE medical_appointments;

UPDATE medical_appointments_clean
SET Neighbourhood = CASE
    WHEN BINARY Neighbourhood = BINARY 'ANTÃNIO HONÃRIO'
        THEN 'ANTÔNIO HONÓRIO'
    WHEN BINARY Neighbourhood = BINARY 'CARATOÃRA'
        THEN 'CARATOÍRA'
    WHEN BINARY Neighbourhood = BINARY 'CONSOLAÃÃO'
        THEN 'CONSOLAÇÃO'
    WHEN BINARY Neighbourhood = BINARY 'ENSEADA DO SUÃ'
        THEN 'ENSEADA DO SUÁ'
    WHEN BINARY Neighbourhood = BINARY 'FORTE SÃO JOÃO'
        THEN 'FORTE SÃO JOÃO'
    WHEN BINARY Neighbourhood = BINARY 'GRANDE VITÃRIA'
        THEN 'GRANDE VITÓRIA'
    WHEN BINARY Neighbourhood = BINARY 'ILHA DO PRÃNCIPE'
        THEN 'ILHA DO PRÍNCIPE'
    WHEN BINARY Neighbourhood = BINARY 'ILHAS OCEÃNICAS DE TRINDADE'
        THEN 'ILHAS OCEÂNICAS DE TRINDADE'
    WHEN BINARY Neighbourhood = BINARY 'INHANGUETÃ'
        THEN 'INHANGUETÁ'
    WHEN BINARY Neighbourhood = BINARY 'ITARARÃ'
        THEN 'ITARARÉ'
    WHEN BINARY Neighbourhood = BINARY 'JOANA DÂ´ARC'
        THEN 'JOANA D’ARC'
    WHEN BINARY Neighbourhood = BINARY 'MÃRIO CYPRESTE'
        THEN 'MÁRIO CYPRESTE'
    WHEN BINARY Neighbourhood = BINARY 'MARUÃPE'
        THEN 'MARUÍPE'
    WHEN BINARY Neighbourhood = BINARY 'PRAIA DO SUÃ'
        THEN 'PRAIA DO SUÁ'
    WHEN BINARY Neighbourhood = BINARY 'REDENÃÃO'
        THEN 'REDENÇÃO'
    WHEN BINARY Neighbourhood = BINARY 'REPÃBLICA'
        THEN 'REPÚBLICA'
    WHEN BINARY Neighbourhood = BINARY 'RESISTÃNCIA'
        THEN 'RESISTÊNCIA'
    WHEN BINARY Neighbourhood = BINARY 'ROMÃO'
        THEN 'ROMÃO'
    WHEN BINARY Neighbourhood = BINARY 'SANTA CECÃLIA'
        THEN 'SANTA CECÍLIA'
    WHEN BINARY Neighbourhood = BINARY 'SANTA LÃCIA'
        THEN 'SANTA LÚCIA'
    WHEN BINARY Neighbourhood = BINARY 'SANTA LUÃZA'
        THEN 'SANTA LUÍZA'
    WHEN BINARY Neighbourhood = BINARY 'SANTO ANDRÃ'
        THEN 'SANTO ANDRÉ'
    WHEN BINARY Neighbourhood = BINARY 'SANTO ANTÃNIO'
        THEN 'SANTO ANTÔNIO'
    WHEN BINARY Neighbourhood = BINARY 'SÃO BENEDITO'
        THEN 'SÃO BENEDITO'
    WHEN BINARY Neighbourhood = BINARY 'SÃO CRISTÃVÃO'
        THEN 'SÃO CRISTÓVÃO'
    WHEN BINARY Neighbourhood = BINARY 'SÃO JOSÃ'
        THEN 'SÃO JOSÉ'
    WHEN BINARY Neighbourhood = BINARY 'SÃO PEDRO'
        THEN 'SÃO PEDRO'
    WHEN BINARY Neighbourhood = BINARY 'SEGURANÃA DO LAR'
        THEN 'SEGURANÇA DO LAR'
    WHEN BINARY Neighbourhood = BINARY 'UNIVERSITÃRIO'
        THEN 'UNIVERSITÁRIO'
    ELSE Neighbourhood
END
WHERE
    BINARY Neighbourhood = BINARY 'ANTÃNIO HONÃRIO'
    OR BINARY Neighbourhood = BINARY 'CARATOÃRA'
    OR BINARY Neighbourhood = BINARY 'CONSOLAÃÃO'
    OR BINARY Neighbourhood = BINARY 'ENSEADA DO SUÃ'
    OR BINARY Neighbourhood = BINARY 'FORTE SÃO JOÃO'
    OR BINARY Neighbourhood = BINARY 'GRANDE VITÃRIA'
    OR BINARY Neighbourhood = BINARY 'ILHA DO PRÃNCIPE'
    OR BINARY Neighbourhood = BINARY 'ILHAS OCEÃNICAS DE TRINDADE'
    OR BINARY Neighbourhood = BINARY 'INHANGUETÃ'
    OR BINARY Neighbourhood = BINARY 'ITARARÃ'
    OR BINARY Neighbourhood = BINARY 'JOANA DÂ´ARC'
    OR BINARY Neighbourhood = BINARY 'MÃRIO CYPRESTE'
    OR BINARY Neighbourhood = BINARY 'MARUÃPE'
    OR BINARY Neighbourhood = BINARY 'PRAIA DO SUÃ'
    OR BINARY Neighbourhood = BINARY 'REDENÃÃO'
    OR BINARY Neighbourhood = BINARY 'REPÃBLICA'
    OR BINARY Neighbourhood = BINARY 'RESISTÃNCIA'
    OR BINARY Neighbourhood = BINARY 'ROMÃO'
    OR BINARY Neighbourhood = BINARY 'SANTA CECÃLIA'
    OR BINARY Neighbourhood = BINARY 'SANTA LÃCIA'
    OR BINARY Neighbourhood = BINARY 'SANTA LUÃZA'
    OR BINARY Neighbourhood = BINARY 'SANTO ANDRÃ'
    OR BINARY Neighbourhood = BINARY 'SANTO ANTÃNIO'
    OR BINARY Neighbourhood = BINARY 'SÃO BENEDITO'
    OR BINARY Neighbourhood = BINARY 'SÃO CRISTÃVÃO'
    OR BINARY Neighbourhood = BINARY 'SÃO JOSÃ'
    OR BINARY Neighbourhood = BINARY 'SÃO PEDRO'
    OR BINARY Neighbourhood = BINARY 'SEGURANÃA DO LAR';
    
    SELECT DISTINCT Neighbourhood
FROM medical_appointments_clean
WHERE
    CAST(Neighbourhood AS BINARY)
        LIKE CAST('%Ã%' AS BINARY)
    OR CAST(Neighbourhood AS BINARY)
        LIKE CAST('%Â%' AS BINARY)
ORDER BY Neighbourhood;

SELECT
    Neighbourhood,
    COUNT(*) AS row_count
FROM medical_appointments_clean
GROUP BY Neighbourhood
ORDER BY Neighbourhood;

USE medical_appointments;

UPDATE medical_appointments_clean
SET Neighbourhood = 'UNIVERSITÁRIO'
WHERE Neighbourhood = 'UNIVERSITÃRIO';

SELECT DISTINCT Neighbourhood
FROM medical_appointments_clean
WHERE CAST(Neighbourhood AS BINARY)
          LIKE CAST('%Ã%' AS BINARY)
   OR CAST(Neighbourhood AS BINARY)
          LIKE CAST('%Â%' AS BINARY)
ORDER BY Neighbourhood;

USE medical_appointments;

SELECT DISTINCT Neighbourhood
FROM medical_appointments_clean
WHERE Neighbourhood LIKE '%Ã%'
   OR Neighbourhood LIKE '%Â%'
ORDER BY Neighbourhood;

SELECT COUNT(*) AS remaining_corrupted_rows
FROM medical_appointments_clean
WHERE CAST(Neighbourhood AS BINARY)
    = CAST('UNIVERSITÃRIO' AS BINARY);
    
SELECT COUNT(*) AS total_rows
FROM medical_appointments_clean; 

SELECT DISTINCT Neighbourhood
FROM medical_appointments_clean
WHERE CAST(Neighbourhood AS BINARY) LIKE CAST('%Ã%' AS BINARY)
   OR CAST(Neighbourhood AS BINARY) LIKE CAST('%Â%' AS BINARY)
ORDER BY Neighbourhood;   

SELECT DISTINCT Neighbourhood
FROM medical_appointments_clean
WHERE Neighbourhood IN (
    'CONSOLAÇÃO',
    'FORTE SÃO JOÃO',
    'ILHAS OCEÂNICAS DE TRINDADE',
    'REDENÇÃO',
    'ROMÃO',
    'SÃO BENEDITO',
    'SÃO CRISTÓVÃO',
    'SÃO JOSÉ',
    'SÃO PEDRO'
)
ORDER BY Neighbourhood;

SELECT
    NEIGHBORHOOD,
    COUNT(*) AS total_rows
FROM medical_appointments.stg_medical_appointments
WHERE NEIGHBORHOOD IN (
    'CONSOLACAO',
    'CONSOLAÇÃO',
    'FORTE SÃO JOÃO',
    'ILHAS OCEÂNICAS DE TRINDADE',
    'REDENÇÃO',
    'ROMÃO',
    'SÃO BENEDITO',
    'SÃO CRISTÓVÃO',
    'SÃO JOSÉ',
    'SÃO PEDRO'
)
GROUP BY NEIGHBORHOOD
ORDER BY NEIGHBORHOOD;

DESCRIBE medical_appointments.stg_medical_appointments;

SELECT
    Neighbourhood,
    COUNT(*) AS total_rows
FROM medical_appointments.stg_medical_appointments
WHERE Neighbourhood IN (
    'CONSOLACAO',
    'CONSOLAÇÃO',
    'FORTE SÃO JOÃO',
    'ILHAS OCEÂNICAS DE TRINDADE',
    'REDENÇÃO',
    'ROMÃO',
    'SÃO BENEDITO',
    'SÃO CRISTÓVÃO',
    'SÃO JOSÉ',
    'SÃO PEDRO'
)
GROUP BY Neighbourhood
ORDER BY Neighbourhood;

SELECT
    Neighbourhood,
    COUNT(*) AS total_rows
FROM medical_appointments.stg_medical_appointments
WHERE Neighbourhood LIKE '%Ã%'
   OR Neighbourhood LIKE '%Â%'
GROUP BY Neighbourhood
ORDER BY Neighbourhood;

CREATE TABLE medical_appointments.stg_medical_appointments_backup
AS
SELECT *
FROM medical_appointments.stg_medical_appointments;

UPDATE medical_appointments.stg_medical_appointments
SET Neighbourhood = CASE Neighbourhood
    WHEN 'ANTÃNIO HONÃRIO' THEN 'ANTÔNIO HONÓRIO'
    WHEN 'CARATOÃRA' THEN 'CARATOÍRA'
    WHEN 'CONSOLAÃÃO' THEN 'CONSOLAÇÃO'
    WHEN 'ENSEADA DO SUÃ' THEN 'ENSEADA DO SUÁ'
    WHEN 'FORTE SÃO JOÃO' THEN 'FORTE SÃO JOÃO'
    WHEN 'GRANDE VITÃRIA' THEN 'GRANDE VITÓRIA'
    WHEN 'ILHA DO PRÃNCIPE' THEN 'ILHA DO PRÍNCIPE'
    WHEN 'ILHAS OCEÃNICAS DE TRINDADE'
        THEN 'ILHAS OCEÂNICAS DE TRINDADE'
    WHEN 'INHANGUETÃ' THEN 'INHANGUETÁ'
    WHEN 'ITARARÃ' THEN 'ITARARÉ'
    WHEN 'JOANA DÂ´ARC' THEN 'JOANA D''ARC'
    WHEN 'MÃRIO CYPRESTE' THEN 'MÁRIO CYPRESTE'
    WHEN 'MARUÃPE' THEN 'MARUÍPE'
    WHEN 'PRAIA DO SUÃ' THEN 'PRAIA DO SUÁ'
    WHEN 'REDENÃÃO' THEN 'REDENÇÃO'
    WHEN 'REPÃBLICA' THEN 'REPÚBLICA'
    WHEN 'RESISTÃNCIA' THEN 'RESISTÊNCIA'
    WHEN 'ROMÃO' THEN 'ROMÃO'
    WHEN 'SANTA CECÃLIA' THEN 'SANTA CECÍLIA'
    WHEN 'SANTA LÃCIA' THEN 'SANTA LÚCIA'
    WHEN 'SANTA LUÃZA' THEN 'SANTA LUÍZA'
    WHEN 'SANTO ANDRÃ' THEN 'SANTO ANDRÉ'
    WHEN 'SANTO ANTÃNIO' THEN 'SANTO ANTÔNIO'
    WHEN 'SÃO BENEDITO' THEN 'SÃO BENEDITO'
    WHEN 'SÃO CRISTÃVÃO' THEN 'SÃO CRISTÓVÃO'
    WHEN 'SÃO JOSÃ' THEN 'SÃO JOSÉ'
    WHEN 'SÃO PEDRO' THEN 'SÃO PEDRO'
    WHEN 'SEGURANÃA DO LAR' THEN 'SEGURANÇA DO LAR'
    WHEN 'UNIVERSITÃRIO' THEN 'UNIVERSITÁRIO'
    ELSE Neighbourhood
END
WHERE Neighbourhood IN (
    'ANTÃNIO HONÃRIO',
    'CARATOÃRA',
    'CONSOLAÃÃO',
    'ENSEADA DO SUÃ',
    'FORTE SÃO JOÃO',
    'GRANDE VITÃRIA',
    'ILHA DO PRÃNCIPE',
    'ILHAS OCEÃNICAS DE TRINDADE',
    'INHANGUETÃ',
    'ITARARÃ',
    'JOANA DÂ´ARC',
    'MÃRIO CYPRESTE',
    'MARUÃPE',
    'PRAIA DO SUÃ',
    'REDENÃÃO',
    'REPÃBLICA',
    'RESISTÃNCIA',
    'ROMÃO',
    'SANTA CECÃLIA',
    'SANTA LÃCIA',
    'SANTA LUÃZA',
    'SANTO ANDRÃ',
    'SANTO ANTÃNIO',
    'SÃO BENEDITO',
    'SÃO CRISTÃVÃO',
    'SÃO JOSÃ',
    'SÃO PEDRO',
    'SEGURANÃA DO LAR',
    'UNIVERSITÃRIO'
);

SELECT
    Neighbourhood,
    COUNT(*) AS total_rows
FROM medical_appointments.stg_medical_appointments
WHERE Neighbourhood LIKE '%Ã%'
   OR Neighbourhood LIKE '%Â%'
GROUP BY Neighbourhood
ORDER BY Neighbourhood;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT Neighbourhood) AS distinct_neighbourhoods
FROM medical_appointments.stg_medical_appointments;

SELECT
    Neighbourhood,
    COUNT(*) AS total_rows
FROM medical_appointments.stg_medical_appointments
WHERE Neighbourhood LIKE '%Ã%'
   OR Neighbourhood LIKE '%Â%'
GROUP BY Neighbourhood;

SELECT
    Neighbourhood,
    COUNT(*) AS total_rows,
    HEX(Neighbourhood) AS neighbourhood_hex
FROM medical_appointments.stg_medical_appointments
GROUP BY Neighbourhood
ORDER BY Neighbourhood;

SHOW CREATE TABLE medical_appointments.stg_medical_appointments;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT Neighbourhood) AS distinct_neighbourhoods,
    SUM(Neighbourhood IS NULL) AS null_neighbourhoods,
    SUM(TRIM(Neighbourhood) = '') AS blank_neighbourhoods
FROM medical_appointments.stg_medical_appointments;

SELECT
    MIN(Age) AS minimum_age,
    MAX(Age) AS maximum_age,
    SUM(Age < 0) AS negative_ages,
    SUM(Age = 0) AS zero_ages,
    SUM(Age IS NULL) AS null_ages
FROM medical_appointments.stg_medical_appointments;

SELECT
    PatientId,
    AppointmentID,
    Gender,
    ScheduledDay,
    AppointmentDay,
    Age,
    Neighbourhood,
    `No-show`
FROM medical_appointments.stg_medical_appointments
WHERE Age < 0;

SELECT
    Age,
    COUNT(*) AS total_rows
FROM medical_appointments.stg_medical_appointments
WHERE Age = 0
GROUP BY Age;

UPDATE medical_appointments.stg_medical_appointments
SET Age = NULL
WHERE PatientId = 465943158731293
  AND AppointmentID = 5775010
  AND Age = -1;
  
SELECT
    COUNT(*) AS total_rows,
    SUM(Age < 0) AS negative_ages,
    SUM(Age IS NULL) AS null_ages,
    SUM(Age = 0) AS zero_ages
FROM medical_appointments.stg_medical_appointments;

SELECT
    ScheduledDay,
    AppointmentDay
FROM medical_appointments.stg_medical_appointments
LIMIT 10;

SELECT
    COUNT(*) AS total_rows,

    SUM(
        STR_TO_DATE(
            REPLACE(REPLACE(ScheduledDay, 'T', ' '), 'Z', ''),
            '%Y-%m-%d %H:%i:%s'
        ) IS NULL
    ) AS invalid_scheduled_dates,

    SUM(
        STR_TO_DATE(
            REPLACE(REPLACE(AppointmentDay, 'T', ' '), 'Z', ''),
            '%Y-%m-%d %H:%i:%s'
        ) IS NULL
    ) AS invalid_appointment_dates

FROM medical_appointments.stg_medical_appointments;

SELECT
    COUNT(*) AS total_rows,
    SUM(
        DATE(
            STR_TO_DATE(
                REPLACE(REPLACE(ScheduledDay, 'T', ' '), 'Z', ''),
                '%Y-%m-%d %H:%i:%s'
            )
        ) >
        DATE(
            STR_TO_DATE(
                REPLACE(REPLACE(AppointmentDay, 'T', ' '), 'Z', ''),
                '%Y-%m-%d %H:%i:%s'
            )
        )
    ) AS appointment_before_scheduled_date
FROM medical_appointments.stg_medical_appointments;

SELECT
    PatientId,
    AppointmentID,
    ScheduledDay,
    AppointmentDay,
    Age,
    Neighbourhood,
    `No-show`
FROM medical_appointments.stg_medical_appointments
WHERE DATE(
    STR_TO_DATE(
        REPLACE(REPLACE(ScheduledDay, 'T', ' '), 'Z', ''),
        '%Y-%m-%d %H:%i:%s'
    )
) > DATE(
    STR_TO_DATE(
        REPLACE(REPLACE(AppointmentDay, 'T', ' '), 'Z', ''),
        '%Y-%m-%d %H:%i:%s'
    )
)
ORDER BY AppointmentDay;

SELECT
    COUNT(*) AS total_rows,
    SUM(
        STR_TO_DATE(
            REPLACE(REPLACE(ScheduledDay, 'T', ' '), 'Z', ''),
            '%Y-%m-%d %H:%i:%s'
        )
        >
        STR_TO_DATE(
            REPLACE(REPLACE(AppointmentDay, 'T', ' '), 'Z', ''),
            '%Y-%m-%d %H:%i:%s'
        )
    ) AS scheduled_timestamp_after_appointment_timestamp
FROM medical_appointments.stg_medical_appointments;

CREATE TABLE medical_appointments.cleaned_medical_appointments AS
SELECT
    PatientId,
    AppointmentID,
    Gender,
    STR_TO_DATE(
        REPLACE(REPLACE(ScheduledDay, 'T', ' '), 'Z', ''),
        '%Y-%m-%d %H:%i:%s'
    ) AS ScheduledDay,
    DATE(
        STR_TO_DATE(
            REPLACE(REPLACE(AppointmentDay, 'T', ' '), 'Z', ''),
            '%Y-%m-%d %H:%i:%s'
        )
    ) AS AppointmentDay,
    Age,
    Neighbourhood,
    Scholarship,
    Hipertension,
    Diabetes,
    Alcoholism,
    Handcap,
    SMS_received,
    `No-show`
FROM medical_appointments.stg_medical_appointments;

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
