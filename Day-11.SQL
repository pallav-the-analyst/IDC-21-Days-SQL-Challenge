--Day 11 (14/11): DISTINCT and Handling Duplicates

--Practice Questions:

--1. List all unique services in the patients table.
SELECT
DISTINCT(service)
FROM patients;
  
--2. Find all unique staff roles in the hospital.
SELECT
DISTINCT(role)
FROM staff;
  
--3. Get distinct months from the services_weekly table.
SELECT
DISTINCT(month)
FROM services_weekly
ORDER BY month ASC;

/**Daily Challenge 11: Find all unique combination of service and event type from the services_weekly table
where events are not null or none, alone with the count of occurences for each combination.
Order by count descending**/
SELECT
service,
event AS event_type,
COUNT(*) AS event_count
FROM services_weekly
WHERE event IS NOT NULL
AND event <> 'None'
GROUP  BY service,event_type
ORDER BY event_count DESC;



