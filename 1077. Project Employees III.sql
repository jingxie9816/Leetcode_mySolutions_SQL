SELECT project_id, employee_id
FROM(
SELECT p.project_id, employee_id,
       RANK() OVER (PARTITION BY p.project_id ORDER BY experience_years DESC) AS rk 
    FROM Project p 
    JOIN Employee e USING (employee_id)) AS T
WHERE rk = 1