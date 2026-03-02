.open fittrackpro.db
.mode box

-- 6.1 

INSERT INTO
    attendance
VALUES(4, 7, 1, '2025-02-14 16:30:00');

-- 6.2 

-- Task: Get attendance history for member with ID 5
SELECT
    DATE(check_in_time) as visit_date,
    check_in_time,
    check_out_time
FROM
    attendance
WHERE
    member_id == 5;

-- 6.3 

-- 6.3. Find the busiest day of the week based on gym visits
-- Task: Identify the busiest day of the week based on gym visits
-- day_of_week | visit_count 

SELECT
    DATENAME('dw', check_in_time) as weekday
FROM 
    attendance;


-- 6.4 

-- 6.4. Calculate the average daily attendance for each location
-- Task: Calculate the average daily attendance for each location
-- Details: including "no show" days
-- Output: A result set with columns:

-- location_name | avg_daily_attendance

