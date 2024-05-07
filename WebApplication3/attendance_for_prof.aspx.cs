using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace WebApplication3
{
  public partial class attendance_for_prof : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (Session["IsAuthenticated"] != null && (bool)Session["IsAuthenticated"])
      {
        int professorID = (int)Session["ID"];

        if (!IsPostBack)
        {
          FetchAndDisplayCourses(professorID);
        }
      }
      else
      {
        Response.Redirect("log_in.aspx");
      }
    }

    protected void btnHideStudents_Click(object sender, EventArgs e)
    {
      StudentRepeater.Visible = false;
    }

    protected void FetchAndDisplayCourses(int professorID)
    {
      string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
      string query = "SELECT c.CourseID, c.CourseName FROM Courses c INNER JOIN ProfessorCourses pc ON c.CourseID = pc.CourseID WHERE pc.ProfessorID = @ProfessorID";

      using (SqlConnection connection = new SqlConnection(connectionString))
      {
        using (SqlCommand command = new SqlCommand(query, connection))
        {
          command.Parameters.AddWithValue("@ProfessorID", professorID);

          connection.Open();
          SqlDataReader reader = command.ExecuteReader();

          List<Course> courses = new List<Course>();
          while (reader.Read())
          {
            int courseID = Convert.ToInt32(reader["CourseID"]);
            string courseName = Convert.ToString(reader["CourseName"]);

            courses.Add(new Course { CourseID = courseID, CourseName = courseName });
          }

          if (courses.Count == 0)
          {
            // Hide the Repeater control
            AssignedCoursesRepeater.Visible = false;
            // Show message indicating no courses assigned
            lblMessage.Text = "You are not assigned to teach any courses.";
          }
          else
          {
            // Show the Repeater control
            AssignedCoursesRepeater.Visible = true;
            // Hide the message
            lblMessage.Text = "";

            AssignedCoursesRepeater.DataSource = courses;
            AssignedCoursesRepeater.DataBind();
          }
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
      Button button = (Button)sender;
      int courseId = Convert.ToInt32(button.CommandArgument);

      List<Students> assignedStudents = GetAssignedStudents(courseId);

      if (assignedStudents.Count == 0)
      {
        // Hide the Repeater control
        StudentRepeater.Visible = false;
        // Show message indicating no students assigned to the course
        lblStudentMessage.Text = "There are no students assigned to this course.";
      }
      else
      {
        // Show the Repeater control
        StudentRepeater.Visible = true;
        // Hide the message
        lblStudentMessage.Text = "";

        StudentRepeater.DataSource = assignedStudents;
        StudentRepeater.DataBind();

        ViewState["CourseID"] = courseId;
      }
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
      try
      {
        // Check if ViewState["CourseID"] is not null
        if (ViewState["CourseID"] != null)
        {
          int courseId = (int)ViewState["CourseID"];

          bool attendanceProcessed = false; // Flag to track if attendance was processed

          foreach (RepeaterItem item in StudentRepeater.Items)
          {
            HiddenField hdnStudentID = (HiddenField)item.FindControl("hdnStudentID");
            CheckBox chkStudent = (CheckBox)item.FindControl("chkStudent");
            if (chkStudent != null && chkStudent.Checked)
            {
              int studentID = Convert.ToInt32(hdnStudentID.Value);
              UpdateAttendance(studentID, courseId);
              attendanceProcessed = true; // Set the flag to true if attendance is processed for at least one student
            }
          }

          if (attendanceProcessed)
          {
            // Display success message if attendance was processed for at least one student
            ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", "alert('Attendance processed successfully.');", true);
          }
          else
          {
            // Display message if no students were selected
            ClientScript.RegisterStartupScript(this.GetType(), "NoStudentSelectedMessage", "alert('Please select at least one student.');", true);
          }

          // Reload the page
          Response.Redirect(Request.RawUrl);
        }
        else
        {
          // Display an alert message for a short time using JavaScript
          ClientScript.RegisterStartupScript(this.GetType(), "CourseIDError", "setTimeout(function(){ alert('Error: You are not assigned to teach any courses.'); }, 2000);", true);
        }
      }
      catch (Exception ex)
      {
        // Display an alert message for a short time using JavaScript
        ClientScript.RegisterStartupScript(this.GetType(), "ProcessingError", "setTimeout(function(){ alert('An error occurred while processing the selected students.'); }, 2000);", true);
        // Log the exception for debugging purposes
        // LogException(ex);
      }
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