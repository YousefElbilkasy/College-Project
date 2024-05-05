<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication3.WebForm1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="PrivateStyle" runat="server">
  <link
    rel="stylesheet"
    href="css/index.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageTitle" runat="server">
  Home
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentBody" runat="server">
  <!-- Start Body -->
  <div class="container-photo">
    <div class="first-subcontainer">
      <div class="info">
        <h3 class="faculty">Faculty of</h3>
        <h1 class="college">Computer & Information</h1>
        <h2 class="unversity">Kafr Elsheikh University</h2>
      </div>
      <h4>Go on to Know More Details</h4>
    </div>
    <div class="second-subcontainer">
      <img src="imgs/9.jpg" alt="" />
    </div>
  </div>
  <!-- End Body -->

  <!-- Start Activities -->
  <div class="activities-container">
    <h3>Our Activities</h3>
    <div class="best-student">
      <div class="first-container">
        <div class="photo-background">
          <img alt="" src="imgs/events.jpg" />
        </div>
        <div class="paragraph-events">
          <h4>Events</h4>
          <p>
            The College of Computers and Information announces the establishment
          of:
            <br />
            third forum to prepare students of the College of Computers
          and Information for the labor market
            <br />
            This will be at 10 o’clock
          on Monday 11/13 in the seminar hall at the college
            <br />
            With the
          participation of:
            <br />
            - Microsoft Corporation
            <br />
            - Digital World
          Magazine
            <br />
            - Information Technology Institute (ITI).
            <br />
            - ITIDA
          Center for Innovation and Entrepreneurship
            <br />
            - My services company
          <br />
            All students are waiting to attend and benefit from the present
          companies and opportunities within the forum
          </p>
          <div class="see-more-button">
            <a href="#">See More Activities</a>
          </div>
        </div>
      </div>
      <!-- <div class="second-container">
          <img alt="" src="imgs/events 2 .jpg" />
          <img alt="" src="imgs/events 3.jpg" />
          <img alt="" src="imgs/events 4.jpg" />
          <img alt="" src="imgs/events 5.jpg" />
        </div> -->
    </div>
    <div class="our-student">
      <h3>Our Students</h3>
      <div class="our-student-photos">
        <img
          src="imgs/our student.jpg"
          alt="" />
        <img
          src="imgs/our student 2.jpg"
          alt="" />
        <img
          src="imgs/our student 3.jpg"
          alt="" />
        <img
          src="imgs/our student 4.jpg"
          alt="" />
        <img
          src="imgs/our student 5.jpg"
          alt="" />
        <img
          src="imgs/our student 6.jpg"
          alt="" />
      </div>
    </div>
  </div>
  <!-- End Activities -->
</asp:Content>
