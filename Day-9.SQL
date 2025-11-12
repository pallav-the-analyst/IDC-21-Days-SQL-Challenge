--Day 9 (12/11): Date Functions

--Practice Questions:

--1. Extract the year from all patient arrival dates.
SELECT
EXTRACT(YEAR FROM arrival_date) AS year
FROM patients;

--2. Calculate the length of stay for each patient (departure_date - arrival_date).
SELECT
name,
(departure_date - arrival_date) AS length_of_stay
FROM patients;

--3. Find all patients who arrived in a specific month.
SELECT
name,
TO_CHAR(arrival_date,'FMMonth') AS patients_arrival_month
FROM patients
WHERE TO_CHAR(arrival_date,'FMMonth')='March';

/**Daily Challenge 9: Calculate the average length of stay (in days) for each service, showing only services
where the average stay is more than 7 days. Also show the count of patients and order by average stay descending.**/
SELECT
service,
COUNT(patient_id) AS patient_count,
ROUND(AVG(departure_date-arrival_date)) AS avg_length_of_stay
FROM patients
GROUP BY service
HAVING AVG(departure_date-arrival_date)>7
ORDER BY avg_length_of_stay DESC;
