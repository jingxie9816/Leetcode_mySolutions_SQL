CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      # Write your MySQL query statement below.
      SELECT CASE WHEN N>MAX(rk) THEN null
                  ELSE salary END
    FROM(
      SELECT salary,
             DENSE_RANK() OVER (ORDER BY salary DESC) rk 
        FROM Employee) AS T 
    WHERE rk = N
  );
END