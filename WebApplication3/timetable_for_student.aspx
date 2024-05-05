<%@ Page Title="" Language="C#" MasterPageFile="~/student_dashboard.master" AutoEventWireup="true" CodeBehind="timetable_for_student.aspx.cs" Inherits="WebApplication3.timetable_for_student" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PrivateStyle2" runat="server">
  <link href="css/timetable_for_student.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentOfStudentDashboard" runat="server">
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <div class="panel panel-default">
          <div class="panel-heading">
            <h3 class="panel-title">Timetable</h3>
          </div>
          <div class="panel-body">
            <div class="table-responsive">
              <table class="table table-bordered table-hover">
                <thead>
                  <tr>
                    <th>Day</th>
                    <th>Time</th>
                    <th>Subject</th>
                    <th>Teacher</th>
                    <th>Room</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td>Monday</td>
                    <td>8:00-9:00</td>
                    <td>Math</td>
                    <td>Mr. Smith</td>
                    <td>Room 1</td>
                  </tr>
                  <tr>
                    <td>Monday</td>
                    <td>9:00-10:00</td>
                    <td>English</td>
                    <td>Mr. Brown</td>
                    <td>Room 2</td>
                  </tr>
                  <tr>
                    <td>Monday</td>
                    <td>10:00-11:00</td>
                    <td>Science</td>
                    <td>Mr. White</td>
                    <td>Room 3</td>
                  </tr>
                  <tr>
                    <td>Monday</td>
                    <td>11:00-12:00</td>
                    <td>History</td>
                    <td>Mr. Black</td>
                    <td>Room 4</td>
                  </tr>
                  <tr>
                    <td>Monday</td>
                    <td>12:00-13:00</td>
                    <td>Geography</td>
                    <td>Mr. Green</td>
                    <td>Room 5</td>
                  </tr>
                  <tr>
                    <td>Monday</td>
                    <td>13:00-14:00</td>
                    <td>Art</td>
                    <td>Mr. Blue</td>
                    <td>Room 6</td>
                  </tr>
                  <tr>
                    <td>Monday</td>
                    <td>14:00-15:00</td>
                    <td>Music</td>
                    <td>Mr. Yellow</td>
                    <td>Room 7</td>
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
