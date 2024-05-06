using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication3
{
    public partial class log_in : Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                string email = Request.Form["email"];
                string password = Request.Form["password"];

                
                if (email == "admin@gmail.com" && password == "admin123")
                {
                    // Set session variables for admin
                    Session["IsAdmin"] = true;
                    Session["Email"] = email;
                    Session["IsAuthenticated"] = true;

          
          Response.Redirect("verification_for_admin.aspx");
                }
                else
                {
                    
                    string role = CheckUserLogin(email, password);

                    if (!string.IsNullOrEmpty(role))
                    {
                        // Set session variables for the user
                        Session["IsAuthenticated"] = true;
                        Session["Email"] = email;
                        Session["Role"] = role;

                        // Redirect based on role
                        switch (role)
                        {
                            case "student":
                                Response.Redirect("timetable_for_student.aspx");
                                break;
                            case "professor":
                                Response.Redirect("attendance_for_prof_trail.aspx");
                                break;
                            case "assistant":
                                Response.Redirect("ass_prof_home.aspx");
                                break;
                        }
                    }
                    else
                    {
                       
                        DisplayLoginError("Invalid email or password. Please try again.");
                    }
                }
            }
        }

        private string CheckUserLogin(string email, string password)
        {
            string role = null;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    if (CheckLoginInTable(conn,"Student", email, password, out int studentId))
                    {
                        role = "student";
                        Session["ID"] = studentId; // Set session ID for student
                    }
                 
                    else if (CheckLoginInTable(conn,"Professor", email, password, out int professorId))
                    {
                        role = "professor";
                        Session["ID"] = professorId; // Set session ID for professor
                    }
                   
                    else if (CheckLoginInTable(conn,"AssistantProfessor", email, password, out int assistantId))
                    {
                        role = "assistant";
                        Session["ID"] = assistantId; // Set session ID for assistant
                    }

                    conn.Close();
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }

            return role;
        }

        private bool CheckLoginInTable(SqlConnection conn, string tableName, string email, string password, out int id)
        {
            bool isAuthenticated = false;
            id = -1;

            
            string query = $@"
                SELECT {tableName}ID FROM {tableName}s
                WHERE Email = @Email AND Password = @Password AND IsVerified = 1";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", password);

             
                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    isAuthenticated = true;
                    id = Convert.ToInt32(result);
                }
            }

            return isAuthenticated;
        }

        private void DisplayLoginError(string errorMessage)
        {
            string script = $"alert('{errorMessage}');";
            ClientScript.RegisterStartupScript(this.GetType(), "loginErrorAlert", script, true);
        }
    }
}
