-- Exploratory Data Analysis

SELECT
    `No-show` AS appointment_outcome,
    COUNT(*) AS total_appointments,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*)
         FROM medical_appointments.cleaned_medical_appointments),
        2
    ) AS percentage
FROM medical_appointments.cleaned_medical_appointments
GROUP BY `No-show`
ORDER BY total_appointments DESC;

SELECT
    CASE
        WHEN Age BETWEEN 1 AND 12 THEN '01. Children (1-12)'
        WHEN Age BETWEEN 13 AND 17 THEN '02. Teenagers (13-17)'
        WHEN Age BETWEEN 18 AND 35 THEN '03. Young adults (18-35)'
        WHEN Age BETWEEN 36 AND 59 THEN '04. Adults (36-59)'
        WHEN Age BETWEEN 60 AND 115 THEN '05. Seniors (60+)'
    END AS age_group,

    COUNT(*) AS total_appointments,

    SUM(`No-show` = 'Yes') AS missed_appointments,

    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct

FROM medical_appointments.cleaned_medical_appointments
WHERE Age BETWEEN 1 AND 115
GROUP BY
    CASE
        WHEN Age BETWEEN 1 AND 12 THEN '01. Children (1-12)'
        WHEN Age BETWEEN 13 AND 17 THEN '02. Teenagers (13-17)'
        WHEN Age BETWEEN 18 AND 35 THEN '03. Young adults (18-35)'
        WHEN Age BETWEEN 36 AND 59 THEN '04. Adults (36-59)'
        WHEN Age BETWEEN 60 AND 115 THEN '05. Seniors (60+)'
    END
ORDER BY age_group;



SELECT
    Gender,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
GROUP BY Gender
ORDER BY no_show_rate_pct DESC;

SELECT
    CASE
        WHEN DATEDIFF(AppointmentDay, DATE(ScheduledDay)) = 0
            THEN '01. Same day'
        WHEN DATEDIFF(AppointmentDay, DATE(ScheduledDay)) BETWEEN 1 AND 7
            THEN '02. 1-7 days'
        WHEN DATEDIFF(AppointmentDay, DATE(ScheduledDay)) BETWEEN 8 AND 14
            THEN '03. 8-14 days'
        WHEN DATEDIFF(AppointmentDay, DATE(ScheduledDay)) BETWEEN 15 AND 30
            THEN '04. 15-30 days'
        ELSE '05. Over 30 days'
    END AS waiting_time_group,

    COUNT(*) AS total_appointments,
    
SELECT
    Neighbourhood,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
GROUP BY Neighbourhood
HAVING COUNT(*) >= 500
ORDER BY missed_appointments DESC
LIMIT 10;

SELECT
    Neighbourhood,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
GROUP BY Neighbourhood
HAVING COUNT(*) >= 500
ORDER BY missed_appointments DESC
LIMIT 10;

    SUM(`No-show` = 'Yes') AS missed_appointments,

    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct

FROM medical_appointments.cleaned_medical_appointments

WHERE AppointmentDay >= DATE(ScheduledDay)

GROUP BY waiting_time_group
ORDER BY waiting_time_group;

SELECT
    SMS_received,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
GROUP BY SMS_received
ORDER BY SMS_received;

SELECT
    CASE
        WHEN DATEDIFF(AppointmentDay, DATE(ScheduledDay)) = 0
            THEN '01. Same day'
        WHEN DATEDIFF(AppointmentDay, DATE(ScheduledDay)) BETWEEN 1 AND 7
            THEN '02. 1-7 days'
        WHEN DATEDIFF(AppointmentDay, DATE(ScheduledDay)) BETWEEN 8 AND 14
            THEN '03. 8-14 days'
        WHEN DATEDIFF(AppointmentDay, DATE(ScheduledDay)) BETWEEN 15 AND 30
            THEN '04. 15-30 days'
        ELSE '05. Over 30 days'
    END AS waiting_time_group,

    SMS_received,

    COUNT(*) AS total_appointments,

    SUM(`No-show` = 'Yes') AS missed_appointments,

    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct

