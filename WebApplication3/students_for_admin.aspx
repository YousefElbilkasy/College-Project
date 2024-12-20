<%@ Page Title="" Language="C#" MasterPageFile="~/admin_dashboard.master"
AutoEventWireup="true" CodeBehind="students_for_admin.aspx.cs"
Inherits="WebApplication3.students_for_admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PrivateStyle2" runat="server">
  <link href="css/students_for_admin.css" rel="stylesheet" />
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
    <p>Add Student</p>
  </div>
  <asp:Repeater ID="Repeater1" runat="server">
    <ItemTemplate>
      <div class="student-card">
        <div class="student-card-header">
          <p class="student-card-id"><%# Eval("StudentID") %> :</p>
          <h2 class="student-card-headline">
            <%# Eval("FirstName") %> <%# Eval("MiddleName") %> <%# Eval("LastName") %>
          </h2>
        </div>
        <div class="student-card-body">
          <div class="div-student-card-info">
            <p class="student-card-info">
              Class Level: <%# Eval("ClassLevel") %>
            </p>
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
              <asp:Button
              ID="DeleteBtn"
              runat="server"
              Text="Delete"
              CommandArgument='<%# Eval("StudentID") %>'
              OnClick="confirmDeleteBtn_Click"
              CssClass="delete-btn"
              OnClientClick="return confirm('Are You Sure You Want to Delete This Student?');"
              />
            </div>
          </div>
        </div>
    </ItemTemplate>
  </asp:Repeater>

  <!--? Modal for Add student -->
  <div id="addStudentModal" class="overlay">
    <div class="modal">
      <span class="close">&times;</span>
      <div class="modal-content-center">
        <div class="modal-header">
          <i class="fa-solid fa-user-graduate"></i>
          <h2>Add Student</h2>
          <div class="label">
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
          </div>
        </div>
        <div class="modal-content">
          <div class="form-group">
            <asp:TextBox ID="txtFirstName" runat="server" placeholder="First Name" CssClass="form-control"
              Required="true"></asp:TextBox>
          </div>
          <div class="form-group">
            <asp:TextBox ID="txtMiddleName" runat="server" placeholder="Middle Name" CssClass="form-control">
            </asp:TextBox>
          </div>
          <div class="form-group">
            <asp:TextBox ID="txtLastName" runat="server" placeholder="Last Name" CssClass="form-control"
              Required="true"></asp:TextBox>
          </div>
          <div class="form-group">
            <asp:TextBox ID="txtContactNumber" runat="server" placeholder="Contact Number" CssClass="form-control"
              Required="true"></asp:TextBox>
          </div>
          <div class="form-group">
            <asp:TextBox ID="txtNationalID" runat="server" placeholder="National ID" CssClass="form-control"
              Required="true"></asp:TextBox>
          </div>
          <div class="form-group">
            <asp:TextBox ID="txtEmail" runat="server" placeholder="Email" CssClass="form-control" Required="true"
              type="email"></asp:TextBox>
          </div>
          <div class="form-group">
            <asp:TextBox ID="txtPassword" runat="server" placeholder="Password" CssClass="form-control" Required="true"
              TextMode="Password"></asp:TextBox>
          </div>
          <div class="form-group">
            <asp:TextBox ID="txtDateOfBirth" runat="server" placeholder="Date of Birth" CssClass="form-control"
              Required="true" type="date"></asp:TextBox>
          </div>
          <div class="form-group">
            <select id="class_level" name="class_level" class="form-control" required>
              <option value="" disabled selected>Select Class Level</option>
              <option value="Level 1">Level 1</option>
              <!-- Add more options as needed -->
            </select>
          </div>
          <div class="form-group">
            <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-control" required="true">
              <asp:ListItem Text="Gender" disabled Selected></asp:ListItem>
              <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
              <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
            </asp:DropDownList>
          </div>
        </div>
        <div class="modal-footer">
          <asp:Button ID="btnAddStudent" runat="server" Text="Add Student" OnClick="btnAddStudent_Click"
            CssClass="add-student-btn" />
        </div>
      </div>

      <!-- Your existing form code goes here -->
    </div>
  </div>


  <!-- Modal for Edit student -->
  <div id="editStudentModal" class="overlay">
    <div class="modal">
      <span class="close">&times;</span>
      <div class="modal-content-center">
        <div class="modal-header">
          <i class="fas fa-edit""></i>
          <h2>Edit Student</h2>
          <div class=" label">
            <asp:Label ID="lblEditMessage" runat="server" ForeColor="Red"></asp:Label>
        </div>
      </div>
      <div class="modal-content">
        <div class="form-group">
          <asp:TextBox ID="txtFirstNameEdit" runat="server" placeholder="First Name" CssClass="form-control"
            Required="true"></asp:TextBox>
        </div>
        <div class="form-group">
          <asp:TextBox ID="txtMiddleNameEdit" runat="server" placeholder="Middle Name" CssClass="form-control">
          </asp:TextBox>
        </div>
        <div class="form-group">
          <asp:TextBox ID="txtLastNameEdit" runat="server" placeholder="Last Name" CssClass="form-control"
            Required="true"></asp:TextBox>
        </div>
        <div class="form-group">
          <asp:TextBox ID="txtContactNumberEdit" runat="server" placeholder="Contact Number" CssClass="form-control"
            Required="true"></asp:TextBox>
        </div>
        <div class="form-group">
          <asp:TextBox ID="txtNationalIDEdit" runat="server" placeholder="National ID" CssClass="form-control"
            Required="true"></asp:TextBox>
        </div>
        <div class="form-group">
          <asp:TextBox ID="txtEmailEdit" runat="server" placeholder="Email" CssClass="form-control" Required="true"
            type="email"></asp:TextBox>
        </div>
        <div class="form-group">
          <asp:TextBox ID="txtPasswordEdit" runat="server" placeholder="Password" CssClass="form-control"
            Required="true" TextMode="Password"></asp:TextBox>
        </div>
        <div class="form-group">
          <asp:TextBox ID="txtDateOfBirthEdit" runat="server" placeholder="Date of Birth" CssClass="form-control"
            Required="true" type="date"></asp:TextBox>
        </div>
        <div class="form-group">
          <select id="class_levelEdit" name="class_level" class="form-control" required>
            <option value="" disabled selected>Select Class Level</option>
            <option value="Level 1">Level 1</option>
            <!-- Add more options as needed -->
          </select>
        </div>
        <div class="form-group">
          <asp:DropDownList ID="ddlGenderEdit" runat="server" CssClass="form-control" required="true">
            <asp:ListItem Text="Gender" disabled Selected></asp:ListItem>
            <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
            <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
          </asp:DropDownList>
        </div>
      </div>
      <div class="modal-footer"></div>
    </div>
  </div>
  </div>
  <script>
    // Get the modals
    var addModal = document.getElementById('addStudentModal');
    var editModal = document.getElementById('editStudentModal');

    // Get the buttons that opens the modals
    var addBtn = document.getElementById('addStudentBtn');
    var editBtns = document.getElementsByClassName('fa-edit');

    // Get the <span> elements that closes the modals
    var addSpan = addModal.getElementsByClassName('close')[0];
    var editSpan = editModal.getElementsByClassName('close')[0];

    // When the user clicks on the button, open the modal 
    addBtn.onclick = function () {
      addModal.style.display = "block";
    }

    for (var i = 0; i < editBtns.length; i++) {
      editBtns[i].onclick = function () {
        editModal.style.display = "block";
      }
    }

    // When the user clicks on <span> (x), close the modal
    addSpan.onclick = function () {
      addModal.style.display = "none";
    }

    editSpan.onclick = function () {
      editModal.style.display = "none";
    }

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function (event) {
      if (event.target == addModal) {
        addModal.style.display = "none";
      }
      if (event.target == editModal) {
        editModal.style.display = "none";
      }
    }
  </script>
</asp:Content>