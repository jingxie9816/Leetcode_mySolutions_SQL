--  duration is seconds!!!

WITH base as (
SELECT '[0-5>' AS bin
UNION 
SELECT '[5-10>'
UNION 
SELECT '[10-15>'
UNION 
SELECT '15 or more')

SELECT base.*, IFNULL(COUNT(T.session_id),0) AS total
FROM base
LEFT JOIN(
SELECT *,
        CASE WHEN duration/60<5 THEN '[0-5>'
            WHEN duration/60 >= 5 AND duration/60<10 THEN '[5-10>'
            WHEN duration/60 >= 10 AND duration/60 < 15 THEN '[10-15>'
            ELSE '15 or more' 
        END as bin
    FROM Sessions) AS T USING (bin)
GROUP BY bin;