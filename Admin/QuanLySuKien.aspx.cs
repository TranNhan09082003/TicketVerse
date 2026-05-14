using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using TranTrongNhan_35011.Models;

namespace TranTrongNhan_35011.Admin
{
    public partial class QuanLySuKien : System.Web.UI.Page
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
                string sql = @"SELECT s.MaSK, s.TenSK, s.ThoiGianBatDau, s.HinhAnh, s.TrangThai, s.LuotXem, l.TenLoai
                               FROM SUKIEN s
                               JOIN LOAISUKIEN l ON s.MaLoai = l.MaLoai";
                
                if (!string.IsNullOrEmpty(search))
                {
                    sql += " WHERE s.TenSK LIKE @Search";
                }
                
                sql += " ORDER BY s.NgayTao DESC";

                SqlCommand cmd = new SqlCommand(sql, conn);
                if (!string.IsNullOrEmpty(search))
                {
                    cmd.Parameters.AddWithValue("@Search", "%" + search + "%");
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvSuKien.DataSource = dt;
                gvSuKien.DataBind();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadData(txtSearch.Text.Trim());
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            // Trong thực tế sẽ chuyển tới trang ThemMoiSuKien.aspx
            ShowMessage("Tính năng thêm sự kiện sẽ được hiển thị ở màn hình Form riêng.", true);
        }

        protected void gvSuKien_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditEvent")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                ShowMessage("Tính năng sửa sự kiện ID " + id + " sẽ mở ở Form riêng.", true);
            }
        }

        protected void gvSuKien_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvSuKien.DataKeys[e.RowIndex].Value);
            
            using (SqlConnection conn = KetNoi.GetTicketVerseConnection())
            {
                // Note: Thực tế cần xóa các bản ghi liên quan (VE, DANHGIA...) trước khi xóa SUKIEN do khóa ngoại
                try
                {
                    conn.Open();
                    // Just a demo delete, since we have foreign keys, it might throw an error if tickets exist.
                    // For a complete project we'd use a transaction to delete VE, DANHGIA, then SUKIEN.
                    
                    // Demo: Soft delete (change status)
                    SqlCommand cmd = new SqlCommand("UPDATE SUKIEN SET TrangThai = 'DaHuy' WHERE MaSK = @MaSK", conn);
                    cmd.Parameters.AddWithValue("@MaSK", id);
                    cmd.ExecuteNonQuery();
                    conn.Close();
                    
                    ShowMessage("Đã hủy sự kiện thành công!", true);
                    LoadData();
                }
                catch (Exception ex)
                {
                    ShowMessage("Lỗi khi xóa: " + ex.Message, false);
                }
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
