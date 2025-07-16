-- SQL Queries for HealthSync Patient Engagement Platform
-- 1. Analyze no-show rates by date
SELECT date, COUNT(*) AS no_shows, 
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS no_show_percentage
FROM appointments
WHERE status = 'no-show'
GROUP BY date
ORDER BY date;

-- 2. Count missed appointments by patient
SELECT patient_id, COUNT(*) AS missed_appointments
FROM appointments
WHERE status = 'no-show'
GROUP BY patient_id
HAVING COUNT(*) > 1
ORDER BY missed_appointments DESC;

-- 3. Validate EHR data integrity
SELECT COUNT(*) AS invalid_records
FROM appointments
WHERE patient_id IS NULL OR appointment_time IS NULL OR hospital_id IS NULL;

-- 4. Appointment volume by hospital
SELECT h.hospital_name, COUNT(*) AS total_appointments
FROM appointments a
JOIN hospitals h ON a.hospital_id = h.hospital_id
WHERE date BETWEEN '2022-01-01' AND '2022-06-30'
GROUP BY h.hospital_name
ORDER BY total_appointments DESC;

-- 5. No-show rates by appointment type
SELECT appointment_type, 
       COUNT(*) AS no_shows,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY appointment_type), 2) AS no_show_rate
FROM appointments
WHERE status = 'no-show'
GROUP BY appointment_type;

-- 6. Patient engagement via portal logins
SELECT p.patient_id, COUNT(l.login_id) AS login_count
FROM patients p
LEFT JOIN portal_logins l ON p.patient_id = l.patient_id
WHERE l.login_date BETWEEN '2022-01-01' AND '2022-06-30'
GROUP BY p.patient_id
ORDER BY login_count DESC;

-- 7. Reminder effectiveness
SELECT reminder_type, 
       COUNT(*) AS reminders_sent,
       SUM(CASE WHEN status = 'attended' THEN 1 ELSE 0 END) AS attended_appointments
FROM appointments
WHERE reminder_sent = 1
GROUP BY reminder_type;

-- 8. Average appointment booking time
SELECT hospital_id, 
       AVG(DATEDIFF(appointment_time, booking_time)) AS avg_booking_lead_time
FROM appointments
WHERE status = 'booked'
GROUP BY hospital_id;