FROM medical_appointments.cleaned_medical_appointments

WHERE AppointmentDay >= DATE(ScheduledDay)

GROUP BY
    CASE
        WHEN DATEDIFF(AppointmentDay, DATE(ScheduledDay)) = 0
            THEN '01. Same day'
        WHEN DATEDIFF(AppointmentDay, DATE(ScheduledDay)) BETWEEN 1 AND 7
            THEN '02. 1-7 days'
        WHEN DATEDIFF(AppointmentDay, DATE(ScheduledDay)) BETWEEN 8 AND 14
            THEN '03. 8-14 days'
        WHEN DATEDIFF(AppointmentDay, DATE(ScheduledDay)) BETWEEN 15 AND 30
            THEN '04. 15-30 days'
        ELSE '05. Over 30 days'
    END,
    SMS_received

ORDER BY waiting_time_group, SMS_received;

WITH neighbourhood_stats AS (
    SELECT
        Neighbourhood,
        COUNT(*) AS total_appointments,
        SUM(`No-show` = 'Yes') AS missed_appointments,
        ROUND(
            SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
            2
        ) AS no_show_rate_pct
    FROM medical_appointments.cleaned_medical_appointments
    WHERE AppointmentDay >= DATE(ScheduledDay)
    GROUP BY Neighbourhood
),
top_neighbourhoods AS (
    SELECT *
    FROM neighbourhood_stats
    ORDER BY total_appointments DESC
    LIMIT 10
)
SELECT
    Neighbourhood,
    total_appointments,
    missed_appointments,
    no_show_rate_pct
FROM top_neighbourhoods
ORDER BY no_show_rate_pct DESC;

SELECT
    Scholarship,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
GROUP BY Scholarship
ORDER BY Scholarship;

SELECT
    Hipertension,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
GROUP BY Hipertension
ORDER BY Hipertension;

SELECT
    Diabetes,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
GROUP BY Diabetes
ORDER BY Diabetes;

SELECT
    Alcoholism,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
GROUP BY Alcoholism
ORDER BY Alcoholism;

SELECT
    Handcap,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
GROUP BY Handcap
ORDER BY Handcap;

SELECT
    CASE
        WHEN Age BETWEEN 1 AND 12 THEN 'Children (1-12)'
        WHEN Age BETWEEN 13 AND 17 THEN 'Teenagers (13-17)'
        WHEN Age BETWEEN 18 AND 35 THEN 'Young adults (18-35)'
        WHEN Age BETWEEN 36 AND 59 THEN 'Adults (36-59)'
        WHEN Age >= 60 THEN 'Seniors (60+)'
    END AS age_group,
    SMS_received,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
  AND Age BETWEEN 1 AND 115
GROUP BY age_group, SMS_received
ORDER BY
    CASE age_group
        WHEN 'Children (1-12)' THEN 1
        WHEN 'Teenagers (13-17)' THEN 2
        WHEN 'Young adults (18-35)' THEN 3
        WHEN 'Adults (36-59)' THEN 4
        WHEN 'Seniors (60+)' THEN 5
    END,
    SMS_received;
    
    SELECT
    DAYNAME(AppointmentDay) AS appointment_day,
    DAYOFWEEK(AppointmentDay) AS day_number,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
GROUP BY
    DAYNAME(AppointmentDay),
    DAYOFWEEK(AppointmentDay)
ORDER BY day_number;

SELECT
    MONTH(AppointmentDay) AS appointment_month,
    MONTHNAME(AppointmentDay) AS month_name,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
GROUP BY
    MONTH(AppointmentDay),
    MONTHNAME(AppointmentDay)
ORDER BY appointment_month;

