--Day 10 (13/11): CASE Statements

--Practice Questions:

--1. Categorise patients as 'High', 'Medium', or 'Low' satisfaction based on their scores.
SELECT
patient_id AS patient_id,
name AS patient_name,
satisfaction AS satisfaction_score,
CASE
WHEN satisfaction>=80 THEN 'High'
WHEN satisfaction BETWEEN 59 AND 79 THEN 'Medium'
ELSE 'Low'
END AS satisfaction_category
FROM patients;

--2. Label staff roles as 'Medical' or 'Support' based on role type.
SELECT
staff_id,
staff_name,
role,
CASE
WHEN role='doctor' THEN 'Medical'
WHEN role='nurse' THEN 'Support'
ELSE 'Support'
END AS role_type 
FROM staff;

--3. Create age groups for patients (0-18, 19-40, 41-65, 65+).
SELECT
patient_id,
name,
age,
CASE
WHEN age BETWEEN 0 AND 18 THEN '0-18'
WHEN age BETWEEN 19 AND 40 THEN '19-40'
WHEN age BETWEEN 41 AND 165 THEN '41-65'
WHEN age>65 THEN '65+'
ELSE 'Unknown'
END AS age_group
FROM patients;

/**Daily Challenge 10: Create a service performance report showing service name, total patients admitted, 
and a performance category based on the following: 'Excellent' if avg satisfaction >= 85, 
'Good' if >= 75, 'Fair' if >= 65, otherwise 'Needs Improvement'. Order by average satisfaction descending.**/
SELECT
service,
SUM(patients_admitted) AS total_patients_admitted,
ROUND(AVG(patient_satisfaction)) AS avg_satisfaction,
CASE
WHEN AVG(patient_satisfaction)>=85 THEN 'Excellent'
WHEN AVG(patient_satisfaction)>=75 THEN 'Good'
WHEN AVG(patient_satisfaction)>=65 THEN 'Fair'
ELSE 'Needs Improvement'
END AS performance
FROM services_weekly
GROUP BY service
ORDER BY avg_satisfaction DESC;
