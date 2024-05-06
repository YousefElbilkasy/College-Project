using System;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace WebApplication3
{
    public partial class verification_for_admin : System.Web.UI.Page
    {
        // Connection string to the database
        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
      if (Session["IsAuthenticated"] != null && (bool)Session["IsAuthenticated"])
      {
        if (!IsPostBack)
        {
          // Load unverified users data when the page is first loaded
          LoadUnverifiedUsers();
        }
      }
    }

        // Function to load unverified users
        private void LoadUnverifiedUsers()
        {
            // Establish database connection
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    // Prepare the SQL query to fetch unverified users from all tables
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

                    // Create a command and data reader
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
                    // Handle any errors that may occur
                    Console.WriteLine(ex.Message);
                }
            }
        }

        // Event handler for Verify button
        protected void VerifyButton_Click(object sender, EventArgs e)
        {
            Button verifyButton = (Button)sender;
            int userId = int.Parse(verifyButton.CommandArgument);

            // Establish database connection
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    // Prepare the SQL query to update the IsVerified column based on the user's role
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
                        // Add parameters to avoid SQL injection
                        cmd.Parameters.AddWithValue("@UserID", userId);

                        // Execute the query
                        cmd.ExecuteNonQuery();
                    }
                }
                catch (Exception ex)
                {
                    // Handle any errors that may occur
                    Console.WriteLine(ex.Message);
                }
            }

            // Reload the unverified users list
            LoadUnverifiedUsers();
        }

        // Event handler for Reject button
        protected void RejectButton_Click(object sender, EventArgs e)
        {
            
            Button rejectButton = (Button)sender;

            // Parse the user ID from the CommandArgument property
            int userId;
            if (!int.TryParse(rejectButton.CommandArgument, out userId))
            {
                // Handle parsing error (invalid user ID)
                DisplayError("Invalid user ID. Please try again.");
                return;
            }

            // Establish a database connection
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    // Open the database connection
                    conn.Open();

                    // Prepare the SQL query to delete the user from any of the tables based on userId
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
                        // Add parameters to avoid SQL injection
                        cmd.Parameters.AddWithValue("@UserID", userId);

                        // Execute the query
                        int rowsAffected = cmd.ExecuteNonQuery();

                        // Optionally check if a row was deleted (e.g., if the user was already verified or deleted)
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

        // Function to display error messages to the admin
        private void DisplayError(string errorMessage)
        {
            // Use JavaScript to display an alert with the error message
            string script = $"alert('{errorMessage}');";
            ClientScript.RegisterStartupScript(this.GetType(), "errorAlert", script, true);
        }

    }
}
