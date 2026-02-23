.open fittrackpro.db
.mode column

PRAGMA foreign_keys = ON;

--set up locations table
CREATE TABLE locations
(
    location_id INTEGER(10) PRIMARY KEY NOT NULL,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(100) NOT NULL,
    phone_number VARCHAR(10) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    opening_hours VARCHAR(50)
);

--members table
CREATE TABLE members
(
    member_id INTEGER(10) PRIMARY KEY NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    phone_number VARCHAR(10) NOT NULL,
    date_of_birth TEXT,
    join_date TEXT DEFAULT(DATE('now')),
    emergency_contact_name VARCHAR(50),
    emergency_contact_phone VARCHAR(10)
    --CHECK (date_of_birth < DATE('now'))
);


--staff table
CREATE TABLE staff (
    staff_id INTEGER(10) PRIMARY KEY NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    phone_number VARCHAR(10) NOT NULL,
    position TEXT,
    hire_date TEXT,
    location_id INTEGER(10),

    CHECK (position in ('Trainer', 'Manager', 'Receptionist', 'Maintenance')),

    FOREIGN KEY (location_id) REFERENCES locations(location_id)

);


--equipment table
CREATE TABLE equipment(
equipment_id INTEGER(10) PRIMARY KEY NOT NULL,
name VARCHAR(30) NOT NULL,
type TEXT NOT NULL,
purchase_date TEXT, --yyyy-mm-dd
last_maintenance_date TEXT,	--yyyy-mm-dd
next_maintenance_date TEXT,	--yyyy-mm-dd
location_id INTEGER(10),

CHECK (type in ('Cardio', 'Strength')),
FOREIGN KEY (location_id) REFERENCES locations(locations_id)

);


--classes table
CREATE TABLE classes(
class_id INTEGER(10) PRIMARY KEY NOT NULL,
name VARCHAR(30) NOT NULL,
description VARCHAR(100) NOT NULL,
capacity INTEGER, --30
duration FLOAT(20) ,--20
location_id INTEGER(10), --FK
FOREIGN KEY (location_id) REFERENCES locations(locations_id)

);


--class_schedule table
CREATE TABLE class_schedule(
schedule_id INTEGER(10) PRIMARY KEY NOT NULL,
class_id INTEGER(10) NOT NULL,
staff_id INTEGER(10) NOT NULL,
start_time TEXT,--	"yyyy-mm-dd hh:mm:ss"
end_time TEXT,	--"yyyy-mm-dd hh:mm:ss"


FOREIGN KEY (class_id) REFERENCES classes(class_id),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)

);


--memberships table
CREATE TABLE memberships(
membership_id INTEGER(10) PRIMARY KEY NOT NULL,
member_id INTEGER(10) NOT NULL,	--FK
type VARCHAR(50) NOT NULL,
start_date TEXT, --	"yyyy-mm-dd"
end_date TEXT,--"yyyy-mm-dd"
status TEXT,

CHECK (status in ('Active', 'Inactive')),

FOREIGN KEY (member_id) REFERENCES members(member_id)
);

--attendance table
CREATE TABLE attendance(
attendance_id INTEGER(10) PRIMARY KEY NOT NULL,
member_id INTEGER(10) NOT NULL,
location_id INTEGER(10) NOT NULL,
check_in_time TEXT, --	yyyy-mm-dd hh:mm:ss
check_out_time TEXT,--	yyyy-mm-dd hh:mm:ss


FOREIGN KEY (member_id) REFERENCES members(member_id),
FOREIGN KEY (location_id) REFERENCES locations(locations_id)
);


--class_attendance table
CREATE TABLE class_attendance(
class_attendance_id INTEGER(10) PRIMARY KEY NOT NULL,
schedule_id INTEGER(10),
member_id INTEGER(10),
attendance_status TEXT,

CHECK (attendance_status in ('Registered', 'Attended', 'Unattended')),
FOREIGN KEY (schedule_id) REFERENCES class_schedule(schedule_id),
FOREIGN KEY (member_id) REFERENCES members(member_id)
);


-- payments table
CREATE TABLE payments(
payment_id INTEGER(10) PRIMARY KEY NOT NULL,
member_id INTEGER(10),
amount FLOAT(1000), 
payment_date TEXT,	--yyyy-mm-dd hh:mm:ss
payment_method TEXT,
payment_type TEXT,

CHECK (payment_method in ('Credit Card', 'Bank Transfer', 'PayPal', 'Cash'))
CHECK (payment_type in ('Monthly membership fee', 'Day pass'))
FOREIGN KEY (member_id) REFERENCES members(member_id)

);


--personal_training_sessions table
CREATE TABLE personal_training_sessions(
session_id INTEGER(10) PRIMARY KEY NOT NULL,
member_id INTEGER(10),
staff_id INTEGER(10),
session_date TEXT, --yyyy-mm-dd
start_time TEXT, --	hh:mm:ss
end_time TEXT, 	--hh:mm:ss
notes VARCHAR(100),

FOREIGN KEY (member_id) REFERENCES members(member_id)
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

-- member_health_metrics table
CREATE TABLE member_health_metrics(
metric_id INTEGER(10) PRIMARY KEY NOT NULL,
member_id INTEGER(10),
measurement_date TEXT, --	yyyy-mm-dd
weight FLOAT(1000), 	--64.5
body_fat_percentage FLOAT(1000), 	--20.0
muscle_mass FLOAT(1000), 	--50.0
bmi FLOAT(1000),--23.5

FOREIGN KEY (member_id) REFERENCES members(member_id)
);

--equipment_maintenance_log table
CREATE TABLE equipment_maintenance_log(
log_id INTEGER(10) PRIMARY KEY NOT NULL,
equipment_id INTEGER(10),
maintenance_date TEXT,	--yyyy-mm-dd
description VARCHAR(100),
staff_id INTEGER(10),

FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);