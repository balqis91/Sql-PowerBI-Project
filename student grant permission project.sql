use student_management;
SELECT * FROM Students;
INSERT INTO Students (Name, Age, Grade) VALUES ('Role Test', 15, 'Grade 10');
DELETE FROM Students WHERE Name = 'Role Test';
UPDATE Students SET Grade = 'Grade 11' WHERE Name = 'Role Test';