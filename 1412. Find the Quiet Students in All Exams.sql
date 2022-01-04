WITH high_low as(
SELECT student_id
FROM(
SELECT student_id, exam_id,
       RANK() OVER(PARTITION BY exam_id ORDER BY score ASC) AS rk1,
       RANK() OVER(PARTITION BY exam_id ORDER BY score DESC) AS rk2
    FROM Exam) AS T
WHERE rk1=1 or rk2=1)

SELECT DISTINCT e.student_id, s.student_name
    FROM Exam e 
    LEFT JOIN Student s USING (student_id)
    WHERE e.student_id NOT IN (SELECT DISTINCT student_id FROM high_low)
ORDER BY e.student_id