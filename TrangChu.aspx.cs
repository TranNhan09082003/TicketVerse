using System;
using System.Data;
using System.Data.SqlClient;
using TranTrongNhan_35011.Models;

namespace TranTrongNhan_35011
{
    public partial class TrangChu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
                LoadHotEvents();
                LoadUpcomingEvents();
                LoadCountdown();
            }
        }

        private void LoadCategories()
        {
            using (SqlConnection conn = KetNoi.GetTicketVerseConnection())
            {
                string sql = "SELECT MaLoai, TenLoai, Icon, MauSac FROM LOAISUKIEN";
                SqlDataAdapter da = new SqlDataAdapter(sql, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptCategories.DataSource = dt;
                rptCategories.DataBind();
            }
        }

        private void LoadHotEvents()
        {
            using (SqlConnection conn = KetNoi.GetTicketVerseConnection())
            {
                string sql = @"SELECT TOP 8 s.MaSK, s.TenSK, s.MoTa, s.DiaDiem, s.ThoiGianBatDau, 
                               s.HinhAnh, s.TrangThai, s.LuotXem,
                               l.TenLoai, l.Icon,
                               (SELECT MIN(GiaVe) FROM VE WHERE MaSK = s.MaSK) AS GiaMin
                               FROM SUKIEN s 
                               JOIN LOAISUKIEN l ON s.MaLoai = l.MaLoai 
                               WHERE s.TrangThai = N'DangBan'
                               ORDER BY s.LuotXem DESC";
                SqlDataAdapter da = new SqlDataAdapter(sql, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptHotEvents.DataSource = dt;
                rptHotEvents.DataBind();
            }
        }

        private void LoadUpcomingEvents()
        {
            using (SqlConnection conn = KetNoi.GetTicketVerseConnection())
            {
                string sql = @"SELECT TOP 4 s.MaSK, s.TenSK, s.MoTa, s.DiaDiem, s.ThoiGianBatDau, 
                               s.HinhAnh, s.TrangThai,
                               l.TenLoai, l.Icon,
                               (SELECT MIN(GiaVe) FROM VE WHERE MaSK = s.MaSK) AS GiaMin
                               FROM SUKIEN s 
                               JOIN LOAISUKIEN l ON s.MaLoai = l.MaLoai 
                               WHERE s.TrangThai = N'SapDienRa' AND s.ThoiGianBatDau > GETDATE()
                               ORDER BY s.ThoiGianBatDau ASC";
                SqlDataAdapter da = new SqlDataAdapter(sql, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptUpcoming.DataSource = dt;
                rptUpcoming.DataBind();
            }
        }

        private void LoadCountdown()
        {
            using (SqlConnection conn = KetNoi.GetTicketVerseConnection())
            {
                string sql = @"SELECT TOP 1 s.MaSK, s.TenSK, s.DiaDiem, s.ThoiGianBatDau,
                               l.TenLoai, l.Icon
                               FROM SUKIEN s 
                               JOIN LOAISUKIEN l ON s.MaLoai = l.MaLoai 
                               WHERE s.ThoiGianBatDau > GETDATE()
                               ORDER BY s.ThoiGianBatDau ASC";
                SqlCommand cmd = new SqlCommand(sql, conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    lblCountdownTitle.Text = reader["TenSK"].ToString();
                    DateTime eventDate = Convert.ToDateTime(reader["ThoiGianBatDau"]);
                    lblCountdownInfo.Text = "📍 " + reader["DiaDiem"].ToString() + " | 📅 " + eventDate.ToString("dd/MM/yyyy HH:mm");
                    
                    // Set countdown target date as ISO string for JS
                    pnlCountdown.Attributes["data-countdown"] = "";
                    var countdownDiv = pnlCountdown.FindControl("tv-countdown-section");
                    
                    // Use ClientScript to set the data attribute
                    string script = string.Format(
                        "document.querySelector('.tv-countdown-section').setAttribute('data-countdown', '{0}');",
                        eventDate.ToString("yyyy-MM-ddTHH:mm:ss"));
                    ClientScript.RegisterStartupScript(GetType(), "countdown", script, true);

                    lnkCountdownEvent.HRef = "ChiTietSuKien.aspx?id=" + reader["MaSK"].ToString();
                }
                else
                {
                    pnlCountdown.Visible = false;
                }
                conn.Close();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string keyword = txtSearch.Text.Trim();
            if (!string.IsNullOrEmpty(keyword))
            {
                Response.Redirect("DanhSachSuKien.aspx?search=" + Server.UrlEncode(keyword));
            }
        }
    }
}
