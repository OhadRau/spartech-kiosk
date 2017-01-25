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


    <div class ="PAGE">

        <div class ="LOGIN">

        <table style="width: 100%;">
            <tr>
                <td style="padding: 18px;">
                    USERNAME :
                </td>
                <td>
                    <asp:TextBox ID="UsernameTextbox" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style ="padding: 18px;">
                    PASSWORD :
                </td>
                <td>
                    <asp:TextBox ID="PasswordTextbox" TextMode ="Password" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr style ="padding: 18px;">
                <td>CONFIRM PASSWORD :
                </td>
                <td>
                    <asp:TextBox ID="ConfirmPasswordTextbx" TextMode ="Password" runat="server"></asp:TextBox>
                </td>
            </tr>
        
            <tr style ="padding: 18px;">
                <td>SCHOOL CODE :
                </td>
                <td>
                    <asp:TextBox ID="SchoolCodeTextbox" runat="server"></asp:TextBox>
                </td>
            </tr>

             <tr style ="padding: 18px;">
                <td>
                </td>
                <td>
                    <asp:Button ID="RegisterButton" runat="server" class="btn" Text="Register" OnClick="RegisterButton_Click" />
                </td>
            </tr>

        </table>


        </div> 
    </div>
    </form>
</body>
</html>
