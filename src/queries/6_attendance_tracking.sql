.open fittrackpro.db
.mode column

-- 6.1 
INSERT INTO
    attendance
VALUES(NULL, 7, 1, '2025-02-14 16:30:00', null);

-- 6.2 
SELECT
    DATE(check_in_time) as visit_date,
    check_in_time,
    check_out_time
FROM
    attendance
WHERE
    member_id = 5;

-- 6.3 
SELECT
    -- mapping number to name for readablility 
    CASE CAST(week_num as integer)
        WHEN 0 THEN 'Sunday'
        WHEN 1 THEN 'Monday'
        WHEN 2 THEN 'Tuesday'
        WHEN 3 THEN 'Wednesday'
        WHEN 4 THEN 'Thursday'
        WHEN 5 THEN 'Friday'
        ELSE 'Saturday'
    END AS day_of_week,
    visit_count
FROM
    --using subquries for efficiency 
    (SELECT
        strftime('%w', check_in_time) as week_num,
        count(attendance_id) as visit_count
    FROM
        attendance
    GROUP BY 
        strftime('%w', check_in_time)
    ORDER BY
        count(attendance_id) DESC
    LIMIT 1
    );


-- 6.4 
SELECT
    name as location_name,
    ROUND(
        COUNT(a.attendance_id) * 1.0
        -- handling where the location has no attendance 
        / COALESCE(NULLIF(JULIANDAY(MAX(a.check_in_time)) - JULIANDAY(MIN(a.check_in_time)) + 1, 0), 1),
        2
    ) AS avg_daily_attendance
FROM
    locations l
LEFT JOIN attendance a on a.location_id = l.location_id
GROUP BY
    l.location_id,
    name;