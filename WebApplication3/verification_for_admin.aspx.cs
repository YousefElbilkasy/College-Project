using System;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace WebApplication3
{
    public partial class verification_for_admin : System.Web.UI.Page
    {
        
        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
      if (Session["IsAuthenticated"] != null && (bool)Session["IsAuthenticated"])
      {
        if (!IsPostBack)
        {
          
          LoadUnverifiedUsers();
        }
      }
      else
      {
        
        Response.Redirect("log_in.aspx");
      }
    }

       
        private void LoadUnverifiedUsers()
        {
            
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    string query = @"
                        SELECT 'Student' AS role, StudentID AS id, FirstName AS first_name, MiddleName AS middle_name, LastName AS last_name, Email AS email
                        FROM Students
                        WHERE IsVerified = 0
                        UNION ALL
                        SELECT 'Professor' AS role, ProfessorID AS id, FirstName AS first_name, MiddleName AS middle_name, LastName AS last_name, Email AS email
                        FROM Professors
                        WHERE IsVerified = 0
                        UNION ALL
                        SELECT 'Assistant Professor' AS role, AssistantProfessorID AS id, FirstName AS first_name, MiddleName AS middle_name, LastName AS last_name, Email AS email
                        FROM AssistantProfessors
                        WHERE IsVerified = 0";

                  
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            // Bind the data reader to the repeater
                            Repeater1.DataSource = reader;
                            Repeater1.DataBind();
                        }
                    }
                }
                catch (Exception ex)
                {
                    
                    Console.WriteLine(ex.Message);
                }
            }
        }

        
        protected void VerifyButton_Click(object sender, EventArgs e)
        {
            Button verifyButton = (Button)sender;
            int userId = int.Parse(verifyButton.CommandArgument);

            
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                   
                    string query = @"
                        UPDATE Students
                        SET IsVerified = 1
                        WHERE StudentID = @UserID
                        ;
                        UPDATE Professors
                        SET IsVerified = 1
                        WHERE ProfessorID = @UserID
                        ;
                        UPDATE AssistantProfessors
                        SET IsVerified = 1
                        WHERE AssistantProfessorID = @UserID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        
                        cmd.Parameters.AddWithValue("@UserID", userId);

                        cmd.ExecuteNonQuery();
                    }
                }
                catch (Exception ex)
                {
                 
                    Console.WriteLine(ex.Message);
                }
            }

           
            LoadUnverifiedUsers();
        }

        
        protected void RejectButton_Click(object sender, EventArgs e)
        {
            
            Button rejectButton = (Button)sender;

            
            int userId;
            if (!int.TryParse(rejectButton.CommandArgument, out userId))
            {
                
                DisplayError("Invalid user ID. Please try again.");
                return;
            }

            
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    
                    conn.Open();

                    
                    string query = @"
                IF EXISTS (SELECT * FROM Students WHERE StudentID = @UserID AND IsVerified = 0)
                BEGIN
                    DELETE FROM Students WHERE StudentID = @UserID;
                END
                ELSE IF EXISTS (SELECT * FROM Professors WHERE ProfessorID = @UserID AND IsVerified = 0)
                BEGIN
                    DELETE FROM Professors WHERE ProfessorID = @UserID;
                END
                ELSE IF EXISTS (SELECT * FROM AssistantProfessors WHERE AssistantProfessorID = @UserID AND IsVerified = 0)
                BEGIN
                    DELETE FROM AssistantProfessors WHERE AssistantProfessorID = @UserID;
                END";

                    
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        
                        cmd.Parameters.AddWithValue("@UserID", userId);

                        
                        int rowsAffected = cmd.ExecuteNonQuery();

                        
                        if (rowsAffected == 0)
                        {
                            DisplayError("The user may have been verified or already deleted. Please refresh the page.");
                        }
                    }
                }
                catch (Exception ex)
                {
                    
                    DisplayError("An error occurred while rejecting the user. Please try again.");
                    Console.WriteLine($"Error rejecting user (ID: {userId}): {ex.Message}");
                }
            }
            LoadUnverifiedUsers();
        }

        
        private void DisplayError(string errorMessage)
        {
            
            string script = $"alert('{errorMessage}');";
            ClientScript.RegisterStartupScript(this.GetType(), "errorAlert", script, true);
        }
    protected void LogoutButton_Click(object sender, EventArgs e)
    {
      // Clear session state
      Session.Clear();
      Session.Abandon();

      // Redirect to the login page
      Response.Redirect("log_in.aspx");
    }

  }
}
