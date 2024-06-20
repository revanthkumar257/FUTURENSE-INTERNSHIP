create database sun;
use sun;
CREATE TABLE StudentCourse (
    StudentID INT,
    StudentName VARCHAR(100),
    CourseID INT,
    CourseName VARCHAR(100),
    InstructorName VARCHAR(100)
);

INSERT INTO StudentCourse (StudentID, StudentName, CourseID, CourseName, InstructorName)
VALUES
(1, 'Alice', 101, 'Math', 'Prof. Smith'),
(2, 'Bob', 101, 'Math', 'Prof. Smith'),
(1, 'Alice', 102, 'English', 'Prof. Johnson'),
(3, 'Carol', 103, 'History', 'Prof. Lee');

-- Student table for 2NF
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100)
);

-- Create Course table for 2NF
CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    InstructorName VARCHAR(100)
);

--  Enrollment table for 2NF
CREATE TABLE Enrollment (
    StudentID INT,
    CourseID INT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

-- Insert data into Student table
INSERT INTO Student (StudentID, StudentName)
SELECT DISTINCT StudentID, StudentName FROM StudentCourse;


INSERT INTO Course (CourseID, CourseName, InstructorName)
SELECT DISTINCT CourseID, CourseName, InstructorName FROM StudentCourse;


INSERT INTO Enrollment (StudentID, CourseID)
SELECT StudentID, CourseID FROM StudentCourse;

-- Instructor table for 3NF
CREATE TABLE Instructor (
    InstructorID INT PRIMARY KEY,
    InstructorName VARCHAR(100)
);

INSERT INTO Instructor (InstructorID, InstructorName)
VALUES
(1, 'Prof. Smith'),
(2, 'Prof. Johnson'),
(3, 'Prof. Lee');

-- Create updated Course table for 3NF
CREATE TABLE Course_3NF (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    InstructorID INT,
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID)
);

INSERT INTO Course_3NF (CourseID, CourseName, InstructorID)
VALUES
(101, 'Math', 1),
(102, 'English', 2),
(103, 'History', 3);

select * from Course_3NF;
SELECT c.CourseID, c.CourseName, i.InstructorName
FROM Course c
JOIN Instructor i ON c.InstructorName = i.InstructorName;

SELECT s.StudentID, s.StudentName, c.CourseID, c.CourseName
FROM Student s
JOIN Enrollment e ON s.StudentID = e.StudentID
JOIN Course c ON e.CourseID = c.CourseID;

SELECT s.StudentID, s.StudentName, c.CourseName, i.InstructorName
FROM Student s
JOIN Enrollment e ON s.StudentID = e.StudentID
JOIN Course_3NF c ON e.CourseID = c.CourseID
JOIN Instructor i ON c.InstructorID = i.InstructorID;

SELECT s.StudentID, s.StudentName
FROM Student s
JOIN Enrollment e ON s.StudentID = e.StudentID
JOIN Course c ON e.CourseID = c.CourseID
WHERE c.CourseName = 'Math';

SELECT c.CourseName, COUNT(e.StudentID) as StudentCount
FROM Course c
JOIN Enrollment e ON c.CourseID = e.CourseID
GROUP BY c.CourseName;

SELECT i.InstructorName, COUNT(c.CourseID) as CourseCount
FROM Instructor i
JOIN Course_3NF c ON i.InstructorID = c.InstructorID
GROUP BY i.InstructorName;

SELECT c.CourseName, COUNT(e.StudentID) as StudentCount
FROM Course c
JOIN Enrollment e ON c.CourseID = e.CourseID
GROUP BY c.CourseName
HAVING COUNT(e.StudentID) > 1;

SELECT s.StudentID, s.StudentName, c.CourseName, i.InstructorName
FROM Student s
JOIN Enrollment e ON s.StudentID = e.StudentID
JOIN Course_3NF c ON e.CourseID = c.CourseID
JOIN Instructor i ON c.InstructorID = i.InstructorID;

SELECT c.CourseID, c.CourseName
FROM Course c
LEFT JOIN Enrollment e ON c.CourseID = e.CourseID
WHERE e.StudentID IS NULL;
