using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace WebApplication3
{
  public partial class timetable_for_admin : System.Web.UI.Page
  {
    private string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
      if (Session["IsAuthenticated"] != null && (bool)Session["IsAuthenticated"])
      {
        if (!IsPostBack)
        {
          LoadCourses();
          LoadRooms();
          LoadProfessors();
          LoadAssistantProfessors();
          LoadTimetableData();
        }
      }
    }

    // Load courses into ddlCourse
    private void LoadCourses()
    {
      using (SqlConnection conn = new SqlConnection(connectionString))
      {
        conn.Open();
        string query = "SELECT CourseID, CourseName FROM Courses";
        using (SqlCommand cmd = new SqlCommand(query, conn))
        {
          using (SqlDataReader reader = cmd.ExecuteReader())
          {
            ddlCourse.DataSource = reader;
            ddlCourse.DataTextField = "CourseName";
            ddlCourse.DataValueField = "CourseID";
            ddlCourse.DataBind();
          }
        }
      }
      ddlCourse.Items.Insert(0, new ListItem("Select a Course", "0"));
    }

    // Load rooms into ddlRoom and ddlSectionRoom
    private void LoadRooms()
    {
      using (SqlConnection conn = new SqlConnection(connectionString))
      {
        conn.Open();
        string query = "SELECT RoomID, RoomName FROM Rooms";
        using (SqlCommand cmd = new SqlCommand(query, conn))
        {
          using (SqlDataReader reader = cmd.ExecuteReader())
          {
            ddlRoom.DataSource = reader;
            ddlRoom.DataTextField = "RoomName";
            ddlRoom.DataValueField = "RoomID";
            ddlRoom.DataBind();

            // Also bind ddlSectionRoom
            reader.Close();
            using (SqlDataReader reader2 = cmd.ExecuteReader())
            {
              ddlSectionRoom.DataSource = reader2;
              ddlSectionRoom.DataTextField = "RoomName";
              ddlSectionRoom.DataValueField = "RoomID";
              ddlSectionRoom.DataBind();
            }
          }
        }
      }
      ddlRoom.Items.Insert(0, new ListItem("Select a Room", "0"));
      ddlSectionRoom.Items.Insert(0, new ListItem("Select a Room", "0"));
    }

    // Load professors into ddlProfessor
    private void LoadProfessors()
    {
      using (SqlConnection conn = new SqlConnection(connectionString))
      {
        conn.Open();
        string query = "SELECT ProfessorID, FirstName + ' ' + LastName AS ProfessorName FROM Professors";
        using (SqlCommand cmd = new SqlCommand(query, conn))
        {
          using (SqlDataReader reader = cmd.ExecuteReader())
          {
            ddlProfessor.DataSource = reader;
            ddlProfessor.DataTextField = "ProfessorName";
            ddlProfessor.DataValueField = "ProfessorID";
            ddlProfessor.DataBind();
          }
        }
      }
      ddlProfessor.Items.Insert(0, new ListItem("Select a Professor", "0"));
    }

    // Load assistant professors into ddlAssistantProfessor
    private void LoadAssistantProfessors()
    {
      using (SqlConnection conn = new SqlConnection(connectionString))
      {
        conn.Open();
        string query = "SELECT AssistantProfessorID, FirstName + ' ' + LastName AS AssistantProfessorName FROM AssistantProfessors";
        using (SqlCommand cmd = new SqlCommand(query, conn))
        {
          using (SqlDataReader reader = cmd.ExecuteReader())
          {
            ddlAssistantProfessor.DataSource = reader;
            ddlAssistantProfessor.DataTextField = "AssistantProfessorName";
            ddlAssistantProfessor.DataValueField = "AssistantProfessorID";
            ddlAssistantProfessor.DataBind();
          }
        }
      }
      ddlAssistantProfessor.Items.Insert(0, new ListItem("Select an Assistant Professor", "0"));
    }

    // Load timetable data into TimetableRepeater
    private void LoadTimetableData()
    {
      using (SqlConnection conn = new SqlConnection(connectionString))
      {
        conn.Open();
        string query = @"
                    SELECT t.TimetableID, t.Day, t.StartTime, t.EndTime, c.CourseName, p.FirstName + ' ' + p.LastName AS ProfessorName, r.RoomName
                    FROM Timetable t
                    JOIN Courses c ON t.CourseID = c.CourseID
                    JOIN Professors p ON t.ProfessorID = p.ProfessorID
                    JOIN Rooms r ON t.RoomID = r.RoomID";
        using (SqlCommand cmd = new SqlCommand(query, conn))
        {
          using (SqlDataReader reader = cmd.ExecuteReader())
          {
            TimetableRepeater.DataSource = reader;
            TimetableRepeater.DataBind();
          }
        }
      }
    }

    // Load sections data into SectionsRepeater
    private void LoadSectionsData()
    {
      // Get the course ID from the dropdown
      int courseID = Convert.ToInt32(ddlCourse.SelectedValue);

      // Check if the course has sections enabled
      if (HasSections(courseID))
      {
        // Load sections data if the course has sections enabled
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
          conn.Open();
          string query = @"
                        SELECT s.SectionID, s.SectionName, s.Day, s.StartTime, s.EndTime, r.RoomName, ap.FirstName + ' ' + ap.LastName AS AssistantProfessorName
                        FROM Sections s
                        JOIN Rooms r ON s.RoomID = r.RoomID
                        JOIN AssistantProfessors ap ON s.AssistantProfessorID = ap.AssistantProfessorID
                        WHERE s.CourseID = @CourseID";
          using (SqlCommand cmd = new SqlCommand(query, conn))
          {
            cmd.Parameters.AddWithValue("@CourseID", courseID);
            using (SqlDataReader reader = cmd.ExecuteReader())
            {
              SectionsRepeater.DataSource = reader;
              SectionsRepeater.DataBind();
            }
          }
        }

        // Show sections table and section details
        sectionTable.Style["display"] = "block";
        sectionDetails.Style["display"] = "block";
      }
      else
      {
        // Hide sections table and section details if the course does not have sections
        sectionTable.Style["display"] = "none";
        sectionDetails.Style["display"] = "none";
      }
    }

    // Helper method to check if a course has sections enabled
    private bool HasSections(int courseID)
    {
      using (SqlConnection conn = new SqlConnection(connectionString))
      {
        conn.Open();
        string query = "SELECT HasSection FROM Courses WHERE CourseID = @CourseID";
        using (SqlCommand cmd = new SqlCommand(query, conn))
        {
          cmd.Parameters.AddWithValue("@CourseID", courseID);
          object result = cmd.ExecuteScalar();
          if (result != null && result != DBNull.Value)
          {
            return Convert.ToBoolean(result);
          }
        }
      }
      return false;
    }

    // Handle adding or updating timetable entries
    protected void BtnAddOrUpdate_Click(object sender, EventArgs e)
    {
      int courseID = Convert.ToInt32(ddlCourse.SelectedValue);
      string day = ddlDay.SelectedValue;
      TimeSpan startTime = TimeSpan.Parse(txtStartTime.Text);
      TimeSpan endTime = TimeSpan.Parse(txtEndTime.Text);
      int roomID = Convert.ToInt32(ddlRoom.SelectedValue);
      int professorID = Convert.ToInt32(ddlProfessor.SelectedValue);

      if (!IsTimetableConflict(courseID, day, startTime, endTime, roomID, professorID))
      {
        SaveTimetableEntry(courseID, day, startTime, endTime, roomID, professorID);
        lblMessage.Text = "Timetable entry saved successfully.";
        lblMessage.CssClass = "text-success";
      }
      else
      {
        lblMessage.Text = "There is a conflict in the timetable. Please choose a different time or room.";
        lblMessage.CssClass = "text-danger";
      }

      // Reload the timetable data
      LoadTimetableData();
    }

    // Handle course dropdown change
    protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
    {
      int courseID = Convert.ToInt32(ddlCourse.SelectedValue);
      if (courseID > 0)
      {
        // Check if the selected course has sections enabled
        if (HasSections(courseID))
        {
          // Load and display sections for the selected course
          LoadSectionsData();
          // Display section details
          sectionDetails.Style["display"] = "block";
          txtSectionName.Text = ddlCourse.SelectedItem.Text + " Section";
          // Show sections table
          sectionTable.Style["display"] = "block";
        }
        else
        {
          // Hide section details and sections table if the course has no sections
          sectionDetails.Style["display"] = "none";
          sectionTable.Style["display"] = "none";
        }
      }
      else
      {
        // Hide section details and sections table if no valid course is selected
        sectionDetails.Style["display"] = "none";
        sectionTable.Style["display"] = "none";
      }
    }

    // Handle adding or updating sections
    protected void btnSaveSection_Click(object sender, EventArgs e)
    {
      if (!int.TryParse(ddlCourse.SelectedValue, out int courseID) || courseID == 0)
      {
        lblSectionMessage.Text = "Please select a valid course.";
        return;
      }

      string sectionName = txtSectionName.Text;
      string sectionDay = ddlSectionDay.SelectedValue;

      if (string.IsNullOrEmpty(sectionDay))
      {
        lblSectionMessage.Text = "Please select a valid day.";
        return;
      }

      if (!TimeSpan.TryParse(txtSectionTime.Text, out TimeSpan sectionTime))
      {
        lblSectionMessage.Text = "Please enter a valid section time (HH:mm).";
        return;
      }

      if (!TimeSpan.TryParse(txtSectionEndTime.Text, out TimeSpan sectionEndTime))
      {
        lblSectionMessage.Text = "Please enter a valid section end time (HH:mm).";
        return;
      }

      if (!int.TryParse(ddlSectionRoom.SelectedValue, out int roomID) || roomID == 0)
      {
        lblSectionMessage.Text = "Please select a valid room.";
        return;
      }

      if (!int.TryParse(ddlAssistantProfessor.SelectedValue, out int assistantProfessorID))
      {
        lblSectionMessage.Text = "Please select a valid assistant professor.";
        return;
      }

      SaveSection(courseID, sectionName, sectionDay, sectionTime, sectionEndTime, roomID, assistantProfessorID);

      LoadSectionsData(); // Refresh sections list
    }

    // Save section entry
    private void SaveSection(int courseID, string sectionName, string sectionDay, TimeSpan sectionTime, TimeSpan sectionEndTime, int roomID, int assistantProfessorID)
    {
      using (SqlConnection conn = new SqlConnection(connectionString))
      {
        conn.Open();
        string query;
        if (IsSectionExists(courseID, sectionName, sectionDay, sectionTime, sectionEndTime, roomID, assistantProfessorID))
        {
          query = @"
                        UPDATE Sections
                        SET Day = @SectionDay, StartTime = @SectionTime, EndTime = @SectionEndTime, RoomID = @RoomID, AssistantProfessorID = @AssistantProfessorID
                        WHERE CourseID = @CourseID AND SectionName = @SectionName";
        }
        else
        {
          query = @"
                        INSERT INTO Sections (CourseID, SectionName, Day, StartTime, EndTime, RoomID, AssistantProfessorID)
                        VALUES (@CourseID, @SectionName, @SectionDay, @SectionTime, @SectionEndTime, @RoomID, @AssistantProfessorID)";
        }

        using (SqlCommand cmd = new SqlCommand(query, conn))
        {
          cmd.Parameters.AddWithValue("@CourseID", courseID);
          cmd.Parameters.AddWithValue("@SectionName", sectionName);
          cmd.Parameters.AddWithValue("@SectionDay", sectionDay);
          cmd.Parameters.AddWithValue("@SectionTime", sectionTime);
          cmd.Parameters.AddWithValue("@SectionEndTime", sectionEndTime);
          cmd.Parameters.AddWithValue("@RoomID", roomID);
          cmd.Parameters.AddWithValue("@AssistantProfessorID", assistantProfessorID);

          cmd.ExecuteNonQuery();
        }
      }
      lblSectionMessage.Text = "Section saved successfully.";
    }

    // Check if a section exists
    private bool IsSectionExists(int courseID, string sectionName, string sectionDay, TimeSpan sectionTime, TimeSpan sectionEndTime, int roomID, int assistantProfessorID)
    {
      using (SqlConnection conn = new SqlConnection(connectionString))
      {
        conn.Open();
        string query = @"
                    SELECT COUNT(*)
                    FROM Sections
                    WHERE CourseID = @CourseID
                    AND SectionName = @SectionName
                    AND Day = @SectionDay
                    AND StartTime = @SectionTime
                    AND EndTime = @SectionEndTime
                    AND RoomID = @RoomID
                    AND AssistantProfessorID = @AssistantProfessorID";
        using (SqlCommand cmd = new SqlCommand(query, conn))
        {
          cmd.Parameters.AddWithValue("@CourseID", courseID);
          cmd.Parameters.AddWithValue("@SectionName", sectionName);
          cmd.Parameters.AddWithValue("@SectionDay", sectionDay);
          cmd.Parameters.AddWithValue("@SectionTime", sectionTime);
          cmd.Parameters.AddWithValue("@SectionEndTime", sectionEndTime);
          cmd.Parameters.AddWithValue("@RoomID", roomID);
          cmd.Parameters.AddWithValue("@AssistantProfessorID", assistantProfessorID);

          int count = (int)cmd.ExecuteScalar();
          return count > 0;
        }
      }
    }

    // Handle the command in SectionsRepeater
    protected void SectionsRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
      if (e.CommandName == "Delete")
      {
        int sectionID = Convert.ToInt32(e.CommandArgument);
        DeleteSection(sectionID);
        LoadSectionsData(); // Refresh sections list
      }
    }

    // Delete a section
    private void DeleteSection(int sectionID)
    {
      using (SqlConnection conn = new SqlConnection(connectionString))
      {
        string query = "DELETE FROM Sections WHERE SectionID = @SectionID";
        using (SqlCommand cmd = new SqlCommand(query, conn))
        {
          cmd.Parameters.AddWithValue("@SectionID", sectionID);
          conn.Open();
          cmd.ExecuteNonQuery();
        }
      }
      lblSectionMessage.Text = "Section deleted successfully.";
    }

    // Format time value for display
    protected string FormatTime(object timeValue)
    {
      if (timeValue == null || timeValue == DBNull.Value)
      {
        return "N/A"; // Default value if data is null or empty
      }

      try
      {
        TimeSpan time = TimeSpan.Parse(timeValue.ToString());
        return time.ToString(@"hh\:mm");
      }
      catch (FormatException)
      {
        return "Invalid Time";
      }
    }

    // Check for timetable conflicts
    private bool IsTimetableConflict(int courseID, string day, TimeSpan startTime, TimeSpan endTime, int roomID, int professorID)
    {
      using (SqlConnection conn = new SqlConnection(connectionString))
      {
        conn.Open();
        string query = @"
                    SELECT COUNT(*)
                    FROM Timetable
                    WHERE Day = @Day
                    AND (
                        (StartTime < @EndTime AND EndTime > @StartTime)
                        OR
                        (StartTime = @StartTime AND EndTime = @EndTime)
                    )
                    AND (RoomID = @RoomID OR ProfessorID = @ProfessorID)";
        using (SqlCommand cmd = new SqlCommand(query, conn))
        {
          cmd.Parameters.AddWithValue("@Day", day);
          cmd.Parameters.AddWithValue("@StartTime", startTime);
          cmd.Parameters.AddWithValue("@EndTime", endTime);
          cmd.Parameters.AddWithValue("@RoomID", roomID);
          cmd.Parameters.AddWithValue("@ProfessorID", professorID);

          int count = (int)cmd.ExecuteScalar();
          return count > 0;
        }
      }
    }

    // Save timetable entry
    private void SaveTimetableEntry(int courseID, string day, TimeSpan startTime, TimeSpan endTime, int roomID, int professorID)
    {
      using (SqlConnection conn = new SqlConnection(connectionString))
      {
        conn.Open();

        string query;
        if (IsTimetableEntryExists(courseID, day, startTime, endTime, roomID, professorID))
        {
          // Update timetable entry
          query = @"
                        UPDATE Timetable
                        SET Day = @Day, StartTime = @StartTime, EndTime = @EndTime, RoomID = @RoomID, ProfessorID = @ProfessorID
                        WHERE CourseID = @CourseID AND TimetableID = @TimetableID";

          using (SqlCommand cmd = new SqlCommand(query, conn))
          {
            int timetableID = GetTimetableID(courseID, day, startTime, endTime, roomID, professorID);
            cmd.Parameters.AddWithValue("@TimetableID", timetableID);
            cmd.Parameters.AddWithValue("@Day", day);
            cmd.Parameters.AddWithValue("@StartTime", startTime);
            cmd.Parameters.AddWithValue("@EndTime", endTime);
            cmd.Parameters.AddWithValue("@RoomID", roomID);
            cmd.Parameters.AddWithValue("@ProfessorID", professorID);

            cmd.ExecuteNonQuery();
          }
        }
        else
        {
          // Insert new timetable entry
          query = @"
                        INSERT INTO Timetable (CourseID, Day, StartTime, EndTime, RoomID, ProfessorID)
                        VALUES (@CourseID, @Day, @StartTime, @EndTime, @RoomID, @ProfessorID)";

          using (SqlCommand cmd = new SqlCommand(query, conn))
          {
            cmd.Parameters.AddWithValue("@CourseID", courseID);
            cmd.Parameters.AddWithValue("@Day", day);
            cmd.Parameters.AddWithValue("@StartTime", startTime);
            cmd.Parameters.AddWithValue("@EndTime", endTime);
            cmd.Parameters.AddWithValue("@RoomID", roomID);
            cmd.Parameters.AddWithValue("@ProfessorID", professorID);

            cmd.ExecuteNonQuery();
          }
        }
      }
    }

    // Check if a timetable entry exists
    private bool IsTimetableEntryExists(int courseID, string day, TimeSpan startTime, TimeSpan endTime, int roomID, int professorID)
    {
      using (SqlConnection conn = new SqlConnection(connectionString))
      {
        conn.Open();
        string query = @"
                    SELECT COUNT(*)
                    FROM Timetable
                    WHERE CourseID = @CourseID
                    AND Day = @Day
                    AND StartTime = @StartTime
                    AND EndTime = @EndTime
                    AND RoomID = @RoomID
                    AND ProfessorID = @ProfessorID";
        using (SqlCommand cmd = new SqlCommand(query, conn))
        {
          cmd.Parameters.AddWithValue("@CourseID", courseID);
          cmd.Parameters.AddWithValue("@Day", day);
          cmd.Parameters.AddWithValue("@StartTime", startTime);
          cmd.Parameters.AddWithValue("@EndTime", endTime);
          cmd.Parameters.AddWithValue("@RoomID", roomID);
          cmd.Parameters.AddWithValue("@ProfessorID", professorID);

          int count = (int)cmd.ExecuteScalar();
          return count > 0;
        }
      }
    }

    // Get timetable ID for an existing timetable entry
    private int GetTimetableID(int courseID, string day, TimeSpan startTime, TimeSpan endTime, int roomID, int professorID)
    {
      using (SqlConnection conn = new SqlConnection(connectionString))
      {
        conn.Open();
        string query = @"
                    SELECT TimetableID
                    FROM Timetable
                    WHERE CourseID = @CourseID
                    AND Day = @Day
                    AND StartTime = @StartTime
                    AND EndTime = @EndTime
                    AND RoomID = @RoomID
                    AND ProfessorID = @ProfessorID";

        using (SqlCommand cmd = new SqlCommand(query, conn))
        {
          cmd.Parameters.AddWithValue("@CourseID", courseID);
          cmd.Parameters.AddWithValue("@Day", day);
          cmd.Parameters.AddWithValue("@StartTime", startTime);
          cmd.Parameters.AddWithValue("@EndTime", endTime);
          cmd.Parameters.AddWithValue("@RoomID", roomID);
          cmd.Parameters.AddWithValue("@ProfessorID", professorID);

          object result = cmd.ExecuteScalar();

          if (result != null && result != DBNull.Value)
          {
            return Convert.ToInt32(result);
          }
          else
          {
            return -1;
          }
        }
      }
    }

    // Handle deleting a timetable entry
    protected void TimetableRepeater_ItemCommand(object sender, CommandEventArgs e)
    {
      if (e.CommandName == "Delete")
      {
        int timetableID = Convert.ToInt32(e.CommandArgument);
        DeleteTimetableEntry(timetableID);
        LoadTimetableData(); // Reload the timetable data after deletion
      }
    }

    // Delete a timetable entry
    private void DeleteTimetableEntry(int timetableID)
    {
      using (SqlConnection conn = new SqlConnection(connectionString))
      {
        string query = "DELETE FROM Timetable WHERE TimetableID = @TimetableID";
        using (SqlCommand cmd = new SqlCommand(query, conn))
        {
          cmd.Parameters.AddWithValue("@TimetableID", timetableID);
          conn.Open();
          cmd.ExecuteNonQuery();
        }
      }
      lblMessage.Text = "Timetable entry deleted successfully.";
    }
  }
}
