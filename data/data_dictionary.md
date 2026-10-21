# Data Dictionary

This dictionary describes the 14 source fields in the commonly
distributed Medical Appointment No Shows dataset. Verify field names
against your imported table with `DESCRIBE` because MySQL column casing
and cleanup choices can differ.

  ----------------------------------------------------------------------------
  Field              Meaning               Typical values /  Quality notes
                                           type              
  ------------------ --------------------- ----------------- -----------------
  `PatientId`        Identifier for a      Numeric           One patient can
                     patient               identifier        have multiple
                                                             appointments; use
                                                             distinct count
                                                             for unique
                                                             patients.

  `AppointmentID`    Identifier for an     Numeric           Used for
                     appointment           identifier        uniqueness
                                                             checks.

  `Gender`           Recorded gender       `F`, `M`          Check for
                                                             unexpected or
                                                             missing
                                                             categories.

  `ScheduledDay`     Date/time when the    Datetime          Used to derive
                     appointment was                         waiting/lead
                     scheduled                               time.

  `AppointmentDay`   Date associated with  Datetime/date     Validate
                     the appointment                         chronological
                                                             order relative to
                                                             scheduling date.

  `Age`              Patient age in years  Integer           Review missing
                                                             values, negative
                                                             values, and
                                                             unusually high
                                                             ages.

  `Neighbourhood`    Neighbourhood         Text              Accented
                     associated with the                     characters
                     appointment                             required encoding
                                                             cleanup and
                                                             verification.

  `Scholarship`      Bolsa Família         Usually `0` or    Validate as a
                     scholarship indicator `1`               binary field.

  `Hipertension`     Hypertension          Usually `0` or    Preserve or
                     indicator (source     `1`               document source
                     spelling)                               spelling if
                                                             renamed.

  `Diabetes`         Diabetes indicator    Usually `0` or    Validate as a
                                           `1`               binary field.

  `Alcoholism`       Alcoholism indicator  Usually `0` or    Validate as a
                                           `1`               binary field.

  `Handcap`          Handicap/disability   Values observed   Do not assume
                     indicator in the      from `0` to `4`   binary; document
                     source                                  observed
                                                             categories.

  `SMS_received`     Whether an SMS        Usually `0` or    Does not by
                     reminder was recorded `1`               itself establish
                     as received                             reminder
                                                             effectiveness.

  `No-show`          Whether the patient   `NO` = attended;  Source outcome
                     missed the            `YES` = missed    used to calculate
                     appointment                             attendance and
                                                             no-show rates.
  ----------------------------------------------------------------------------

## Derived report fields

  -----------------------------------------------------------------------
  Derived field                       Definition
  ----------------------------------- -----------------------------------
  `Valid Appointment`                 Flag used to include/exclude
                                      records from the main report; `1`
                                      means included. Five invalid
                                      date-order records were excluded.

  `Lead Time Days`                    Difference in days between
                                      scheduling and appointment dates,
                                      as implemented in the Power BI
                                      model.

  `Waiting Time Group`                Grouped lead-time categories: Same
                                      day, 1--7, 8--14, 15--30, Over 30
                                      days, and Excluded for invalid
                                      records.

  `Age Group`                         Existing age-band field used in the
                                      age-group visual; document exact
                                      band boundaries from the model.

  `Appointment Day Name`              Weekday name derived from
                                      `AppointmentDay`.

  `Appointment Day Number`            Numeric weekday sort key;
                                      Monday-first ordering was used.

  `Scholarship Status`                Label derived from the scholarship
                                      indicator.

  `SMS Reminder Status`               Label derived from the SMS
                                      indicator.
  -----------------------------------------------------------------------

## Important interpretation notes

-   `No-show = "NO"` means attended; `No-show = "YES"` means missed.
-   Do not count `PatientId` rows as unique patients; use a distinct
    count.
-   Missing ages, negative ages, and ages above 100 are different
    quality categories.
-   The five invalid date-order records are excluded from the main
    report using `Valid Appointment = 1`.
