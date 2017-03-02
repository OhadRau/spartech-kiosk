using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient; 


namespace Accounts
{
    public partial class RegisterForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
                                 


        }

        protected void RegisterButton_Click(object sender, EventArgs e)
        {
            string password;
            string username = UsernameTextbox.Text;
            string email = EmailTextbox.Text;
            if (UsernameTextbox.Text != null)
            {
                if (PasswordTextbox.Text == ConfirmPasswordTextbx.Text)
                {
                    Console.WriteLine("adding new account");
                    password = PasswordTextbox.Text;

                    SqlConnection con = new SqlConnection("Data Source=" + "localhost;" +
                                                      "Database=STUDENT_KIOSK,1433;" +
                                                      "Integrated Security = false;" +
                                                      "Initial Catalog=master;" +
                                                      "connection timeout = 30;" +
                                                      @"User ID=Student;" +
                                                      "Password=Student123;");

                    con.Open();
                    SqlCommand command = new SqlCommand("SELECT * FROM Student_Accounts", con);
                    string query = "INSERT INTO Student_Accounts (Name, Email, Password) VALUES (@Name, @Email, @Password)";

                    SqlCommand cmd = new SqlCommand(query);
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.Connection = con;
                    cmd.Parameters.AddWithValue("@Name", username);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", password);
                    cmd.ExecuteNonQuery();
                    con.Close();

                    // Redirect to form page 

                }
                else
                {
                    // passwords dont match 

                }
            }

            




        }
    }
}