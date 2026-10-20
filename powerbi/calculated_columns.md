### Age Group
```Dax
Age Group = 
VAR PatientAge =
    'medical_appointments cleaned_medical_appointments'[Age]
RETURN
    SWITCH(
        TRUE(),
        ISBLANK(PatientAge) || PatientAge < 1 || PatientAge > 115, "Unknown",
        PatientAge <= 12, "1. Children (1-12)",
        PatientAge <= 17, "2. Teenagers (13-17)",
        PatientAge <= 35, "3. Young adults (18-35)",
        PatientAge <= 59, "4. Adults (36-59)",
        "5. Seniors (60+)"
    )
```

### Age Group Sort
```Dax
Age Group Sort = 
VAR PatientAge =
    'medical_appointments cleaned_medical_appointments'[Age]
RETURN
    SWITCH(
        TRUE(),
        ISBLANK(PatientAge) || PatientAge < 1 || PatientAge > 115, 6,
        PatientAge <= 12, 1,
        PatientAge <= 17, 2,
        PatientAge <= 35, 3,
        PatientAge <= 59, 4,
        5
    )
```

### Appointment Day Name
```Dax
Appointment Day Name = 
FORMAT(
    'medical_appointments cleaned_medical_appointments'[AppointmentDay],
    "dddd"
)
```

### Appointment Day Number
```Dax
Appointment Day Number = 
WEEKDAY(
    'medical_appointments cleaned_medical_appointments'[AppointmentDay],
    2
)
```

### Appointment Month
```Dax
Appointment Month = 
FORMAT(
    'medical_appointments cleaned_medical_appointments'[AppointmentDay],
    "MMMM"
)
```

### Appointment Weekday
```Dax
Appointment Weekday = 
FORMAT(
    'medical_appointments cleaned_medical_appointments'[AppointmentDay],
    "dddd"
)
```

### Lead Time Days
```Dax
Lead Time Days = 
VAR ScheduledDate =
    'medical_appointments cleaned_medical_appointments'[ScheduledDay]
VAR AppointmentDate =
    'medical_appointments cleaned_medical_appointments'[AppointmentDay]
RETURN
    MAX(
        0,
        DATEDIFF(
            ScheduledDate,
            AppointmentDate,
            DAY
        )
    )
```

### Lead Time Group
```Dax
Lead Time Group = 
SWITCH(
    TRUE(),
    'medical_appointments cleaned_medical_appointments'[Lead Time Days] = 0,
        "0 days",
    'medical_appointments cleaned_medical_appointments'[Lead Time Days] <= 7,
        "1–7 days",
    'medical_appointments cleaned_medical_appointments'[Lead Time Days] <= 14,
        "8–14 days",
    'medical_appointments cleaned_medical_appointments'[Lead Time Days] <= 30,
        "15–30 days",
    "31+ days"
)
```

### Month Sort
```Dax
Month Sort = 
MONTH(
    'medical_appointments cleaned_medical_appointments'[AppointmentDay]
)
```

### No-show Rate (%)
```Dax
No-show Rate (%) = 
DIVIDE(
    CALCULATE(
        COUNTROWS('medical_appointments cleaned_medical_appointments'),
        'medical_appointments cleaned_medical_appointments'[No-show] = "Yes",
        'medical_appointments cleaned_medical_appointments'[Valid Appointment] = 1
    ),
    CALCULATE(
        COUNTROWS('medical_appointments cleaned_medical_appointments'),
        'medical_appointments cleaned_medical_appointments'[Valid Appointment] = 1
    ),
    0
)
```

### Scholarship Status
```Dax
Scholarship Status = 
IF(
    'medical_appointments cleaned_medical_appointments'[Scholarship] = 1,
    "Has Scholarship",
    "No Scholarship"
)
```

### SMS Reminder Status
```Dax
SMS Reminder Status = 
IF(
    'medical_appointments cleaned_medical_appointments'[SMS_received] = 1,
    "SMS Received",
    "No SMS Received"
)
```

### Valid Appointment
```Dax
Valid Appointment = 
IF(
    'medical_appointments cleaned_medical_appointments'[AppointmentDay]
        >= DATE(
            YEAR('medical_appointments cleaned_medical_appointments'[ScheduledDay]),
            MONTH('medical_appointments cleaned_medical_appointments'[ScheduledDay]),
            DAY('medical_appointments cleaned_medical_appointments'[ScheduledDay])
        ),
    1,
    0
)
```

### Waiting Time Group
```Dax
Waiting Time Group = 
VAR ScheduledDate =
    DATE(
        YEAR('medical_appointments cleaned_medical_appointments'[ScheduledDay]),
        MONTH('medical_appointments cleaned_medical_appointments'[ScheduledDay]),
        DAY('medical_appointments cleaned_medical_appointments'[ScheduledDay])
    )
VAR AppointmentDate =
    'medical_appointments cleaned_medical_appointments'[AppointmentDay]
VAR DaysWait =
    DATEDIFF(ScheduledDate, AppointmentDate, DAY)
RETURN
    SWITCH(
        TRUE(),
        'medical_appointments cleaned_medical_appointments'[Valid Appointment] = 0,
            "Excluded",
        DaysWait = 0, "0. Same day",
        DaysWait <= 7, "1. 1-7 days",
        DaysWait <= 14, "2. 8-14 days",
        DaysWait <= 30, "3. 15-30 days",
        "4. Over 30 days"
    )
```

### Waiting Time Sort 
```Dax
Waiting Time Sort = 
VAR ScheduledDate =
    DATE(
        YEAR('medical_appointments cleaned_medical_appointments'[ScheduledDay]),
        MONTH('medical_appointments cleaned_medical_appointments'[ScheduledDay]),
        DAY('medical_appointments cleaned_medical_appointments'[ScheduledDay])
    )
VAR AppointmentDate =
    'medical_appointments cleaned_medical_appointments'[AppointmentDay]
VAR DaysWait =
    DATEDIFF(ScheduledDate, AppointmentDate, DAY)
RETURN
    SWITCH(
        TRUE(),
        'medical_appointments cleaned_medical_appointments'[Valid Appointment] = 0, 5,
        DaysWait = 0, 0,
        DaysWait <= 7, 1,
        DaysWait <= 14, 2,
        DaysWait <= 30, 3,
        4
    )
```

### Weekday Sort
```Dax
Weekday Sort = 
WEEKDAY(
    'medical_appointments cleaned_medical_appointments'[AppointmentDay],
    2
  )
```
