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

            SqlConnection con = new SqlConnection("Data Source=" + "10.217.118.152;" +
                                                   "Database=STUDENT_KIOSK,1433;" +
                                                   "Integrated Security = false;" +
                                                   "Initial Catalog=master;" +
                                                   "connection timeout = 30;" +
                                                   @"User ID=Student;"+
                                                   "Password=Student123;");

            con.Open();
            SqlCommand command = new SqlCommand("SELECT * FROM Accounts", con);
            SqlDataReader reader = command.ExecuteReader();

            while (reader.Read())
            {
                if(reader["Name"].ToString() == TextBox1.Text)
                {
                    if (reader["Password"].ToString() == TextBox2.Text)
                    {
                        // Goto login page
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