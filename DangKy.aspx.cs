using System;
using System.Data.SqlClient;
using TranTrongNhan_35011.Models;

namespace TranTrongNhan_35011
{
    public partial class DangKy : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["MaTK"] != null)
            {
                Response.Redirect("TrangChu.aspx");
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string hoTen = txtHoTen.Text.Trim();
            string email = txtEmail.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string password = txtPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;

            // Validation
            if (string.IsNullOrEmpty(hoTen) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                ShowError("⚠️ Vui lòng nhập đầy đủ thông tin bắt buộc!");
                return;
            }
            if (password.Length < 6)
            {
                ShowError("⚠️ Mật khẩu phải có ít nhất 6 ký tự!");
                return;
            }
            if (password != confirmPassword)
            {
                ShowError("⚠️ Mật khẩu xác nhận không khớp!");
                return;
            }

            using (SqlConnection conn = KetNoi.GetTicketVerseConnection())
            {
                conn.Open();

                // Check duplicate email
                string checkSql = "SELECT COUNT(*) FROM TAIKHOAN WHERE Email = @Email";
                SqlCommand checkCmd = new SqlCommand(checkSql, conn);
                checkCmd.Parameters.AddWithValue("@Email", email);
                int count = (int)checkCmd.ExecuteScalar();

                if (count > 0)
                {
                    ShowError("❌ Email này đã được đăng ký!");
                    conn.Close();
                    return;
                }

                // Insert new user
                string sql = @"INSERT INTO TAIKHOAN (HoTen, Email, MatKhau, SoDienThoai, VaiTro) 
                               VALUES (@HoTen, @Email, @MatKhau, @Phone, 'KhachHang')";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@HoTen", hoTen);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@MatKhau", password);
                cmd.Parameters.AddWithValue("@Phone", phone);
                cmd.ExecuteNonQuery();
                conn.Close();

                lblSuccess.Visible = false;
                lblError.Visible = false;

                // Show success toast and Auto-redirect after 2 seconds
                string script = "showToast('success', 'Đăng ký thành công!'); setTimeout(function(){ window.location.href='DangNhap.aspx'; }, 2000);";
                ClientScript.RegisterStartupScript(GetType(), "redirect", script, true);
            }
        }

        private void ShowError(string msg)
        {
            lblError.Visible = false;
            lblSuccess.Visible = false;
            // Extract message without the emoji prefix if any
            string cleanMsg = msg.StartsWith("⚠️ ") || msg.StartsWith("❌ ") ? msg.Substring(3) : msg;
            System.Web.UI.ScriptManager.RegisterStartupScript(this, GetType(), "ToastError", $"showToast('error', '{cleanMsg}');", true);
        }
    }
}
