create table Students
(
  StudentID int identity(1,1) primary key,
  FirstName nvarchar(50) not null,
  LastName nvarchar(50) not null,
  MiddleName nvarchar(50) null,
  ContactNumber varchar(11) not null unique,
  NationalID varchar(14) not null unique,
  Email nvarchar(255) not null unique,
  Password nvarchar(100) not null,
  DateOfBirth date not null,
  ClassLevel nvarchar(20) not null,
  Gender nvarchar(10) not null
);

create table Professors
(
  ProfessorID int identity(1,1) primary key,
  FirstName nvarchar(50) not null,
  LastName nvarchar(50) not null,
  MiddleName nvarchar(50) null,
  ContactNumber varchar(11) not null unique,
  NationalID varchar(14) not null unique,
  Email nvarchar(255) not null unique,
  Password nvarchar(100) not null,
  DateOfBirth date not null,
  Gender nvarchar(10) not null
);

create table AssistantProfessors
(
  AssistantProfessorID int identity(1,1) primary key,
  FirstName nvarchar(50) not null,
  LastName nvarchar(50) not null,
  MiddleName nvarchar(50) null,
  ContactNumber varchar(11) not null unique,
  NationalID varchar(14) not null unique,
  Email nvarchar(255) not null unique,
  Password nvarchar(100) not null,
  DateOfBirth date not null,
  Gender nvarchar(10) not null
);
alter table Students
    add IsVerified BIT default 0 not null;

alter table Professors
    add IsVerified BIT default 0 not null;

alter table AssistantProfessors
    add IsVerified BIT default 0 not null;

create table Rooms
(
  RoomID int identity(1,1) primary key,
  RoomName nvarchar(50) not null unique,
  Capacity int default 30
  -- Optional: Define the default room capacity if needed
);

create table Timetable
(
  TimetableID int identity(1,1) primary key,
  CourseID int not null,
  ProfessorID int not null,
  RoomID int not null,
  Day nvarchar(10) not null,
  StartTime time not null,
  EndTime time not null,
  foreign key (CourseID) references Courses(CourseID),
  foreign key (ProfessorID) references Professors(ProfessorID),
  foreign key (RoomID) references Rooms(RoomID)
);

create table Sections
(
  SectionID int identity(1,1) primary key,
  CourseID int not null,
  SectionName nvarchar(50) not null,
  AssistantProfessorID int not null,
  Day nvarchar(10) not null,
  StartTime time not null,
  EndTime time not null,
  RoomID int not null,
  foreign key (CourseID) references Courses(CourseID),
  foreign key (AssistantProfessorID) references AssistantProfessors(AssistantProfessorID),
  foreign key (RoomID) references Rooms(RoomID)
);

-- Add test rooms to the Rooms table
insert into Rooms
  (RoomName, Capacity)
values
  ('Room A101', 30),
  ('Room B202', 25),
  ('Room C303', 20),
  ('Room D404', 40),
  ('Room E505', 35),
  ('Room F606', 50);

