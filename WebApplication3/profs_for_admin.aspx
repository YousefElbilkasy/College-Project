<%@ Page Title="" Language="C#" MasterPageFile="~/admin_dashboard.master" AutoEventWireup="true" CodeBehind="profs_for_admin.aspx.cs" Inherits="WebApplication3.profs_for_admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PrivateStyle2" runat="server">
  <link href="css/profs_for_admin.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentForAdminDashboard" runat="server">
  <div class="search-container">
    <div class="search-field">
      <select id="searchField" name="searchField" class="form-control">
        <option value="" selected disabled>Select Search Field</option>
        <option value="FirstName">First Name</option>
        <option value="LastName">Last Name</option>
        <option value="NationalID">National ID</option>
        <option value="ContactNumber">Contact Number</option>
        <option value="Email">Email</option>
      </select>
    </div>
    <div class="search">
      <input id="searchInput" placeholder="Search..." type="text" />
      <button id="searchButton" type="button">Go</button>
    </div>
  </div>
  <div class="add-student" id="addStudentBtn">
    <i class="fa-solid fa-circle-plus"></i>
    <p>Add Assistant Professor</p>
  </div>
  <asp:Repeater ID="Repeater1" runat="server">
    <ItemTemplate>
      <div class="student-card">
        <div class="student-card-header">
          <p class="student-card-id"><%# Eval("ProfessorID") %> :</p>
          <h2 class="student-card-headline">
            <%# Eval("FirstName") %> <%# Eval("MiddleName") %> <%#
            Eval("LastName") %>
          </h2>
        </div>
        <div class="student-card-body">
          <div class="div-student-card-info">
            <p class="student-card-info">
              National ID: <%# Eval("NationalID") %>
            </p>
            <p class="student-card-info">Email: <%# Eval("Email") %></p>
            <p class="student-card-info">
              Contact Number: <%# Eval("ContactNumber") %>
            </p>
            <p class="student-card-info">
              Date of Birth: <%# ((DateTime)Eval("DateOfBirth")).ToString("dd-MM-yyyy") %>
            </p>
            <p class="student-card-info">Gender: <%# Eval("Gender") %></p>
          </div>
          <div class="div-student-card-actions">
            <i class="fas fa-edit"></i>
            <i class="fas fa-trash"></i>
          </div>
        </div>
      </div>
    </ItemTemplate>
  </asp:Repeater>
  <div id="addStudentModal" class="overlay">
    <div class="modal">

      <span class="close">&times;</span>
      <div class="modal-content-center">
        <div class="modal-header">
          <i class="fa-solid fa-user-tie"></i>
          <h2>Add Professor</h2>
          <div class="label">
            <asp:Label ID="lblMessageForProf" runat="server" ForeColor="Red"></asp:Label>
          </div>
        </div>
        <div class="modal-content">
          <div class="form-group">
            <asp:TextBox
              ID="txtFirstName1"
              runat="server"
              placeholder="First Name"
              CssClass="form-control"
              Required="true"></asp:TextBox>
          </div>
          <div class="form-group">
            <asp:TextBox
              ID="txtMiddleName1"
              runat="server"
              placeholder="Middle Name"
              CssClass="form-control"></asp:TextBox>
          </div>
          <div class="form-group">
            <asp:TextBox
              ID="txtLastName1"
              runat="server"
              placeholder="Last Name"
              CssClass="form-control"
              Required="true"></asp:TextBox>
          </div>
          <div class="form-group">
            <asp:TextBox
              ID="txtContactNumber1"
              runat="server"
              placeholder="Contact Number"
              CssClass="form-control"
              Required="true"></asp:TextBox>
          </div>
          <div class="form-group">
            <asp:TextBox
              ID="txtNationalID1"
              runat="server"
              placeholder="National ID"
              CssClass="form-control"
              Required="true"></asp:TextBox>
          </div>
          <div class="form-group">
            <asp:TextBox
              ID="txtEmail1"
              runat="server"
              placeholder="Email"
              CssClass="form-control"
              Required="true"
              type="email"></asp:TextBox>
          </div>
          <div class="form-group">
            <asp:TextBox
              ID="txtPassword1"
              runat="server"
              placeholder="Password"
              CssClass="form-control"
              Required="true"
              TextMode="Password"></asp:TextBox>
          </div>
          <div class="form-group">
            <asp:TextBox
              ID="txtDateOfBirth1"
              runat="server"
              placeholder="Date of Birth"
              CssClass="form-control"
              Required="true"
              type="date"></asp:TextBox>
          </div>
          <div class="form-group">
            <asp:DropDownList
              ID="ddlGender1"
              runat="server"
              CssClass="form-control"
              required="true">
              <asp:ListItem Text="Gender" disabled Selected></asp:ListItem>
              <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
              <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
            </asp:DropDownList>
          </div>

        </div>
        <div class="modal-footer">
          <asp:Button
            ID="btnAddStudent"
            runat="server"
            Text="Add Professor"
            OnClick="btnAddProfessor_Click"
            CssClass="add-student-btn" />
        </div>
      </div>

      <!-- Your existing form code goes here -->
    </div>
  </div>

  <script type="text/javascript">
    // Get the modal
      var modal = document.getElementById("addStudentModal");

      // Get the button that opens the modal
      var btn = document.getElementById("addStudentBtn");

      // Get the <span> element that closes the modal
      var span = document.getElementsByClassName("close")[0];

      // When the user clicks the button, open the modal 
      btn.onclick = function () {
        modal.style.display = "block";
      }

      // When the user clicks on <span> (x), close the modal
      span.onclick = function () {
        modal.style.display = "none";
      }

      // When the user clicks anywhere outside of the modal, close it
      window.onclick = function (event) {
        if (event.target == modal) {
          modal.style.display = "none";
        }
      }
    // Function to reload the page and clear the form
    function reloadPage() {
      // Reload the page
      window.location.reload();
    }
  </script>
</asp:Content>
