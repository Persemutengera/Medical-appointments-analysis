CREATE DATABASE IF NOT EXISTS medical_appointments;

USE medical_appointments;

-- 1. Patient information
CREATE TABLE patients (
    patient_id BIGINT PRIMARY KEY,
    gender CHAR(1),
    age SMALLINT,
    scholarship TINYINT,
    hypertension TINYINT,
    diabetes TINYINT,
    alcoholism TINYINT,
    handicap TINYINT,
    CHECK (gender IN ('F', 'M')),
    CHECK (scholarship IN (0, 1)),
    CHECK (hypertension IN (0, 1)),
    CHECK (diabetes IN (0, 1)),
    CHECK (alcoholism IN (0, 1))
);

-- 2. Neighbourhood lookup
CREATE TABLE neighbourhoods (
    neighbourhood_id INT AUTO_INCREMENT PRIMARY KEY,
    neighbourhood_name VARCHAR(100) NOT NULL UNIQUE
);

-- 3. Appointment records
CREATE TABLE appointments (
    appointment_id BIGINT PRIMARY KEY,
    patient_id BIGINT NOT NULL,
    scheduled_day DATETIME NOT NULL,
    appointment_day DATETIME NOT NULL,
    neighbourhood_id INT,
    sms_received TINYINT,
    no_show VARCHAR(3) NOT NULL,

    CONSTRAINT fk_appointment_patient
        FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id),

    CONSTRAINT fk_appointment_neighbourhood
        FOREIGN KEY (neighbourhood_id)
        REFERENCES neighbourhoods(neighbourhood_id),

    CHECK (sms_received IN (0, 1)),
    CHECK (no_show IN ('Yes', 'No')),

    INDEX idx_patient_id (patient_id),
    INDEX idx_appointment_day (appointment_day),
    INDEX idx_no_show (no_show)
);

USE medical_appointments;

SELECT *
FROM stg_medical_appointments;

DESCRIBE stg_medical_appointments;

SELECT COUNT(*) AS total_rows
FROM stg_medical_appointments;

SELECT *
FROM stg_medical_appointments
LIMIT 20;

SELECT
    SUM(patientid IS NULL) AS missing_patientid,
    SUM(appointmentid IS NULL) AS missing_appointmentid,
    SUM(gender IS NULL OR TRIM(gender) = '') AS missing_gender,
    SUM(scheduledday IS NULL OR TRIM(scheduledday) = '') AS missing_scheduledday,
    SUM(appointmentday IS NULL OR TRIM(appointmentday) = '') AS missing_appointmentday,
    SUM(age IS NULL) AS missing_age,
    SUM(neighbourhood IS NULL OR TRIM(neighbourhood) = '') AS missing_neighbourhood,
    SUM(no_show IS NULL OR TRIM(no_show) = '') AS missing_no_show
FROM stg_medical_appointments;

DESCRIBE medical_appointments.stg_medical_appointments;

SELECT
    SUM(PatientId IS NULL) AS missing_patient_id,
    SUM(AppointmentID IS NULL) AS missing_appointment_id,
    SUM(Gender IS NULL OR TRIM(Gender) = '') AS missing_gender,
    SUM(ScheduledDay IS NULL OR TRIM(ScheduledDay) = '') AS missing_scheduled_day,
    SUM(AppointmentDay IS NULL OR TRIM(AppointmentDay) = '') AS missing_appointment_day,
    SUM(Age IS NULL) AS missing_age,
    SUM(Neighbourhood IS NULL OR TRIM(Neighbourhood) = '') AS missing_neighbourhood,
    SUM(Scholarship IS NULL) AS missing_scholarship,
    SUM(Hipertension IS NULL) AS missing_hypertension,
    SUM(Diabetes IS NULL) AS missing_diabetes,
    SUM(Alcoholism IS NULL) AS missing_alcoholism,
    SUM(Handcap IS NULL) AS missing_handicap,
    SUM(SMS_received IS NULL) AS missing_sms_received,
    SUM(`No-show` IS NULL OR TRIM(`No-show`) = '') AS missing_no_show
FROM stg_medical_appointments;

SELECT
    AppointmentID,
    COUNT(*) AS occurrences
