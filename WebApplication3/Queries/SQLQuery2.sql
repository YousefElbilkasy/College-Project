CREATE DATABASE CollegeDB;
USE CollegeDB;

CREATE TABLE Students (
    StudentID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    MiddleName NVARCHAR(50) NULL,
    LastName NVARCHAR(50) NOT NULL,
    ContactNumber VARCHAR(11) NOT NULL UNIQUE,
    NationalID VARCHAR(14) NOT NULL UNIQUE,
    Email NVARCHAR(255) NOT NULL UNIQUE,
    Password NVARCHAR(100) NOT NULL,
    DateOfBirth DATE NOT NULL,
    ClassLevel NVARCHAR(20) NOT NULL,
    Gender NVARCHAR(10) NOT NULL
);
select* from Students;