SELECT
    CASE
        WHEN Age BETWEEN 1 AND 12 THEN 'Children (1-12)'
        WHEN Age BETWEEN 13 AND 17 THEN 'Teenagers (13-17)'
        WHEN Age BETWEEN 18 AND 35 THEN 'Young adults (18-35)'
        WHEN Age BETWEEN 36 AND 59 THEN 'Adults (36-59)'
        WHEN Age >= 60 THEN 'Seniors (60+)'
    END AS age_group,
    Gender,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
  AND Age BETWEEN 1 AND 115
GROUP BY age_group, Gender
ORDER BY
    CASE age_group
        WHEN 'Children (1-12)' THEN 1
        WHEN 'Teenagers (13-17)' THEN 2
        WHEN 'Young adults (18-35)' THEN 3
        WHEN 'Adults (36-59)' THEN 4
        WHEN 'Seniors (60+)' THEN 5
    END,
    Gender;
    
    SELECT
    CASE
        WHEN Age BETWEEN 1 AND 12 THEN 'Children (1-12)'
        WHEN Age BETWEEN 13 AND 17 THEN 'Teenagers (13-17)'
        WHEN Age BETWEEN 18 AND 35 THEN 'Young adults (18-35)'
        WHEN Age BETWEEN 36 AND 59 THEN 'Adults (36-59)'
        WHEN Age >= 60 THEN 'Seniors (60+)'
    END AS age_group,
    CASE
        WHEN DATEDIFF(
            AppointmentDay,
            DATE(ScheduledDay)
        ) = 0 THEN 'Same day'
        WHEN DATEDIFF(
            AppointmentDay,
            DATE(ScheduledDay)
        ) BETWEEN 1 AND 7 THEN '1-7 days'
        WHEN DATEDIFF(
            AppointmentDay,
            DATE(ScheduledDay)
        ) BETWEEN 8 AND 14 THEN '8-14 days'
        WHEN DATEDIFF(
            AppointmentDay,
            DATE(ScheduledDay)
        ) BETWEEN 15 AND 30 THEN '15-30 days'
        ELSE 'Over 30 days'
    END AS waiting_time_group,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
  AND Age BETWEEN 1 AND 115
GROUP BY age_group, waiting_time_group
ORDER BY
    CASE age_group
        WHEN 'Children (1-12)' THEN 1
        WHEN 'Teenagers (13-17)' THEN 2
        WHEN 'Young adults (18-35)' THEN 3
        WHEN 'Adults (36-59)' THEN 4
        WHEN 'Seniors (60+)' THEN 5
    END,
    CASE waiting_time_group
        WHEN 'Same day' THEN 1
        WHEN '1-7 days' THEN 2
        WHEN '8-14 days' THEN 3
        WHEN '15-30 days' THEN 4
        WHEN 'Over 30 days' THEN 5
    END;
    
    SELECT
    `No-show` AS appointment_outcome,
    COUNT(*) AS total_appointments,
    ROUND(
        AVG(
            DATEDIFF(
                AppointmentDay,
                DATE(ScheduledDay)
            )
        ),
        2
    ) AS average_waiting_days,
    ROUND(
        MIN(
            DATEDIFF(
                AppointmentDay,
                DATE(ScheduledDay)
            )
        ),
        2
    ) AS minimum_waiting_days,
    MAX(
        DATEDIFF(
            AppointmentDay,
            DATE(ScheduledDay)
        )
    ) AS maximum_waiting_days
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
GROUP BY `No-show`
ORDER BY `No-show`;

SELECT
    `No-show` AS appointment_outcome,
    COUNT(*) AS total_appointments,
    ROUND(
        AVG(
            DATEDIFF(
                AppointmentDay,
                DATE(ScheduledDay)
            )
        ),
        2
    ) AS average_waiting_days,
    MIN(
        DATEDIFF(
            AppointmentDay,
            DATE(ScheduledDay)
        )
    ) AS minimum_waiting_days,
    MAX(
        DATEDIFF(
            AppointmentDay,
            DATE(ScheduledDay)
        )
    ) AS maximum_waiting_days
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
GROUP BY `No-show`
ORDER BY `No-show`;

