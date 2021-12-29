SELECT Department, Employee, Salary
FROM (
SELECT d.name Department, 
       e.name Employee, 
       e.salary Salary,
       DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) AS RK
    FROM Department d 
    JOIN Employee e ON d.id = e.departmentId 
) AS T
WHERE RK <= 3