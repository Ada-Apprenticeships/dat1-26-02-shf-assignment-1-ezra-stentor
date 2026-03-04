.open fittrackpro.db
.mode column

-- 7.1 
SELECT 
    staff_id,
    first_name,
    last_name,
    position as role 
FROM 
    staff
ORDER BY position;


-- 7.2 
SELECT 
    pts.staff_id as trainer_id,
    first_name || ' ' || last_name as trainer_name,
    count(*) as session_count
FROM 
    personal_training_sessions as pts
INNER JOIN staff s on s.staff_id = pts.staff_id
WHERE
    s.position = 'Trainer' AND
    julianday(session_date) - julianday('2025-01-20') BETWEEN 0 AND 30
GROUP BY
    trainer_id;
