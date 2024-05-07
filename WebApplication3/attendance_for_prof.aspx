<%@ Page Title="" Language="C#" MasterPageFile="~/prof_dashboard.master" AutoEventWireup="true" CodeBehind="attendance_for_prof.aspx.cs" Inherits="WebApplication3.attendance_for_prof" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PrivateStyle2" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentOfProfDashboard" runat="server">
  <div class="container">
    <h2>Assigned Courses</h2>
    <% if (AssignedCoursesRepeater.Items.Count > 0)
      { %>
    <asp:Repeater ID="AssignedCoursesRepeater" runat="server">
      <itemtemplate>
        <div class="card">
          <h3><%# Eval("CourseID") %></h3>
          <p>Name: <%# Eval("CourseName") %></p>
          <asp:Button ID="AssignButton" runat="server" Text="View Students" OnClick="Assign_Courses_Button_Click" CommandArgument='<%# Eval("CourseID") %>' />
        </div>
      </itemtemplate>
    </asp:Repeater>
    <% }
      else
      { %>
    <p>No courses assigned to you.</p>
    <% } %>
  </div>

  <div class="student-list">
    <h2>Students Assigned to Course</h2>
    <asp:Repeater ID="StudentRepeater" runat="server">
      <ItemTemplate>
        <div class="student">
          <asp:HiddenField ID="hdnStudentID" runat="server" Value='<%# Eval("StudentID") %>' />
          <p><%# Eval("FirstName") %> <%# Eval("LastName") %> - <%# Eval("Email") %></p>
          <asp:CheckBox ID="chkStudent" runat="server" />
        </div>
      </ItemTemplate>
    </asp:Repeater>

    <asp:SqlDataSource runat="server" ID="SqlDataSource1"></asp:SqlDataSource>
    <br />
    <asp:Button ID="btnProcessSelected" runat="server" Text="Process Selected Students" OnClick="btnProcessSelected_Click" />
    <asp:Button ID="btnHideStudents" runat="server" Text="Hide Students" OnClick="btnHideStudents_Click" />
  </div>

  <asp:Label ID="lblMessage" runat="server" ForeColor="Red" />
  <asp:Label ID="lblStudentMessage" runat="server" ForeColor="Red" />
  <script>
    function showStudents(courseId) {
      __doPostBack('Assign_Courses_Button_Click', courseId);
    }
  </script>
</asp:Content>
