--Day 6 (09/11): GROUP BY Clause

--Practice Questions:

--Count the number of patients by each service.
SELECT
service,
COUNT(patient_id) AS number_of_patients
FROM patients 
GROUP BY service;

--Calculate the average age of patients grouped by service.
SELECT
service,
COUNT(patient_id) AS number_of_patients,
ROUND(AVG(age)) AS average_age
FROM patients 
GROUP BY service;

--Find the total number of staff members per role.
SELECT
role,
COUNT(staff_id) AS total_staff
FROM staff
GROUP BY role;

--Daily Challenge 6: For each hospital service, calculate the total number of patients admitted, total patients refused, and the admission rate (percentage of requests that were admitted). Order by admission rate descending.
SELECT
service,
SUM(patients_admitted) AS total_patient_admitted,
SUM(patients_refused) AS total_patient_refused,
(SUM(patients_admitted)*100/SUM(patients_request)) AS admission_rate
FROM services_weekly
GROUP BY service
ORDER BY admission_rate DESC;

