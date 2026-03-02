.open fittrackpro.db
.mode column

-- 5.1 
SELECT 
    m.member_id,
    first_name,
    last_name,
    type as membership_type,
    join_date
FROM
    memberships ms
INNER JOIN members m on m.member_id = ms.member_id
WHERE status == 'Active';

-- 5.2 
SELECT 
    type as membership_type,
    AVG(
        (strftime('%s', check_out_time) / 60) - (strftime('%s', check_in_time) / 60)
    ) as avg_visit_duration_minutes
FROM
    attendance a
INNER JOIN members m on m.member_id = a.member_id
INNER JOIN memberships ms on ms.member_id  = a.member_id
GROUP BY type;

-- 5.3 

SELECT 
    m.member_id,
    first_name,
    last_name,
    email,
    end_date
FROM
    members m
INNER JOIN memberships ms on ms.member_id = m.member_id
WHERE
    strftime('%Y',end_date) == '2025'
    -- excluding already expired memberships
    and lower(status) == 'active';