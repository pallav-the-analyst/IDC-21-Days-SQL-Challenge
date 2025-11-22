--Day 17 (22/11): Subqueries (SELECT and FROM clause)

--Practice Questions:

--Show each patient with their service's average satisfaction as an additional column.
SELECT
p.name AS patient_name,
p.service,
p.satisfaction AS patient_satisfaction,
(SELECT ROUND(AVG(sw.patient_satisfaction)) FROM services_weekly sw
WHERE p.service=sw.service GROUP BY service) AS service_average_satisfaction
FROM patients p;

--Create a derived table of service statistics and query from it.
SELECT
sw.week,
sw.service,
sw.patients_admitted,
s.staff_assigned,
s.staff_present,
sw.staff_morale
FROM services_weekly sw
JOIN(SELECT week,
service,
COUNT(staff_id) AS staff_assigned,
SUM(present) AS staff_present
FROM staff_schedule
GROUP BY week,service)s
ON s.week=sw.week AND s.service=sw.service;

--Display staff with their service's total patient count as a calculated field.
SELECT
s.week,s.staff_name,s.role,s.service,
(SELECT COUNT(p.patient_id) FROM patients p WHERE EXTRACT(week FROM p.arrival_date)=s.week) AS patients_count
FROM staff_schedule s
ORDER BY week;

/**Daily Challenge 17: Create a report showing each service with: service name, total patients admitted, 
the difference between their total admissions and the average admissions across all services, and a rank indicator 
('Above Average', 'Average', 'Below Average'). Order by total patients admitted descending.**/


SELECT
    s.service,
    s.total_admit,
    s.total_admit - a.avg_admit AS diff,
    CASE
        WHEN s.total_admit > a.avg_admit THEN 'Above Average'
        WHEN s.total_admit = a.avg_admit THEN 'Average'
        ELSE 'Below Average'
    END AS rank_indicator
FROM
    -- Subquery 1: totals per service
    (SELECT 
         service,
         SUM(patients_admitted) AS total_admit
     FROM services_weekly
     GROUP BY service
    ) AS s,

    -- Subquery 2: overall average
    (SELECT 
         ROUND(AVG(total_admit)) AS avg_admit
     FROM (
            SELECT SUM(patients_admitted) AS total_admit
            FROM services_weekly
            GROUP BY service
          ) AS t
    ) AS a
ORDER BY s.total_admit DESC;
