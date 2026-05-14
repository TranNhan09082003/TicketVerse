using System;
using System.Data;
using System.Data.SqlClient;
using TranTrongNhan_35011.Models;

namespace TranTrongNhan_35011.Admin
{
    public partial class QuanLyNguoiDung : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
            }
        }

        private void LoadData(string search = "")
        {
            using (SqlConnection conn = KetNoi.GetTicketVerseConnection())
            {
                string sql = "SELECT MaTK, HoTen, Email, SoDienThoai, NgayTao, VaiTro FROM TAIKHOAN";
                if (!string.IsNullOrEmpty(search))
                {
                    sql += " WHERE HoTen LIKE @Search OR Email LIKE @Search";
                }
                sql += " ORDER BY NgayTao DESC";

                SqlCommand cmd = new SqlCommand(sql, conn);
                if (!string.IsNullOrEmpty(search))
                {
                    cmd.Parameters.AddWithValue("@Search", "%" + search + "%");
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvUsers.DataSource = dt;
                gvUsers.DataBind();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadData(txtSearch.Text.Trim());
        }
    }
}
