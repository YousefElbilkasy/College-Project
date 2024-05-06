using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication3
{
    public partial class courses_for_student : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["IsAuthenticated"] != null && (bool)Session["IsAuthenticated"])
            {
                if (Session["ID"] != null)
                {
                    int studentID = (int)Session["ID"];

                    if (!IsPostBack)
                    {
                        // Fetch unassigned course data from the database
                        BindUnassignedCourses(studentID);

                        // Fetch assigned course data from the database
                        BindAssignedCourses(studentID);
                    }
                }
                else
                {
                    // Handle the case when Session["ID"] is null
                    // Maybe redirect the user to another page or display an error message
                }
            }
            else
            {
                // Redirect to the login page if the user is not authenticated
                Response.Redirect("log_in.aspx");
            }
        }

        private void BindUnassignedCourses(int studentID)
        {
            // Fetch unassigned courses from the database
            List<Course> unassignedCourses = FetchUnassignedCoursesFromDatabase(studentID);

            // Bind the list of unassigned courses to the Repeater
            CourseRepeater.DataSource = unassignedCourses;
            CourseRepeater.DataBind();
        }

        private List<Course> FetchUnassignedCoursesFromDatabase(int studentID)
        {
            List<Course> unassignedCourses = new List<Course>();

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string query = @"
                SELECT c.CourseID, c.CourseName, p.FirstName AS ProfessorFirstName, p.LastName AS ProfessorLastName, 
                       a.FirstName AS AssistantFirstName, a.LastName AS AssistantLastName, c.Hours, c.CourseTime, c.HasSection 
                FROM Courses c
                LEFT JOIN ProfessorCourses pc ON c.CourseID = pc.CourseID
                LEFT JOIN Professors p ON pc.ProfessorID = p.ProfessorID
                LEFT JOIN AssistantProfessorCourses apc ON c.CourseID = apc.CourseID
                LEFT JOIN AssistantProfessors a ON apc.AssistantProfessorID = a.AssistantProfessorID
                WHERE c.CourseID NOT IN (
                    SELECT sc.CourseID
                    FROM StudentsCourses sc
                    WHERE sc.StudentID = @StudentID
                )";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@StudentID", studentID);
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    while (reader.Read())
                    {
                        Course course = new Course();
                        course.CourseID = Convert.ToInt32(reader["CourseID"]);
                        course.CourseName = Convert.ToString(reader["CourseName"]);
                        // Check if ProfessorFirstName and ProfessorLastName are not null
                        if (!reader.IsDBNull(reader.GetOrdinal("ProfessorFirstName")) && !reader.IsDBNull(reader.GetOrdinal("ProfessorLastName")))
                        {
                            course.ProfessorName = Convert.ToString(reader["ProfessorFirstName"]) + " " + Convert.ToString(reader["ProfessorLastName"]);
                        }
                        else
                        {
                            course.ProfessorName = "No Professor yet";
                        }

                        // Check if AssistantFirstName and AssistantLastName are not null
                        if (!reader.IsDBNull(reader.GetOrdinal("AssistantFirstName")) && !reader.IsDBNull(reader.GetOrdinal("AssistantLastName")))
                        {
                            course.AssistantName = Convert.ToString(reader["AssistantFirstName"]) + " " + Convert.ToString(reader["AssistantLastName"]);
                        }
                        else
                        {
                            course.AssistantName = "No Assistant yet";
                        }
                        course.Hours = Convert.ToInt32(reader["Hours"]);
                        course.CourseTime = (TimeSpan)reader["CourseTime"];
                        course.HasSection = Convert.ToBoolean(reader["HasSection"]);
                        unassignedCourses.Add(course);
                    }
                }
            }

            return unassignedCourses;
        }

        protected void AssignButton_Click(object sender, EventArgs e)
        {
            // Get the CourseID from the CommandArgument of the button that triggered the event
            Button button = (Button)sender;
            int courseId = Convert.ToInt32(button.CommandArgument);

            // Retrieve the StudentID from the session
            int studentId = (int)Session["ID"];

            // Insert a record into the StudentsCourses table
            InsertStudentCourse(studentId, courseId);

            // Optionally, you can display a success message or perform any other action
            ScriptManager.RegisterStartupScript(this, GetType(), "assignSuccess", "alert('Course assigned successfully.');", true);
            Response.Redirect(Request.RawUrl);
        }

        private void InsertStudentCourse(int studentId, int courseId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string query = "INSERT INTO StudentsCourses (StudentID, CourseID) VALUES (@StudentID, @CourseID)";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@StudentID", studentId);
                    command.Parameters.AddWithValue("@CourseID", courseId);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        private void BindAssignedCourses(int studentID)
        {
            // Your logic to fetch assigned courses and bind them to the Repeater
            List<Course> assignedCourses = FetchAssignedCourses(studentID);

            if (assignedCourses.Count > 0)
            {
                AssignedCoursesRepeater.DataSource = assignedCourses;
                AssignedCoursesRepeater.DataBind();
                noCoursesMessage.Visible = false; // Hide the message
            }
            else
            {
                AssignedCoursesRepeater.DataSource = null;
                AssignedCoursesRepeater.DataBind();
                noCoursesMessage.Visible = true; // Show the message
            }
        }

        private List<Course> FetchAssignedCourses(int studentID)
        {
            List<Course> assignedCourses = new List<Course>();

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string query = @"
                SELECT c.CourseID, c.CourseName
                FROM Courses c
                INNER JOIN StudentsCourses sc ON c.CourseID = sc.CourseID
                WHERE sc.StudentID = @StudentID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@StudentID", studentID);
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    while (reader.Read())
                    {
                        Course course = new Course();
                        course.CourseID = Convert.ToInt32(reader["CourseID"]);
                        course.CourseName = Convert.ToString(reader["CourseName"]);
                        assignedCourses.Add(course);
                    }
                }
            }

            return assignedCourses;
        }
    protected void LogoutButton_Click(object sender, EventArgs e)
    {
      // Clear session state
      Session.Clear();

      // Redirect to the login page or any other appropriate page
      Response.Redirect("Login.aspx");
    }

  }
}
