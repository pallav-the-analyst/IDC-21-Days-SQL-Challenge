--Day 15 (19/11): Multiple Joins

--Practice Questions:

--1. Join patients, staff, and staff_schedule to show patient service and staff availability.
SELECT
p.name AS patient_name,p.service,
s.staff_name,s.role,
ss.week,ss.present
FROM  patients p
JOIN staff s
ON p.service=s.service
JOIN staff_schedule ss
ON s.staff_id=ss.staff_id AND s.staff_name=ss.staff_name AND s.role=ss.role AND s.service=ss.service
ORDER BY ss.week,p.patient_id;

--2. Combine services_weekly with staff and staff_schedule for comprehensive service analysis.
SELECT
sw.week,sw.month,sw.service,sw.event,
s.staff_id,s.staff_name,s.role,ss.present
FROM services_weekly sw
LEFT JOIN staff s
ON sw.service=s.service
LEFT JOIN staff_schedule ss
ON s.staff_id=ss.staff_id AND s.staff_name=ss.staff_name AND s.role=ss.role AND s.service=ss.service
ORDER BY sw.week ASC,sw.service ASC,s.staff_name ASC;

--3. Create a multi-table report showing patient admissions with staff information.
SELECT
DISTINCT p.name AS patient_name,p.age,
sw.event,sw.service,p.arrival_date,
departure_date-arrival_date AS days_stayed,
ss.staff_name,ss.role
FROM patients p
JOIN services_weekly sw
on p.service=sw.service
JOIN staff_schedule ss
ON sw.service=sw.service AND sw.week=ss.week
ORDER BY arrival_date;

/**Daily Chalenge 15: Create a comprehensive service analysis report for week 20 showing: service name, total patients admitted 
that week, total patients refused, average patient satisfaction, count of staff assigned to service, 
and count of staff present that week. Order by patients admitted descending.**/
SELECT
sw.service,
SUM(sw.patients_admitted) AS total_patients_admitted,
SUM(sw.patients_refused) AS total_patients_refused,
ROUND(AVG(sw.patient_satisfaction),2) AS average_patient_satisfaction,
COUNT(DISTINCT ss.staff_id) AS staff_assigned_to_service,
COUNT(DISTINCT CASE WHEN present=1 THEN ss.staff_id END) AS staff_present_that_week
FROM services_weekly sw
LEFT JOIN staff_schedule ss
ON sw.service=ss.service AND ss.week=20
WHERE ss.week=20
GROUP BY sw.service
ORDER BY total_patients_admitted DESC;
