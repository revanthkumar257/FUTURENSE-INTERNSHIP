CREATE Database University;
USE University;

-- Create tables
CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(100) NOT NULL
);

CREATE TABLE Instructor (
    InstructorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    HireDate DATE,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Credits INT,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

CREATE TABLE Enrollment (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    Grade CHAR(1),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

CREATE TABLE ClassSchedule (
    ScheduleID INT PRIMARY KEY,
    CourseID INT,
    InstructorID INT,
    DayOfWeek VARCHAR(10),
    StartTime TIME,
    EndTime TIME,
    RoomNumber VARCHAR(10),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID),
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID)
);

-- Insert sample data into Department
INSERT INTO Department (DeptID, DeptName) VALUES
(1, 'Computer Science'),
(2, 'Mathematics'),
(3, 'Physics'),
(4, 'Chemistry');

-- Insert sample data into Instructor
INSERT INTO Instructor (InstructorID, FirstName, LastName, HireDate, DeptID) VALUES
(1, 'Alice', 'Smith', '2015-08-01', 1),
(2, 'Bob', 'Johnson', '2017-06-15', 2),
(3, 'Carol', 'Williams', '2012-03-25', 3),
(4, 'David', 'Brown', '2019-11-05', 4);

-- Insert sample data into Course
INSERT INTO Course (CourseID, CourseName, Credits, DeptID) VALUES
(1, 'Database Systems', 3, 1),
(2, 'Calculus I', 4, 2),
(3, 'Physics I', 4, 3),
(4, 'Organic Chemistry', 3, 4);

-- Insert sample data into Student
INSERT INTO Student (StudentID, FirstName, LastName, DateOfBirth, DeptID) VALUES
(1, 'Eve', 'Miller', '1999-04-15', 1),
(2, 'Frank', 'Taylor', '2000-05-20', 2),
(3, 'Grace', 'Anderson', '1998-11-30', 3),
(4, 'Hank', 'Thomas', '2001-07-25', 4);

-- Insert sample data into Enrollment
INSERT INTO Enrollment (EnrollmentID, StudentID, CourseID, EnrollmentDate, Grade) VALUES
(1, 1, 1, '2023-01-10', 'A'),
(2, 2, 2, '2023-01-12', 'B'),
(3, 3, 3, '2023-01-15', 'C'),
(4, 4, 4, '2023-01-20', 'A');

-- Insert sample data into ClassSchedule
INSERT INTO ClassSchedule (ScheduleID, CourseID, InstructorID, DayOfWeek, StartTime, EndTime, RoomNumber) VALUES
(1, 1, 1, 'Monday', '10:00:00', '11:30:00', 'CS101'),
(2, 2, 2, 'Tuesday', '12:00:00', '13:30:00', 'MATH201'),
(3, 3, 3, 'Wednesday', '14:00:00', '15:30:00', 'PHY301'),
(4, 4, 4, 'Thursday', '16:00:00', '17:30:00', 'CHEM401');

-- Complex queries
-- Example: List all students enrolled in 'Database Systems' along with their grades
SELECT s.FirstName, s.LastName, e.Grade
FROM Student s
JOIN Enrollment e ON s.StudentID = e.StudentID
JOIN Course c ON e.CourseID = c.CourseID
WHERE c.CourseName = 'Database Systems';

-- Example: Find all courses taught by 'Alice Smith'
SELECT c.CourseName
FROM Course c
JOIN ClassSchedule cs ON c.CourseID = cs.CourseID
JOIN Instructor i ON cs.InstructorID = i.InstructorID
WHERE i.FirstName = 'Alice' AND i.LastName = 'Smith';

-- Example: Count of students in each department
SELECT d.DeptName, COUNT(s.StudentID) AS StudentCount
FROM Department d
LEFT JOIN Student s ON d.DeptID = s.DeptID
GROUP BY d.DeptName;

-- Example: Insert a new student
INSERT INTO Student (StudentID, FirstName, LastName, DateOfBirth, DeptID)
VALUES (5, 'Ivy', 'King', '2002-09-10', 1);

-- Example: Update grade for a student
UPDATE Enrollment
SET Grade = 'B'
WHERE StudentID = 1 AND CourseID = 1;

-- Example: Delete a course
DELETE FROM Course
WHERE CourseID = 4;

-- Procedures
DELIMITER //

CREATE PROCEDURE GetStudentCourses (IN studentID INT)
BEGIN
    SELECT c.CourseName, e.Grade
    FROM Enrollment e
    JOIN Course c ON e.CourseID = c.CourseID
    WHERE e.StudentID = studentID;
END //

DELIMITER ;

-- Example: Call the procedure
CALL GetStudentCourses(1);

-- Functions
DELIMITER //

CREATE FUNCTION GetInstructorFullName (instructorID INT)
RETURNS VARCHAR(100)
BEGIN
    DECLARE fullName VARCHAR(100);
    SELECT CONCAT(FirstName, ' ', LastName) INTO fullName
    FROM Instructor
    WHERE InstructorID = instructorID;
    RETURN fullName;
END //

DELIMITER ;

-- Example: Use the function
SELECT GetInstructorFullName(1);

-- Date and time functions
-- Example: Calculate age of students
SELECT FirstName, LastName, DateOfBirth,
TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) AS Age
FROM Student;

-- Subqueries
-- Example: List instructors who teach more than one course
SELECT i.FirstName, i.LastName
FROM Instructor i
WHERE i.InstructorID IN (
    SELECT InstructorID
    FROM ClassSchedule
    GROUP BY InstructorID
    HAVING COUNT(CourseID) > 1
);
