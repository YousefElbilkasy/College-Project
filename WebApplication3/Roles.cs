using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplication3
{
    public class Students
    {
        public int StudentID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string MiddleName { get; set; }
        public string ContactNumber { get; set; }
        public string NationalID { get; set; }
        public string Email { get; set; }
        public DateTime DateOfBirth { get; set; }
        public string ClassLevel { get; set; }
        public string Gender { get; set; }
        public bool IsVerified { get; set; }
    }
    public class Professors
    {
        public int ProfessorID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string MiddleName { get; set; }
        public string ContactNumber { get; set; }
        public string NationalID { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public DateTime DateOfBirth { get; set; }
        public string Gender { get; set; }
        public bool IsVerified { get; set; }
    }
    public class AssistantProfessors
    {
        public int AssistantProfessorID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string MiddleName { get; set; }
        public string ContactNumber { get; set; }
        public string NationalID { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public DateTime DateOfBirth { get; set; }
        public string Gender { get; set; }
        public bool IsVerified { get; set; }
    }

    public class Course
    {
        public int CourseID { get; set; }
        public string CourseName { get; set; }
        public int? ProfessorID { get; set; }
        public string ProfessorName { get; set; }
        // Nullable int to accommodate NULL values
        public int? AssistantProfessorID { get; set; }
        public string AssistantName { get; set; }

        // Nullable int
        public int Hours { get; set; }
        public TimeSpan CourseTime { get; set; }
        public bool HasSection { get; set; }
    }

}