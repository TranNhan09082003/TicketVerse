using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using TranTrongNhan_35011.Models;

namespace TranTrongNhan_35011.Admin
{
    public partial class QuanLyDonHang : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
            }
        }

        private void LoadData()
        {
            using (SqlConnection conn = KetNoi.GetTicketVerseConnection())
            {
                string sql = @"SELECT d.MaDH, d.MaDonPayOS, d.NgayDat, d.TongTien, d.TrangThai, t.HoTen
                               FROM DONHANG d
                               JOIN TAIKHOAN t ON d.MaTK = t.MaTK
                               WHERE 1=1";
                
                SqlCommand cmd = new SqlCommand();
                
                string search = txtSearch.Text.Trim();
                if (!string.IsNullOrEmpty(search))
                {
                    sql += " AND d.MaDonPayOS LIKE @Search";
                    cmd.Parameters.AddWithValue("@Search", "%" + search + "%");
                }

                string status = ddlTrangThai.SelectedValue;
                if (!string.IsNullOrEmpty(status))
                {
                    sql += " AND d.TrangThai = @Status";
                    cmd.Parameters.AddWithValue("@Status", status);
                }

                sql += " ORDER BY d.NgayDat DESC";
                cmd.CommandText = sql;
                cmd.Connection = conn;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvDonHang.DataSource = dt;
                gvDonHang.DataBind();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadData();
        }

        protected void gvDonHang_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewDetail")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                // Demo: We can show a JS alert or redirect to a detailed page
                ShowMessage("Chức năng xem chi tiết đơn hàng #" + id + " sẽ được mở trong Modal hoặc trang riêng.", true);
            }
        }

        private void ShowMessage(string msg, bool isSuccess)
        {
            lblMessage.Text = msg;
            lblMessage.Visible = true;
            lblMessage.Style["background"] = isSuccess ? "#e8f5e9" : "#ffebee";
            lblMessage.Style["color"] = isSuccess ? "#2e7d32" : "#c62828";
        }
    }
}
