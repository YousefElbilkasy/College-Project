﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication3
{
  public partial class timetable_for_student : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
            if (Session["IsAuthenticated"] != null && (bool)Session["IsAuthenticated"])
            {
                // Retrieve user-specific data based on their email
                string userEmail = Session["Email"] != null ? Session["Email"].ToString() : "No email found";

                // Display a welcome message or perform other actions based on the user's role
                    string welcomeScript = $"alert('Welcome, {userEmail}!');";
                    ClientScript.RegisterStartupScript(this.GetType(), "welcomeAlert", welcomeScript, true);
                
            }
            else
            {
                // Redirect to the login page if the user is not authenticated
                Response.Redirect("log_in.aspx");
            }
        }

    }
  }
