.open fittrackpro.db
.mode column

-- 8.1 
SELECT 
    session_id,
    m.first_name || ' ' || m.last_name as member_name,
    session_date,
    start_time,
    end_time
FROM 
    personal_training_sessions pts
INNER JOIN members m on m.member_id = pts.member_id
INNER JOIN staff s on s.staff_id = pts.staff_id
WHERE lower(s.first_name) = 'ivy' AND lower(s.last_name) = 'irwin';