SELECT
    DATEDIFF(
        AppointmentDay,
        DATE(ScheduledDay)
    ) AS waiting_days,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
GROUP BY waiting_days
HAVING total_appointments >= 100
ORDER BY waiting_days;

SELECT
    CASE
        WHEN DATEDIFF(
            AppointmentDay,
            DATE(ScheduledDay)
        ) = 0 THEN '0. Same day'
        WHEN DATEDIFF(
            AppointmentDay,
            DATE(ScheduledDay)
        ) BETWEEN 1 AND 7 THEN '1. 1-7 days'
        WHEN DATEDIFF(
            AppointmentDay,
            DATE(ScheduledDay)
        ) BETWEEN 8 AND 14 THEN '2. 8-14 days'
        WHEN DATEDIFF(
            AppointmentDay,
            DATE(ScheduledDay)
        ) BETWEEN 15 AND 30 THEN '3. 15-30 days'
        ELSE '4. Over 30 days'
    END AS waiting_time_group,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
GROUP BY waiting_time_group
ORDER BY waiting_time_group;

SELECT
    CASE
        WHEN DATEDIFF(
            AppointmentDay,
            DATE(ScheduledDay)
        ) = 0 THEN '0. Same day'
        WHEN DATEDIFF(
            AppointmentDay,
            DATE(ScheduledDay)
        ) BETWEEN 1 AND 7 THEN '1. 1-7 days'
        WHEN DATEDIFF(
            AppointmentDay,
            DATE(ScheduledDay)
        ) BETWEEN 8 AND 14 THEN '2. 8-14 days'
        WHEN DATEDIFF(
            AppointmentDay,
            DATE(ScheduledDay)
        ) BETWEEN 15 AND 30 THEN '3. 15-30 days'
        ELSE '4. Over 30 days'
    END AS waiting_time_group,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
GROUP BY waiting_time_group
ORDER BY waiting_time_group;

SELECT
    DAYNAME(AppointmentDay) AS appointment_weekday,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
GROUP BY DAYOFWEEK(AppointmentDay), DAYNAME(AppointmentDay)
ORDER BY DAYOFWEEK(AppointmentDay);

SELECT
    MONTHNAME(AppointmentDay) AS appointment_month,
    MONTH(AppointmentDay) AS month_number,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
GROUP BY MONTH(AppointmentDay), MONTHNAME(AppointmentDay)
ORDER BY month_number;

SELECT
    CASE
        WHEN Age BETWEEN 1 AND 12 THEN 'Children (1-12)'
        WHEN Age BETWEEN 13 AND 17 THEN 'Teenagers (13-17)'
        WHEN Age BETWEEN 18 AND 35 THEN 'Young adults (18-35)'
        WHEN Age BETWEEN 36 AND 59 THEN 'Adults (36-59)'
        WHEN Age >= 60 THEN 'Seniors (60+)'
    END AS age_group,
    Gender,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
  AND Age BETWEEN 1 AND 115
GROUP BY
    CASE
        WHEN Age BETWEEN 1 AND 12 THEN 'Children (1-12)'
        WHEN Age BETWEEN 13 AND 17 THEN 'Teenagers (13-17)'
        WHEN Age BETWEEN 18 AND 35 THEN 'Young adults (18-35)'
        WHEN Age BETWEEN 36 AND 59 THEN 'Adults (36-59)'
        WHEN Age >= 60 THEN 'Seniors (60+)'
    END,
    Gender
