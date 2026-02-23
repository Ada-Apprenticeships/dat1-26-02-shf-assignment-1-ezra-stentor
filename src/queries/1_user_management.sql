.open fittrackpro.db
.mode column

-- 1.1
SELECT
    member_id,
    first_name,
    last_name,
    email,
    join_date
FROM
    members;

-- 1.2

UPDATE members
SET phone_number = '07000 100005', 
email = 'emily.jones.updated@email.com'
WHERE member_id = 5; 

-- 1.3

SELECT count(member_id) as count FROM members;

-- 1.4

SELECT
    class_attendance.member_id,
    first_name,
    last_name,
    count(class_attendance.member_id) as registration_count
FROM class_attendance
INNER JOIN members ON class_attendance.member_id = members.member_id
GROUP BY members.member_id
ORDER BY count(class_attendance.member_id) desc LIMIT 1;

-- 1.5

SELECT
    class_attendance.member_id,
    first_name,
    last_name,
    count(class_attendance.member_id) as registration_count
FROM class_attendance
INNER JOIN members ON class_attendance.member_id = members.member_id
GROUP BY members.member_id
ORDER BY count(class_attendance.member_id) LIMIT 1;

-- 1.6

SELECT 
    count(*) as Count
FROM 
(
    SELECT
        count(member_id) as count
    FROM class_attendance
    WHERE attendance_status == 'Attended'
    GROUP BY member_id
)
WHERE count >= 2;
