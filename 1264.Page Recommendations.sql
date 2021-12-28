WITH friends AS(
SELECT user1_id as frd_id
    FROM Friendship
    WHERE user2_id = 1
UNION 
SELECT user2_id as frd_id
    FROM Friendship
    WHERE user1_id = 1)

SELECT DISTINCT page_id recommended_page
    FROM Likes 
    WHERE user_id in (SELECT frd_id FROM friends)
    AND page_id NOT IN (SELECT page_id FROM Likes WHERE user_id =1)