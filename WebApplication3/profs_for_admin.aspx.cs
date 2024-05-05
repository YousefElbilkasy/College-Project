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
    public partial class profs_for_admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Fetch data from a database
                List<Professors> professors = FetchProfessorsFromDatabase();

                // Bind the list of students to the Repeater
                Repeater1.DataSource = professors;
                Repeater1.DataBind();
            }

        }
        private List<Professors> FetchProfessorsFromDatabase()
        {
            List<Professors> professors = new List<Professors>();

            // Connection string
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            // SQL query to fetch students
            string query = "SELECT * FROM Professors";

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
                        Professors professor = new Professors();
                        professor.ProfessorID = Convert.ToInt32(reader["ProfessorID"]);
                        professor.FirstName = reader["FirstName"].ToString();
                        professor.LastName = reader["LastName"].ToString();
                        professor.MiddleName = reader["MiddleName"].ToString();
                        professor.ContactNumber = reader["ContactNumber"].ToString();
                        professor.NationalID = reader["NationalID"].ToString();
                        professor.Email = reader["Email"].ToString();
                        professor.DateOfBirth = Convert.ToDateTime(reader["DateOfBirth"]);
                        professor.Gender = reader["Gender"].ToString();
                        // Add the student to the list
                       professors.Add(professor);
                    }
                }
            }

            return professors;
        }
        protected void btnAddProfessor_Click(object sender, EventArgs e)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Professors (FirstName, LastName, MiddleName, ContactNumber, NationalID, Email, Password, DateOfBirth , Gender,IsVerified) " +
                               "VALUES (@FirstName, @LastName, @MiddleName, @ContactNumber, @NationalID, @Email, @Password, @DateOfBirth, @Gender,@IsVerified)";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@FirstName", txtFirstName1.Text);
                cmd.Parameters.AddWithValue("@LastName", txtLastName1.Text);
                cmd.Parameters.AddWithValue("@MiddleName", txtMiddleName1.Text);
                cmd.Parameters.AddWithValue("@ContactNumber", txtContactNumber1.Text);
                cmd.Parameters.AddWithValue("@NationalID", txtNationalID1.Text);
                cmd.Parameters.AddWithValue("@Email", txtEmail1.Text);
                cmd.Parameters.AddWithValue("@Password", txtPassword1.Text);
                cmd.Parameters.AddWithValue("@DateOfBirth", Convert.ToDateTime(txtDateOfBirth1.Text));
                cmd.Parameters.AddWithValue("@Gender", ddlGender1.SelectedValue);
                cmd.Parameters.AddWithValue("@IsVerified",1);

                con.Open();
                int rowsAffected = cmd.ExecuteNonQuery();
                con.Close();

                if (rowsAffected > 0)
                {
                    lblMessage.Text = "Professor added successfully!";
                }
                else
                {
                    lblMessage.Text = "Failed to add Professor!";
                }
                //ClientScript.RegisterStartupScript(this.GetType(), "reload", "reloadPage();", true);
            }
        }
    }
}

