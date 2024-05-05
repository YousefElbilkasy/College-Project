<%@ Page Title="" Language="C#" MasterPageFile="~/admin_dashboard.master" AutoEventWireup="true" CodeBehind="verification_for_admin.aspx.cs" Inherits="WebApplication3.verification_for_admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PrivateStyle2" runat="server">
  <link href="css/verification_for_admin.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentForAdminDashboard" runat="server">
  <asp:Repeater ID="Repeater1" runat="server">
    <HeaderTemplate>
      <section>
    </HeaderTemplate>
    <ItemTemplate>
      <div class="card">
        <div class="details">
          <h2>User: <%# Eval("first_name") %> <%# Eval("middle_name") %> <%# Eval("last_name") %></h2>
          <p>Email: <%# Eval("email") %></p>
          <p>Role: <%# Eval("role") %></p>
          <p>ID: <%# Eval("id") %></p>
        </div>
        <div class="buttons">
          <asp:Button ID="VerifyButton" runat="server" Text="Verify" CssClass="btn-approve" CommandArgument='<%# Eval("id") %>' OnClick="VerifyButton_Click" />
          
          <asp:Button ID="RejectButton" runat="server" Text="Reject" CssClass="btn-decline" CommandArgument='<%# Eval("id") %>' OnClick="RejectButton_Click" />


        </div>
      </div>
    </ItemTemplate>
    <FooterTemplate>
      </section>
   
    </FooterTemplate>
  </asp:Repeater>

</asp:Content>
