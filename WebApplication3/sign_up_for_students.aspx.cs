using System;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication3
{
    public partial class sign_up_for_students : System.Web.UI.Page
    {
        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Handle form submission
            if (IsPostBack)
            {
                
                string firstName = Request.Form["first-name"];
                string lastName = Request.Form["last-name"];
                string middleName = Request.Form["middle-name"];
                string contactNumber = Request.Form["contact-number"];
                string nationalID = Request.Form["national-id"];
                string email = Request.Form["email"];
                string password = Request.Form["password"];
                DateTime dateOfBirth = Convert.ToDateTime(Request.Form["date-of-birth"]);
                string classLevel = Request.Form["class_level"];
                string gender = Request.Form["gender"];

               
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    try
                    {
                        conn.Open();

                        
                        string query = @"
                            INSERT INTO Students (FirstName, LastName, MiddleName, ContactNumber, NationalID, Email, Password, DateOfBirth, ClassLevel, Gender)
                            VALUES (@FirstName, @LastName, @MiddleName, @ContactNumber, @NationalID, @Email, @Password, @DateOfBirth, @ClassLevel, @Gender)";

                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                           
                            cmd.Parameters.AddWithValue("@FirstName", firstName);
                            cmd.Parameters.AddWithValue("@LastName", lastName);
                            cmd.Parameters.AddWithValue("@MiddleName", middleName);
                            cmd.Parameters.AddWithValue("@ContactNumber", contactNumber);
                            cmd.Parameters.AddWithValue("@NationalID", nationalID);
                            cmd.Parameters.AddWithValue("@Email", email);
                            cmd.Parameters.AddWithValue("@Password", password);
                            cmd.Parameters.AddWithValue("@DateOfBirth", dateOfBirth);
                            cmd.Parameters.AddWithValue("@ClassLevel", classLevel);
                            cmd.Parameters.AddWithValue("@Gender", gender);

                            cmd.ExecuteNonQuery();
                        }

                        
                        string script = "alert('Sign-up successful! Redirecting to login page...'); window.location.href='log_in.aspx';";
                        ClientScript.RegisterStartupScript(this.GetType(), "successAlert", script, true);
                    }
                    catch (Exception ex)
                    {
                        
                        Console.WriteLine(ex.Message);
                    }
                }
            }
        }
    }
}
