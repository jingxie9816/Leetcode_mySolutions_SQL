WITH tb1 AS(
SELECT COUNT(*) FROM(
SELECT COUNT(*)
    FROM FriendRequest
    GROUP BY sender_id, send_to_id) as S),

tb2 AS(
SELECT COUNT(*) FROM(
SELECT COUNT(*)
    FROM RequestAccepted
    GROUP BY requester_id, accepter_id) as T)

SELECT 
    ROUND(ifnull((SELECT * FROM tb2)/(
        SELECT * FROM tb1),0),2)  accept_rate