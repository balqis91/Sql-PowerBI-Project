#  SQL + Power BI Project: Student Management System

##  Overview  
This project integrates **MySQL database management** with **Power BI dashboards** to analyze student performance and teacher impact.  
It demonstrates **database design**, **SQL procedures**, **roles & permissions**, and **data visualization** for actionable insights.  

The project includes:  
-  SQL Database with **Students & Teachers**  
-  Role-based Access Control (**Admin, Teacher, Student**)  
-  Stored Procedures & User-Defined Functions  
-  Power BI Dashboards for **Students & Teachers**

---

##  Dashboards  

### Student Performance Dashboard  
<img width="1097" height="611" alt="image" src="https://github.com/user-attachments/assets/cb78c490-0fa3-4849-9201-3e62949b80ce" />
 

### Teacher Impact Dashboard  
<img width="1103" height="613" alt="image" src="https://github.com/user-attachments/assets/3a3cb318-41f7-4c9d-b981-d21c5c8be45a" />




##  Database Schema  

**Students Table**
- `StudentID` (Primary Key)  
- `Name`  
- `Age`  
- `Grade`  
- `TeachersID` (Foreign Key → Teachers)  
- `Score`  
- `ScoreGrade`  

**Teachers Table**
- `TeachersID` (Primary Key)  
- `Name`  
- `Subject`  

**Relationship**  
- One Teacher → Many Students  

---

##  Key SQL Features  

###  Views  
```sql
CREATE VIEW Student_Overview AS
SELECT StudentID, Name, Grade FROM Students;

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
END;
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
END;
 Findings
Top Performing Student: Ella Black (Score: 95)

Best Performing Grade: Grade 11

Highest Pass Rate Teachers: Dr. Brown & Mr. Smith

Age Distribution: 71% Adults vs 29% Minors

Balanced Workload: Dr. Brown & Ms. Johnson had the highest student counts

 Conclusion
This project successfully combines SQL database management and Power BI dashboards to monitor student performance and teacher effectiveness.

Future Enhancements

Add attendance tracking

Automate alerts for failing students

Expand subject-level performance analysis

 Tools Used
MySQL – Database design & queries

Power BI – Data visualization

DAX & Power Query – Data transformations

Role-Based Access Control – Data security

 Created by Balikisu Ajoke Oniyide
