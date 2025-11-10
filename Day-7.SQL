--Day 7 (10/11): HAVING Clause

--Practice Questions:

--Find services that have admitted more than 500 patients in total.
SELECT
service,
SUM(patients_admitted) AS total_patients
FROM services_weekly
GROUP BY service
HAVING SUM(patients_admitted)>500
ORDER BY total_patients DESC;

--Show services where average patient satisfaction is below 75.
SELECT
service,
AVG(patient_satisfaction) AS avg_patient_satisfaction
FROM services_weekly
GROUP BY service
HAVING AVG(patient_satisfaction)<75
ORDER BY avg_patient_satisfaction;

--List weeks where total staff presence across all services was less than 50.
SELECT
week,
COUNT(present) AS staff_presence
FROM staff_schedule
GROUP BY week
HAVING COUNT(present)<50
ORDER BY staff_presence;

--Daily Challenge 7: Identify services that refused more than 100 patients in total and had an average patient satisfaction below 80. Show service name, total refused, and average satisfaction.
SELECT
service,
SUM(patients_refused) AS total_refused,
ROUND(AVG(patient_satisfaction)) AS average_satisfaction
FROM services_weekly
GROUP BY service
HAVING SUM(patients_refused)>100 AND AVG(patient_satisfaction)<80;
