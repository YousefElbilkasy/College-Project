INSERT INTO Students (FirstName, LastName, MiddleName, ContactNumber, NationalID, Email, Password, DateOfBirth, ClassLevel, Gender, IsVerified)
VALUES 
('John', 'Doe', 'Smith', '1234567890', '12345678901234', 'john.doe@example.com', 'password123', '2000-05-15', 'Sophomore', 'Male', 1),
('Alice', 'Johnson', NULL, '9876543210', '98765432109876', 'alice.johnson@example.com', 'securepass', '2001-08-20', 'Freshman', 'Female', 0),
('Michael', 'Brown', 'David', '5553334444', '33322211109876', 'michael.brown@example.com', 'pass123', '1999-12-10', 'Junior', 'Male', 1),
('Emma', 'Garcia', 'Lynn', '7778889999', '45678901234567', 'emma.garcia@example.com', 'emmapass', '2002-04-03', 'Senior', 'Female', 0),
('William', 'Martinez', 'J.', '1112223333', '09876543210987', 'william.martinez@example.com', 'willpass', '2003-01-25', 'Freshman', 'Male', 1);
INSERT INTO Professors (FirstName, LastName, MiddleName, ContactNumber, NationalID, Email, Password, DateOfBirth, Gender, IsVerified)
VALUES 
('David', 'Clark', 'L.', '5556667777', '45678901234561', 'david.clark@example.com', 'prof123', '1975-09-28', 'Male', 1),
('Jennifer', 'Smith', NULL, '9998887777', '12345678901233', 'jennifer.smith@example.com', 'jenniferpass', '1980-03-12', 'Female', 0),
('Robert', 'Lee', 'A.', '3334445555', '33344455551234', 'robert.lee@example.com', 'robertpass', '1968-11-05', 'Male', 1),
('Mary', 'Wilson', 'K.', '7778889999', '12309876543212', 'mary.wilson@example.com', 'marypass', '1973-07-20', 'Female', 0),
('Daniel', 'Garcia', NULL, '2223334444', '12309876543213', 'daniel.garcia@example.com', 'danpass', '1985-06-30', 'Male', 1);
INSERT INTO AssistantProfessors (FirstName, LastName, MiddleName, ContactNumber, NationalID, Email, Password, DateOfBirth, Gender, IsVerified)
VALUES 
('Emily', 'Harris', NULL, '1112223333', '12312312341234', 'emily.harris@example.com', 'emilypass', '1989-02-15', 'Female', 1),
('Andrew', 'Johnson', 'S.', '4445556666', '56789012341234', 'andrew.johnson@example.com', 'andypass', '1983-10-18', 'Male', 0),
('Jessica', 'Martinez', NULL, '7778889999', '67890123412345', 'jessica.martinez@example.com', 'jesspass', '1987-04-25', 'Female', 1),
('Ryan', 'Brown', 'P.', '8889990000', '89012341234567', 'ryan.brown@example.com', 'ryanpass', '1990-12-03', 'Male', 0),
('Sophia', 'Lee', NULL, '5554443333', '78901234123456', 'sophia.lee@example.com', 'sophiapass', '1982-08-10', 'Female', 1);
INSERT INTO Rooms (RoomName, Capacity)
VALUES 
('Room A', 30),
('Room B', 25),
('Room C', 35),
('Room D', 40),
('Room E', 20);
INSERT INTO Courses (CourseName, ProfessorID, AssistantProfessorID, Hours, [Time], HasSection, CourseTime)
VALUES 
('Mathematics', 1, 1, 3, 1, 1, '08:00:00'),
('Physics', 3, 2, 3, 1, 1, '09:00:00'),
('Biology', 2, 4, 3, 2, 1, '10:00:00'),
('Chemistry', 4, 3, 3, 2, 1, '11:00:00'),
('Computer Science', 5, NULL, 3, 2, 0, '12:00:00');
INSERT INTO StudentAttendance (StudentID, CourseID, Attendance)
VALUES 
(1, 1, 10), -- John attended 10 classes of Mathematics
(2, 1, 9),  -- Alice attended 9 classes of Mathematics
(3, 2, 8),  -- Michael attended 8 classes of Physics
(4, 2, 7),  -- Emma attended 7 classes of Physics
(5, 3, 6),  -- William attended 6 classes of Biology
(1, 4, 8),  -- John attended 8 classes of Chemistry
(3, 4, 9),  -- Michael attended 9 classes of Chemistry
(2, 5, 7),  -- Alice attended 7 classes of Computer Science
(4, 5, 6),  -- Emma attended 6 classes of Computer Science
(5, 5, 5);  -- William attended 5 classes of Computer Science
INSERT INTO Sections (CourseID, SectionName, AssistantProfessorID, Day, StartTime, EndTime, RoomID)
VALUES 
(1, 'Section A', 1, 'Monday', '08:00:00', '10:00:00', 1), -- Mathematics Section A on Monday, 8:00 AM - 10:00 AM in Room A
(2, 'Section B', 2, 'Tuesday', '09:00:00', '11:00:00', 2), -- Physics Section B on Tuesday, 9:00 AM - 11:00 AM in Room B
(3, 'Section C', 3, 'Wednesday', '10:00:00', '12:00:00', 3), -- Biology Section C on Wednesday, 10:00 AM - 12:00 PM in Room C
(4, 'Section D', 4, 'Thursday', '11:00:00', '13:00:00', 4), -- Chemistry Section D on Thursday, 11:00 AM - 1:00 PM in Room D
(5, 'Section E', NULL, 'Friday', '12:00:00', '14:00:00', 5); -- Computer Science Section E on Friday, 12:00 PM - 2:00 PM in Room E
INSERT INTO Timetable (CourseID, ProfessorID, RoomID, Day, StartTime, EndTime)
VALUES 
(1, 1, 1, 'Monday', '08:00:00', '10:00:00'), -- Mathematics taught by Professor David Clark on Monday, 8:00 AM - 10:00 AM in Room A
(2, 3, 2, 'Tuesday', '09:00:00', '11:00:00'), -- Physics taught by Professor Robert Lee on Tuesday, 9:00 AM - 11:00 AM in Room B
(3, 2, 3, 'Wednesday', '10:00:00', '12:00:00'), -- Biology taught by Professor Jennifer Smith on Wednesday, 10:00 AM - 12:00 PM in Room C
(4, 4, 4, 'Thursday', '11:00:00', '13:00:00'), -- Chemistry taught by Professor Mary Wilson on Thursday, 11:00 AM - 1:00 PM in Room D
(5, 5, 5, 'Friday', '12:00:00', '14:00:00'); -- Computer Science taught by Professor Daniel Garcia on Friday, 12:00 PM - 2:00 PM in Room E
INSERT INTO Grades (StudentID, CourseID, Grade)
VALUES 
(1, 1, 85.5), -- John got 85.5% in Mathematics
(2, 1, 78.2), -- Alice got 78.2% in Mathematics
(3, 2, 91.7), -- Michael got 91.7% in Physics
(4, 2, 82.3), -- Emma got 82.3% in Physics
(5, 3, 75.8), -- William got 75.8% in Biology
(1, 4, 89.4), -- John got 89.4% in Chemistry
(3, 4, 93.1), -- Michael got 93.1% in Chemistry
(2, 5, 80.6), -- Alice got 80.6% in Computer Science
(4, 5, 77.9), -- Emma got 77.9% in Computer Science
(5, 5, 70.5); -- William got 70.5% in Computer Science
