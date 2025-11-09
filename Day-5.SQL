--Day 5 (07/11): Aggregate Functions (COUNT, SUM, AVG, MIN, MAX)

--Practice Questions:

--Count the total number of patients in the hospital.
SELECT
COUNT(*) AS total_patient
FROM patients;

--Calculate the average satisfaction score of all patients.
select
ROUND(AVG(satisfaction),2) AS avg_satisfaction
FROM patients;

--Find the minimum and maximum age of patients.
SELECT
MIN(age) AS min_age,
MAX(age) AS max_age
FROM patients;

--Daily Challenge 5: Calculate the total number of patients admitted, total patients refused, and the average patient satisfaction across all services and weeks. Round the average satisfaction to 2 decimal places.
SELECT
SUM(patients_admitted) AS total_patients_admitted,
SUM(patients_refused) AS total_patients_refused,
ROUND(AVG(patient_satisfaction),2) AS average_patient_satisfaction
FROM services_weekly;
