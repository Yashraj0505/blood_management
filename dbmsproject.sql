-- 1️⃣ Database
CREATE DATABASE IF NOT EXISTS blood_donation;
USE blood_donation;

-- 2️⃣ Tables
CREATE TABLE IF NOT EXISTS Donor (
    donor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    blood_group VARCHAR(5),
    contact VARCHAR(15),
    city VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Recipient (
    recipient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    blood_group VARCHAR(5),
    hospital VARCHAR(50),
    contact VARCHAR(15)
);

CREATE TABLE IF NOT EXISTS Blood_Bank (
    bank_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    location VARCHAR(50),
    contact VARCHAR(15)
);

CREATE TABLE IF NOT EXISTS Blood_Stock (
    stock_id INT AUTO_INCREMENT PRIMARY KEY,
    bank_id INT,
    blood_group VARCHAR(5),
    units_available INT,
    FOREIGN KEY (bank_id) REFERENCES Blood_Bank(bank_id)
);

CREATE TABLE IF NOT EXISTS Donation (
    donation_id INT AUTO_INCREMENT PRIMARY KEY,
    donor_id INT,
    bank_id INT,
    recipient_id INT NULL,
    recency INT,
    frequency INT,
    total_blood_donated INT,
    first_donation_time INT,
    donated_in_march2007 BOOLEAN,
    donation_date DATE,
    units_donated INT,
    FOREIGN KEY (donor_id) REFERENCES Donor(donor_id),
    FOREIGN KEY (bank_id) REFERENCES Blood_Bank(bank_id),
    FOREIGN KEY (recipient_id) REFERENCES Recipient(recipient_id)
);

-- 3️⃣ Insert Donors (20 people)
INSERT INTO Donor (name, age, gender, blood_group, contact, city) VALUES
('Alice Smith', 25, 'Female', 'A+', '9876543210', 'Pune'),
('Bob Johnson', 30, 'Male', 'B+', '9123456780', 'Mumbai'),
('Charlie Lee', 28, 'Male', 'O-', '9988776655', 'Delhi'),
('David Kumar', 35, 'Male', 'AB+', '9871234567', 'Pune'),
('Eve Davis', 27, 'Female', 'A-', '9765432109', 'Mumbai'),
('Frank Miller', 32, 'Male', 'B-', '9123456701', 'Bangalore'),
('Grace Wilson', 29, 'Female', 'O+', '9876501234', 'Hyderabad'),
('Hannah Brown', 26, 'Female', 'AB-', '9988701234', 'Chennai'),
('Ian Thomas', 31, 'Male', 'A+', '9876543211', 'Pune'),
('Julia White', 24, 'Female', 'B+', '9123456781', 'Mumbai'),
('Kevin Moore', 33, 'Male', 'O-', '9988776656', 'Delhi'),
('Laura Martin', 28, 'Female', 'AB+', '9871234568', 'Pune'),
('Mike Anderson', 35, 'Male', 'A-', '9765432110', 'Mumbai'),
('Nina Scott', 27, 'Female', 'B+', '9123456790', 'Bangalore'),
('Oscar Clark', 29, 'Male', 'O+', '9876501235', 'Hyderabad'),
('Paula Lewis', 30, 'Female', 'AB-', '9988701235', 'Chennai'),
('Quinn Walker', 26, 'Male', 'A+', '9876543212', 'Pune'),
('Rachel Hall', 31, 'Female', 'B-', '9123456782', 'Mumbai'),
('Steve Allen', 32, 'Male', 'O-', '9988776657', 'Delhi'),
('Tina Young', 28, 'Female', 'AB+', '9871234569', 'Pune');

-- 4️⃣ Insert Recipients (20 people)
INSERT INTO Recipient (name, age, blood_group, hospital, contact) VALUES
('Rita Kapoor', 40, 'A+', 'City Hospital', '9123456789'),
('Sam Mehta', 50, 'B+', 'Central Hospital', '9876543212'),
('Tom Sharma', 35, 'O-', 'Metro Hospital', '9988774455'),
('Uma Singh', 45, 'AB+', 'City Hospital', '9765432123'),
('Vikram Joshi', 38, 'A-', 'Apollo Hospital', '9123405678'),
('Wendy Rao', 32, 'B-', 'Fortis Hospital', '9876501234'),
('Xavier Paul', 41, 'O+', 'Global Hospital', '9988701234'),
('Yara Das', 36, 'AB-', 'City Hospital', '9871234501'),
('Zane Khan', 29, 'A+', 'Metro Hospital', '9123456701'),
('Aisha Patel', 33, 'B+', 'Central Hospital', '9876543213'),
('Brian Mathew', 42, 'O-', 'City Hospital', '9988776658'),
('Cathy Nair', 30, 'AB+', 'Apollo Hospital', '9871234570'),
('Derek Thomas', 37, 'A-', 'Fortis Hospital', '9765432111'),
('Elena Roy', 28, 'B-', 'Global Hospital', '9123405679'),
('Fiona George', 34, 'O+', 'City Hospital', '9876501236'),
('George Varma', 45, 'AB-', 'Metro Hospital', '9988701236'),
('Holly Fernandez', 31, 'A+', 'Central Hospital', '9871234512'),
('Ian Pillai', 36, 'B+', 'Apollo Hospital', '9123456783'),
('Jane Kaur', 29, 'O-', 'City Hospital', '9988776659'),
('Kyle Reddy', 32, 'AB+', 'Global Hospital', '9871234580');

-- 5️⃣ Insert Blood Banks (6 banks)
INSERT INTO Blood_Bank (name, location, contact) VALUES
('City Blood Bank', 'Pune', '9876501234'),
('Central Blood Bank', 'Mumbai', '9123405678'),
('Metro Blood Bank', 'Delhi', '9988701234'),
('Fortis Blood Bank', 'Bangalore', '9871234560'),
('Apollo Blood Bank', 'Chennai', '9123456791'),
('Global Blood Bank', 'Hyderabad', '9988776640');

-- 6️⃣ Insert Blood Stock (for each bank & blood group)
INSERT INTO Blood_Stock (bank_id, blood_group, units_available) VALUES
(1,'A+',50),(1,'B+',40),(1,'O+',30),(1,'AB+',20),
(2,'A+',45),(2,'B+',35),(2,'O+',25),(2,'AB+',15),
(3,'A+',60),(3,'B+',50),(3,'O+',40),(3,'AB+',30),
(4,'A+',55),(4,'B+',45),(4,'O+',35),(4,'AB+',25),
(5,'A+',50),(5,'B+',40),(5,'O+',30),(5,'AB+',20),
(6,'A+',45),(6,'B+',35),(6,'O+',25),(6,'AB+',15);

-- 7️⃣ Generate 500 random donations
-- Disable FK temporarily for batch inserts
SET FOREIGN_KEY_CHECKS = 0;

DELIMITER $$

CREATE PROCEDURE generate_donations()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 500 DO
        INSERT INTO Donation (
            donor_id, bank_id, recipient_id, recency, frequency, total_blood_donated,
            first_donation_time, donated_in_march2007, donation_date, units_donated
        ) VALUES (
            FLOOR(1 + RAND()*20),      -- donor_id 1-20
            FLOOR(1 + RAND()*6),       -- bank_id 1-6
            FLOOR(1 + RAND()*20),      -- recipient_id 1-20
            FLOOR(RAND()*365),         -- recency in days
            FLOOR(1 + RAND()*50),      -- frequency
            FLOOR(250 + RAND()*10000), -- total blood donated
            FLOOR(1 + RAND()*50),      -- first donation time
            FLOOR(RAND()*2),           -- donated_in_march2007 0/1
            DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND()*365) DAY), -- donation date
            FLOOR(1 + RAND()*3)        -- units donated 1-3
        );
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

-- Execute procedure
CALL generate_donations();

-- Drop procedure after use
DROP PROCEDURE IF EXISTS generate_donations;

-- Re-enable FK checks
SET FOREIGN_KEY_CHECKS = 1;


-- 8️⃣ Verify 10 donations
SELECT * FROM Donation LIMIT 10;

SELECT * FROM blood_donation LIMIT 10;

SELECT * FROM donor limit 10;





