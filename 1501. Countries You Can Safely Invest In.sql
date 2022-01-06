SELECT t.name as country
    FROM Calls c
    JOIN Person p ON c.caller_id = p.id OR c.callee_id = p.id
    JOIN Country t ON t.country_code = LEFT(p.phone_number,3)
    GROUP BY country_code
    HAVING AVG(c.duration)>(SELECT AVG(duration) FROM Calls);