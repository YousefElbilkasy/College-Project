<%@ Page Title="" Language="C#" MasterPageFile="~/student_dashboard.master" AutoEventWireup="true" CodeBehind="courses_for_student.aspx.cs" Inherits="WebApplication3.courses_for_student" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PrivateStyle2" runat="server">
  <link href="css/course_for_students.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentOfStudentDashboard" runat="server">
          <!-- Assigined coureses -->
    <header class="courses-header">
  <h1>Assigned Courses</h1>
        </header>
<asp:Repeater ID="AssignedCoursesRepeater" runat="server">
    <ItemTemplate>
        <div class="course-item">
            <h2><%# Eval("CourseID") %></h2>
    <div class="course-details">
        <p><strong>Course Name:</strong> <%# Eval("CourseName") %></p>
        
        </div>
    </ItemTemplate>
</asp:Repeater>


<div id="noCoursesMessage" runat="server" visible="false">
    <p>No courses assigned yet.</p>
</div>

  <!-- You must put 2 divs -->
  <header class="courses-header">
    <h1>College Courses</h1>
  </header>

  <div class="container">
      

    <!-- Course cards -->
   <asp:Repeater ID="CourseRepeater" runat="server">
    <ItemTemplate>
        <a href='<%# Eval("CourseID", "course{0}.html") %>' class="course-card">
            <div>
                <h2><%# Eval("CourseName") %></h2>
                <div class="course-details">
                    <p><strong>Professor:</strong> <%# Eval("ProfessorName") %></p>
                    <p><strong>Assistant Professor:</strong> <%# Eval("AssistantName") %></p>
                    <p><strong>Hours:</strong> <%# Eval("Hours") %></p>
                    <p><strong>Time:</strong> <%# Eval("CourseTime") %></p>
                    <p><strong>Has Section:</strong> <%# Eval("HasSection") %></p>
                    <asp:Button ID="AssignButton" runat="server" Text="Assign" OnClick="AssignButton_Click" CommandArgument='<%# Eval("CourseID") %>' />
                </div>
            </div>
        </a>
    </ItemTemplate>
</asp:Repeater>
      </div>



</asp:Content>
