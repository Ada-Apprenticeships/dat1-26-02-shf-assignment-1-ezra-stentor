.open fittrackpro.db
.mode column

PRAGMA foreign_keys = ON;

--set up locations table
CREATE TABLE locations
(
    location_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    opening_hours VARCHAR(50),
    CHECK (email LIKE '%@%.%')
);

--members table
CREATE TABLE members
(
    member_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    phone_number VARCHAR(15) NOT NULL,
    date_of_birth TEXT,
    join_date TEXT DEFAULT(DATE('now')),
    emergency_contact_name VARCHAR(50),
    emergency_contact_phone VARCHAR(10),
    CHECK (date_of_birth LIKE '____-__-__'),
    CHECK (join_date LIKE '____-__-__'),
    CHECK (email LIKE '%@%.%')
);


--staff table
CREATE TABLE staff (
    staff_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    phone_number VARCHAR(15) NOT NULL,
    position TEXT,
    hire_date TEXT,
    location_id INTEGER(10) NOT NULL,
    CHECK (hire_date LIKE '____-__-__'),
    CHECK (position in ('Trainer', 'Manager', 'Receptionist', 'Maintenance')),
    CHECK (email LIKE '%@%.%'),

    FOREIGN KEY (location_id) REFERENCES locations(location_id)

);


--equipment table
CREATE TABLE equipment(
equipment_id INTEGER PRIMARY KEY AUTOINCREMENT,
name VARCHAR(30) NOT NULL,
type TEXT NOT NULL,
purchase_date TEXT, 
last_maintenance_date TEXT,	
next_maintenance_date TEXT,	
location_id INTEGER(10) NOT NULL,

CHECK (purchase_date LIKE '____-__-__'),
CHECK (last_maintenance_date LIKE '____-__-__'),
CHECK (next_maintenance_date LIKE '____-__-__'),
CHECK (type in ('Cardio', 'Strength')),
FOREIGN KEY (location_id) REFERENCES locations(location_id)

);


--classes table
CREATE TABLE classes(
class_id INTEGER PRIMARY KEY AUTOINCREMENT,
name VARCHAR(30) NOT NULL,
description VARCHAR(100) NOT NULL,
capacity INTEGER,
duration INTEGER,
location_id INTEGER(10) NOT NULL,

CHECK (capacity > 0),
CHECK (duration > 0),
FOREIGN KEY (location_id) REFERENCES locations(location_id)
);


--class_schedule table
CREATE TABLE class_schedule(
schedule_id INTEGER PRIMARY KEY AUTOINCREMENT,
class_id INTEGER(10) NOT NULL,
staff_id INTEGER(10) NOT NULL,
start_time TEXT,
end_time TEXT,
CHECK (start_time LIKE '____-__-__ __:__:__'),
CHECK (end_time LIKE '____-__-__ __:__:__'),
FOREIGN KEY (class_id) REFERENCES classes(class_id),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)

);


--memberships table
CREATE TABLE memberships(
membership_id INTEGER PRIMARY KEY AUTOINCREMENT,
member_id INTEGER(10) NOT NULL,	
type VARCHAR(50) NOT NULL,
start_date TEXT, 
end_date TEXT,
status TEXT DEFAULT 'Active',

CHECK (start_date LIKE '____-__-__'),
CHECK (end_date LIKE '____-__-__'),

CHECK (status in ('Active', 'Inactive')),
CHECK (end_date > start_date),

FOREIGN KEY (member_id) REFERENCES members(member_id)
);

--attendance table
CREATE TABLE attendance(
attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,
member_id INTEGER(10) NOT NULL,
location_id INTEGER(10) NOT NULL,
check_in_time TEXT DEFAULT (DATETIME('now')), 
check_out_time TEXT,
CHECK (check_out_time IS NULL OR check_out_time > check_in_time),
CHECK (check_in_time LIKE '____-__-__ __:__:__'),
CHECK (check_out_time IS NULL OR check_out_time LIKE '____-__-__ __:__:__'),
FOREIGN KEY (member_id) REFERENCES members(member_id),
FOREIGN KEY (location_id) REFERENCES locations(location_id)
);


--class_attendance table
CREATE TABLE class_attendance(
class_attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,
schedule_id INTEGER(10) NOT NULL,
member_id INTEGER(10) NOT NULL,
attendance_status TEXT,
CHECK (attendance_status in ('Registered', 'Attended', 'Unattended')),
FOREIGN KEY (schedule_id) REFERENCES class_schedule(schedule_id),
FOREIGN KEY (member_id) REFERENCES members(member_id)
);


-- payments table
CREATE TABLE payments(
payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
member_id INTEGER(10) NOT NULL,
amount DECIMAL(10,2), 
payment_date TEXT DEFAULT (DATETIME('now')),
payment_method TEXT,
payment_type TEXT,
CHECK (amount > 0),
CHECK (payment_date LIKE '____-__-__ __:__:__'),
CHECK (payment_method in ('Credit Card', 'Bank Transfer', 'PayPal', 'Cash')),
CHECK (payment_type in ('Monthly membership fee', 'Day pass')),
FOREIGN KEY (member_id) REFERENCES members(member_id)

);


--personal_training_sessions table
CREATE TABLE personal_training_sessions(
session_id INTEGER PRIMARY KEY AUTOINCREMENT,
member_id INTEGER(10) NOT NULL,
staff_id INTEGER(10) NOT NULL,
session_date TEXT,
start_time TEXT,
end_time TEXT, 
notes VARCHAR(100),
CHECK (session_date LIKE '____-__-__'),
CHECK (start_time LIKE '__:__:__'),
CHECK (end_time LIKE '__:__:__'),
FOREIGN KEY (member_id) REFERENCES members(member_id),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

-- member_health_metrics table
CREATE TABLE member_health_metrics(
metric_id INTEGER PRIMARY KEY AUTOINCREMENT,
member_id INTEGER(10) NOT NULL,
measurement_date TEXT, 
weight REAL,
body_fat_percentage REAL,
muscle_mass REAL,
bmi REAL,
CHECK (measurement_date LIKE '____-__-__'),
FOREIGN KEY (member_id) REFERENCES members(member_id)
);

--equipment_maintenance_log table
CREATE TABLE equipment_maintenance_log(
log_id INTEGER PRIMARY KEY AUTOINCREMENT,
equipment_id INTEGER(10) NOT NULL,
maintenance_date TEXT,
description VARCHAR(100),
staff_id INTEGER(10) NOT NULL,
CHECK (maintenance_date LIKE '____-__-__'),
FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);