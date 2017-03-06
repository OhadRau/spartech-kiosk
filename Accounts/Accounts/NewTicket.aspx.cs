using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace Accounts
{
    public partial class NewTicket : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            EmailTextbox.Width = 280; 
            
        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {

            SqlConnection con = new SqlConnection("Data Source=" + "localhost;" +
                                       "Database=STUDENT_KIOSK,1433;" +
                                       "Integrated Security = false;" +
                                       "Initial Catalog=master;" +
                                       "connection timeout = 30;" +
                                       @"User ID=Student;" +
                                       "Password=Student123;");


            con.Open();
            string numQuery = "SELECT COUNT(*) FROM Ticket;";
            SqlCommand numCmd = new SqlCommand(numQuery);
            numCmd.Connection = con;
            int num = NumOfRows(); 
            con.Close();



            con.Open(); 
            string query = "INSERT INTO Ticket (First_Name, Last_Name, School, Ticket, Device, Description) VALUES (@First_Name, @Last_Name, @School, @Ticket, @Device, @Description)";
            SqlCommand cmd = new SqlCommand(query);
            cmd.CommandType = System.Data.CommandType.Text;
            cmd.Connection = con;
            cmd.Parameters.AddWithValue("@First_Name", Session["FirstName"].ToString());
            cmd.Parameters.AddWithValue("@Last_Name", Session["LastName"].ToString());
            cmd.Parameters.AddWithValue("@School", Session["School"].ToString());
            cmd.Parameters.AddWithValue("@Ticket", num + 1);
            cmd.Parameters.AddWithValue("@Device", DeviceList.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@Description", ProblemTextbox.Text);
            cmd.ExecuteNonQuery();
            con.Close();

            Response.Redirect("WebForm1.aspx");
        }

        private int NumOfRows()
        {
            string stmt = "SELECT COUNT(*) FROM Ticket";
            int count = 0;

            using (SqlConnection thisConnection = new SqlConnection("Data Source=" + "localhost;" +
                                       "Database=STUDENT_KIOSK,1433;" +
                                       "Integrated Security = false;" +
                                       "Initial Catalog=master;" +
                                       "connection timeout = 30;" +
                                       @"User ID=Student;" +
                                       "Password=Student123;"))
            {
                using (SqlCommand cmdCount = new SqlCommand(stmt, thisConnection))
                {
                    thisConnection.Open();
                    count = (int)cmdCount.ExecuteScalar();
                }
            }
            return count;
        }


        protected void DeviceList_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}