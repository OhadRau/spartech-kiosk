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
        <div class="PAGE">

            <div class="Logo">
                <img src="Images/fulton-county-logo.png" />
            </div>

            <div class="Ticket">

                <div class="CenterLogin">
                    <table>


                        <tr>
                            <td style="padding: 10%;">USERNAME:
                            </td>
                            <td style="padding: 10%;">
                                <asp:TextBox ID="TextBox1" runat="server" OnTextChanged="TextBox1_TextChanged"></asp:TextBox>
                            </td>
                        </tr>
                        
                        <tr>
                            <td style="padding: 10%;">PASSWORD:
                            </td>
                            <td style="padding: 10%;">
                                <asp:TextBox ID="TextBox2" runat="server" TextMode="Password"></asp:TextBox>
                            </td>
                        </tr>


                        <tr>
                            <td style="padding: 10%;"></td>
                            <td style="padding: 10%;">
                                <asp:Button ID="Button1" runat="server" class="btn" Text="Register" OnClick="Button1_Click" />
                                <asp:Button ID="Button2" runat="server" class="btn" Text="Login" OnClick="Button2_Click" />

                            </td>
                        </tr>
                    </table>
                </div>

            </div>


        </div>
    </form>
</body>
</html>
