<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="log_in.aspx.cs" Inherits="WebApplication3.log_in" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PrivateStyle" runat="server">
  <link rel="stylesheet" href="css/log_in.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
  Log in
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentBody" runat="server">
  <!-- Start Log in -->
  <div class="big-log-in-container">
    <div class="login-container">
      <i class="fa-solid fa-circle-user"></i>
      <h2>Log in</h2>

      <form method="post" class="log-in-form">
        <input 
            type="email"
            name="email" placeholder="Email" 
            required /><br />
        <input
          type="password"
          name="password"
          placeholder="Password"
          required /><br />
        <div class="remember-me">
          <input type="checkbox" id="remeber" />
          <label for="remeber">Remember Me</label>
        </div>
        <div class="have-an-account">
          <a href="sign_up.aspx" class="create-new-account">Create a New Account</a>
        </div>
        <input type="submit" value="Login" />
      </form>
    </div>
  </div>
  <!-- End Log in -->

</asp:Content>