FROM stg_medical_appointments
GROUP BY AppointmentID
HAVING COUNT(*) > 1
ORDER BY occurrences DESC;

SELECT
    Age,
    COUNT(*) AS occurrences
FROM stg_medical_appointments
GROUP BY Age
ORDER BY Age;

SELECT
    PatientId,
    AppointmentID,
    Age,
    Gender,
    ScheduledDay,
    AppointmentDay,
    Neighbourhood,
    `No-show`
FROM stg_medical_appointments
WHERE Age < 0 OR Age > 100
ORDER BY Age;

USE medical_appointments;

CREATE TABLE medical_appointments_clean AS
SELECT
    PatientId,
    AppointmentID,

    UPPER(TRIM(Gender)) AS Gender,

    STR_TO_DATE(
        REPLACE(TRIM(ScheduledDay), 'T', ' '),
        '%Y-%m-%d %H:%i:%sZ'
    ) AS ScheduledDay,

    STR_TO_DATE(
        REPLACE(TRIM(AppointmentDay), 'T', ' '),
        '%Y-%m-%d %H:%i:%sZ'
    ) AS AppointmentDay,

    CASE
        WHEN Age < 0 THEN NULL
        WHEN Age > 100 THEN NULL
        ELSE Age
    END AS Age,

    UPPER(TRIM(Neighbourhood)) AS Neighbourhood,

    Scholarship,
    Hipertension,
    Diabetes,
    Alcoholism,
    Handcap,
    SMS_received,

    UPPER(TRIM(`No-show`)) AS `No-show`,

    CASE
        WHEN Age < 0 THEN 'Invalid negative age'
        WHEN Age > 100 THEN 'Age above 100 - review'
        ELSE 'Valid age range'
    END AS Age_Quality_Flag

FROM stg_medical_appointments
WHERE AppointmentID IS NOT NULL;

SELECT
    (SELECT COUNT(*) FROM stg_medical_appointments)
        AS staging_rows,
    (SELECT COUNT(*) FROM medical_appointments_clean)
        AS cleaned_rows;
        
USE medical_appointments;

SHOW TABLES; 

SELECT COUNT(*) AS cleaned_rows
FROM medical_appointments_clean;    

SELECT
    ScheduledDay,
    AppointmentDay,
    Age,
    Age_Quality_Flag
FROM medical_appointments_clean
LIMIT 10;  

 SELECT
    (SELECT COUNT(*)
     FROM stg_medical_appointments) AS staging_rows,
    (SELECT COUNT(*)
     FROM medical_appointments_clean) AS cleaned_rows;
     
 SELECT
    Age_Quality_Flag,
    COUNT(*) AS total_records
FROM medical_appointments_clean
GROUP BY Age_Quality_Flag; 

SELECT
    COUNT(*) AS remaining_invalid_ages
FROM medical_appointments_clean
WHERE Age < 0 OR Age > 100;   

SELECT
    SUM(ScheduledDay IS NULL) AS missing_scheduled_dates,
    SUM(AppointmentDay IS NULL) AS missing_appointment_dates
FROM medical_appointments_clean;

SELECT
    AppointmentID,
    COUNT(*) AS occurrences
FROM medical_appointments_clean
GROUP BY AppointmentID
HAVING COUNT(*) > 1
ORDER BY occurrences DESC;

DESCRIBE medical_appointments_clean;

SELECT DISTINCT Gender
FROM medical_appointments_clean;

SELECT DISTINCT `No-show`
FROM medical_appointments_clean;

SELECT 'Scholarship' AS column_name, Scholarship AS value_found,
       COUNT(*) AS occurrences
FROM medical_appointments_clean
WHERE Scholarship NOT IN (0, 1)
GROUP BY Scholarship

UNION ALL

SELECT 'Hipertension', Hipertension, COUNT(*)
FROM medical_appointments_clean
WHERE Hipertension NOT IN (0, 1)
GROUP BY Hipertension

UNION ALL

SELECT 'Diabetes', Diabetes, COUNT(*)
FROM medical_appointments_clean
WHERE Diabetes NOT IN (0, 1)
GROUP BY Diabetes

UNION ALL

