<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminPage.aspx.cs" Inherits="Accounts.AdminPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Page</title>
    <link href="Css/StyleSheet.css" rel="stylesheet" />
    <style type="text/css">
        #TextArea1 {
            height: 359px;
            width: 588px;
            margin-left: 0px;
        }
        .auto-style1 {
            width: 198px;
        }
        
        </style>
    </head>

<body class="AdminPage">
    <form id="form1" runat="server">

     
       
     <div class ="Heading">
         <div style="margin: 12px;">
             <h1>Ticket Information</h1> 
         </div>
         
     </div>
      
     <div class ="AdminTable">
               
         
         <br />

         <table>
             <tr>
                 <td>
                     <div>
                         <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" Height="396px" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" Width="685px" style="margin-right: 0px" AllowPaging="True">
                         <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                         <Columns>
                             <asp:CommandField ShowSelectButton="True" />
                             <asp:BoundField DataField="Last_Name" HeaderText="Last_Name" SortExpression="Last_Name" />
                             <asp:BoundField DataField="First_Name" HeaderText="First_Name" SortExpression="First_Name" />
                             <asp:BoundField DataField="School" HeaderText="School" SortExpression="School" />
                             <asp:BoundField DataField="Ticket" HeaderText="Ticket" SortExpression="Ticket" />
                             <asp:BoundField DataField="Device" HeaderText="Device" SortExpression="Device" />
                             <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                         </Columns>
                         <EditRowStyle BackColor="#999999" />
                         <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                         <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                         <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                         <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                         <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                         <SortedAscendingCellStyle BackColor="#E9E7E2" />
                         <SortedAscendingHeaderStyle BackColor="#506C8C" />
                         <SortedDescendingCellStyle BackColor="#FFFDF8" />
                         <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                         </asp:GridView>
                     </div>
                 </td>

                 <td class="auto-style1">
                     <div class="RespondTicket">

                         <table>
                             <tr>
                                 <td>
                                     <asp:Label ID="NameLabel" runat="server" Text="Label">Name: </asp:Label>
                                 </td>
                                 <td>
                                     <asp:TextBox ID="NameTextbox" runat="server"></asp:TextBox>
                                 </td>
                             </tr>

                             <tr>
                                 <td>
                                     <asp:Label ID="TicketNumberLabel" runat="server" Text="Label">Ticket #: </asp:Label>
                                 </td>
                                 <td>
                                     <asp:TextBox ID="TicketNumberTextbox" runat="server"></asp:TextBox>
                                 </td>
                             </tr>

                             <tr>
                                 <td>
                                     <asp:Label ID="SchoolLabel" runat="server" Text="Label">School: </asp:Label>
                                 </td>
                                 <td>
                                     <asp:TextBox ID="SchoolTextbox" runat="server"></asp:TextBox>
                                 </td>
                                
                             </tr>

                             <tr>
                                 <td></td>
                                  <td>
                                     <asp:Button ID="ResolveButton" runat="server" Text="Resolve!" Width="124px" OnClick="ResolveButton_Click" />
                                 </td>
                             </tr>

                         </table>                                          
                         
                      </div>
                 </td>
                 <td>
                     <h3>Resolution</h3>
                     
                     <asp:TextBox ID="ResolutionTextbox" runat="server" Height="361px" Width="514px" TextMode="MultiLine"></asp:TextBox>
                 </td>
                
             </tr>

         </table>
         <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:masterConnectionString %>" OnSelecting="SqlDataSource1_Selecting" SelectCommand="SELECT [Last_Name], [First_Name], [School], [Ticket], [Device], [Description] FROM [Ticket]"></asp:SqlDataSource>



    </div>

    </form>
</body>
</html>
