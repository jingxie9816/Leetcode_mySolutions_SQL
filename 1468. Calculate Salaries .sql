-- Solution 1: 
-- 1. Maximun salary in each compancy (group by)
-- 2. determine tax rate based on the range of max salary (CASE WHEN)
-- 3. compute the salary after tax
SELECT s.company_id, s.employee_id, s.employee_name,
       ROUND(s.salary * (1-M.tax_rate),0) as salary
FROM Salaries s 
JOIN (
SELECT company_id,
    CASE WHEN max_salary < 1000 THEN 0
         WHEN max_salary >= 1000 AND max_salary <= 10000 THEN 0.24
         ELSE 0.49
    END AS tax_rate
FROM(
SELECT company_id,
       MAX(salary) as max_salary
    FROM Salaries
    GROUP BY company_id
) AS T 
) AS M USING (company_id);


-- Solution2:
-- Combine the step of CASE WHEN and MAX()
SELECT s.company_id, s.employee_id, s.employee_name,
       ROUND(s.salary * (1-M.tax_rate),0) as salary
FROM Salaries s 
JOIN (
SELECT company_id,
    CASE WHEN max_salary < 1000 THEN 0
         WHEN max_salary >= 1000 AND max_salary <= 10000 THEN 0.24
         ELSE 0.49
    END AS tax_rate
FROM(
SELECT company_id,
       MAX(salary) as max_salary
    FROM Salaries
    GROUP BY company_id
) AS T 
) AS M USING (company_id);


-- Solution 3:
-- Window Function MAX()
SELECT s.company_id, s.employee_id, s.employee_name, 
       ROUND(s.salary * (1-T.tax_rate),0) as salary
FROM Salaries s
JOIN (
SELECT DISTINCT company_id,
    CASE WHEN (MAX(salary) OVER (PARTITION BY company_id)) <1000 THEN 0
         WHEN (MAX(salary) OVER (PARTITION BY company_id)) BETWEEN 1000 AND 10000 THEN 0.24
         ELSE 0.49
    END as tax_rate
FROM Salaries
) AS T USING (company_id);
