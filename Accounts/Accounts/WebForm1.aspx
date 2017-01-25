<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Accounts.Css.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>LOGIN FORM</title>
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
    <div class = "LOGIN">

        <table style="width: 100%;">
            <tr>
                <td style="padding: 18px;">
                    USER NAME :
                </td>
                <td>
                    <asp:TextBox ID="TextBox1" runat="server" OnTextChanged="TextBox1_TextChanged"></asp:TextBox>

                </td>
            </tr>
            <tr>
                <td style ="padding: 18px";>
                    PASSWORD :
                </td>
                <td>
                    <asp:TextBox ID="TextBox2" runat="server" TextMode="Password"></asp:TextBox>

                </td>
            </tr>
            <tr>
                <td>
                    

                </td>
                <td>
                    <asp:Button ID="Button1" runat="server" class="btn" Text="Register" OnClick="Button1_Click" />
                    <asp:Button ID="Button2" runat="server" class="btn" Text="Login" OnClick="Button2_Click" />

                </td>
            </tr>
        </table>


    </div>
    </div>
    </form>
</body>
</html>
