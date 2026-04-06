create database Student_Management;
use Student_Management;
create table Students (
StudentID int Primary key auto_increment,
Name varchar(60),
Age int,
Grade Varchar(15)
);
create table Teachers (
TeachersID int primary key auto_increment,
Name varchar(60),
Subject varchar(60)
);
create user 'Teacher_User'@'Localhost' identified by 'StrongPass123';
grant select, insert on Student_Management.Students to 'Teacher_User'@'Localhost';
create user 'admin_user'@'localhost' IDENTIFIED BY 'StrongPassword123!';
grant select, insert, update, delete on student_management.Students TO 'admin_user'@'localhost';
grant select, insert, update, delete on student_management.Teachers TO 'admin_user'@'localhost';
CREATE ROLE 'student_role';
REVOKE DELETE ON student_management.Students FROM 'admin_user'@'localhost';
GRANT SELECT ON student_management.Students TO 'student_role';
CREATE USER 'student_user'@'localhost' IDENTIFIED BY 'StudentPass123!';
GRANT 'student_role' TO 'student_user'@'Localhost';
SET DEFAULT ROLE 'student_role' TO 'student_user'@'Localhost';
GRANT INSERT ON student_management.Students TO 'student_role';
select *from teachers;
use Student_Management;

Alter table students add TeachersID int,
add constraint fk_TeacherID foreign key (TeachersID) references Teachers(TeachersID);

INSERT INTO Teachers (Name, Subject) VALUES
('Mr. Smith', 'Mathematics'),
('Ms. Johnson', 'English'),
('Dr. Brown', 'Science'),
('Mrs. Taylor', 'History'),
('Mr. White', 'Geography'),
('Ms. Green', 'Biology'),
('Dr. Carter', 'Chemistry'),
('Mr. Adams', 'Physics'),
('Ms. Lewis', 'Art'),
('Mr. Thomas', 'Computer Science');
select * from students;
INSERT INTO Students (Name, Age, Grade, TeachersID) VALUES
('Alice Green', 14, 'Grade 9', 1),
('Brian Lee', 15, 'Grade 10', 2),
('Carla White', 13, 'Grade 8', 1),
('Daniel Moore', 14, 'Grade 9', 3),
('Ella Black', 15, 'Grade 10', 2),
('Frank Scott', 13, 'Grade 8', 4),
('Grace Hall', 14, 'Grade 9', 5),
('Henry Young', 15, 'Grade 10', 3),
('Isla King', 13, 'Grade 8', 6),
('Jack Turner', 14, 'Grade 9', 7),
('Katie Adams', 15, 'Grade 10', 6),
('Leo Evans', 13, 'Grade 8', 8),
('Mia Clark', 14, 'Grade 9', 5),
('Noah Hill', 15, 'Grade 10', 9),
('Olivia Walker', 13, 'Grade 8', 2),
('Paul Baker', 14, 'Grade 9', 10),
('Quinn Adams', 15, 'Grade 10', 9),
('Ruby Collins', 13, 'Grade 8', 4),
('Sam Roberts', 14, 'Grade 9', 7),
('Tina Foster', 15, 'Grade 10', 10);

ALTER TABLE Students
ADD COLUMN Score INT,
ADD COLUMN ScoreGrade VARCHAR(3);

