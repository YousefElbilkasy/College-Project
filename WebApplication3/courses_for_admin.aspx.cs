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
      if (Session["IsAuthenticated"] != null && (bool)Session["IsAuthenticated"])
      {
        if (!IsPostBack)
        {
          // Load and bind current courses when the page loads for the first time
          BindCurrentCourses();
          BindProfessors();
          BindAssistantProfessors();
        }
      }
      else
      {
        // Redirect to the login page if the user is not authenticated
        Response.Redirect("log_in.aspx");
      }
    }

    private void BindProfessors()
    {
      string query = "SELECT ProfessorID, FirstName + ' ' + ISNULL(MiddleName, '') + ' ' + LastName AS FullName FROM Professors";

      using (SqlConnection conn = new SqlConnection(connectionString))
      {
        conn.Open();

        using (SqlCommand cmd = new SqlCommand(query, conn))
        {
          using (SqlDataReader reader = cmd.ExecuteReader())
          {
            ddlProfessors.DataSource = reader;
            ddlProfessors.DataValueField = "ProfessorID";
            ddlProfessors.DataTextField = "FullName";
            ddlProfessors.DataBind();
          }
        }
      }
      ddlProfessors.Items.Insert(0, new ListItem("Select a professor", ""));
    }

    private void BindAssistantProfessors()
    {
      string query = "SELECT AssistantProfessorID, FirstName + ' ' + ISNULL(MiddleName, '') + ' ' + LastName AS FullName FROM AssistantProfessors";

      using (SqlConnection conn = new SqlConnection(connectionString))
      {
        conn.Open();

        using (SqlCommand cmd = new SqlCommand(query, conn))
        {
          using (SqlDataReader reader = cmd.ExecuteReader())
          {
            ddlAssistantProfessors.DataSource = reader;
            ddlAssistantProfessors.DataValueField = "AssistantProfessorID";
            ddlAssistantProfessors.DataTextField = "FullName";
            ddlAssistantProfessors.DataBind();
          }
        }
      }
      ddlAssistantProfessors.Items.Insert(0, new ListItem("Select an assistant professor", ""));
    }

    protected void BtnAddCourse_Click(object sender, EventArgs e)
    {
      // Retrieve input values
      string courseName = txtCourseName.Text;
      bool hasSection = chkHasSection.Checked;
      int professorId = int.Parse(ddlProfessors.SelectedValue);
      int? assistantProfessorId = chkHasSection.Checked ? int.Parse(ddlAssistantProfessors.SelectedValue) : (int?)null;

      // Validate course hours input
      if (!int.TryParse(txtCourseHours.Text, out int courseHours))
      {
        lblMessage.Text = "Invalid course hours. Please enter a valid number.";
        return;
      }

      if (ddlProfessors.SelectedValue == "")
      {
        lblMessage.Text = "Please select a professor.";
        return;
      }

      if (chkHasSection.Checked && ddlAssistantProfessors.SelectedValue == "")
      {
        lblMessage.Text = "Please select an assistant professor.";
        return;
      }

      // SQL query to insert the new course
      string query = "INSERT INTO Courses (CourseName, Hours, HasSection, ProfessorID, AssistantProfessorID) VALUES (@CourseName, @Hours, @HasSection, @ProfessorID, @AssistantProfessorID)";

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
            cmd.Parameters.AddWithValue("@ProfessorID", professorId);
            cmd.Parameters.AddWithValue("@AssistantProfessorID", assistantProfessorId ?? (object)DBNull.Value);

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
      // SQL query to fetch courses and their professors from the database
      string query = @"SELECT 
                        Courses.CourseID, 
                        Courses.CourseName, 
                        Courses.Hours,
                        Courses.HasSection,
                        Professors.FirstName + ' ' + ISNULL(Professors.MiddleName, '') + ' ' + Professors.LastName AS ProfessorFullName,
                        CASE 
                          WHEN Sections.CourseID IS NOT NULL THEN AssistantProfessors.FirstName + ' ' + ISNULL(AssistantProfessors.MiddleName, '') + ' ' + AssistantProfessors.LastName
                          ELSE NULL
                        END AS AssistantProfessorFullName
                      FROM 
                        Courses
                      LEFT JOIN 
                        Professors ON Courses.ProfessorID = Professors.ProfessorID
                      LEFT JOIN 
                        Sections ON Courses.CourseID = Sections.CourseID
                      LEFT JOIN 
                        AssistantProfessors ON Sections.AssistantProfessorID = AssistantProfessors.AssistantProfessorID";

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
    protected void LogoutButton_Click(object sender, EventArgs e)
    {
      // Clear session state
      Session.Clear();

      // Redirect to the login page or any other appropriate page
      Response.Redirect("Login.aspx");
    }

    protected void chkHasSection_CheckedChanged(object sender, EventArgs e)
    {
      ddlAssistantProfessors.Visible = chkHasSection.Checked;
    }
  }
}
