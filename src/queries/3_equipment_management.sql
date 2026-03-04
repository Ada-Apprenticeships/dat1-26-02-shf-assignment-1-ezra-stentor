.open fittrackpro.db
.mode column

-- 3.1 
SELECT
    equipment_id,
    name,
    next_maintenance_date    
FROM equipment
WHERE julianday(next_maintenance_date) - julianday('2025-01-01') <= 30;

-- 3.2 
SELECT 
    type as equipment_type,
    count(type) as count
FROM equipment
GROUP BY type;

-- 3.3 
SELECT 
    type as equipment_type,
    -- rounding to make the display clear
    ROUND(AVG(julianday('now') - julianday(purchase_date)),2) as avg_age_days
FROM equipment
GROUP BY type;