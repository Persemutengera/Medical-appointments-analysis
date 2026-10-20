SHOW GLOBAL VARIABLES LIKE 'local_infile';

SET GLOBAL local_infile = 1;

SHOW GLOBAL VARIABLES LIKE 'local_infile';

SHOW GLOBAL VARIABLES LIKE 'local_infile';


LOAD DATA LOCAL INFILE
'C:/Users/Perseverance/Downloads/KaggleV2-May-2016-UTF8.csv'
INTO TABLE medical_appointments.stg_medical_appointments
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    PatientId,
    AppointmentID,
    Gender,
    ScheduledDay,
    AppointmentDay,
    Age,
    Neighbourhood,
    Scholarship,
    Hipertension,
    Diabetes,
    Alcoholism,
    Handcap,
    SMS_received,
    `No-show`
);
