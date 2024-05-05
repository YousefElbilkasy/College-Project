<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master"
AutoEventWireup="true" CodeBehind="sign_up.aspx.cs"
Inherits="WebApplication3.sign_up" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PrivateStyle" runat="server">
  <link href="css/sign_up.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
  Sign Up
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentBody" runat="server">
  <!-- Start Sign Up -->
  <main class="big-container">
    <section class="container">
      <h2>Please Select Type of Sign Up</h2>
      <div class="signup-container">
        <div class="signup-option">
          <a href="sign_up_for_prof.aspx" class="button">
            <div>
              <i class="fa-solid fa-user-tie"></i>
              <h6>Professor</h6>
            </div>
          </a>
        </div>
        <div class="signup-option">
          <a href="sign_up_for_ass_prof.aspx" class="button">
            <div>
              <i class="fa-solid fa-chalkboard-user"></i>
              <h6>Prof. Assistant</h6>
            </div>
          </a>
        </div>
        <div class="signup-option">
          <a href="sign_up_for_students.aspx" class="button">
            <div>
              <i class="fa-solid fa-user-graduate"></i>
              <h6>Student</h6>
            </div>
          </a>
        </div>
      </div>
      <div>
        <a href="log_in.aspx" class="have-account"
          >Or You Already Have an Account</a
        >
      </div>
    </section>
  </main>
  <!-- End Sign Up -->
</asp:Content>