ORDER BY
    MIN(
        CASE
            WHEN Age BETWEEN 1 AND 12 THEN 1
            WHEN Age BETWEEN 13 AND 17 THEN 2
            WHEN Age BETWEEN 18 AND 35 THEN 3
            WHEN Age BETWEEN 36 AND 59 THEN 4
            WHEN Age >= 60 THEN 5
        END
    ),
    Gender;
    
 SELECT
    CASE
        WHEN Age BETWEEN 1 AND 12 THEN 'Children (1-12)'
        WHEN Age BETWEEN 13 AND 17 THEN 'Teenagers (13-17)'
        WHEN Age BETWEEN 18 AND 35 THEN 'Young adults (18-35)'
        WHEN Age BETWEEN 36 AND 59 THEN 'Adults (36-59)'
        WHEN Age >= 60 THEN 'Seniors (60+)'
    END AS age_group,
    CASE
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) = 0 THEN '0. Same day'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 1 AND 7 THEN '1. 1-7 days'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 8 AND 14 THEN '2. 8-14 days'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 15 AND 30 THEN '3. 15-30 days'
        ELSE '4. Over 30 days'
    END AS waiting_time_group,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
  AND Age BETWEEN 1 AND 115
GROUP BY
    CASE
        WHEN Age BETWEEN 1 AND 12 THEN 'Children (1-12)'
        WHEN Age BETWEEN 13 AND 17 THEN 'Teenagers (13-17)'
        WHEN Age BETWEEN 18 AND 35 THEN 'Young adults (18-35)'
        WHEN Age BETWEEN 36 AND 59 THEN 'Adults (36-59)'
        WHEN Age >= 60 THEN 'Seniors (60+)'
    END,
    CASE
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) = 0 THEN '0. Same day'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 1 AND 7 THEN '1. 1-7 days'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 8 AND 14 THEN '2. 8-14 days'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 15 AND 30 THEN '3. 15-30 days'
        ELSE '4. Over 30 days'
    END
ORDER BY
    MIN(
        CASE
            WHEN Age BETWEEN 1 AND 12 THEN 1
            WHEN Age BETWEEN 13 AND 17 THEN 2
            WHEN Age BETWEEN 18 AND 35 THEN 3
            WHEN Age BETWEEN 36 AND 59 THEN 4
            WHEN Age >= 60 THEN 5
        END
    ),
    MIN(DATEDIFF(AppointmentDay, DATE(ScheduledDay)));   
    
 SELECT
    `No-show` AS appointment_outcome,
    COUNT(*) AS total_appointments,
    ROUND(
        AVG(DATEDIFF(
            AppointmentDay,
            DATE(ScheduledDay)
        )),
        2
    ) AS average_waiting_days,
    MIN(DATEDIFF(
        AppointmentDay,
        DATE(ScheduledDay)
    )) AS minimum_waiting_days,
    MAX(DATEDIFF(
        AppointmentDay,
        DATE(ScheduledDay)
    )) AS maximum_waiting_days
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
GROUP BY `No-show`
ORDER BY `No-show`;  

SELECT
    CASE
        WHEN Age BETWEEN 1 AND 12 THEN 'Children (1-12)'
        WHEN Age BETWEEN 13 AND 17 THEN 'Teenagers (13-17)'
        WHEN Age BETWEEN 18 AND 35 THEN 'Young adults (18-35)'
        WHEN Age BETWEEN 36 AND 59 THEN 'Adults (36-59)'
        WHEN Age >= 60 THEN 'Seniors (60+)'
    END AS age_group,
    SMS_received,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
  AND Age BETWEEN 1 AND 115
GROUP BY
    CASE
        WHEN Age BETWEEN 1 AND 12 THEN 'Children (1-12)'
        WHEN Age BETWEEN 13 AND 17 THEN 'Teenagers (13-17)'
        WHEN Age BETWEEN 18 AND 35 THEN 'Young adults (18-35)'
        WHEN Age BETWEEN 36 AND 59 THEN 'Adults (36-59)'
        WHEN Age >= 60 THEN 'Seniors (60+)'
    END,
    SMS_received
