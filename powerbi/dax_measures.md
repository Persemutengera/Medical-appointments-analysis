### Attendance rate 
```Dax
Attendance Rate = 
DIVIDE(
    [Attended Appointments],
    [Total Valid Appointments],
    0
)
```

### Attended Appointments
```Dax
Attended Appointments = 
CALCULATE(
    COUNTROWS('medical_appointments cleaned_medical_appointments'),
    'medical_appointments cleaned_medical_appointments'[Valid Appointment] = 1,
    'medical_appointments cleaned_medical_appointments'[No-show] = "No"
)
```

### No-Show Appointments
```Dax
No-Show Appointments = 
CALCULATE(
    COUNTROWS('medical_appointments cleaned_medical_appointments'),
    'medical_appointments cleaned_medical_appointments'[Valid Appointment] = 1,
    'medical_appointments cleaned_medical_appointments'[No-show] = "Yes"
)
```

### No-Show Rate
```Dax
No-Show Rate = 
DIVIDE(
    [No-Show Appointments],
    [Total Valid Appointments],
    0
)
```

### Total Neighbourhoods
```Dax
Total Neighbourhoods = 
DISTINCTCOUNT(
    'medical_appointments cleaned_medical_appointments'[Neighbourhood]
)
```

### Total Valid Appointments
```Dax
Total Valid Appointments = 
CALCULATE(
    COUNTROWS('medical_appointments cleaned_medical_appointments'),
    'medical_appointments cleaned_medical_appointments'[Valid Appointment] = 1
)
```

### Unique Patients
```Dax
Unique Patients = 
CALCULATE(
    DISTINCTCOUNT('medical_appointments cleaned_medical_appointments'[PatientId]),
    'medical_appointments cleaned_medical_appointments'[Valid Appointment] = 1
)
```