SELECT 'Alcoholism', Alcoholism, COUNT(*)
FROM medical_appointments_clean
WHERE Alcoholism NOT IN (0, 1)
GROUP BY Alcoholism

UNION ALL

SELECT 'SMS_received', SMS_received, COUNT(*)
FROM medical_appointments_clean
WHERE SMS_received NOT IN (0, 1)
GROUP BY SMS_received;

SELECT
    Age_Quality_Flag,
    COUNT(*) AS total_records
FROM medical_appointments_clean
GROUP BY Age_Quality_Flag
ORDER BY total_records DESC;

SELECT COUNT(*) AS remaining_invalid_ages
FROM medical_appointments_clean
WHERE Age < 0 OR Age > 100;

SELECT
    SUM(ScheduledDay IS NULL) AS missing_scheduled_dates,
    SUM(AppointmentDay IS NULL) AS missing_appointment_dates
FROM medical_appointments_clean;

SELECT COUNT(*) AS scheduled_after_appointment
FROM medical_appointments_clean
WHERE ScheduledDay > AppointmentDay;

SELECT
    COUNT(*) AS scheduled_after_appointment_date
FROM medical_appointments_clean
WHERE DATE(ScheduledDay) > DATE(AppointmentDay);

SELECT
    PatientId,
    AppointmentID,
    ScheduledDay,
    AppointmentDay,
    DATE(ScheduledDay) AS scheduled_date,
    DATE(AppointmentDay) AS appointment_date
FROM medical_appointments_clean
WHERE DATE(ScheduledDay) > DATE(AppointmentDay)
ORDER BY ScheduledDay
LIMIT 20;

SELECT
    COUNT(*) AS duplicate_appointment_ids
FROM (
    SELECT AppointmentID
    FROM medical_appointments_clean
    GROUP BY AppointmentID
    HAVING COUNT(*) > 1
) AS duplicates;

ALTER TABLE medical_appointments_clean
ADD COLUMN Date_Quality_Flag VARCHAR(40)
DEFAULT 'Valid date order';

SELECT
    Date_Quality_Flag,
    COUNT(*) AS total_records
FROM medical_appointments_clean
GROUP BY Date_Quality_Flag;

UPDATE medical_appointments_clean
SET Date_Quality_Flag =
    CASE
        WHEN DATE(ScheduledDay) > DATE(AppointmentDay)
            THEN 'Scheduled after appointment'
        ELSE 'Valid date order'
    END;
    
 SELECT
    Date_Quality_Flag,
    COUNT(*) AS total_records
FROM medical_appointments_clean
GROUP BY Date_Quality_Flag; 

SELECT
    Gender,
    COUNT(*) AS total_records
FROM medical_appointments_clean
GROUP BY Gender;  

SELECT
    `No-show`,
    COUNT(*) AS total_records
FROM medical_appointments_clean
GROUP BY `No-show`;

SELECT 'Scholarship' AS column_name,
       Scholarship AS invalid_value,
       COUNT(*) AS occurrences
FROM medical_appointments_clean
WHERE Scholarship NOT IN (0, 1)
   OR Scholarship IS NULL
GROUP BY Scholarship

UNION ALL

SELECT 'Hipertension', Hipertension, COUNT(*)
FROM medical_appointments_clean
WHERE Hipertension NOT IN (0, 1)
   OR Hipertension IS NULL
GROUP BY Hipertension

UNION ALL

SELECT 'Diabetes', Diabetes, COUNT(*)
FROM medical_appointments_clean
WHERE Diabetes NOT IN (0, 1)
   OR Diabetes IS NULL
GROUP BY Diabetes

UNION ALL

SELECT 'Alcoholism', Alcoholism, COUNT(*)
FROM medical_appointments_clean
WHERE Alcoholism NOT IN (0, 1)
   OR Alcoholism IS NULL
GROUP BY Alcoholism

UNION ALL

SELECT 'SMS_received', SMS_received, COUNT(*)
FROM medical_appointments_clean
WHERE SMS_received NOT IN (0, 1)
   OR SMS_received IS NULL
GROUP BY SMS_received;

SELECT
    Handcap,
    COUNT(*) AS total_records
