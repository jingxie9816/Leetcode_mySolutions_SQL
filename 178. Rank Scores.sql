-- Solution 1: WINDOW FUNCTION 
SELECT score,
       DENSE_RANK() over (order by score DESC) AS  `rank`
    FROM Scores
    ORDER BY score DESC;
    
-- Solution 2: JOIN + COUNT
SELECT a.score,
       COUNT(DISTINCT b.score) AS `rank`
    FROM Scores a
    JOIN Scores b
    WHERE a.score <= b.score
    GROUP BY a.id
    ORDER BY a.score DESC