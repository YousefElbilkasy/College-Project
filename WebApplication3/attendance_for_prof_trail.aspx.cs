using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.Data;

namespace WebApplication3
{
    public partial class Attendace_for_prof_trail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if the user is authenticated
            if (Session["IsAuthenticated"] != null && (bool)Session["IsAuthenticated"])
            {
                int professorID = (int)Session["ID"];

                if (!IsPostBack)
                {
                    // Fetch and display the courses taught by the professor
                    FetchAndDisplayCourses(professorID);
                }
            }
            else
            {
                // Redirect to the login page if the user is not authenticated
                Response.Redirect("log_in.aspx");
            }
        }
        protected void btnHideStudents_Click(object sender, EventArgs e)
        {
            StudentRepeater.Visible = false;
        }

        // Function to fetch and display the courses taught by the professor
        private void FetchAndDisplayCourses(int professorID)
        {
            // Your connection string
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            // Query to fetch courses taught by the professor
            string query = "SELECT c.CourseID, c.CourseName FROM Courses c INNER JOIN ProfessorCourses pc ON c.CourseID = pc.CourseID WHERE pc.ProfessorID = @ProfessorID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@ProfessorID", professorID);

                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    // Loop through the result set and display courses
                    List<Course> courses = new List<Course>();
                    while (reader.Read())
                    {
                        int courseID = Convert.ToInt32(reader["CourseID"]);
                        string courseName = Convert.ToString(reader["CourseName"]);

                        courses.Add(new Course { CourseID = courseID, CourseName = courseName });
                    }

                    // Bind the courses to the Repeater control
                    AssignedCoursesRepeater.DataSource = courses;
                    AssignedCoursesRepeater.DataBind();
                }
            }
        }

        private List<Students> GetAssignedStudents(int courseId)
        {
            List<Students> students = new List<Students>();

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            string query = @"
        SELECT s.StudentID, s.FirstName, s.LastName, s.Email
        FROM Students s
        INNER JOIN StudentsCourses sa ON s.StudentID = sa.StudentID
        WHERE sa.CourseID = @CourseID
    ";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@CourseID", courseId);

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            int studentID = reader.GetInt32(0);
                            string firstName = reader.GetString(1);
                            string lastName = reader.GetString(2);
                            string email = reader.GetString(3);

                            students.Add(new Students { StudentID = studentID, FirstName = firstName, LastName = lastName, Email = email });
                        }
                    }
                }
            }

            return students;
        }
        protected void Assign_Courses_Button_Click(object sender, EventArgs e)
        {
            StudentRepeater.Visible = true;
            // Get the CourseID from the CommandArgument of the button that triggered the event
            Button button = (Button)sender;
            int courseId = Convert.ToInt32(button.CommandArgument);

            // Retrieve the list of students assigned to the course
            List<Students> assignedStudents = GetAssignedStudents(courseId);

            // Bind the students to the Repeater control
            StudentRepeater.DataSource = assignedStudents;
            StudentRepeater.DataBind();

            // Store the CourseID in ViewState for later use
            ViewState["CourseID"] = courseId;
        }

        private void UpdateAttendance(int studentID, int courseId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            string query = @"IF EXISTS (SELECT 1 FROM StudentAttendance WHERE StudentID = @StudentID AND CourseID = @CourseID)
                    BEGIN
                        UPDATE StudentAttendance
                        SET Attendance = Attendance + 1
                        WHERE StudentID = @StudentID AND CourseID = @CourseID
                    END
                    ELSE
                    BEGIN
                        INSERT INTO StudentAttendance (StudentID, CourseID, Attendance)
                        VALUES (@StudentID, @CourseID, 1)
                    END";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@StudentID", studentID);
                    command.Parameters.AddWithValue("@CourseID", courseId);

                    command.ExecuteNonQuery();
                }
            }
        }
        protected void btnProcessSelected_Click(object sender, EventArgs e)
        {
            // Get the CourseID from ViewState
            int courseId = (int)ViewState["CourseID"];

            List<Students> selectedStudents = new List<Students>();
            foreach (RepeaterItem item in StudentRepeater.Items)
            {
                HiddenField hdnStudentID = (HiddenField)item.FindControl("hdnStudentID");
                CheckBox chkStudent = (CheckBox)item.FindControl("chkStudent");
                if (chkStudent.Checked)
                {
                    int studentID = Convert.ToInt32(hdnStudentID.Value);

                    // Update the attendance record for the selected student
                    UpdateAttendance(studentID, courseId);
                }
            }
        }

        private void ProcessSelectedStudents(List<Students> selectedStudents, int courseId)
        {
            // Perform logic with the selected students and course ID
            // For example, you could update the attendance records for the selected students
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                foreach (Students student in selectedStudents)
                {
                    string query=@"IF EXISTS (SELECT 1 FROM StudentAttendance WHERE ProfessorID = @ProfessorID AND StudentID = @StudentID AND CourseID = @CourseID)
                    BEGIN
                        UPDATE StudentAttendance
                        SET Attendance = Attendance + 1
                        WHERE ProfessorID = @ProfessorID AND StudentID = @StudentID AND CourseID = @CourseID
                    END
                    ELSE
                    BEGIN
                        INSERT INTO StudentAttendance (ProfessorID, StudentID, CourseID, Attendance)
                        VALUES (@ProfessorID, @StudentID, @CourseID, 1)
                    END";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@StudentID", student.StudentID);
                        command.Parameters.AddWithValue("@CourseID", courseId);

                        command.ExecuteNonQuery();
                    }
                }
            }
        }
    }

    
}

