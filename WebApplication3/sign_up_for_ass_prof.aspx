<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master"
AutoEventWireup="true" CodeBehind="sign_up_for_ass_prof.aspx.cs"
Inherits="WebApplication3.sign_up_for_ass_prof" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PrivateStyle" runat="server">
  <link href="css/sign_up_for_ass_prof.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
  Sign Up For Assistant Professors
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentBody" runat="server">
  <!-- Start Sign Up for Assistant Professors -->
  <div class="big-sign-up-container">
    <div class="signup-container">
      <i class="fa-solid fa-chalkboard-user"></i>
      <h2>Sign Up for Assistant Professors</h2>
      <form method="post" action="sign_up_for_ass_prof.aspx">
        <div class="columns">
          <div class="column">
            <input
              type="text"
              id="first-name"
              name="first-name"
              placeholder="First Name"
              required
            /><br />

            <input
              type="text"
              id="last-name"
              name="last-name"
              placeholder="Last Name"
              required
            /><br />

            <input
              type="tel"
              id="contact-number"
              name="contact-number"
              placeholder="Contact Number"
              maxlength="11"
              minlength="11"
              required
            /><br />

            <input
              type="password"
              id="password"
              name="password"
              placeholder="Password"
              required
            /><br />

            <select id="gender" name="gender" required>
              <option value="" disabled selected>Select Gender</option>
              <option value="Male">Male</option>
              <option value="Female">Female</option></select
            ><br />
          </div>

          <div class="column">
            <input
              type="text"
              id="middle-name"
              name="middle-name"
              placeholder="Middle Name"
              required
            /><br />

            <input
              type="text"
              id="national-id"
              name="national-id"
              placeholder="National ID"
              maxlength="14"
              minlength="14"
              required
            /><br />

            <input
              type="email"
              id="email"
              name="email"
              placeholder="Email"
              required
            /><br />

            <input
              type="date"
              id="date-of-birth"
              name="date-of-birth"
              placeholder="Date of Birth"
              required
            /><br />
          </div>
        </div>

        <a href="log_in.aspx">Already have an account? Log in here</a>
        <input type="submit" value="Sign Up" />
      </form>
    </div>
  </div>
  <!-- End Sign Up for Assistant Professors -->
</asp:Content>
