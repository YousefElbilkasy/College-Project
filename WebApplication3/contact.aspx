<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="contact.aspx.cs" Inherits="WebApplication3.WebForm3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PrivateStyle" runat="server">
  <link href="css/contact.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
  Contact
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentBody" runat="server">
  <div class="main-container">
    <h1>Contact Us</h1>
    <p>We're open for any suggestion or just to have a chat</p>
    <div class="subcontainer">
      <div class="first-subcontainer">
        <div class="first-column">
          <p>
            <span>MY ADDRESS:</span>
            El-Gish Street, Kafr Elsheikh, Arab Republic of Egypt.
          </p>
        </div>
        <div class="second-column">
          <p>
            <span>MY EMAIL:</span>
            fci@fci.kfs.edu.eg
          </p>
        </div>
        <div class="third-column">
          <p>
            <span>MY PHONE:</span>
            (+20) 1096554062
          </p>
        </div>
      </div>
    </div>
    <div class="second-subcontainer">
      <form action="">
        <input type="text" placeholder="Name" required class="main-input" />
        <input type="email" placeholder="Email" required class="main-input" />
        <input type="text" placeholder="Subject" required class="main-input" />
        <textarea
          class="main-input"
          name="message"
          id=""
          placeholder="Create a message here"
          required></textarea>
        <input type="submit" value="send message" class="sumbit-button" />
      </form>
    </div>
  </div>
</asp:Content>
