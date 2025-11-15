--Day 12 (15/11): NULL Values and IS NULL/IS NOT NULL

--Practice Questions:

--1. Find all weeks in services_weekly where no special event occurred.
SELECT
DISTINCT week
FROM services_weekly
WHERE event IS NULL
OR event='none'
ORDER BY week ASC;

--2. Count how many records have null or empty event values.
SELECT
COUNT(event) AS record_count
FROM services_weekly
WHERE event IS NULL OR event = 'none';

--3. List all services that had at least one week with a special event.
SELECT
DISTINCT service
FROM services_weekly
WHERE event IS NOT NULL
AND event<>'none';

/**Daily Challenge 12: Analyze the event impact by comparing weeks with events vs weeks without events. 
Show: event status ('With Event' or 'No Event'), count of weeks, average patient satisfaction, 
and average staff morale. Order by average patient satisfaction descending.**/
SELECT
CASE
WHEN event IS NOT NULL AND event !='none' AND event!=''
THEN 'With Event'
ELSE 'No Event'
END AS event_status,
COUNT(week) AS week_count,
ROUND(AVG(patient_satisfaction),2) AS avg_patient_satisfaction,
ROUND(AVG(staff_morale),2) AS avg_staff_morale
FROM services_weekly
GROUP BY event_status
ORDER BY avg_patient_satisfaction DESC;
