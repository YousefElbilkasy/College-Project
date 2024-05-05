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
                <asp:TextBox ID="txtCourseTime" runat="server" Placeholder="Course Time" TextMode="Time"></asp:TextBox>
                <asp:TextBox ID="txtProfessorID" runat="server" Placeholder="Professor ID" TextMode="Number"></asp:TextBox>
                <asp:TextBox ID="txtAssistantProfessorID" runat="server" Placeholder="Assistant Professor ID (optional)" TextMode="Number"></asp:TextBox>
                <asp:CheckBox ID="chkHasSection" runat="server" Text="Has Section" />
                <asp:Button ID="btnAddCourse" runat="server" Text="Add Course" OnClick="btnAddCourse_Click" />
                <asp:Label ID="lblMessage" runat="server" />
            </div>
        </div>
    </div>
</asp:Content>
