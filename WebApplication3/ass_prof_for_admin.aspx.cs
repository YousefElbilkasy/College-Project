using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication3
{
    public partial class ass_prof_for_admin : System.Web.UI.Page
    {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (Session["IsAuthenticated"] != null && (bool)Session["IsAuthenticated"])
      {

        if (!IsPostBack)
        {
          // Fetch data from a database
          List<AssistantProfessors> assistantprofessors = FetchAssistantProfessorsFromDatabase();

          // Bind the list of students to the Repeater
          Repeater1.DataSource = assistantprofessors;
          Repeater1.DataBind();
        }
      }
      else
      {
        // Redirect to the login page if the user is not authenticated
        Response.Redirect("log_in.aspx");
      }
    }
        private List<AssistantProfessors> FetchAssistantProfessorsFromDatabase()
        {
            List<AssistantProfessors> assistantprofessors = new List<AssistantProfessors>();

            // Connection string
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            // SQL query to fetch students
            string query = "SELECT * FROM AssistantProfessors";

            // Create a SqlConnection object
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Create a SqlCommand object
                SqlCommand command = new SqlCommand(query, connection);

                // Open the database connection
                connection.Open();

                // Execute the command and read data
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    // Read each row from the result set
                    while (reader.Read())
                    {
                        // Create a new Student object
                        AssistantProfessors assistantprofessor = new AssistantProfessors();
                        assistantprofessor.AssistantProfessorID = Convert.ToInt32(reader["AssistantProfessorID"]);
                        assistantprofessor.FirstName = reader["FirstName"].ToString();
                        assistantprofessor.LastName = reader["LastName"].ToString();
                        assistantprofessor.MiddleName = reader["MiddleName"].ToString();
                        assistantprofessor.ContactNumber = reader["ContactNumber"].ToString();
                        assistantprofessor.NationalID = reader["NationalID"].ToString();
                        assistantprofessor.Email = reader["Email"].ToString();
                        assistantprofessor.DateOfBirth = Convert.ToDateTime(reader["DateOfBirth"]);
                        assistantprofessor.Gender = reader["Gender"].ToString();
                        // Add the student to the list
                        assistantprofessors.Add(assistantprofessor);
                    }
                }
            }
            return assistantprofessors;
        }
        protected void btnAddAssistantProfessor_Click(object sender, EventArgs e)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO AssistantProfessors (FirstName, LastName, MiddleName, ContactNumber, NationalID, Email, Password, DateOfBirth , Gender,IsVerified) " +
                               "VALUES (@FirstName, @LastName, @MiddleName, @ContactNumber, @NationalID, @Email, @Password, @DateOfBirth, @Gender,@IsVerified)";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@FirstName", txtFirstName.Text);
                cmd.Parameters.AddWithValue("@LastName", txtLastName.Text);
                cmd.Parameters.AddWithValue("@MiddleName", txtMiddleName.Text);
                cmd.Parameters.AddWithValue("@ContactNumber", txtContactNumber.Text);
                cmd.Parameters.AddWithValue("@NationalID", txtNationalID.Text);
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text);
                cmd.Parameters.AddWithValue("@DateOfBirth", Convert.ToDateTime(txtDateOfBirth.Text));
                cmd.Parameters.AddWithValue("@Gender", ddlGender.SelectedValue);
                cmd.Parameters.AddWithValue("@IsVerified", 1);

                con.Open();
                int rowsAffected = cmd.ExecuteNonQuery();
                con.Close();

                if (rowsAffected > 0)
                {
                    lblMessage.Text = "Assistant-Professor added successfully!";
                }
                else
                {
                    lblMessage.Text = "Failed to add Assistant-Professor!";
                }
                //ClientScript.RegisterStartupScript(this.GetType(), "reload", "reloadPage();", true);
            }
        }
    }
}
    