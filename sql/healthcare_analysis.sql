/* ============================================================
   Healthcare Operations & Patient Access Analytics
   Independent Portfolio Project

   Purpose:
   Analyze appointment operations, patient access,
   missed appointments, wait times, provider workload,
   and patient satisfaction.

   Dataset:
   healthcare_appointments.csv
   ============================================================ */


/* ============================================================
   1. OVERALL APPOINTMENT PERFORMANCE
   Business Questions:
   - How many appointments were scheduled?
   - How many were completed, cancelled, or no-show?
   ============================================================ */

SELECT
    COUNT(*) AS total_appointments,
    SUM(CASE WHEN appointment_status = 'Completed' THEN 1 ELSE 0 END)
        AS completed_appointments,
    SUM(CASE WHEN appointment_status = 'Cancelled' THEN 1 ELSE 0 END)
        AS cancelled_appointments,
    SUM(CASE WHEN appointment_status = 'No-show' THEN 1 ELSE 0 END)
        AS no_show_appointments
FROM healthcare_appointments;


/* ============================================================
   2. CORE OPERATIONAL KPIs
   ============================================================ */

SELECT
    COUNT(*) AS total_appointments,

    ROUND(
        100.0 * SUM(
            CASE WHEN appointment_status = 'Completed' THEN 1 ELSE 0 END
        ) / COUNT(*), 2
    ) AS completion_rate_pct,

    ROUND(
        100.0 * SUM(
            CASE WHEN appointment_status = 'Cancelled' THEN 1 ELSE 0 END
        ) / COUNT(*), 2
    ) AS cancellation_rate_pct,

    ROUND(
        100.0 * SUM(
            CASE WHEN appointment_status = 'No-show' THEN 1 ELSE 0 END
        ) / COUNT(*), 2
    ) AS no_show_rate_pct,

    ROUND(
        AVG(
            CASE
                WHEN appointment_status = 'Completed'
                THEN wait_time_minutes
            END
        ), 2
    ) AS avg_wait_time_minutes,

    ROUND(
        AVG(
            CASE
                WHEN appointment_status = 'Completed'
                THEN patient_satisfaction_score
            END
        ), 2
    ) AS avg_patient_satisfaction

FROM healthcare_appointments;


/* ============================================================
   3. PERFORMANCE BY SPECIALTY
   Business Question:
   Which specialties have higher levels of missed appointments?
   ============================================================ */

SELECT
    specialty,
    COUNT(*) AS total_appointments,

    SUM(
        CASE WHEN appointment_status = 'Completed' THEN 1 ELSE 0 END
    ) AS completed_appointments,

    SUM(
        CASE WHEN appointment_status = 'Cancelled' THEN 1 ELSE 0 END
    ) AS cancelled_appointments,

    SUM(
        CASE WHEN appointment_status = 'No-show' THEN 1 ELSE 0 END
    ) AS no_show_appointments,

    ROUND(
        100.0 * SUM(
            CASE WHEN appointment_status = 'Cancelled' THEN 1 ELSE 0 END
        ) / COUNT(*), 2
    ) AS cancellation_rate_pct,

    ROUND(
        100.0 * SUM(
            CASE WHEN appointment_status = 'No-show' THEN 1 ELSE 0 END
        ) / COUNT(*), 2
    ) AS no_show_rate_pct,

    ROUND(
        AVG(
            CASE
                WHEN appointment_status = 'Completed'
                THEN wait_time_minutes
            END
        ), 2
    ) AS avg_wait_time_minutes

FROM healthcare_appointments

GROUP BY specialty

ORDER BY no_show_rate_pct DESC;


/* ============================================================
   4. PERFORMANCE BY LOCATION
   Business Question:
   Which locations have longer wait times or higher
   missed-appointment rates?
   ============================================================ */

SELECT
    location,
    COUNT(*) AS total_appointments,

    ROUND(
        100.0 * SUM(
            CASE WHEN appointment_status = 'Completed' THEN 1 ELSE 0 END
        ) / COUNT(*), 2
    ) AS completion_rate_pct,

    ROUND(
        100.0 * SUM(
            CASE WHEN appointment_status = 'Cancelled' THEN 1 ELSE 0 END
        ) / COUNT(*), 2
    ) AS cancellation_rate_pct,

    ROUND(
        100.0 * SUM(
            CASE WHEN appointment_status = 'No-show' THEN 1 ELSE 0 END
        ) / COUNT(*), 2
    ) AS no_show_rate_pct,

    ROUND(
        AVG(
            CASE
                WHEN appointment_status = 'Completed'
                THEN wait_time_minutes
            END
        ), 2
    ) AS avg_wait_time_minutes,

    ROUND(
        AVG(
            CASE
                WHEN appointment_status = 'Completed'
                THEN patient_satisfaction_score
            END
        ), 2
    ) AS avg_patient_satisfaction

