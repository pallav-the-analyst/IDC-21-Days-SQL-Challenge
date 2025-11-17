--Day 13 (17/11): INNER JOIN

--Practice Questions:

--1. Join patients and staff based on their common service field (show patient and staff who work in same service).
SELECT 
p.patient_id,
p.name AS patient_name,
p.service AS patient_service,
s.staff_id,
s.staff_name,
s.role AS staff_role
FROM patients p
INNER JOIN staff s
ON p.service=s.service;

--2. Join services_weekly with staff to show weekly service data with staff information.
SELECT
sw.week,
sw.month,
sw.service,
sw.patients_request,
s.staff_id,
s.staff_name
FROM services_weekly sw
INNER JOIN staff s
ON sw.service=s.service;

--3. Create a report showing patient information along with staff assigned to their service.
SELECT
p.patient_id,
p.name,
p.age,
p.service,
s.staff_name
FROM patients p
INNER JOIN staff s
ON p.service=s.service;

/**Daily Challenge 13: Create a comprehensive report showing patient_id, patient name, age, service, and 
the total number of staff members available in their service. Only include patients from services 
that have more than 5 staff members. Order by number of staff descending, then by patient name.**/
SELECT
p.patient_id,
p.name AS patient_name,
p.age,
p.service,
COUNT(s.staff_id) AS total_staff
FROM patients p
INNER JOIN staff s
ON p.service=s.service
GROUP BY p.patient_id,p.name,
p.age,p.service
HAVING count(s.staff_id)>5
ORDER BY total_staff DESC,p.name ASC;