FROM medical_appointments_clean
GROUP BY Handcap
ORDER BY Handcap;

SELECT
    SUM(PatientId IS NULL) AS missing_patient_id,
    SUM(AppointmentID IS NULL) AS missing_appointment_id,
    SUM(Gender IS NULL OR TRIM(Gender) = '') AS missing_gender,
    SUM(ScheduledDay IS NULL) AS missing_scheduled_day,
    SUM(AppointmentDay IS NULL) AS missing_appointment_day,
    SUM(Age IS NULL) AS missing_age,
    SUM(Neighbourhood IS NULL OR TRIM(Neighbourhood) = '') AS missing_neighbourhood,
    SUM(Scholarship IS NULL) AS missing_scholarship,
    SUM(Hipertension IS NULL) AS missing_hypertension,
    SUM(Diabetes IS NULL) AS missing_diabetes,
    SUM(Alcoholism IS NULL) AS missing_alcoholism,
    SUM(Handcap IS NULL) AS missing_handcap,
    SUM(SMS_received IS NULL) AS missing_sms_received,
    SUM(`No-show` IS NULL OR TRIM(`No-show`) = '') AS missing_no_show
FROM medical_appointments_clean;

SELECT DISTINCT Neighbourhood
FROM medical_appointments_clean
WHERE Neighbourhood LIKE '%Ã%'
ORDER BY Neighbourhood;

SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT AppointmentID) AS unique_appointment_ids,
    COUNT(DISTINCT PatientId) AS unique_patients
FROM medical_appointments_clean;

SELECT DISTINCT
    Neighbourhood AS original_name,
    CONVERT(
        CAST(
            CONVERT(Neighbourhood USING latin1)
            AS BINARY
        )
        USING utf8mb4
    ) AS proposed_name
FROM medical_appointments_clean
WHERE Neighbourhood LIKE '%Ã%'
   OR Neighbourhood LIKE '%Â%'
ORDER BY original_name;

USE medical_appointments;

SELECT DISTINCT
    Neighbourhood AS original_name,
    HEX(Neighbourhood) AS original_hex,
    LENGTH(Neighbourhood) AS byte_length,
    CHAR_LENGTH(Neighbourhood) AS character_length
FROM medical_appointments_clean
WHERE Neighbourhood LIKE '%Ã%'
   OR Neighbourhood LIKE '%Â%'
ORDER BY original_name
LIMIT 10;

SELECT DISTINCT
    Neighbourhood AS original_name,
    CONVERT(
        CAST(Neighbourhood AS BINARY)
        USING latin1
    ) AS test_result
FROM medical_appointments_clean
WHERE Neighbourhood IN (
    'ANTÃNIO HONÃRIO',
    'CONSOLAÃÃO',
    'FORTE SÃO JOÃO',
    'ROMÃO'
)
ORDER BY original_name;

USE medical_appointments;

SELECT DISTINCT
    Neighbourhood AS original_name,
    HEX(Neighbourhood) AS original_hex,
    CONVERT(
        CONVERT(
            CAST(Neighbourhood AS BINARY)
            USING utf8mb4
        )
        USING latin1
    ) AS test_result
FROM medical_appointments_clean
WHERE Neighbourhood IN (
    'ANTÃNIO HONÃRIO',
    'CONSOLAÃÃO',
    'FORTE SÃO JOÃO',
    'ROMÃO'
);

SHOW FULL COLUMNS
FROM medical_appointments_clean
LIKE 'Neighbourhood';

CREATE TABLE medical_appointments_clean_backup AS
SELECT *
FROM medical_appointments_clean;

SELECT
    (SELECT COUNT(*)
     FROM medical_appointments_clean) AS original_rows,
    (SELECT COUNT(*)
     FROM medical_appointments_clean_backup) AS backup_rows;
     
 SELECT
    Neighbourhood AS original_name,
    CASE Neighbourhood
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
        WHEN 'JOANA DÂ´ARC' THEN 'JOANA D’ARC'
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
    END AS proposed_name
FROM medical_appointments_clean
WHERE Neighbourhood LIKE '%Ã%'
   OR Neighbourhood LIKE '%Â%'
ORDER BY original_name
LIMIT 100;    
     