FROM healthcare_appointments

GROUP BY location

ORDER BY avg_wait_time_minutes DESC;


/* ============================================================
   5. APPOINTMENT TYPE PERFORMANCE
   Business Question:
   Which appointment types show weaker performance?
   ============================================================ */

SELECT
    appointment_type,
    COUNT(*) AS total_appointments,

    ROUND(
        100.0 * SUM(
            CASE WHEN appointment_status = 'Completed' THEN 1 ELSE 0 END
        ) / COUNT(*), 2
    ) AS completion_rate_pct,

    ROUND(
        100.0 * SUM(
            CASE WHEN appointment_status = 'Cancelled' THEN 1 ELSE 0 END
        ) / COUNT(*), 2
    ) AS cancellation_rate_pct,

    ROUND(
        100.0 * SUM(
            CASE WHEN appointment_status = 'No-show' THEN 1 ELSE 0 END
        ) / COUNT(*), 2
    ) AS no_show_rate_pct,

    ROUND(
        AVG(
            CASE
                WHEN appointment_status = 'Completed'
                THEN wait_time_minutes
            END
        ), 2
    ) AS avg_wait_time_minutes

FROM healthcare_appointments

GROUP BY appointment_type

ORDER BY no_show_rate_pct DESC;


/* ============================================================
   6. SCHEDULING LEAD-TIME ANALYSIS
   Business Question:
   Does longer scheduling lead time appear to be associated
   with missed appointments?
   ============================================================ */

SELECT
    CASE
        WHEN scheduled_lead_days <= 7 THEN '0-7 Days'
        WHEN scheduled_lead_days <= 14 THEN '8-14 Days'
        WHEN scheduled_lead_days <= 30 THEN '15-30 Days'
        ELSE '31+ Days'
    END AS lead_time_group,

    COUNT(*) AS total_appointments,

    ROUND(
        100.0 * SUM(
            CASE WHEN appointment_status = 'Cancelled' THEN 1 ELSE 0 END
        ) / COUNT(*), 2
    ) AS cancellation_rate_pct,

    ROUND(
        100.0 * SUM(
            CASE WHEN appointment_status = 'No-show' THEN 1 ELSE 0 END
        ) / COUNT(*), 2
    ) AS no_show_rate_pct

FROM healthcare_appointments

GROUP BY
    CASE
        WHEN scheduled_lead_days <= 7 THEN '0-7 Days'
        WHEN scheduled_lead_days <= 14 THEN '8-14 Days'
        WHEN scheduled_lead_days <= 30 THEN '15-30 Days'
        ELSE '31+ Days'
    END

ORDER BY
    CASE
        WHEN lead_time_group = '0-7 Days' THEN 1
        WHEN lead_time_group = '8-14 Days' THEN 2
        WHEN lead_time_group = '15-30 Days' THEN 3
        WHEN lead_time_group = '31+ Days' THEN 4
    END;


/* ============================================================
   7. PROVIDER WORKLOAD ANALYSIS
   Business Question:
   Which providers have higher appointment volumes and
   scheduled workload?
   ============================================================ */

SELECT
    provider,
    COUNT(*) AS total_appointments,

    SUM(
        CASE WHEN appointment_status = 'Completed' THEN 1 ELSE 0 END
    ) AS completed_appointments,

    SUM(appointment_duration_minutes) AS total_scheduled_minutes,

    ROUND(
        AVG(appointment_duration_minutes), 2
    ) AS avg_appointment_duration_minutes,

    ROUND(
        AVG(
            CASE
                WHEN appointment_status = 'Completed'
                THEN wait_time_minutes
            END
        ), 2
    ) AS avg_wait_time_minutes

FROM healthcare_appointments

GROUP BY provider

ORDER BY total_scheduled_minutes DESC;


/* ============================================================
   8. MONTHLY APPOINTMENT TREND
   Business Question:
   How does appointment demand and performance change over time?
   ============================================================ */

SELECT
    YEAR(appointment_date) AS appointment_year,
    MONTH(appointment_date) AS appointment_month,

    COUNT(*) AS total_appointments,

    SUM(
        CASE WHEN appointment_status = 'Completed' THEN 1 ELSE 0 END
    ) AS completed_appointments,

    SUM(
        CASE WHEN appointment_status = 'Cancelled' THEN 1 ELSE 0 END
    ) AS cancelled_appointments,

    SUM(
        CASE WHEN appointment_status = 'No-show' THEN 1 ELSE 0 END
    ) AS no_show_appointments,

    ROUND(
        100.0 * SUM(
            CASE WHEN appointment_status = 'No-show' THEN 1 ELSE 0 END
        ) / COUNT(*), 2
    ) AS no_show_rate_pct

FROM healthcare_appointments

GROUP BY
    YEAR(appointment_date),
    MONTH(appointment_date)

