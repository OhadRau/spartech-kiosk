<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewTicket.aspx.cs" Inherits="Accounts.NewTicket" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>NEW TICKET</title>
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

        <div class ="Logo">
            <img src="Images/fulton-county-logo.png" />
        </div>

        <div class ="Ticket">

            <table>

                <tr>
                    <td style ="padding: 10%;">
                        Email:
                    </td>
                    <td style ="padding: 10%;">
                        <asp:TextBox ID="EmailTextbox" runat="server" Width="280px"></asp:TextBox>
                    </td>
                </tr>

                <tr> 
                    <td style ="padding: 10%;">
                        Device:
                    </td>
                    <td style ="padding: 10%;">
                        <asp:DropDownList ID="DeviceList" runat="server">                                                        
                            <asp:ListItem Value="IPad">IPad</asp:ListItem>
                            <asp:ListItem Value="Surface3">Surface 3</asp:ListItem>
                            <asp:ListItem Value="Laptop">Laptop</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>


                <tr>
                    <td style ="padding: 10%;">
                        Problem:
                    </td>
                    <td style ="padding: 10%;">
                        <textarea id="ProblemTextbox" style="resize:none; width:280px; height:70px;" cols="20" rows="2"></textarea>
                    </td>
                </tr>

                <tr>
                    <td>

                    </td>
                    <td style ="padding:2px;">
                         <asp:Button ID="SubmitButton" runat="server" Text="Submit!" />
                    </td>

                </tr>


            </table>


        </div>

    
        
    </div>
    </form>
</body>
</html>
