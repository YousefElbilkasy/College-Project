<%@ Page Title="Courses Management" Language="C#" MasterPageFile="~/admin_dashboard.master" AutoEventWireup="true" CodeBehind="courses_for_admin.aspx.cs" Inherits="WebApplication3.courses_for_admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PrivateStyle2" runat="server">
    <link href="css/courses_for_admin.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentForAdminDashboard" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h2>Add New Course</h2>
                
                <asp:TextBox ID="txtCourseName" runat="server" Placeholder="Course Name"></asp:TextBox>
                <asp:TextBox ID="txtCourseHours" runat="server" Placeholder="Course Hours" TextMode="Number"></asp:TextBox>
                <asp:CheckBox ID="chkHasSection" runat="server" Text="Has Section" />
                <asp:Button ID="btnAddCourse" runat="server" Text="Add Course" OnClick="BtnAddCourse_Click" />
                <asp:Label ID="lblMessage" runat="server" />
                
                <h2>Current Courses</h2>
                <asp:Repeater ID="rptCourses" runat="server">
                    <HeaderTemplate>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Course ID</th>
                                    <th>Course Name</th>
                                    <th>Hours</th>
                                    <th>Has Section</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("CourseID") %></td>
                            <td><%# Eval("CourseName") %></td>
                            <td><%# Eval("Hours") %></td>
                            <td>
                          <%# Convert.ToBoolean(Eval("HasSection")) ? "Yes" : "No" %>
                              </td>

                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                            </tbody>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</asp:Content>
