using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace WebApplication3
{
    public partial class students_for_admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Fetch and bind all students to the GridView
                BindStudentsToRepeater(null, null);
            }
            else if (Request.Params["__EVENTTARGET"] == "searchButton")
            {
                // Handle the search functionality
                string searchField = Request.Params["searchField"];
                string searchTerm = Request.Params["__EVENTARGUMENT"];
                BindStudentsToRepeater(searchField, searchTerm);
            }
        }

        private void BindStudentsToRepeater(string searchField, string searchTerm)
        {
            List<Students> students = FetchStudentsFromDatabase(searchField, searchTerm);
            Repeater1.DataSource = students;
            Repeater1.DataBind();
        }

        // Method to fetch students from the database and return a list of Student objects
        private List<Students> FetchStudentsFromDatabase(string searchField, string searchTerm)
        {
            List<Students> students = new List<Students>();

            // Connection string
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            // SQL query to fetch students
            string query = "SELECT * FROM Students";

            // Add the search condition based on the search field
            if (!string.IsNullOrEmpty(searchField) && !string.IsNullOrEmpty(searchTerm))
            {
                query += " WHERE ";
                switch (searchField)
                {
                    case "FirstName":
                        query += "FirstName LIKE @SearchTerm";
                        break;
                    case "LastName":
                        query += "LastName LIKE @SearchTerm";
                        break;
                    case "NationalID":
                        query += "NationalID = @SearchTerm";
                        break;
                    case "ContactNumber":
                        query += "ContactNumber = @SearchTerm";
                        break;
                    case "Email":
                        query += "Email LIKE @SearchTerm";
                        break;
                    default:
                        query += "FirstName LIKE @SearchTerm OR StudentID = @SearchTerm";
                        break;
                }
            }

            // Create a SqlConnection object
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Create a SqlCommand object
                SqlCommand command = new SqlCommand(query, connection);

                // Add the search parameter if a search term is provided
                if (!string.IsNullOrEmpty(searchTerm))
                {
                    command.Parameters.AddWithValue("@SearchTerm", "%" + searchTerm + "%");
                }

                // Open the database connection
                connection.Open();

                // Execute the command and read data
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    // Read each row from the result set
                    while (reader.Read())
                    {
                        // Create a new Student object
                        Students student = new Students();
                        // Populate the student object
                        student.StudentID = Convert.ToInt32(reader["StudentID"]);
                        student.FirstName = reader["FirstName"].ToString();
                        student.LastName = reader["LastName"].ToString();
                        student.MiddleName = reader["MiddleName"].ToString();
                        student.ContactNumber = reader["ContactNumber"].ToString();
                        student.NationalID = reader["NationalID"].ToString();
                        student.Email = reader["Email"].ToString();
                        student.DateOfBirth = Convert.ToDateTime(reader["DateOfBirth"]);
                        student.ClassLevel = reader["ClassLevel"].ToString();
                        student.Gender = reader["Gender"].ToString();
                        student.IsVerified = Convert.ToBoolean(reader["IsVerified"]);

                        // Add the student to the list
                        students.Add(student);
                    }
                }
            }

            return students;
        }

        protected void btnAddStudent_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Students (FirstName, LastName, MiddleName, ContactNumber, NationalID, Email, Password, DateOfBirth, ClassLevel, Gender,IsVerified) " +
                               "VALUES (@FirstName, @LastName, @MiddleName, @ContactNumber, @NationalID, @Email, @Password, @DateOfBirth, @ClassLevel, @Gender,@IsVerified)";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@FirstName", txtFirstName.Text);
                cmd.Parameters.AddWithValue("@LastName", txtLastName.Text);
                cmd.Parameters.AddWithValue("@MiddleName", txtMiddleName.Text);
                cmd.Parameters.AddWithValue("@ContactNumber", txtContactNumber.Text);
                cmd.Parameters.AddWithValue("@NationalID", txtNationalID.Text);
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text);
                cmd.Parameters.AddWithValue("@DateOfBirth", Convert.ToDateTime(txtDateOfBirth.Text));
                cmd.Parameters.AddWithValue("@ClassLevel", Request.Form["class_level"]);
                cmd.Parameters.AddWithValue("@Gender", ddlGender.SelectedValue);
                cmd.Parameters.AddWithValue("@IsVerified", 1);

                con.Open();
                int rowsAffected = cmd.ExecuteNonQuery();
                con.Close();

                if (rowsAffected > 0)
                {
                    lblMessage.Text = "Student added successfully!";
                }
                else
                {
                    lblMessage.Text = "Failed to add student!";
                }
                //ClientScript.RegisterStartupScript(this.GetType(), "reload", "reloadPage();", true);
            }
        }
        protected void confirmDeleteBtn_Click(object sender, EventArgs e)
        {
            Button button = (Button)sender;
            int studentId = Convert.ToInt32(button.CommandArgument);

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                    // Delete related records in StudentAttendance table
                    string deleteAttendanceQuery = "DELETE FROM StudentAttendance WHERE StudentID = @StudentID";
                    using (SqlCommand attendanceCommand = new SqlCommand(deleteAttendanceQuery, connection))
                    {
                        attendanceCommand.Parameters.AddWithValue("@StudentID", studentId);
                        attendanceCommand.ExecuteNonQuery();
                    }
                    // Delete related records in StudentCoursese table
                    string deleteStudentCourseseQuery = "DELETE FROM StudentsCourses WHERE StudentID = @StudentID";
                    using (SqlCommand attendanceCommand = new SqlCommand(deleteStudentCourseseQuery, connection))
                    {
                        attendanceCommand.Parameters.AddWithValue("@StudentID", studentId);
                        attendanceCommand.ExecuteNonQuery();
                    }

                    // Delete the student
                    string deleteQuery = "DELETE FROM Students WHERE StudentID = @StudentID";
                using (SqlCommand command = new SqlCommand(deleteQuery, connection))
                {
                    command.Parameters.AddWithValue("@StudentID", studentId);
                    int rowsAffected = command.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        ShowMessage("Success");
                        Response.Redirect(Request.Url.ToString());
                    }
                    else
                    {
                        ShowError("Failed");
                    }
                }

                void ShowMessage(string txt)
                {
                    // Display success message to the user
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + txt + "');", true);
                }

                void ShowError(string txt)
                {
                    // Display error message to the user
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + txt + "');", true);
                }
            }
        }



    }
}

                   
