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
            string firstname = FirstNameTextbox.Text;
            string lastname = LastNameTextbox.Text;
            string school = SchoolCodeTextbox.Text; 
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
                    string query = "INSERT INTO Accounts (Username, First_Name, Last_Name, Email, Password, School) VALUES" +
                        "(@Username, @First_Name, @Last_Name, @Email, @Password, @School)";

                    SqlCommand cmd = new SqlCommand(query);
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.Connection = con;
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@First_Name", firstname);
                    cmd.Parameters.AddWithValue("@Last_Name", lastname);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", password);
                    cmd.Parameters.AddWithValue("@School", school);
                    cmd.ExecuteNonQuery();
                    con.Close();

                    // Redirect to form page 
                    Response.Redirect("WebForm1.aspx");
                }
                else
                {
                    // passwords dont match 

                }
            }

            




        }
    }
}