<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Jquery DDL.aspx.cs" Inherits="WebApplication3.Jquery_DDL" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

     <!-- new search -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.jquery.min.js"></script>
<link herf ="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.min.css" rel ="stylesheet" />
    <!-- new search -->


</head>
<body>
    <form id="form1" runat="server">
        <div>
            <center>
                <h1> Search Here...</h1>
                <hr />
                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="FirstName" DataValueField="FirstName"></asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [FirstName] FROM [AssistantProfessors]"></asp:SqlDataSource>
            </center>
        </div>
        <script>

            <!--new search -->
    $('#<%=DropDownList1.ClientID%>').chosen();
        </script>


<!--new search -->
    </form>
</body>
</html>
