using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace Accounts.Css
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button2_Click(object sender, EventArgs e) // Login
        {
            Console.WriteLine("Logging in to account");

            SqlConnection con = new SqlConnection("Data Source=" + "localhost;" +
                                                   "Database=STUDENT_KIOSK,1433;" +
                                                   "Integrated Security = false;" +
                                                   "Initial Catalog=master;" +
                                                   "connection timeout = 30;" +
                                                   @"User ID=Student;"+
                                                   "Password=Student321;");

            con.Open();
            SqlCommand command = new SqlCommand("SELECT * FROM Accounts", con);
            SqlDataReader reader = command.ExecuteReader();


            // Admin 
            if (TextBox1.Text.ToString() == "Admin")
            {
                if (TextBox2.Text.ToString() == "aDmIn01")
                {
                    Response.Redirect("AdminPage.aspx");
                }
            }


            while (reader.Read())
            {
                if(reader["Username"].ToString() == TextBox1.Text)
                {
                    if (reader["Password"].ToString() == TextBox2.Text)
                    {

                        
                        // Goto login page
                        Session["FirstName"] = reader["First_Name"];
                        Session["LastName"] = reader["Last_Name"];
                        Session["School"] = reader["School"]; 
                        
                        Response.Redirect("NewTicket.aspx");

                    }
                }
            }
            
            con.Close();
        }

        
        protected void Button1_Click(object sender, EventArgs e) //Register
        {
            Response.Redirect("RegisterForm.aspx"); 
        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }
    }
}