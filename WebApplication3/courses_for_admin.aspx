<%@ Page Title="Courses Management" Language="C#" MasterPageFile="~/admin_dashboard.master" AutoEventWireup="true" CodeBehind="courses_for_admin.aspx.cs" Inherits="WebApplication3.courses_for_admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PrivateStyle2" runat="server">
  <link href="css/courses_for_admin.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentForAdminDashboard" runat="server">
  <div class="courses-container">
    <div class="new-course-card">
      <div class="card-head">
        <h2>Add New Course</h2>
      </div>
      <div class="card-body">
        <asp:TextBox ID="txtCourseName" runat="server" Placeholder="Course Name" class="form-member"></asp:TextBox>
        <asp:TextBox ID="txtCourseHours" runat="server" Placeholder="Course Hours" TextMode="Number" class="form-member"></asp:TextBox>
        <asp:DropDownList ID="ddlProfessors" runat="server" class="form-member">
          <asp:ListItem Text="Select a Professor" Value="" />
        </asp:DropDownList>
        <asp:DropDownList ID="ddlAssistantProfessors" runat="server" Visible="false" class="form-member">
          <asp:ListItem Text="Select an Assistant Professor" Value="" />
        </asp:DropDownList>
        <asp:CheckBox ID="chkHasSection" runat="server" Text="Has Section" AutoPostBack="true" class="form-member"
          OnCheckedChanged="chkHasSection_CheckedChanged" />
      </div>
      <div class="card-footer">
        <asp:Button ID="btnAddCourse" runat="server" Text="Add Course" OnClick="BtnAddCourse_Click" />
        <asp:Label ID="lblMessage" runat="server" />
      </div>
    </div>

    <!-- <h2>Current Courses</h2> -->
    <asp:Repeater ID="rptCourses" runat="server">
      <ItemTemplate>
        <div class="course-card">
          <div class="card-head">
            <!-- <p>Course ID: <%# Eval("CourseID") %></p> -->
            <p><%# Eval("CourseID") %>: <%# Eval("CourseName") %></p>
          </div>
          <div class="card-content">
            <p>Hours: <%# Eval("Hours") %></p>
            <p>Has Section: <%# Convert.ToBoolean(Eval("HasSection")) ? "Yes" : "No" %></p>
          </div>
          <div class="card-footer">
            <p>Dr. <%# Eval("ProfessorFullName") %></p>
            <%# Convert.ToBoolean(Eval("HasSection")) ? "<p>Eng. " + Eval("AssistantProfessorFullName") + "</p>" : "" %>
          </div>
        </div>
      </ItemTemplate>
    </asp:Repeater>
  </div>
</asp:Content>