CREATE TABLE Courses (
    CourseID INT IDENTITY(1,1) PRIMARY KEY,
    CourseName NVARCHAR(100) NOT NULL,
    ProfessorID INT DEFAULT NULL,
    AssistantProfessorID INT DEFAULT NULL,
    Hours INT,
    [Time] INT, -- Enclosed in square brackets to escape reserved keyword
    HasSection BIT Default 0,
    FOREIGN KEY (ProfessorID) REFERENCES Professors(ProfessorID),
    FOREIGN KEY (AssistantProfessorID) REFERENCES AssistantProfessors(AssistantProfessorID)
);
--Ahmed Shiko Commit--
ALTER TABLE Courses
ADD CourseTime TIME DEFAULT '00:00:00' NOT NULL;



SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Courses';


CREATE TABLE AssistantProfessorCourses (
    AssistantProfessorID INT,
    CourseID INT,
    PRIMARY KEY (AssistantProfessorID, CourseID),
    FOREIGN KEY (AssistantProfessorID) REFERENCES AssistantProfessors(AssistantProfessorID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
CREATE TABLE ProfessorCourses (
    ProfessorID INT,
    CourseID INT,
    PRIMARY KEY (ProfessorID, CourseID),
    FOREIGN KEY (ProfessorID) REFERENCES Professors(ProfessorID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
CREATE TABLE StudentsCourses (
    StudentID INT,
    CourseID INT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
CREATE TABLE Grades (
    GradeID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    Grade DECIMAL(3, 2), -- Example: Decimal grade format
    CONSTRAINT CK_Grade CHECK (Grade >= 0 AND Grade <= 100), -- Ensures grade is within valid range
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

CREATE TABLE StudentAttendance (
    StudentID INT,
    CourseID INT,
    Attendance INT DEFAULT 0,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

INSERT INTO AssistantProfessorCourses (AssistantProfessorID, CourseID)
VALUES (1, 2);

INSERT INTO ProfessorCourses (ProfessorID, CourseID)
VALUES (2, 1);

INSERT INTO StudentsCourses (StudentID, CourseID)
VALUES (1, 1),
       (2, 2);
