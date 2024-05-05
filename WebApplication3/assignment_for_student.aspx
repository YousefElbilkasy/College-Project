<%@ Page Title="" Language="C#" MasterPageFile="~/student_dashboard.master" AutoEventWireup="true" CodeBehind="assignment_for_student.aspx.cs" Inherits="WebApplication3.assignment_for_student" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PrivateStyle2" runat="server">
  <link href="css/assignment_for_student.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentOfStudentDashboard" runat="server">
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <h1>Assignments</h1>
        <div class="table-responsive">
          <table class="table table-striped">
            <thead>
              <tr>
                <th>Assignment Name</th>
                <th>Due Date</th>
                <th>Submission Status</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>Assignment 1</td>
                <td>12/12/2019</td>
                <td>Submitted</td>
              </tr>
              <tr>
                <td>Assignment 2</td>
                <td>12/12/2019</td>
                <td>Not Submitted</td>
              </tr>
              <tr>
                <td>Assignment 3</td>
                <td>12/12/2019</td>
                <td>Submitted</td>
              </tr>
              <tr>
                <td>Assignment 4</td>
                <td>12/12/2019</td>
                <td>Not Submitted</td>
              </tr>
              <tr>
                <td>Assignment 5</td>
                <td>12/12/2019</td>
                <td>Submitted</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</asp:Content>