UPDATE Students SET Score = 87, ScoreGrade = 'B2' WHERE StudentID = 1;
UPDATE Students SET Score = 91, ScoreGrade = 'A1' WHERE StudentID = 2;
UPDATE Students SET Score = 78, ScoreGrade = 'B3' WHERE StudentID = 3;
UPDATE Students SET Score = 69, ScoreGrade = 'C4' WHERE StudentID = 4;
UPDATE Students SET Score = 95, ScoreGrade = 'A1' WHERE StudentID = 5;
UPDATE Students SET Score = 58, ScoreGrade = 'C6' WHERE StudentID = 6;
UPDATE Students SET Score = 83, ScoreGrade = 'B2' WHERE StudentID = 7;
UPDATE Students SET Score = 62, ScoreGrade = 'C5' WHERE StudentID = 8;
UPDATE Students SET Score = 73, ScoreGrade = 'B3' WHERE StudentID = 9;
UPDATE Students SET Score = 55, ScoreGrade = 'C6' WHERE StudentID = 10;
UPDATE Students SET Score = 80, ScoreGrade = 'B2' WHERE StudentID = 11;
UPDATE Students SET Score = 39, ScoreGrade = 'F9' WHERE StudentID = 12; -- FAIL
UPDATE Students SET Score = 67, ScoreGrade = 'C4' WHERE StudentID = 13;
UPDATE Students SET Score = 93, ScoreGrade = 'A1' WHERE StudentID = 14;
UPDATE Students SET Score = 34, ScoreGrade = 'F9' WHERE StudentID = 15; -- FAIL
UPDATE Students SET Score = 76, ScoreGrade = 'B3' WHERE StudentID = 16;
UPDATE Students SET Score = 64, ScoreGrade = 'C5' WHERE StudentID = 17;
UPDATE Students SET Score = 59, ScoreGrade = 'C6' WHERE StudentID = 18;
UPDATE Students SET Score = 81, ScoreGrade = 'B2' WHERE StudentID = 19;
UPDATE Students SET Score = 22, ScoreGrade = 'F9' WHERE StudentID = 20; -- FAIL

UPDATE Students SET Age = 18 WHERE StudentID = 3;
UPDATE Students SET Age = 19 WHERE StudentID = 5;
UPDATE Students SET Age = 20 WHERE StudentID = 7;
UPDATE Students SET Age = 18 WHERE StudentID = 10;
UPDATE Students SET Age = 19 WHERE StudentID = 15;
UPDATE Students SET Name = 'Tara Faster' WHERE StudentID = 21;
-- To create a view
create view Student_Overview as
select StudentID, Name, Grade from Students;

-- To test the view
SELECT * FROM student_overview;
SELECT * FROM students;

SELECT 
    StudentID,
    Name,
    Grade,
    Age,
    CASE 
        WHEN Age < 18 THEN 'Minor'
        ELSE 'Adult'
    END AS AgeCategory
FROM Students;

-- Delete all records
DELETE FROM Students;

-- Reset auto_increment counter to 1
ALTER TABLE Students AUTO_INCREMENT = 1;
-- To create procedures
DELIMITER $$

CREATE PROCEDURE add_student (
    IN p_name VARCHAR(60),
    IN p_age INT,
    IN p_grade VARCHAR(15),
    IN p_teachersID INT,
    IN p_score INT,
    IN p_scoreGrade VARCHAR(3),
    OUT p_studentID INT
)
BEGIN
    INSERT INTO Students (Name, Age, Grade, TeachersID, Score, ScoreGrade)
    VALUES (p_name, p_age, p_grade, p_teachersID, p_score, p_scoreGrade);

    SET p_studentID = LAST_INSERT_ID();
END $$

DELIMITER ;

-- Create a session variable to receive the new ID
SET @new_id = 0;
-- To call out the procedure created
CALL add_student('Tina Foster', 17, 'Grade 11', 3, 88, 'B2', @new_id);
SELECT @new_id AS InsertedStudentID;

SELECT * FROM Students WHERE StudentID = @new_id;
-- creating a "user defined function" (UDFs)
DELIMITER $$

CREATE FUNCTION Calculate_Discount (
    price DECIMAL(10,2),
    discount_percent DECIMAL(5,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE discounted_price DECIMAL(10,2);
    SET discounted_price = price - (price * discount_percent / 100);
    RETURN discounted_price;
END $$

DELIMITER ;

SELECT Calculate_Discount(100, 15) AS 'Discounted Price';
select * from students;
DELETE FROM Students
WHERE StudentID BETWEEN 34 AND 53;
DROP FUNCTION IF EXISTS Calculate_Discount;