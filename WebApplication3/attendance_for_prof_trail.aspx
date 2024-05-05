<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="attendance_for_prof_trail.aspx.cs" Inherits="WebApplication3.Attendace_for_prof_trail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Attendance</title>
    <script>
        function showStudents(courseId) {
            __doPostBack('Assign_Courses_Button_Click', courseId);
        }
    </script>
    <style>
        .student-list {
            margin-top: 20px;
        }

        .student-list h2 {
            margin-bottom: 10px;
        }

        .student-list .student {
            margin-bottom: 5px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Assigned Courses</h2>
            <asp:Repeater ID="AssignedCoursesRepeater" runat="server">
                <ItemTemplate>
                    <div class="card">
                        <h3><%# Eval("CourseID") %></h3>
                        <p>Name: <%# Eval("CourseName") %></p>
                        <asp:Button ID="AssignButton" runat="server" Text="View Students" OnClick="Assign_Courses_Button_Click" CommandArgument='<%# Eval("CourseID") %>' />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
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

            <br />
            <asp:Button ID="btnProcessSelected" runat="server" Text="Process Selected Students" OnClick="btnProcessSelected_Click" />
                <asp:Button ID="btnHideStudents" runat="server" Text="Hide Students" OnClick="btnHideStudents_Click" />
        </div>
    </form>
</body>
</html>
