--Day 14 (18/11): LEFT JOIN and RIGHT JOIN

--Practice Questions:

--Show all staff members and their schedule information (including those with no schedule entries).
SELECT
s.staff_id,
s.staff_name,
ss.week,
ss.present
ss.service
FROM staff s
LEFT JOIN staff_schedule ss
ON s.staff_id=ss.staff_id;

--List all services from services_weekly and their corresponding staff (show services even if no staff assigned).
SELECT
sw.service,
s.staff_id,
s.staff_name,
s.role
FROM services_weekly sw
LEFT JOIN staff s
ON sw.service=s.service;

--Display all patients and their service's weekly statistics (if available).
SELECT
p.patient_id,
p.name AS patient_name,
p.service,
sw.week,
sw.month,
sw.patients_request,
sw.patients_admitted,
sw.patients_refused,
sw.patient_satisfaction
FROM patients p
LEFT JOIN services_weekly sw
ON p.service=sw.service;

/**Create a staff utilisation report showing all staff members (staff_id, staff_name, role, service) 
and the count of weeks they were present (from staff_schedule). Include staff members 
even if they have no schedule records. Order by weeks present descending.**/
SELECT
s.staff_id,
s.staff_name,
s.role AS staff_role,
s.service AS staff_service,
COUNT(DISTINCT(CASE
WHEN ss.present=1 THEN ss.week
END)) AS count_of_weeks
FROM staff s
LEFT JOIN staff_schedule ss
ON s.staff_id=ss.staff_id
GROUP BY s.staff_id,s.staff_name,s.role,s.service
ORDER BY count_of_weeks;