ORDER BY
    MIN(
        CASE
            WHEN Age BETWEEN 1 AND 12 THEN 1
            WHEN Age BETWEEN 13 AND 17 THEN 2
            WHEN Age BETWEEN 18 AND 35 THEN 3
            WHEN Age BETWEEN 36 AND 59 THEN 4
            WHEN Age >= 60 THEN 5
        END
    ),
    SMS_received; 
    
    SELECT
    CASE
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) = 0 THEN '0. Same day'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 1 AND 7 THEN '1. 1-7 days'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 8 AND 14 THEN '2. 8-14 days'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 15 AND 30 THEN '3. 15-30 days'
        ELSE '4. Over 30 days'
    END AS waiting_time_group,
    SMS_received,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
GROUP BY
    CASE
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) = 0 THEN '0. Same day'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 1 AND 7 THEN '1. 1-7 days'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 8 AND 14 THEN '2. 8-14 days'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 15 AND 30 THEN '3. 15-30 days'
        ELSE '4. Over 30 days'
    END,
    SMS_received
ORDER BY
    MIN(DATEDIFF(AppointmentDay, DATE(ScheduledDay))),
    SMS_received;
    
    SELECT
    Neighbourhood,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
GROUP BY Neighbourhood
HAVING COUNT(*) >= 500
ORDER BY no_show_rate_pct DESC
LIMIT 10;

SELECT
    Neighbourhood,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
GROUP BY Neighbourhood
HAVING COUNT(*) >= 500
ORDER BY missed_appointments DESC
LIMIT 10;

SELECT
    Neighbourhood,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
GROUP BY Neighbourhood
HAVING COUNT(*) >= 500
ORDER BY
    SUM(`No-show` = 'Yes') * 1.0 / COUNT(*) ASC
LIMIT 10;

SELECT
    Neighbourhood,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
GROUP BY Neighbourhood
HAVING COUNT(*) >= 500
ORDER BY
    SUM(`No-show` = 'Yes') * 1.0 / COUNT(*) ASC
LIMIT 10;

SELECT
    Scholarship,
    CASE
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) = 0 THEN '0. Same day'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 1 AND 7 THEN '1. 1-7 days'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 8 AND 14 THEN '2. 8-14 days'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 15 AND 30 THEN '3. 15-30 days'
        ELSE '4. Over 30 days'
    END AS waiting_time_group,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
GROUP BY
    Scholarship,
    CASE
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) = 0 THEN '0. Same day'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 1 AND 7 THEN '1. 1-7 days'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 8 AND 14 THEN '2. 8-14 days'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 15 AND 30 THEN '3. 15-30 days'
        ELSE '4. Over 30 days'
    END
ORDER BY
    Scholarship,
    MIN(DATEDIFF(AppointmentDay, DATE(ScheduledDay)));
    
SELECT
    Hipertension,
    CASE
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) = 0 THEN '0. Same day'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 1 AND 7 THEN '1. 1-7 days'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 8 AND 14 THEN '2. 8-14 days'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 15 AND 30 THEN '3. 15-30 days'
        ELSE '4. Over 30 days'
    END AS waiting_time_group,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
GROUP BY
    Hipertension,
    CASE
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) = 0 THEN '0. Same day'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 1 AND 7 THEN '1. 1-7 days'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 8 AND 14 THEN '2. 8-14 days'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 15 AND 30 THEN '3. 15-30 days'
        ELSE '4. Over 30 days'
    END
ORDER BY
    Hipertension,
    MIN(DATEDIFF(AppointmentDay, DATE(ScheduledDay)));
    
SELECT
    Diabetes,
    CASE
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) = 0 THEN '0. Same day'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 1 AND 7 THEN '1. 1-7 days'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 8 AND 14 THEN '2. 8-14 days'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 15 AND 30 THEN '3. 15-30 days'
        ELSE '4. Over 30 days'
    END AS waiting_time_group,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
GROUP BY
    Diabetes,
    CASE
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) = 0 THEN '0. Same day'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 1 AND 7 THEN '1. 1-7 days'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 8 AND 14 THEN '2. 8-14 days'
        WHEN DATEDIFF(
            AppointmentDay, DATE(ScheduledDay)
        ) BETWEEN 15 AND 30 THEN '3. 15-30 days'
        ELSE '4. Over 30 days'
    END
