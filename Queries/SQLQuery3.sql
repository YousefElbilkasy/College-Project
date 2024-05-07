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

--======================================

-- Inserting sample data into Professors table
insert into Professors
  (FirstName, LastName, ContactNumber, NationalID, Email, Password, DateOfBirth, Gender, IsVerified)
values
  ('John', 'Doe', '1234567890', '12345678901234', 'john.doe@example.com', 'password123', '1980-05-15', 'Male', 1),
  ('Jane', 'Smith', '0987654321', '98765432109876', 'jane.smith@example.com', 'password456', '1975-10-20', 'Female', 1),
  ('Michael', 'Johnson', '1112223333', '11122233334444', 'michael.johnson@example.com', 'password789', '1988-03-25', 'Male', 1),
  ('Emily', 'Brown', '4445556666', '44455566667777', 'emily.brown@example.com', 'passwordabc', '1990-12-10', 'Female', 1),
  ('David', 'Martinez', '7778889999', '77788899991111', 'david.martinez@example.com', 'passwordxyz', '1982-08-07', 'Male', 1);

-- Inserting sample data into AssistantProfessors table
insert into AssistantProfessors
  (FirstName, LastName, ContactNumber, NationalID, Email, Password, DateOfBirth, Gender, IsVerified)
values
  ('Emma', 'Wilson', '3334445555', '33344455556666', 'emma.wilson@example.com', 'pass123', '1985-07-20', 'Female', 1),
  ('James', 'Taylor', '6667778888', '66677788889999', 'james.taylor@example.com', 'pass456', '1987-09-12', 'Male', 1),
  ('Olivia', 'Martinez', '9990001111', '99900011112222', 'olivia.martinez@example.com', 'pass789', '1991-04-30', 'Female', 1),
  ('Daniel', 'Anderson', '2223334444', '22233344445555', 'daniel.anderson@example.com', 'passabc', '1983-11-18', 'Male', 1),
  ('Sophia', 'Garcia', '5556667777', '55566677778888', 'sophia.garcia@example.com', 'passxyz', '1980-02-28', 'Female', 1);

-- Inserting sample data into Courses table
insert into Courses
  (CourseName, ProfessorID, AssistantProfessorID, Hours, [Time], HasSection, CourseTime)
values
  ('Mathematics', 1, 2, 4, 1, 1, '08:00:00'),
  ('Physics', 3, 4, 3, 2, 0, '10:00:00'),
  ('Chemistry', 5, null, 3, 3, 1, '14:00:00'),
  ('Biology', 2, 3, 4, 4, 0, '11:00:00'),
  ('English Literature', 4, 5, 3, 5, 1, '13:00:00');

-- Inserting sample data into Rooms table
insert into Rooms
  (RoomName, Capacity)
values
  ('Room A', 30),
  ('Room B', 25),
  ('Room C', 35),
  ('Room D', 40),
  ('Room E', 20);

-- Inserting sample data into Sections table
insert into Sections
  (CourseID, SectionName, AssistantProfessorID, Day, StartTime, EndTime, RoomID)
values
  (1, 'Section A', 2, 'Monday', '08:00:00', '10:00:00', 1),
  (1, 'Section B', 3, 'Wednesday', '10:00:00', '12:00:00', 2),
  (2, 'Section C', 4, 'Thursday', '14:00:00', '16:00:00', 3),
  (4, 'Section D', 3, 'Tuesday', '11:00:00', '13:00:00', 4),
  (5, 'Section E', 5, 'Friday', '13:00:00', '15:00:00', 5);

-- Inserting sample data into Timetable table
insert into Timetable
  (CourseID, ProfessorID, RoomID, Day, StartTime, EndTime)
values
  (1, 1, 1, 'Monday', '08:00:00', '10:00:00'),
  (2, 3, 2, 'Wednesday', '10:00:00', '12:00:00'),
  (3, 5, 3, 'Thursday', '14:00:00', '16:00:00'),
  (4, 2, 4, 'Tuesday', '11:00:00', '13:00:00'),
  (5, 4, 5, 'Friday', '13:00:00', '15:00:00');

-- Inserting sample data into Students table
insert into Students
  (FirstName, LastName, ContactNumber, NationalID, Email, Password, DateOfBirth, ClassLevel, Gender, IsVerified)
values
  ('Michael', 'Johnson', '1231231231', '12345678901231', 'michael.johnson@student.com', 'student123', '2002-01-15', 'Senior', 'Male', 1),
  ('Sophia', 'Brown', '4564564564', '98765432109876', 'sophia.brown@student.com', 'student456', '2003-05-20', 'Junior', 'Female', 1),
  ('Ethan', 'Martinez', '7897897897', '77788899991111', 'ethan.martinez@student.com', 'student789', '2001-11-30', 'Senior', 'Male', 1),
  ('Isabella', 'Smith', '9876543219', '44455566667777', 'isabella.smith@student.com', 'studentabc', '2002-08-18', 'Junior', 'Female', 1),
  ('William', 'Garcia', '3213213213', '55566677778888', 'william.garcia@student.com', 'studentxyz', '2004-03-28', 'Sophomore', 'Male', 1);

-- Inserting sample data into AssistantProfessorCourses table
insert into AssistantProfessorCourses
  (AssistantProfessorID, CourseID)
values
  (2, 1),
  (3, 2),
  (4, 3),
  (3, 4),
  (5, 5);

-- Inserting sample data into ProfessorCourses table
insert into ProfessorCourses
  (ProfessorID, CourseID)
values
  (1, 1),
  (3, 2),
  (5, 3),
  (2, 4),
  (4, 5);

-- Inserting sample data into StudentsCourses table
insert into StudentsCourses
  (StudentID, CourseID)
values
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 5);

-- Inserting sample data into Grades table
insert into Grades
  (StudentID, CourseID, Grade)
values
  (1, 1, 85.5),
  (2, 2, 90.0),
  (3, 3, 88.2),
  (4, 4, 92.7),
  (5, 5, 87.9);

-- Inserting sample data into StudentAttendance table
insert into StudentAttendance
  (StudentID, CourseID, Attendance)
values
  (1, 1, 25),
  (2, 2, 28),
  (3, 3, 30),
  (4, 4, 27),
  (5, 5, 29);
