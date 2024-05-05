<%@ Page Title="" Language="C#" MasterPageFile="~/student_dashboard.master" AutoEventWireup="true" CodeBehind="attendance_for_student.aspx.cs" Inherits="WebApplication3.attendance_for_student" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PrivateStyle2" runat="server">
  <link href="css/attendance_for_student.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentOfStudentDashboard" runat="server">
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <div class="panel panel-default">
          <div class="panel-heading">
            <h3 class="panel-title">Attendance</h3>
          </div>
          <div class="panel-body">
            <div class="table-responsive">
              <table class="table table-striped table-bordered table-hover">
                <thead>
                  <tr>
                    <th>Subject</th>
                    <th>Attendance</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td>Maths</td>
                    <td>75%</td>
                  </tr>
                  <tr>
                    <td>Science</td>
                    <td>80%</td>
                  </tr>
                  <tr>
                    <td>English</td>
                    <td>70%</td>
                  </tr>
                  <tr>
                    <td>History</td>
                    <td>85%</td>
                  </tr>
                  <tr>
                    <td>Geography</td>
                    <td>90%</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</asp:Content>
