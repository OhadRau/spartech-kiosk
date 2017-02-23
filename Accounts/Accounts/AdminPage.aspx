<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminPage.aspx.cs" Inherits="Accounts.AdminPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Page</title>
    <link href="Css/StyleSheet.css" rel="stylesheet" />
    </head>

<body>
    <form id="form1" runat="server">

     <div class ="PAGE">
        
     <div class ="AdminTable">

        <table>
            
            <tr>
                <td>
                    <ul>

                        <li class ="IDschoolList">School</li>
                        <li class ="IDschoolList">

                            <select name ="Schools">
                            <option value ="Westlake">Westlake</option>
                            <option value ="Langston">Langston</option>
                            <option value ="Creekside">Creekside</option>
                            <option value ="Banneker">Banneker</option>
                            </select>

                        </li>
                    </ul>
                                    

                </td>
            </tr>
                        
            <tr>
                <td>
                    <div class ="ScrollMenu">
                        <ul>
                            <li>
                                IPAD
                            </li>
                            <li>
                                KINDLE
                            </li>
                            <li>
                                SURFACE
                            </li>
                        </ul>
                    </div>
                                       
                </td>
            </tr>

        </table>

         <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1" 
            onsorting="ListView1_Sorting"  InsertItemPosition="LastItem" 
            onitemcommand="ListView1_ItemCommand" >
            <LayoutTemplate>
                <table border="0" cellpadding="1">
                    <tr style="background-color:#E5E5FE">
                        <th align="left"><asp:LinkButton ID="lnkId" runat="server" CommandName="Sort" CommandArgument="ID">Id</asp:LinkButton></th>
                        <th align="left"><asp:LinkButton ID="lnkName" runat="server" CommandName="Sort" CommandArgument="FirstName">Name</asp:LinkButton></th>
                        <th align="left"><asp:LinkButton ID="lnkType" runat="server" CommandName="Sort" CommandArgument="ContactType">Type</asp:LinkButton></th>
                        <th></th>
                    </tr>
                    <tr id="itemPlaceholder" runat="server"></tr>
                </table>
                <asp:DataPager ID="ItemDataPager" runat="server" PageSize="5">
                    <Fields>
                        <asp:NumericPagerField ButtonCount="2" />
                    </Fields>
                </asp:DataPager>    
            </LayoutTemplate>
            <ItemTemplate>
                    <tr>
                        <td><asp:Label runat="server" ID="lblId"><%#Eval("ID") %></asp:Label></td>
                        <td><asp:Label runat="server" ID="lblName"><%#Eval("FirstName")+" "+Eval("LastName") %></asp:Label></td>
                        <td><asp:Label runat="server" ID="lblType"><%#Eval("ContactType") %></asp:Label></td>
                        <td><asp:LinkButton ID="lnkEdit" runat="server" CommandName="Edit">Edit</asp:LinkButton></td>
                    </tr>
            </ItemTemplate>
            <AlternatingItemTemplate>
                    <tr style="background-color:#EFEFEF">
                        <td><asp:Label runat="server" ID="lblId"><%#Eval("ID") %></asp:Label></td>
                        <td><asp:Label runat="server" ID="lblName"><%#Eval("FirstName")+" "+Eval("LastName") %></asp:Label></td>
                        <td><asp:Label runat="server" ID="lblType"><%#Eval("ContactType") %></asp:Label></td>
                        <td><asp:LinkButton ID="lnkEdit" runat="server" CommandName="Edit">Edit</asp:LinkButton></td>
                    </tr>
            </AlternatingItemTemplate>
            <EditItemTemplate>
                    <td>
                        <asp:TextBox ID="txtUpId" runat="server" Text='<%#Eval("Id") %>' Enabled="false" Width="20px"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtUpFname" runat="server" Text='<%#Eval("FirstName") %>' Width="100px"></asp:TextBox>
                        <asp:TextBox ID="txtUpLname" runat="server" Text='<%#Eval("LastName") %>' Width="100px"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtUpCtype" runat="server" Width="100px" Text='<%#Eval("ContactType") %>'></asp:TextBox>
                     </td>
                     <td>   
                            <asp:LinkButton ID="lnkUpdate" runat="server" CommandName="Update">Update</asp:LinkButton>
                            <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete">Delete</asp:LinkButton>
                            <asp:LinkButton ID="lnkCancel" runat="server" CommandName="Cancel">Cancel</asp:LinkButton>
                    </td>
                    
                </tr>
            </EditItemTemplate>
            <InsertItemTemplate>
                <tr runat="server">
                    <td></td>
                    <td>
                        <asp:TextBox ID="txtFname" runat="server" Text='<%#Eval("FirstName") %>' Width="100px">First Name</asp:TextBox>
                        <asp:TextBox ID="txtLname" runat="server" Text='<%#Eval("LastName") %>' Width="100px">Last Name</asp:TextBox>
                    </td>
                    <td><asp:TextBox ID="txtCtype" runat="server" Text='<%#Eval("ContactType") %>' Width="100px">Contact Type</asp:TextBox></td>
                     <td><asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" /></td>
                    
                </tr>
            </InsertItemTemplate>
            
        </asp:ListView>
        
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:TestDatabaseConnectionString %>" 
            SelectCommand="SELECT * FROM [Contacts]" >
        </asp:SqlDataSource>

    </div>

        </div>
    </form>
    <p>
&nbsp;</p>
</body>
</html>
