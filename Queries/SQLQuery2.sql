CREATE TABLE Students (
    StudentID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    MiddleName NVARCHAR(50) NULL,
    ContactNumber VARCHAR(11) NOT NULL UNIQUE,
    NationalID VARCHAR(14) NOT NULL UNIQUE,
    Email NVARCHAR(255) NOT NULL UNIQUE,
    Password NVARCHAR(100) NOT NULL,
    DateOfBirth DATE NOT NULL,
    ClassLevel NVARCHAR(20) NOT NULL,
    Gender NVARCHAR(10) NOT NULL
);

CREATE TABLE Professors (
    ProfessorID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    MiddleName NVARCHAR(50) NULL,
    ContactNumber VARCHAR(11) NOT NULL UNIQUE,
    NationalID VARCHAR(14) NOT NULL UNIQUE,
    Email NVARCHAR(255) NOT NULL UNIQUE,
    Password NVARCHAR(100) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender NVARCHAR(10) NOT NULL
);

CREATE TABLE AssistantProfessors (
    AssistantProfessorID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    MiddleName NVARCHAR(50) NULL,
    ContactNumber VARCHAR(11) NOT NULL UNIQUE,
    NationalID VARCHAR(14) NOT NULL UNIQUE,
    Email NVARCHAR(255) NOT NULL UNIQUE,
    Password NVARCHAR(100) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender NVARCHAR(10) NOT NULL
);
ALTER TABLE Students
    ADD IsVerified BIT DEFAULT 0 NOT NULL;

ALTER TABLE Professors
    ADD IsVerified BIT DEFAULT 0 NOT NULL;

ALTER TABLE AssistantProfessors
    ADD IsVerified BIT DEFAULT 0 NOT NULL;

	CREATE TABLE Rooms (
    RoomID INT IDENTITY(1,1) PRIMARY KEY,
    RoomName NVARCHAR(50) NOT NULL UNIQUE,
    Capacity INT DEFAULT 30 -- Optional: Define the default room capacity if needed
);

	CREATE TABLE Timetable (
    TimetableID INT IDENTITY(1,1) PRIMARY KEY,
    CourseID INT NOT NULL,
    ProfessorID INT NOT NULL,
    RoomID INT NOT NULL,
    Day NVARCHAR(10) NOT NULL,
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    FOREIGN KEY (ProfessorID) REFERENCES Professors(ProfessorID),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);

			CREATE TABLE Sections (
    SectionID INT IDENTITY(1,1) PRIMARY KEY,
    CourseID INT NOT NULL,
    SectionName NVARCHAR(50) NOT NULL,
    AssistantProfessorID INT NOT NULL,
    Day NVARCHAR(10) NOT NULL,
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL,
    RoomID INT NOT NULL,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    FOREIGN KEY (AssistantProfessorID) REFERENCES AssistantProfessors(AssistantProfessorID),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);

-- Add test rooms to the Rooms table
INSERT INTO Rooms (RoomName, Capacity)
VALUES
    ('Room A101', 30),
    ('Room B202', 25),
    ('Room C303', 20),
    ('Room D404', 40),
    ('Room E505', 35),
    ('Room F606', 50);

