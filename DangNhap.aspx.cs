using System;
using System.Data;
using System.Data.SqlClient;
using TranTrongNhan_35011.Models;

namespace TranTrongNhan_35011
{
    public partial class DangNhap : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["MaTK"] != null)
            {
                Response.Redirect("TrangChu.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblError.Visible = false;
                System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "ToastError", "showToast('warning', 'Vui lòng nhập đầy đủ email và mật khẩu!');", true);
                return;
            }

            using (SqlConnection conn = KetNoi.GetTicketVerseConnection())
            {
                string sql = "SELECT MaTK, HoTen, Email, VaiTro FROM TAIKHOAN WHERE Email = @Email AND MatKhau = @MatKhau";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@MatKhau", password);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    Session["MaTK"] = reader["MaTK"].ToString();
                    Session["HoTen"] = reader["HoTen"].ToString();
                    Session["Email"] = reader["Email"].ToString();
                    Session["VaiTro"] = reader["VaiTro"].ToString();

                    if (reader["VaiTro"].ToString() == "Admin")
                        Response.Redirect("Admin/Dashboard.aspx");
                    else
                        Response.Redirect("TrangChu.aspx");
                }
                else
                {
                    lblError.Visible = false;
                    System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "ToastError", "showToast('error', 'Email hoặc mật khẩu không đúng!');", true);
                }
                conn.Close();
            }
        }
    }
}
