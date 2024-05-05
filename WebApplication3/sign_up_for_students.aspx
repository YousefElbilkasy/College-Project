<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master"
AutoEventWireup="true" CodeBehind="sign_up_for_students.aspx.cs"
Inherits="WebApplication3.sign_up_for_students" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PrivateStyle" runat="server">
  <link href="css/sign_up_for_students.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
  Sign Up for Students
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentBody" runat="server">
  <!-- Start Sign Up for Students -->
  <div class="big-sign-up-container">
    <div class="signup-container">
      <i class="fa-solid fa-user-graduate"></i>
      <h2>Sign Up for Students</h2>
      <form method="post" action="sign_up_for_students.aspx">
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

            <select id="class-level" name="class_level" required>
              <option value="" disabled selected>Select Class Level</option>
              <option value="Level 1">Level 1</option>
              <!-- Add more options as needed --></select
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
              type="tel"
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

            <select id="gender" name="gender" required>
              <option value="" disabled selected>Select Gender</option>
              <option value="Male">Male</option>
              <option value="Female">Female</option>
              <!-- Add more options as needed --></select
            ><br />
          </div>
        </div>
        <a href="log_in.aspx" class="have-account"
          >Already have an account ? Log in here.</a
        >
        <input type="submit" value="Sign Up" />
      </form>
    </div>
  </div>
  <!-- End Sign Up for Students -->
</asp:Content>
