<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewTicket.aspx.cs" Inherits="Accounts.NewTicket" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>NEW TICKET</title>
    <link href="Css/StyleSheet.css" rel="stylesheet" />
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
                        <asp:DropDownList ID="DeviceList" runat="server" OnSelectedIndexChanged="DeviceList_SelectedIndexChanged">                                                        
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
                        <asp:TextBox ID="ProblemTextbox" runat="server" Height="361px" Width="262px" TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>

                <tr>
                    <td>

                    </td>
                    <td style ="padding:2px;">
                         <asp:Button ID="SubmitButton" runat="server" Text="Submit!" OnClick="SubmitButton_Click" />
                    </td>

                </tr>


            </table>


        </div>

    
        
    </div>
    </form>
</body>
</html>
