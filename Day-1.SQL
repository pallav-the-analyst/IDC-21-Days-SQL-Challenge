-- Day 1 (03/11): Introduction to SQL & SELECT Statement

--Practice Questions:

--Retrieve all columns from the patients table.
SELECT * FROM patients;

--Select only the patient_id, name, and age columns from the patients table.
SELECT 
patient_id, name, age 
FROM patients;

--Display the first 10 records from the services_weekly table.
SELECT * FROM services_weekly LIMIT 10;

--Daily Challenge 1: List all unique hospital services available in the hospital.
SELECT DISTINCT service AS services
FROM services_weekly;
