<%@ Page Title="Timetable Management" Language="C#"
  MasterPageFile="~/admin_dashboard.master" AutoEventWireup="true"
  CodeBehind="timetable_for_admin.aspx.cs"
  Inherits="WebApplication3.timetable_for_admin" %>

<%@ Import
  Namespace="System.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PrivateStyle2" runat="server">
  <link href="css/timetable_for_admin.css" rel="stylesheet" />
</asp:Content>

<asp:Content
  ID="Content2"
  ContentPlaceHolderID="ContentForAdminDashboard"
  runat="server">
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <div class="panel panel-default">
          <div class="panel-heading">
            <h3 class="panel-title">Timetable Management</h3>
          </div>
          <div class="panel-body">
            <!--? Lectures Control -->
            <div class="admin-form">
              <div class="lectures-control-head">
                <h4>Add or Update Timetable Entry</h4>
              </div>
              <div class="lectures-control-content">
                <asp:DropDownList
                  ID="ddlCourse"
                  runat="server"
                  CssClass="form-control"
                  AutoPostBack="true"
                  OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:DropDownList
                  ID="ddlDay"
                  runat="server"
                  CssClass="form-control">
                  <asp:ListItem Text="Select a Day" Selected disabled />
                  <asp:ListItem Text="Saturday" Value="Saturday" />
                  <asp:ListItem Text="Sunday" Value="Sunday" />
                  <asp:ListItem Text="Monday" Value="Monday" />
                  <asp:ListItem Text="Tuesday" Value="Tuesday" />
                  <asp:ListItem Text="Wednesday" Value="Wednesday" />
                  <asp:ListItem Text="Thursday" Value="Thursday" />
                </asp:DropDownList>
                <asp:TextBox
                  ID="txtStartTime"
                  runat="server"
                  CssClass="form-control"
                  Placeholder="Start Time (HH:mm)"
                  type="time" />
                <asp:TextBox
                  ID="txtEndTime"
                  runat="server"
                  CssClass="form-control"
                  Placeholder="End Time (HH:mm)"
                  type="time" />
                <asp:DropDownList
                  ID="ddlRoom"
                  runat="server"
                  CssClass="form-control">
                </asp:DropDownList>
                <asp:TextBox ID="txtProfessor" runat="server" CssClass="form-control" ReadOnly="true"  />
                <asp:HiddenField ID="hdnProfessorId" runat="server" Value='<%# Eval("ProfessorID") %>' />
              </div>
              <div class="lectures-control-footer">
                <asp:Button
                  ID="btnAddOrUpdate"
                  runat="server"
                  CssClass="btn btn-primary"
                  Text="Save"
                  OnClick="BtnAddOrUpdate_Click" />
                <asp:Label ID="lblMessage" runat="server" CssClass="" />
              </div>
            </div>
            <!--? Sections Control -->
            <div id="sectionDetails" runat="server" style="display: none">
              <hr />
              <div class="section-control-head">
                <h4>Add Section Details</h4>
              </div>
              <div class="section-control-content">
                <asp:Label
                  ID="lblSectionName"
                  runat="server"
                  Text="Section Name:"
                  CssClass="form-label section-name-lbl" />
                <asp:TextBox
                  ID="txtSectionName"
                  runat="server"
                  class="form-control section-name-input"
                  ReadOnly="true"
                  disabled />
                <asp:Label
                  ID="lblSectionDay"
                  runat="server"
                  Text="Day:"
                  CssClass="form-label" />
                <asp:DropDownList
                  ID="ddlSectionDay"
                  runat="server"
                  CssClass="form-control">
                  <asp:ListItem Text="Select a Day" Selected disabled />
                  <asp:ListItem Text="Saturday" Value="Saturday" />
                  <asp:ListItem Text="Sunday" Value="Sunday" />
                  <asp:ListItem Text="Monday" Value="Monday" />
                  <asp:ListItem Text="Tuesday" Value="Tuesday" />
                  <asp:ListItem Text="Wednesday" Value="Wednesday" />
                  <asp:ListItem Text="Thursday" Value="Thursday" />
                </asp:DropDownList>
                <asp:Label
                  ID="lblSectionTime"
                  runat="server"
                  Text="Start Time:"
                  CssClass="form-label" />
                <asp:TextBox
                  ID="txtSectionTime"
                  runat="server"
                  CssClass="form-control"
                  Placeholder="HH:mm"
                  type="time" />
                <asp:Label
                  ID="lblSectionEndTime"
                  runat="server"
                  Text="End Time:"
                  CssClass="form-label" />
                <asp:TextBox
                  ID="txtSectionEndTime"
                  runat="server"
                  CssClass="form-control"
                  Placeholder="HH:mm"
                  type="time" />
                <asp:Label
                  ID="lblSectionRoom"
                  runat="server"
                  Text="Room:"
                  CssClass="form-label" />
                <asp:DropDownList
                  ID="ddlSectionRoom"
                  runat="server"
                  CssClass="form-control">
                </asp:DropDownList>
                <asp:Label
                  ID="lblAssistantProfessor"
                  runat="server"
                  Text="Assistant Professor:"
                  CssClass="form-label" />
                <asp:TextBox ID="txtAssistantProfessor" runat="server" CssClass="form-control" ReadOnly="true" />
                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("AssistantProfessorID") %>' />
              </div>
              <div class="section-control-footer">
                <asp:Button
                  ID="btnSaveSection"
                  runat="server"
                  CssClass="btn btn-primary"
                  Text="Save Section"
                  OnClick="btnSaveSection_Click" />
                <asp:Label ID="lblSectionMessage" runat="server" CssClass="" />
              </div>
            </div>
            <!--? Lectures Table -->
            <div class="table-responsive">
              <hr />
              <h4>Existing Lectures</h4>
              <table class="table table-striped table-bordered table-hover">
                <thead>
                  <tr>
                    <th>Day</th>
                    <th>Start Time</th>
                    <th>End Time</th>
                    <th>Course</th>
                    <th>Professor</th>
                    <th>Room</th>
                    <th>Action</th>
                  </tr>
                </thead>
                <tbody>
                  <asp:Repeater
                    ID="TimetableRepeater"
                    runat="server"
                    OnItemCommand="TimetableRepeater_ItemCommand">
                    <ItemTemplate>
                      <tr>
                        <td><%# Eval("Day") %></td>
                        <td><%# FormatTime(Eval("StartTime")) %></td>
                        <td><%# FormatTime(Eval("EndTime")) %></td>
                        <td><%# Eval("CourseName") %></td>
                        <td><%# Eval("ProfessorName") %></td>
                        <td><%# Eval("RoomName") %></td>
                        <td>
                          <asp:Button
                            ID="btnDeleteTimetable"
                            runat="server"
                            Text="Delete"
                            CommandName="Delete"
                            CommandArgument='<%# Eval("TimetableID") %>'
                            OnCommand="TimetableRepeater_ItemCommand"
                            class="delete-btn"
                            OnClientClick="return confirm('Are you sure you want to delete this timetable?');" />
                        </td>
                      </tr>
                    </ItemTemplate>
                  </asp:Repeater>
                </tbody>
              </table>
            </div>
            <!--? Sections Table -->
            <div id="sectionTable" runat="server" style="display: none">
              <hr />
              <h4>Existing Sections</h4>
              <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover">
                  <thead>
                    <tr>
                      <th>Section Name</th>
                      <th>Day</th>
                      <th>Start Time</th>
                      <th>End Time</th>
                      <th>Room</th>
                      <th>Assistant Professor</th>
                      <th>Action</th>
                    </tr>
                  </thead>
                  <tbody>
                    <asp:Repeater
                      ID="SectionsRepeater"
                      runat="server"
                      OnItemCommand="SectionsRepeater_ItemCommand">
                      <ItemTemplate>
                        <tr>
                          <td><%# Eval("SectionName") %></td>
                          <td><%# Eval("Day") %></td>
                          <td><%# FormatTime(Eval("StartTime")) %></td>
                          <td><%# FormatTime(Eval("EndTime")) %></td>
                          <td><%# Eval("RoomName") %></td>
                          <td><%# Eval("AssistantProfessorName") %></td>
                          <td>
                            <asp:Button
                              ID="btnDeleteSection"
                              runat="server"
                              Text="Delete"
                              CommandName="Delete"
                              CommandArgument='<%# Eval("SectionID") %>'
                              class="delete-btn"
                              OnClientClick="return confirm('Are you sure you want to delete this timetable?');" />
                          </td>
                        </tr>
                      </ItemTemplate>
                    </asp:Repeater>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</asp:Content>
