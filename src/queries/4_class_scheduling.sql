.open fittrackpro.db
.mode column

-- 4.1 
SELECT
    c.class_id,
    name as class_name,
    s.first_name || ' ' || s.last_name as instructor_name
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
INSERT INTO
    class_attendance
VALUES (
    NULL,
    (
    SELECT
        schedule_id 
    FROM
        class_schedule
    WHERE
        class_id == 1 AND DATE(start_time) == '2025-02-01'
    ),
    11,
    'Registered'
);

-- 4.4 
DELETE FROM
    class_attendance
WHERE
    schedule_id == 7 AND member_id == 3;

-- 4.5 
SELECT
    c.class_id,
    c.name as class_name,
    COUNT(attendance_status) as registration_count
FROM 
    class_schedule cs
INNER JOIN class_attendance ca on ca.schedule_id = cs.schedule_id
INNER JOIN classes c on c.class_id = cs.class_id
WHERE
    attendance_status == 'Registered'
GROUP BY
    c.class_id,
    c.name,
    attendance_status
ORDER BY
    registration_count DESC
LIMIT 1;


-- 4.6 
SELECT
    -- Rounding the average to the 1st DP for readability 
    ROUND(AVG(attendance_count), 1) as average_classes
FROM (
    SELECT
        COUNT(attendance_status) as attendance_count
    FROM
        class_attendance
    WHERE
        attendance_status IN ('Registered', 'Attended')
    GROUP BY
        member_id
);
