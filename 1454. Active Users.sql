SELECT DISTINCT id, name
FROM (
SELECT id, tag, COUNT(DISTINCT login_date) as ntag  
FROM (
SELECT id, login_date,
       DATE_SUB(login_date, interval rk day) as tag  
FROM(
SELECT id, login_date,
       DENSE_RANK() OVER (PARTITION BY id ORDER BY login_date) as rk 
    FROM Logins
    ) AS T 
 ) as S 
GROUP BY id, tag
) as M 
JOIN Accounts USING (id)
WHERE ntag >= 5
ORDER BY id;