ORDER BY
    appointment_year,
    appointment_month;


/* ============================================================
   9. WAIT TIME VS PATIENT SATISFACTION
   Business Question:
   How does patient satisfaction vary across wait-time ranges?
   ============================================================ */

SELECT
    CASE
        WHEN wait_time_minutes <= 15 THEN '0-15 Minutes'
        WHEN wait_time_minutes <= 30 THEN '16-30 Minutes'
        WHEN wait_time_minutes <= 45 THEN '31-45 Minutes'
        WHEN wait_time_minutes <= 60 THEN '46-60 Minutes'
        ELSE '61+ Minutes'
    END AS wait_time_group,

    COUNT(*) AS completed_appointments,

    ROUND(
        AVG(patient_satisfaction_score), 2
    ) AS avg_patient_satisfaction,

    ROUND(
        AVG(wait_time_minutes), 2
    ) AS avg_wait_time_minutes

FROM healthcare_appointments

WHERE appointment_status = 'Completed'

GROUP BY
    CASE
        WHEN wait_time_minutes <= 15 THEN '0-15 Minutes'
        WHEN wait_time_minutes <= 30 THEN '16-30 Minutes'
        WHEN wait_time_minutes <= 45 THEN '31-45 Minutes'
        WHEN wait_time_minutes <= 60 THEN '46-60 Minutes'
        ELSE '61+ Minutes'
    END

ORDER BY avg_wait_time_minutes;


/* ============================================================
   10. SPECIALTY + LOCATION PERFORMANCE
   Business Question:
   Where are the most significant operational differences?
   ============================================================ */

SELECT
    specialty,
    location,
    COUNT(*) AS total_appointments,

    ROUND(
        AVG(
            CASE
                WHEN appointment_status = 'Completed'
                THEN wait_time_minutes
            END
        ), 2
    ) AS avg_wait_time_minutes,

    ROUND(
        100.0 * SUM(
            CASE WHEN appointment_status = 'No-show' THEN 1 ELSE 0 END
        ) / COUNT(*), 2
    ) AS no_show_rate_pct,

    ROUND(
        100.0 * SUM(
            CASE WHEN appointment_status = 'Cancelled' THEN 1 ELSE 0 END
        ) / COUNT(*), 2
    ) AS cancellation_rate_pct

FROM healthcare_appointments

GROUP BY
    specialty,
    location

HAVING COUNT(*) >= 20

ORDER BY
    no_show_rate_pct DESC,
    avg_wait_time_minutes DESC;


/* ============================================================
   11. HIGH WAIT-TIME AREAS
   Business Question:
   Which specialty/location combinations have the highest
   average wait times?
   ============================================================ */

SELECT
    specialty,
    location,

    COUNT(*) AS completed_appointments,

    ROUND(
        AVG(wait_time_minutes), 2
    ) AS avg_wait_time_minutes,

    ROUND(
        AVG(patient_satisfaction_score), 2
    ) AS avg_patient_satisfaction

FROM healthcare_appointments

WHERE appointment_status = 'Completed'

GROUP BY
    specialty,
    location

HAVING COUNT(*) >= 20

ORDER BY avg_wait_time_minutes DESC;


/* ============================================================
   12. EXECUTIVE SUMMARY DATASET
   A compact result set for dashboard KPI validation.
   ============================================================ */

SELECT
    COUNT(*) AS total_appointments,

    SUM(
        CASE WHEN appointment_status = 'Completed' THEN 1 ELSE 0 END
    ) AS completed_appointments,

    SUM(
        CASE WHEN appointment_status = 'Cancelled' THEN 1 ELSE 0 END
    ) AS cancelled_appointments,

    SUM(
        CASE WHEN appointment_status = 'No-show' THEN 1 ELSE 0 END
    ) AS no_show_appointments,

    ROUND(
        100.0 * SUM(
            CASE WHEN appointment_status = 'Completed' THEN 1 ELSE 0 END
        ) / COUNT(*), 2
    ) AS completion_rate_pct,

    ROUND(
        100.0 * SUM(
            CASE WHEN appointment_status = 'Cancelled' THEN 1 ELSE 0 END
        ) / COUNT(*), 2
    ) AS cancellation_rate_pct,

    ROUND(
        100.0 * SUM(
            CASE WHEN appointment_status = 'No-show' THEN 1 ELSE 0 END
        ) / COUNT(*), 2
    ) AS no_show_rate_pct,

    ROUND(
        AVG(
            CASE
                WHEN appointment_status = 'Completed'
                THEN wait_time_minutes
            END
        ), 2
    ) AS avg_wait_time_minutes,

    ROUND(
        AVG(
            CASE
                WHEN appointment_status = 'Completed'
                THEN patient_satisfaction_score
            END
        ), 2
    ) AS avg_patient_satisfaction

FROM healthcare_appointments;
