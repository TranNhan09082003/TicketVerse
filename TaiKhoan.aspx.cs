using System;
using System.Data;
using System.Data.SqlClient;
using TranTrongNhan_35011.Models;

namespace TranTrongNhan_35011
{
    public partial class TaiKhoan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["MaTK"] == null)
            {
                Response.Redirect("DangNhap.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadProfile();
                LoadOrderHistory();
            }
        }

        private void LoadProfile()
        {
            int maTK = int.Parse(Session["MaTK"].ToString());
            using (SqlConnection conn = KetNoi.GetTicketVerseConnection())
            {
                string sql = "SELECT HoTen, Email, SoDienThoai, NgayTao FROM TAIKHOAN WHERE MaTK = @MaTK";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@MaTK", maTK);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    lblHoTen.Text = reader["HoTen"].ToString();
                    lblEmail.Text = reader["Email"].ToString();
                    lblPhone.Text = reader["SoDienThoai"].ToString();
                    lblNgayTao.Text = Convert.ToDateTime(reader["NgayTao"]).ToString("dd/MM/yyyy");
                }
                conn.Close();
            }
        }

        private void LoadOrderHistory()
        {
            int maTK = int.Parse(Session["MaTK"].ToString());
            using (SqlConnection conn = KetNoi.GetTicketVerseConnection())
            {
                string sql = @"SELECT d.MaDH, d.MaDonPayOS, d.NgayDat, d.TongTien, d.TrangThai,
                                      (SELECT SUM(SoLuong) FROM CHITIETDONHANG WHERE MaDH = d.MaDH) AS SoLuongVe
                               FROM DONHANG d
                               WHERE d.MaTK = @MaTK
                               ORDER BY d.NgayDat DESC";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@MaTK", maTK);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    rptOrders.DataSource = dt;
                    rptOrders.DataBind();
                    lblNoOrders.Visible = false;
                }
                else
                {
                    lblNoOrders.Visible = true;
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("TrangChu.aspx");
        }
    }
}