ORDER BY
    Diabetes,
    MIN(DATEDIFF(AppointmentDay, DATE(ScheduledDay)));
    
 SELECT
    Alcoholism,
    CASE
        WHEN DATEDIFF(AppointmentDay, DATE(ScheduledDay)) = 0
            THEN '0. Same day'
        WHEN DATEDIFF(AppointmentDay, DATE(ScheduledDay)) BETWEEN 1 AND 7
            THEN '1. 1-7 days'
        WHEN DATEDIFF(AppointmentDay, DATE(ScheduledDay)) BETWEEN 8 AND 14
            THEN '2. 8-14 days'
        WHEN DATEDIFF(AppointmentDay, DATE(ScheduledDay)) BETWEEN 15 AND 30
            THEN '3. 15-30 days'
        ELSE '4. Over 30 days'
    END AS waiting_time_group,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
GROUP BY
    Alcoholism,
    CASE
        WHEN DATEDIFF(AppointmentDay, DATE(ScheduledDay)) = 0
            THEN '0. Same day'
        WHEN DATEDIFF(AppointmentDay, DATE(ScheduledDay)) BETWEEN 1 AND 7
            THEN '1. 1-7 days'
        WHEN DATEDIFF(AppointmentDay, DATE(ScheduledDay)) BETWEEN 8 AND 14
            THEN '2. 8-14 days'
        WHEN DATEDIFF(AppointmentDay, DATE(ScheduledDay)) BETWEEN 15 AND 30
            THEN '3. 15-30 days'
        ELSE '4. Over 30 days'
    END
ORDER BY
    Alcoholism,
    MIN(DATEDIFF(AppointmentDay, DATE(ScheduledDay)));   
    
    SELECT
    Handcap,
    CASE
        WHEN DATEDIFF(AppointmentDay, DATE(ScheduledDay)) = 0
            THEN '0. Same day'
        WHEN DATEDIFF(AppointmentDay, DATE(ScheduledDay)) BETWEEN 1 AND 7
            THEN '1. 1-7 days'
        WHEN DATEDIFF(AppointmentDay, DATE(ScheduledDay)) BETWEEN 8 AND 14
            THEN '2. 8-14 days'
        WHEN DATEDIFF(AppointmentDay, DATE(ScheduledDay)) BETWEEN 15 AND 30
            THEN '3. 15-30 days'
        ELSE '4. Over 30 days'
    END AS waiting_time_group,
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay)
GROUP BY
    Handcap,
    CASE
        WHEN DATEDIFF(AppointmentDay, DATE(ScheduledDay)) = 0
            THEN '0. Same day'
        WHEN DATEDIFF(AppointmentDay, DATE(ScheduledDay)) BETWEEN 1 AND 7
            THEN '1. 1-7 days'
        WHEN DATEDIFF(AppointmentDay, DATE(ScheduledDay)) BETWEEN 8 AND 14
            THEN '2. 8-14 days'
        WHEN DATEDIFF(AppointmentDay, DATE(ScheduledDay)) BETWEEN 15 AND 30
            THEN '3. 15-30 days'
        ELSE '4. Over 30 days'
    END
ORDER BY
    Handcap,
    MIN(DATEDIFF(AppointmentDay, DATE(ScheduledDay)));
    
 SELECT
    COUNT(*) AS total_appointments,
    SUM(`No-show` = 'No') AS attended_appointments,
    SUM(`No-show` = 'Yes') AS missed_appointments,
    ROUND(
        SUM(`No-show` = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS no_show_rate_pct,
    ROUND(
        SUM(`No-show` = 'No') * 100.0 / COUNT(*),
        2
    ) AS attendance_rate_pct
FROM medical_appointments.cleaned_medical_appointments
WHERE AppointmentDay >= DATE(ScheduledDay);   
