using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication3
{
    public partial class courses_for_admin : Page
    {
        // Update the connection string with your actual connection string
        private string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Load and bind current courses when the page loads for the first time
                BindCurrentCourses();
            }
        }

        protected void BtnAddCourse_Click(object sender, EventArgs e)
        {
            // Retrieve input values
            string courseName = txtCourseName.Text;
            bool hasSection = chkHasSection.Checked;

            // Validate course hours input
            if (!int.TryParse(txtCourseHours.Text, out int courseHours))
            {
                lblMessage.Text = "Invalid course hours. Please enter a valid number.";
                return;
            }

            // SQL query to insert the new course
            string query = "INSERT INTO Courses (CourseName, Hours, HasSection) VALUES (@CourseName, @Hours, @HasSection)";

            try
            {
                // Using statement for proper resource disposal
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Create and execute the command
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@CourseName", courseName);
                        cmd.Parameters.AddWithValue("@Hours", courseHours);
                        cmd.Parameters.AddWithValue("@HasSection", hasSection);

                        // Execute the query
                        cmd.ExecuteNonQuery();
                    }
                }

                // Provide feedback to the user
                lblMessage.Text = "Course added successfully.";

                // Refresh the list of current courses
                BindCurrentCourses();
            }
            catch (Exception ex)
            {
                // Display error message
                lblMessage.Text = $"Error adding course: {ex.Message}";
            }
        }

        private void BindCurrentCourses()
        {
            // SQL query to fetch courses from the database
            string query = "SELECT CourseID, CourseName, Hours, HasSection FROM Courses";

            try
            {
                // Using statement for proper resource disposal
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Create and execute the command
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            // Bind the data reader to the repeater
                            rptCourses.DataSource = reader;
                            rptCourses.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Display error message
                lblMessage.Text = $"Error loading courses: {ex.Message}";
            }
        }
    }
}
