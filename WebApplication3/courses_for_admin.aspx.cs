using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication3
{
    public partial class courses_for_admin : System.Web.UI.Page
    {
        // Connection string from configuration file
        private readonly string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void btnAddCourse_Click(object sender, EventArgs e)
        {
            // Retrieve form data
            string courseName = txtCourseName.Text;
            int courseHours;
            TimeSpan courseTime;
            int professorID;
            int assistantProfessorID = 0;
            bool hasSection = chkHasSection.Checked;

            // Validate and parse course hours
            if (!int.TryParse(txtCourseHours.Text, out courseHours))
            {
                lblMessage.Text = "Invalid course hours.";
                return;
            }

            // Validate and parse course time
            if (!TimeSpan.TryParse(txtCourseTime.Text, out courseTime))
            {
                lblMessage.Text = "Invalid course time. Please enter time in the format HH:mm (e.g., 09:00 for 9:00 AM).";
                return;
            }

            // Validate and parse professor ID
            if (!int.TryParse(txtProfessorID.Text, out professorID))
            {
                lblMessage.Text = "Invalid professor ID.";
                return;
            }

            // Validate and parse assistant professor ID (if provided)
            if (!string.IsNullOrEmpty(txtAssistantProfessorID.Text))
            {
                if (!int.TryParse(txtAssistantProfessorID.Text, out assistantProfessorID))
                {
                    lblMessage.Text = "Invalid assistant professor ID.";
                    return;
                }
            }

            // Open a SQL connection
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Create a SQL command to insert course data
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = connection;
                    cmd.CommandText = @"
                        INSERT INTO Courses (CourseName, ProfessorID, AssistantProfessorID, Hours, CourseTime, HasSection)
                        VALUES (@courseName, @professorID, @assistantProfessorID, @courseHours, @courseTime, @hasSection)";

                    // Add parameters
                    cmd.Parameters.AddWithValue("@courseName", courseName);
                    cmd.Parameters.AddWithValue("@professorID", professorID);
                    cmd.Parameters.AddWithValue("@assistantProfessorID", assistantProfessorID);
                    cmd.Parameters.AddWithValue("@courseHours", courseHours);
                    cmd.Parameters.AddWithValue("@courseTime", courseTime);
                    cmd.Parameters.AddWithValue("@hasSection", hasSection);

                    try
                    {
                        // Execute the command
                        cmd.ExecuteNonQuery();
                        lblMessage.Text = "Course added successfully!";
                    }
                    catch (Exception ex)
                    {
                        // Handle error and provide feedback to the user
                        lblMessage.Text = $"Error adding course: {ex.Message}";
                        System.Diagnostics.Debug.WriteLine(ex);
                    }
                }
            }
        }
    }
}
