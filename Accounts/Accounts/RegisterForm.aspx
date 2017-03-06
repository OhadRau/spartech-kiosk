<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterForm.aspx.cs" Inherits="Accounts.RegisterForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register Form</title>
    <link href="Css/StyleSheet.css" rel="stylesheet" />
    <style type="text/css">
        .auto-style1 {
            width: 117px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <div class ="Logo">
            <img src="Images/fulton-county-logo.png" />
        </div>


    <div class ="PAGE">

        <div class ="Ticket">

        <table>
            <br /><br /><br />
            <tr>
                <td style="padding: 5%;">
                    USERNAME :
                </td>
                <td style="padding: 5%;">
                    <asp:TextBox ID="UsernameTextbox" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="padding: 5%;">
                    First Name :
                </td>
                <td style="padding: 5%;">
                    <asp:TextBox ID="FirstNameTextbox" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="padding: 5%;">
                    Last Name :
                </td>
                <td style="padding: 5%;">
                    <asp:TextBox ID="LastNameTextbox" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="padding: 5%;">
                    EMAIL : 
                </td>
                <td style="padding: 5%;">
                    <asp:TextBox ID="EmailTextbox" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="padding: 5%;">
                    PASSWORD :
                </td>
                <td style="padding: 5%;">
                    <asp:TextBox ID="PasswordTextbox" TextMode ="Password" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="padding: 5%;">
                    CONFIRM PASSWORD :
                </td>
                <td style="padding: 5%;">
                    <asp:TextBox ID="ConfirmPasswordTextbx" TextMode ="Password" runat="server"></asp:TextBox>
                </td>
            </tr>
        
            <tr>
                <td style="padding: 5%;">
                    SCHOOL :
                </td>
                <td style="padding: 5%;">
                    <asp:TextBox ID="SchoolCodeTextbox" runat="server"></asp:TextBox>
                </td>
            </tr>

             <tr>
                <td style="padding: 5%;">
                </td>
                <td style="padding: 5%;">
                    <asp:Button ID="RegisterButton" runat="server" class="btn" Text="Register" OnClick="RegisterButton_Click" />
                </td>
            </tr>

        </table>


        </div> 
    </div>
    </form>
</body>
</html>
