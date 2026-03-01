.open fittrackpro.db
.mode box

-- 4.1 
SELECT
    c.class_id,
    name as class_name,
    s.first_name as instructor_name
FROM class_schedule cs
INNER JOIN classes c on c.class_id = cs.class_id
INNER JOIN staff s on s.staff_id = cs.staff_id;

-- 4.2

SELECT
    cs.class_id,
    name,
    start_time,
    end_time,
    -- removing already booked spots
    capacity - count(class_attendance_id) as available_spots
FROM 
    class_schedule cs
INNER JOIN classes c on c.class_id = cs.class_id
LEFT JOIN class_attendance as ca on ca.schedule_id = cs.schedule_id
WHERE date(start_time) == '2025-02-01'
GROUP BY 
    cs.class_id, 
    name,
    start_time,
    end_time,
    capacity;


-- 4.3 


-- 4.4 


-- 4.5 


-- 4.6 

