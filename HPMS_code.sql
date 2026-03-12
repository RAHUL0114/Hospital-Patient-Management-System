CREATE DATABASE hospital_patient_management_system;

USE hospital_patient_management_system;

CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(100) NOT NULL UNIQUE,
    dept_phone VARCHAR(15),
    email VARCHAR(100)
);

CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_name VARCHAR(100) NOT NULL,
    age INT CHECK (age > 0),
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    blood_group VARCHAR(5),
    address VARCHAR(255),
    phone_number VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);


CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT,
    appointment_date DATETIME NOT NULL,
    appointment_status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    reason VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);


CREATE TABLE Medical_Tests (
    test_id INT PRIMARY KEY AUTO_INCREMENT,
    test_name VARCHAR(100) NOT NULL,
    appointment_id INT,
    test_fees DECIMAL(8,2) NOT NULL,
    test_date DATE NOT NULL,
    result VARCHAR(100),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Billing (
    billing_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    test_id INT,
    amount DECIMAL(10,2) NOT NULL,
    payment_status ENUM('Paid', 'Unpaid', 'Pending') DEFAULT 'Pending',
    payment_date DATETIME,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (test_id) REFERENCES Medical_Tests(test_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);


CREATE TABLE Room_Allocation (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_type ENUM('Private', 'Semi-private', 'General') NOT NULL,
    patient_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE,
    room_status VARCHAR(20) DEFAULT 'Occupied',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE Staff_Allocation (
    staff_id INT PRIMARY KEY,
    staff_name VARCHAR(100) NOT NULL,
    room_id INT NOT NULL,
    assigned_from DATE NOT NULL,
    assigned_to DATE,
    FOREIGN KEY (room_id) REFERENCES Room_Allocation(room_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE Staff_Allocation DROP PRIMARY KEY;


SHOW TABLES;

INSERT INTO Departments (dept_name, dept_phone, email) VALUES
('Cardiology', '9876543210', 'cardio@hospital.com'),
('Neurology', '9876543211', 'neuro@hospital.com'),
('Orthopedics', '9876543212', 'ortho@hospital.com'),
('Pediatrics', '9876543213', 'pediatrics@hospital.com'),
('Oncology', '9876543214', 'oncology@hospital.com'),
('Emergency', '9876543215', 'emergency@hospital.com'),
('Radiology', '9876543216', 'radiology@hospital.com'),
('Dermatology', '9876543217', 'derma@hospital.com'),
('ENT', '9876543218', 'ent@hospital.com'),
('General Medicine', '9876543219', 'genmed@hospital.com');

INSERT INTO Patients (patient_name, age, gender, blood_group, address, phone_number, email) VALUES
('John Doe', 35, 'Male', 'A+', '123 Street, City', '9000000001', 'john@example.com'),
('Jane Smith', 28, 'Female', 'B+', '456 Avenue, City', '9000000002', 'jane@example.com'),
('Raj Kumar', 42, 'Male', 'O+', '789 Road, Town', '9000000003', 'raj@example.com'),
('Anita Roy', 30, 'Female', 'AB-', 'Central Plaza, City', '9000000004', 'anita@example.com'),
('Imran Ali', 60, 'Male', 'B-', 'West End, City', '9000000005', 'imran@example.com'),
('Sara Paul', 22, 'Female', 'A-', 'Near Lake, Town', '9000000006', 'sara@example.com'),
('Nikhil Mehta', 55, 'Male', 'O-', 'Hill Top, City', '9000000007', 'nikhil@example.com'),
('Meena Das', 40, 'Female', 'AB+', 'Market Road, Town', '9000000008', 'meena@example.com'),
('Rohit Singh', 27, 'Male', 'A+', 'City Mall, Metro', '9000000009', 'rohit@example.com'),
('Priya Verma', 33, 'Female', 'B+', 'Garden Area, Metro', '9000000010', 'priya@example.com'),
('Allison Hill', 82, 'Male', 'A+', '819 Johnson Course, East William, OH 26563', '9896233790', 'shaneramirez@gmail.com'),
('Andrew Stevens', 12, 'Male', 'B-', '84959 Janet Cape Apt. 413, South Joshuastad, MN 47067', '9642621108', 'jacqueline19@jackson.biz'),
('Melanie Bell', 61, 'Female', 'B+', '984 Davis Ridges, South Carrie, PA 42989', '9973750319', 'wclark@yahoo.com'),
('Samantha Young', 66, 'Female', 'AB-', '18392 James Point, South Staceyfurt, SD 23531', '9745981542', 'johnnymartinez@hotmail.com'),
('Aaron Kennedy', 78, 'Male', 'O+', '13284 Hoffman Views Apt. 263, Harristown, SC 38557', '9994018553', 'yvalencia@gmail.com'),
('Travis Thompson', 5, 'Male', 'O-', '47329 Becky View Apt. 727, New Tammy, OR 22843', '9747497380', 'paulcasey@hotmail.com'),
('Crystal Munoz', 13, 'Female', 'O-', '64625 Vasquez Inlet Suite 737, Smithborough, GA 66212', '9748933027', 'brownsteven@hudson.org'),
('Brent Wilson', 83, 'Male', 'AB+', '70599 Sandoval Plaza Apt. 631, Caldwellsidetown, AL 16600', '9994339920', 'lbradley@hotmail.com'),
('Brian Stanley', 10, 'Male', 'AB-', '384 Mary Crescent, Barreratown, UT 48939', '9930269855', 'patrick78@webster.com'),
('Derek Thomas', 16, 'Male', 'A+', '947 Taylor Hollow Suite 488, Kimton, NE 96777', '9765055833', 'anthony39@hotmail.com');



INSERT INTO Doctors (doctor_name, specialization, phone, email, department_id) VALUES
('Dr. Suresh Nair', 'Cardiologist', '8000000001', 'suresh@hospital.com', 1),
('Dr. Neha Kapoor', 'Neurologist', '8000000002', 'neha@hospital.com', 2),
('Dr. Amit Rana', 'Orthopedic', '8000000003', 'amit@hospital.com', 3);


INSERT INTO Appointments (patient_id, doctor_id, appointment_date, appointment_status, reason) VALUES
(1, 1, '2025-06-01 09:00:00', 'Completed', 'Routine Checkup'),
(1, 2, '2025-06-15 10:00:00', 'Scheduled', 'Follow-up Visit'),
(2, 2, '2025-06-03 11:00:00', 'Completed', 'Fever and Cold'),
(2, 1, '2025-06-17 14:30:00', 'Scheduled', 'Fatigue'),
(2, 3, '2025-06-24 13:00:00', 'Cancelled', 'Migraine'),
(3, 1, '2025-06-05 09:30:00', 'Completed', 'Blood Pressure Check'),
(3, 2, '2025-06-19 11:00:00', 'Scheduled', 'Chest Pain'),
(4, 3, '2025-06-07 12:00:00', 'Completed', 'Back Pain'),
(4, 1, '2025-06-21 10:15:00', 'Scheduled', 'Neck Stiffness'),
(5, 2, '2025-06-09 10:45:00', 'Completed', 'Diabetes Check'),
(5, 1, '2025-06-25 09:00:00', 'Scheduled', 'Skin Rash'),
(6, 1, '2025-06-11 15:00:00', 'Completed', 'Allergy Symptoms'),
(6, 3, '2025-06-27 14:30:00', 'Scheduled', 'Cough & Cold'),
(7, 3, '2025-06-13 09:15:00', 'Scheduled', 'Chest Pain'),
(7, 2, '2025-06-28 10:30:00', 'Completed', 'Fatigue Check'),
(8, 1, '2025-06-15 11:30:00', 'Completed', 'Migraine'),
(8, 3, '2025-06-30 13:00:00', 'Scheduled', 'Follow-up Visit'),
(9, 2, '2025-06-17 10:45:00', 'Completed', 'General Checkup'),
(9, 1, '2025-07-01 15:00:00', 'Scheduled', 'Back Ache'),
(10, 3, '2025-06-19 13:00:00', 'Cancelled', 'Skin Allergy'),
(10, 2, '2025-07-02 14:15:00', 'Scheduled', 'Diet Consultation'),
(11, 1, '2025-06-21 09:30:00', 'Completed', 'High Fever'),
(11, 3, '2025-07-03 12:00:00', 'Scheduled', 'General Illness'),
(12, 2, '2025-06-23 11:00:00', 'Completed', 'Sprain'),
(12, 1, '2025-07-04 10:30:00', 'Scheduled', 'Routine Checkup'),
(13, 3, '2025-06-25 14:00:00', 'Completed', 'BP Monitoring'),
(13, 1, '2025-07-05 09:45:00', 'Scheduled', 'Heart Checkup'),
(14, 2, '2025-06-27 15:30:00', 'Completed', 'Arthritis Pain'),
(14, 3, '2025-07-06 10:00:00', 'Scheduled', 'Joint Swelling'),
(15, 1, '2025-06-29 10:15:00', 'Completed', 'Routine Checkup'),
(15, 2, '2025-07-07 11:30:00', 'Scheduled', 'Blood Sugar'),
(16, 3, '2025-07-01 13:15:00', 'Completed', 'Cold and Cough'),
(16, 1, '2025-07-08 09:30:00', 'Scheduled', 'Allergy'),
(17, 2, '2025-07-03 11:45:00', 'Completed', 'General Check'),
(17, 3, '2025-07-09 14:00:00', 'Scheduled', 'Vision Problem'),
(18, 1, '2025-07-05 15:00:00', 'Scheduled', 'Ear Pain'),
(18, 2, '2025-07-10 12:30:00', 'Completed', 'Throat Infection'),
(19, 3, '2025-07-07 10:45:00', 'Scheduled', 'Flu Symptoms'),
(19, 1, '2025-07-11 13:30:00', 'Completed', 'Coughing'),
(20, 2, '2025-07-09 11:15:00', 'Completed', 'Injury Follow-up'),
(20, 3, '2025-07-12 10:00:00', 'Scheduled', 'Headache');

INSERT INTO Medical_Tests (test_name, appointment_id, test_fees, test_date, result) VALUES
('ECG', 1, 1200.00, '2025-06-25', 'Normal'),
('MRI Brain', 2, 8000.00, '2025-06-26', 'Normal'),
('X-Ray Spine', 3, 1500.00, '2025-06-27', 'Mild disc bulge'),
('Blood Test', 4, 500.00, '2025-06-28', 'Viral'),
('CT Scan', 5, 7000.00, '2025-06-29', 'Under Review'),
('CBC', 6, 300.00, '2025-06-30', 'Normal'),
('Chest X-Ray', 7, 1000.00, '2025-07-01', 'Clear'),
('Skin Biopsy', 8, 2000.00, '2025-07-02', 'Benign'),
('Audiometry', 9, 1200.00, '2025-07-03', 'Moderate loss'),
('Thyroid Profile', 10, 600.00, '2025-07-04', 'Slightly high TSH');


INSERT INTO Billing (patient_id, test_id, amount, payment_status, payment_date) VALUES
(1, 1, 1200.00, 'Paid', '2025-06-26'),
(1, 2, 8000.00, 'Pending', NULL),
(2, 3, 1500.00, 'Paid', '2025-06-28'),
(2, 4, 500.00, 'Paid', '2025-06-29'),
(3, 5, 7000.00, 'Pending', NULL),
(3, 6, 300.00, 'Paid', '2025-06-30'),
(4, 7, 1000.00, 'Paid', '2025-07-01'),
(5, 9, 1200.00, 'Pending', NULL),
(5, 10, 600.00, 'Paid', '2025-07-05'),
(6, 1, 1200.00, 'Paid', '2025-07-06'),
(6, 2, 8000.00, 'Paid', '2025-07-06'),
(7, 3, 1500.00, 'Pending', NULL),
(7, 4, 500.00, 'Paid', '2025-07-07'),
(8, 6, 300.00, 'Paid', '2025-07-08'),
(9, 7, 1000.00, 'Paid', '2025-07-08'),
(9, 8, 2000.00, 'Pending', NULL),
(10, 9, 1200.00, 'Paid', '2025-07-09'),
(10, 10, 600.00, 'Paid', '2025-07-09'),
(11, 1, 1200.00, 'Pending', NULL),
(11, 2, 8000.00, 'Paid', '2025-07-10'),
(12, 3, 1500.00, 'Paid', '2025-07-11'),
(12, 4, 500.00, 'Paid', '2025-07-11'),
(13, 5, 7000.00, 'Paid', '2025-07-11'),
(13, 6, 300.00, 'Pending', NULL),
(14, 8, 2000.00, 'Paid', '2025-07-12'),
(15, 9, 1200.00, 'Paid', '2025-07-12'),
(15, 10, 600.00, 'Paid', '2025-07-12'),
(16, 1, 1200.00, 'Pending', NULL),
(16, 2, 8000.00, 'Paid', '2025-07-13'),
(17, 3, 1500.00, 'Paid', '2025-07-13'),
(17, 4, 500.00, 'Paid', '2025-07-13'),
(18, 5, 7000.00, 'Paid', '2025-07-14'),
(19, 7, 1000.00, 'Paid', '2025-07-14'),
(19, 8, 2000.00, 'Paid', '2025-07-14'),
(20, 9, 1200.00, 'Pending', NULL),
(20, 10, 600.00, 'Paid', '2025-07-15');

INSERT INTO Room_Allocation (room_type, patient_id, check_in_date, check_out_date, room_status) VALUES
('Private', 1, '2025-06-01', '2025-06-05', 'Discharged'),
('Semi-private', 1, '2025-06-15', NULL, 'Occupied'),
('Semi-private', 2, '2025-06-02', '2025-06-06', 'Discharged'),
('Private', 2, '2025-06-20', NULL, 'Occupied'),
('Private', 3, '2025-06-03', '2025-06-07', 'Discharged'),
('Private', 4, '2025-06-04', '2025-06-08', 'Discharged'),
('Semi-private', 4, '2025-06-28', NULL, 'Occupied'),
('Semi-private', 5, '2025-06-05', NULL, 'Occupied'),
('Private', 6, '2025-06-06', '2025-06-09', 'Discharged'),
('Private', 6, '2025-06-26', NULL, 'Occupied'),
('Semi-private', 7, '2025-06-07', '2025-06-10', 'Discharged'),
('Private', 8, '2025-06-08', '2025-06-11', 'Discharged'),
('Private', 8, '2025-06-30', NULL, 'Occupied'),
('Semi-private', 9, '2025-06-09', '2025-06-12', 'Discharged'),
('Private', 10, '2025-06-10', NULL, 'Occupied'),
('Semi-private', 11, '2025-06-11', '2025-06-14', 'Discharged'),
('Private', 11, '2025-07-01', NULL, 'Occupied'),
('Private', 12, '2025-06-12', '2025-06-15', 'Discharged'),
('Semi-private', 13, '2025-06-13', NULL, 'Occupied'),
('Private', 14, '2025-06-14', '2025-06-17', 'Discharged'),
('Private', 14, '2025-07-03', NULL, 'Occupied'),
('Semi-private', 15, '2025-06-15', '2025-06-18', 'Discharged'),
('Private', 16, '2025-06-16', '2025-06-19', 'Discharged'),
('Semi-private', 16, '2025-07-04', NULL, 'Occupied'),
('Private', 17, '2025-06-17', NULL, 'Occupied'),
('Private', 18, '2025-06-18', '2025-06-21', 'Discharged'),
('Semi-private', 18, '2025-07-05', NULL, 'Occupied'),
('Private', 19, '2025-06-19', NULL, 'Occupied'),
('Semi-private', 20, '2025-06-20', '2025-06-23', 'Discharged'),
('Private', 20, '2025-07-06', NULL, 'Occupied');


INSERT INTO Staff_Allocation (staff_id, staff_name, room_id, assigned_from, assigned_to) VALUES
(1, 'Dr. Suresh Nair', 1, '2025-06-01', '2025-06-10'),
(1, 'Dr. Suresh Nair', 5, '2025-06-11', '2025-06-20'),
(1, 'Dr. Suresh Nair', 9, '2025-06-21', NULL),
(2, 'Dr. Neha Kapoor', 2, '2025-06-02', '2025-06-12'),
(2, 'Dr. Neha Kapoor', 6, '2025-06-13', '2025-06-22'),
(2, 'Dr. Neha Kapoor', 10, '2025-06-23', NULL),
(3, 'Dr. Amit Rana', 3, '2025-06-03', '2025-06-14'),
(3, 'Dr. Amit Rana', 7, '2025-06-15', '2025-06-25'),
(3, 'Dr. Amit Rana', 11, '2025-06-26', NULL),
(4, 'Nurse Kavita Rao', 1, '2025-06-01', '2025-06-10'),
(4, 'Nurse Kavita Rao', 3, '2025-06-11', '2025-06-20'),
(4, 'Nurse Kavita Rao', 7, '2025-06-21', NULL),
(5, 'Nurse Ramesh Yadav', 2, '2025-06-01', '2025-06-10'),
(5, 'Nurse Ramesh Yadav', 6, '2025-06-11', '2025-06-18'),
(5, 'Nurse Ramesh Yadav', 10, '2025-06-19', NULL),
(6, 'Nurse Anjali Das', 4, '2025-06-05', '2025-06-15'),
(6, 'Nurse Anjali Das', 8, '2025-06-16', '2025-06-25'),
(6, 'Nurse Anjali Das', 12, '2025-06-26', NULL);




-- Full Patient Lifecycle Report with Revenue, Room, and Doctor Summary


SELECT 
    p.patient_id,
    p.patient_name,
    COUNT(DISTINCT a.appointment_id) AS total_appointments,
    COUNT(DISTINCT m.test_id) AS total_tests,
    SUM(b.amount) AS total_billed_amount,
    GROUP_CONCAT(DISTINCT d.doctor_name) AS consulted_doctors,
    GROUP_CONCAT(DISTINCT r.room_type) AS room_types_used
FROM Patients p
LEFT JOIN Appointments a ON p.patient_id = a.patient_id
LEFT JOIN Doctors d ON a.doctor_id = d.doctor_id
LEFT JOIN Medical_Tests m ON a.appointment_id = m.appointment_id
LEFT JOIN Billing b ON m.test_id = b.test_id
LEFT JOIN Room_Allocation r ON p.patient_id = r.patient_id
GROUP BY p.patient_id
ORDER BY total_billed_amount DESC;



--  Monthly Department Revenue & Appointment Load Report

SELECT 
    DATE_FORMAT(a.appointment_date, '%Y-%m') AS month,
    dept.dept_name,
    COUNT(DISTINCT a.appointment_id) AS total_appointments,
    SUM(b.amount) AS total_revenue
FROM Appointments a
JOIN Doctors d ON a.doctor_id = d.doctor_id
JOIN Departments dept ON d.department_id = dept.department_id
LEFT JOIN Medical_Tests m ON a.appointment_id = m.appointment_id
LEFT JOIN Billing b ON m.test_id = b.test_id AND b.payment_status = 'Paid'
GROUP BY month, dept.dept_name
ORDER BY month DESC, total_revenue DESC;

-- Doctor Performance: Patients Treated, Avg Billing, Test Coverage

SELECT 
    d.doctor_id, d.doctor_name,
    COUNT(DISTINCT a.patient_id) AS total_patients,
    COUNT(DISTINCT a.appointment_id) AS total_appointments,
    ROUND(AVG(b.amount), 2) AS avg_billed_per_patient,
    COUNT(DISTINCT m.test_id) AS total_tests_requested
FROM Doctors d
LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id
LEFT JOIN Medical_Tests m ON a.appointment_id = m.appointment_id
LEFT JOIN Billing b ON m.test_id = b.test_id AND b.payment_status = 'Paid'
GROUP BY d.doctor_id
ORDER BY total_patients DESC, avg_billed_per_patient DESC;


-- Patients With the Highest Cost per Test

SELECT 
    p.patient_id, p.patient_name,
    ROUND(SUM(b.amount)/COUNT(m.test_id), 2) AS avg_cost_per_test
FROM Patients p
JOIN Appointments a ON p.patient_id = a.patient_id
JOIN Medical_Tests m ON a.appointment_id = m.appointment_id
JOIN Billing b ON m.test_id = b.test_id
WHERE b.payment_status = 'Paid'
GROUP BY p.patient_id
ORDER BY avg_cost_per_test DESC
LIMIT 10;


-- Doctors With No Appointments in Last 90 Days 

SELECT doctor_id, doctor_name
FROM Doctors
WHERE doctor_id NOT IN (
    SELECT DISTINCT doctor_id
    FROM Appointments
    WHERE appointment_date >= CURDATE() - INTERVAL 90 DAY
);

-- Patients With Highest Revenue Generated per Visit


SELECT 
    p.patient_id,
    p.patient_name,
    COUNT(DISTINCT a.appointment_id) AS total_visits,
    SUM(b.amount) AS total_billed,
    ROUND(SUM(b.amount)/COUNT(DISTINCT a.appointment_id), 2) AS avg_per_visit
FROM Patients p
JOIN Appointments a ON p.patient_id = a.patient_id
JOIN Medical_Tests m ON a.appointment_id = m.appointment_id
JOIN Billing b ON m.test_id = b.test_id
WHERE b.payment_status = 'Paid'
GROUP BY p.patient_id
HAVING total_visits >= 2
ORDER BY avg_per_visit DESC
LIMIT 10;

-- Appointment with more than 2 tests


SELECT appointment_id, patient_id
FROM Appointments
WHERE appointment_id IN (
    SELECT appointment_id
    FROM Medical_Tests
    GROUP BY appointment_id
    HAVING COUNT(*) > 2
);

-- Tests That Cost More Than the Patient’s Average Bill

SELECT m.test_id, m.test_name, m.test_fees, p.patient_id, p.patient_name
FROM Medical_Tests m
JOIN Appointments a ON m.appointment_id = a.appointment_id
JOIN Patients p ON a.patient_id = p.patient_id
WHERE m.test_fees > (
    SELECT AVG(amount)
    FROM Billing b
    WHERE b.patient_id = p.patient_id
);


-- Patients With Highest Bill Per Visit

SELECT patient_id, patient_name
FROM (
    SELECT 
        p.patient_id,
        p.patient_name,
        SUM(b.amount) / COUNT(DISTINCT a.appointment_id) AS avg_bill_per_visit
    FROM Patients p
    JOIN Appointments a ON p.patient_id = a.patient_id
    JOIN Medical_Tests m ON a.appointment_id = m.appointment_id
    JOIN Billing b ON m.test_id = b.test_id
    GROUP BY p.patient_id
) AS patient_avg
WHERE avg_bill_per_visit = (
    SELECT MAX(avg_bill)
    FROM (
        SELECT 
            SUM(b.amount) / COUNT(DISTINCT a.appointment_id) AS avg_bill
        FROM Patients p
        JOIN Appointments a ON p.patient_id = a.patient_id
        JOIN Medical_Tests m ON a.appointment_id = m.appointment_id
        JOIN Billing b ON m.test_id = b.test_id
        GROUP BY p.patient_id
    ) AS avg_table
);


-- Percentage of Rooms Occupied by room_type

SELECT 
    room_type,
    COUNT(DISTINCT room_id) AS rooms_occupied,
    ROUND((COUNT(DISTINCT room_id) * 100.0) / 
        (SELECT COUNT(DISTINCT room_id) FROM Room_Allocation), 2) AS occupancy_percentage
FROM Room_Allocation
GROUP BY room_type;


-- Patients Who Revisited Within 30 Days of Last Visit 

SELECT DISTINCT
    a1.patient_id,
    p.patient_name,
    a1.appointment_date AS earlier_visit,
    a2.appointment_date AS revisit_within_30_days
FROM Appointments a1
JOIN Appointments a2 
    ON a1.patient_id = a2.patient_id
   AND a2.appointment_date > a1.appointment_date
   AND DATEDIFF(a2.appointment_date, a1.appointment_date) <= 30
JOIN Patients p ON a1.patient_id = p.patient_id
ORDER BY a1.patient_id, a1.appointment_date;

-- View All Upcoming Appointments (Next 7 Days)


SELECT 
    a.appointment_id,
    p.patient_name,
    d.doctor_name,
    a.appointment_date,
    a.reason
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id
WHERE a.appointment_date >= CURDATE()
  AND a.appointment_date < CURDATE() + INTERVAL 7 DAY
  AND a.appointment_status = 'Scheduled';
  

-- Remove cancelled appointments older than 30 days


DELETE FROM Appointments 
WHERE appointment_status = 'Cancelled' AND appointment_date < NOW() - INTERVAL 30 DAY;

--  List doctors who had the most appointments

SELECT doctor_name
FROM Doctors
WHERE doctor_id = (
    SELECT doctor_id
    FROM Appointments
    GROUP BY doctor_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- Creates a new appointment with basic validations --- Store Procedure

DELIMITER //
CREATE PROCEDURE create_appointment (
    IN p_patient_id INT,
    IN p_doctor_id INT,
    IN p_date DATETIME,
    IN p_reason VARCHAR(255)
)
BEGIN
    IF p_date < NOW() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Appointment date cannot be in the past';
    END IF;

    INSERT INTO Appointments (patient_id, doctor_id, appointment_date, reason)
    VALUES (p_patient_id, p_doctor_id, p_date, p_reason);
END //
DELIMITER ;

Call create_appointment(21,3,'2025-07-03 10:00:00','fever');


-- generate_billing_by_patient --- Store Procedure

DELIMITER //

CREATE PROCEDURE generate_billing_by_patients (
    IN p_patient_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN

        ROLLBACK TO SAVEPOINT billing_savepoint;

    END;

    START TRANSACTION;
    SAVEPOINT billing_savepoint;

    INSERT INTO Billing (patient_id, test_id, amount, payment_status, payment_date)
    SELECT 
        p_patient_id,
        mt.test_id,
        mt.test_fees,
        'Pending',
        NULL
    FROM Appointments a
    JOIN Medical_Tests mt ON a.appointment_id = mt.appointment_id
    WHERE a.patient_id = p_patient_id
      AND mt.test_id NOT IN (
          SELECT test_id FROM Billing WHERE patient_id = p_patient_id
      );

    -- If all is good, commit the transaction
    COMMIT;
END //

DELIMITER ;



CALL generate_billing_by_patient (4)

--   Auto-Update Room Status to 'Occupied' --- Trigger


DELIMITER //
CREATE TRIGGER trg_room_status_on_insert
AFTER INSERT ON Room_Allocation
FOR EACH ROW
BEGIN
    UPDATE Room_Allocation
    SET room_status = 'Occupied'
    WHERE room_id = NEW.room_id;
END;
//
DELIMITER ;


-- Update Room Status to 'Available' on Discharge --- Trigger


DELIMITER //
CREATE TRIGGER trg_room_status_on_checkout
AFTER UPDATE ON Room_Allocation
FOR EACH ROW
BEGIN
    IF NEW.check_out_date IS NOT NULL THEN
        UPDATE Room_Allocation
        SET room_status = 'Available'
        WHERE room_id = NEW.room_id;
    END IF;
END;
//
DELIMITER ;

-- Indexes

CREATE INDEX idx_tests_appointment ON Medical_Tests(appointment_id);

CREATE INDEX idx_tests_date ON Medical_Tests(test_date);

CREATE INDEX idx_tests_name ON Medical_Tests(test_name);

CREATE INDEX idx_doctors_specialization ON Doctors(specialization);


-- adding additional information using json in patients table.

ALTER TABLE Patients ADD COLUMN additional_info JSON;

-- insert json data in patients table.

INSERT INTO Patients (
    patient_id, patient_name, age, gender, blood_group, address, phone_number, email, additional_info
) VALUES (
    21,
    'Manish Sharma',
    45,
    'Male',
    'B+',
    'Green Park, City',
    '9000000021',
    'manish@example.com',
    JSON_OBJECT(
        'emergency_contacts', JSON_ARRAY(
            JSON_OBJECT('name', 'Pooja Sharma', 'phone', '9000000101', 'relation', 'Wife')
        ),
        'allergies', JSON_ARRAY('Penicillin')
    )
);
INSERT INTO Patients (
    patient_id, patient_name, age, gender, blood_group, address, phone_number, email, additional_info
) VALUES (
    22,
    'Sneha Verma',
    29,
    'Female',
    'A-',
    'Sunshine Apartments, City',
    '9000000022',
    'sneha@example.com',
    JSON_OBJECT(
        'emergency_contacts', JSON_ARRAY(
            JSON_OBJECT('name', 'Raj Verma', 'phone', '9000000102', 'relation', 'Brother')
        ),
        'allergies', JSON_ARRAY('None')
    )
);
INSERT INTO Patients (
    patient_id, patient_name, age, gender, blood_group, address, phone_number, email, additional_info
) VALUES (
    23,
    'Arjun Singh',
    38,
    'Male',
    'O+',
    'Lakeview Road, Town',
    '9000000023',
    'arjun@example.com',
    JSON_OBJECT(
        'emergency_contacts', JSON_ARRAY(
            JSON_OBJECT('name', 'Kiran Singh', 'phone', '9000000103', 'relation', 'Spouse'),
            JSON_OBJECT('name', 'Meera Singh', 'phone', '9000000104', 'relation', 'Daughter')
        ),
        'allergies', JSON_ARRAY('Sulfa Drugs', 'Latex')
    )
);

-- retrieval of the entire JSON column

SELECT patient_id, patient_name, additional_info
FROM Patients
WHERE patient_id BETWEEN 21 AND 23;

-- Extract the emergency contacts and allergies array from JSON

SELECT
    patient_id,
    patient_name,
    JSON_EXTRACT(additional_info, '$.emergency_contacts') AS emergency_contacts,
    JSON_EXTRACT(additional_info, '$.allergies') AS allergies
FROM Patients
WHERE patient_id BETWEEN 21 AND 23;








































































