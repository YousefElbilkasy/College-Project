<%@ Page Title="Courses Management" Language="C#" MasterPageFile="~/admin_dashboard.master" AutoEventWireup="true" CodeBehind="courses_for_admin.aspx.cs" Inherits="WebApplication3.courses_for_admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PrivateStyle2" runat="server">
  <link href="css/courses_for_admin.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentForAdminDashboard" runat="server">
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <div class="new-course-card">
          <h2>Add New Course</h2>
          <asp:TextBox ID="txtCourseName" runat="server" Placeholder="Course Name"></asp:TextBox>
          <asp:TextBox ID="txtCourseHours" runat="server" Placeholder="Course Hours" TextMode="Number"></asp:TextBox>
          <asp:CheckBox ID="chkHasSection" runat="server" Text="Has Section" />
          <asp:Button ID="btnAddCourse" runat="server" Text="Add Course" OnClick="BtnAddCourse_Click" />
          <asp:Label ID="lblMessage" runat="server" />
        </div>

        <!-- <h2>Current Courses</h2> -->
        <div class="current-courses-card">
          <asp:Repeater ID="rptCourses" runat="server">
            <ItemTemplate>
              <div class="card-head">
                <p>Course ID: <%# Eval("CourseID") %></p>
                <p>Course Name: <%# Eval("CourseName") %></p>
              </div>
              <div class="card-content">
                <p>Hours: <%# Eval("Hours") %></p>
                <p>
                  Has Section: <%# Convert.ToBoolean(Eval("HasSection")) ? "Yes" : "No" %>
                </p>
              </div>
              <div class="card-footer">
                
              </div>
            </ItemTemplate>
          </asp:Repeater>
        </div>
      </div>
    </div>
  </div>
</asp:Content>