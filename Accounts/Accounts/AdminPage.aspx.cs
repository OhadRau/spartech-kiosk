using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace Accounts
{
    public partial class AdminPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            NameTextbox.ReadOnly = true;
            TicketNumberTextbox.ReadOnly = true;
            SchoolTextbox.ReadOnly = true; 
        }

        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            NameTextbox.Text = GridView1.SelectedRow.Cells[2].Text + " " + GridView1.SelectedRow.Cells[1].Text;
            TicketNumberTextbox.Text = GridView1.SelectedRow.Cells[4].Text;
            SchoolTextbox.Text = GridView1.SelectedRow.Cells[3].Text; 
        }

        protected void ResolveButton_Click(object sender, EventArgs e)
        {                                 
            // send resolution to people
            string resolution = ResolutionTextbox.Text;
            string studentName = GridView1.SelectedRow.Cells[2].Text + " " + GridView1.SelectedRow.Cells[1].Text;
            string final = studentName + "\n" + resolution; 
                        
            SqlConnection con = new SqlConnection("Data Source=" + "localhost;" +
                                              "Database=STUDENT_KIOSK,1433;" +
                                              "Integrated Security = false;" +
                                              "Initial Catalog=master;" +
                                              "connection timeout = 30;" +
                                              @"User ID=Student;" +
                                              "Password=Student123;");

            con.Open();
            SqlCommand command = new SqlCommand("SELECT * FROM Resolution", con);
            SqlCommand command2 = new SqlCommand("SELECT * FROM Student_Accounts", con);
            
            string query = "INSERT INTO Resolution (Resolution) VALUES (@Resolution)";

            SqlCommand cmd = new SqlCommand(query);
            cmd.CommandType = System.Data.CommandType.Text;
            cmd.Connection = con;
            cmd.Parameters.AddWithValue("@Resolution", final);
            cmd.ExecuteNonQuery();


            SqlDataReader reader = command2.ExecuteReader();
            SqlCommand command3 = new SqlCommand(); 
            while (reader.Read())
            {
                if (reader["Ticket"].ToString() == GridView1.SelectedRow.Cells[4].Text)
                {
                   // delete ticket
                  command3 = new SqlCommand("DELETE FROM Ticket WHERE Ticket='" + reader["Ticket"] + "'");
                  
                }
            }
            command3.ExecuteNonQuery(); 


            con.Close();


        }
    }
}