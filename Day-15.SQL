--Day 15 (19/11): Multiple Joins

--Practice Questions:

--1. Join patients, staff, and staff_schedule to show patient service and staff availability.
SELECT
DISTINCT p.name AS patient_name,p.service,
s.staff_name,s.role,
EXTRACT(WEEK FROM p.arrival_date) AS week,
CASE WHEN ss.present=1 THEN 'Yes' ELSE 'No' END AS availability
FROM  patients p
JOIN staff s
ON p.service=s.service
JOIN staff_schedule ss
ON s.staff_id=ss.staff_id AND s.week=ss.week
ORDER BY week,patient_name;

--2. Combine services_weekly with staff and staff_schedule for comprehensive service analysis.
SELECT
DISTINCT sw.week,sw.service,
s.staff_id,s.staff_name,s.role,
CASE WHEN ss.present=1 THEN 'Yes' ELSE 'No' END AS availability,sw.staff_morale
FROM services_weekly sw
RIGHT JOIN staff s
ON sw.service=s.service
JOIN staff_schedule ss
ON s.staff_id=ss.staff_id AND sw.week=ss.week
ORDER BY sw.week,s.staff_name;

--3. Create a multi-table report showing patient admissions with staff information.
SELECT
DISTINCT p.name AS patient_name,p.age,
sw.event,sw.service,p.arrival_date,
departure_date-arrival_date AS days_stayed,
ss.staff_name AS assigned_staffs,ss.role,
CASE WHEN ss.present=1 THEN 'Yes' ELSE 'No' END AS staff_availability
FROM patients p
JOIN services_weekly sw
on p.service=sw.service
JOIN staff_schedule ss
ON sw.service=ss.service AND sw.week=ss.week
ORDER BY arrival_date;

/**Daily Chalenge 15: Create a comprehensive service analysis report for week 20 showing: service name, total patients admitted 
that week, total patients refused, average patient satisfaction, count of staff assigned to service, 
and count of staff present that week. Order by patients admitted descending.**/
SELECT
sw.service,
MAX(sw.patients_admitted) AS patients_admitted,
MAX(sw.patients_refused) AS patients_refused,
ROUND(AVG(sw.patient_satisfaction),1) AS average_patient_satisfaction,
COUNT(ss.staff_id) AS staff_assigned,
SUM(ss.present) AS staff_present
FROM services_weekly sw
JOIN staff_schedule ss
ON sw.week=ss.week AND sw.service=ss.service
WHERE sw.week=20
GROUP BY sw.service
ORDER BY patients_admitted DESC;
