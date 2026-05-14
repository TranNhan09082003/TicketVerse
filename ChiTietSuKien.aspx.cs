using System;
using System.Data;
using System.Data.SqlClient;
using TranTrongNhan_35011.Models;

namespace TranTrongNhan_35011
{
    public partial class ChiTietSuKien : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string id = Request.QueryString["id"];
                if (string.IsNullOrEmpty(id))
                {
                    Response.Redirect("DanhSachSuKien.aspx");
                    return;
                }
                LoadEvent(int.Parse(id));
                LoadTickets(int.Parse(id));
                LoadReviews(int.Parse(id));
                UpdateViews(int.Parse(id));
            }
        }

        private void LoadEvent(int maSK)
        {
            using (SqlConnection conn = KetNoi.GetTicketVerseConnection())
            {
                string sql = @"SELECT s.*, l.TenLoai, l.Icon 
                               FROM SUKIEN s JOIN LOAISUKIEN l ON s.MaLoai = l.MaLoai 
                               WHERE s.MaSK = @MaSK";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@MaSK", maSK);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    lblTenSK.Text = reader["TenSK"].ToString();
                    lblMoTa.Text = reader["MoTa"].ToString();
                    lblCatIcon.Text = reader["Icon"].ToString();
                    lblCatName.Text = reader["TenLoai"].ToString();
                    lblDiaDiem.Text = reader["DiaDiem"].ToString();
                    lblLuotXem.Text = string.Format("{0:N0} lượt", reader["LuotXem"]);

                    DateTime start = Convert.ToDateTime(reader["ThoiGianBatDau"]);
                    DateTime? end = reader["ThoiGianKetThuc"] != DBNull.Value
                        ? (DateTime?)Convert.ToDateTime(reader["ThoiGianKetThuc"]) : null;

                    lblThoiGian.Text = start.ToString("dd/MM/yyyy HH:mm") +
                        (end.HasValue ? " - " + end.Value.ToString("HH:mm") : "");

                    litMoTaChiTiet.Text = reader["MoTaChiTiet"] != DBNull.Value
                        ? reader["MoTaChiTiet"].ToString()
                        : "<p>" + reader["MoTa"].ToString() + "</p>";

                    imgBanner.ImageUrl = "Assets/images/events/" + reader["HinhBanner"].ToString();

                    Page.Title = reader["TenSK"].ToString() + " — TicketVerse";

                    // Countdown
                    if (start > DateTime.Now)
                    {
                        string script = string.Format(
                            "document.querySelector('.tv-countdown-section').setAttribute('data-countdown', '{0}');",
                            start.ToString("yyyy-MM-ddTHH:mm:ss"));
                        ClientScript.RegisterStartupScript(GetType(), "countdown", script, true);
                    }
                    else
                    {
                        pnlCountdown.Visible = false;
                    }
                }
                else
                {
                    Response.Redirect("DanhSachSuKien.aspx");
                }
                conn.Close();
            }

            // Load rating
            using (SqlConnection conn = KetNoi.GetTicketVerseConnection())
            {
                string sql = "SELECT AVG(CAST(SoSao AS FLOAT)) AS Avg, COUNT(*) AS Total FROM DANHGIA WHERE MaSK = @MaSK";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@MaSK", maSK);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read() && reader["Avg"] != DBNull.Value)
                {
                    double avg = Convert.ToDouble(reader["Avg"]);
                    int total = Convert.ToInt32(reader["Total"]);
                    lblRating.Text = string.Format("{0:F1} / 5 ({1} đánh giá)", avg, total);
                }
                else
                {
                    lblRating.Text = "Chưa có đánh giá";
                }
                conn.Close();
            }
        }

        private void LoadTickets(int maSK)
        {
            using (SqlConnection conn = KetNoi.GetTicketVerseConnection())
            {
                string sql = "SELECT * FROM VE WHERE MaSK = @MaSK ORDER BY GiaVe DESC";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@MaSK", maSK);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptVe.DataSource = dt;
                rptVe.DataBind();

                // Fill dropdown
                ddlVe.Items.Clear();
                foreach (DataRow row in dt.Rows)
                {
                    if (Convert.ToInt32(row["SoLuongConLai"]) > 0)
                    {
                        string text = string.Format("{0} — {1:N0} đ",
                            row["TenLoaiVe"], row["GiaVe"]);
                        ddlVe.Items.Add(new System.Web.UI.WebControls.ListItem(text, row["MaVe"].ToString()));
                    }
                }
            }
        }

        private void LoadReviews(int maSK)
        {
            using (SqlConnection conn = KetNoi.GetTicketVerseConnection())
            {
                string sql = @"SELECT d.*, t.HoTen FROM DANHGIA d 
                               JOIN TAIKHOAN t ON d.MaTK = t.MaTK 
                               WHERE d.MaSK = @MaSK ORDER BY d.NgayDG DESC";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@MaSK", maSK);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    rptDanhGia.DataSource = dt;
                    rptDanhGia.DataBind();
                    lblNoReview.Visible = false;
                }
                else
                {
                    lblNoReview.Visible = true;
                }
            }
        }

        private void UpdateViews(int maSK)
        {
            using (SqlConnection conn = KetNoi.GetTicketVerseConnection())
            {
                string sql = "UPDATE SUKIEN SET LuotXem = LuotXem + 1 WHERE MaSK = @MaSK";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@MaSK", maSK);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
        }

        protected void btnAddCart_Click(object sender, EventArgs e)
        {
            if (Session["MaTK"] == null)
            {
                Response.Redirect("DangNhap.aspx");
                return;
            }

            int maTK = int.Parse(Session["MaTK"].ToString());
            int maVe = int.Parse(ddlVe.SelectedValue);
            int soLuong = 1;
            int.TryParse(txtSoLuong.Text, out soLuong);
            if (soLuong < 1) soLuong = 1;

            using (SqlConnection conn = KetNoi.GetTicketVerseConnection())
            {
                conn.Open();

                // Check available
                SqlCommand checkCmd = new SqlCommand("SELECT SoLuongConLai FROM VE WHERE MaVe = @MaVe", conn);
                checkCmd.Parameters.AddWithValue("@MaVe", maVe);
                int remaining = (int)checkCmd.ExecuteScalar();

                if (soLuong > remaining)
                {
                    lblMsg.Text = "❌ Chỉ còn " + remaining + " vé!";
                    lblMsg.Style["background"] = "#ffebee";
                    lblMsg.Style["color"] = "#c62828";
                    lblMsg.Visible = true;
                    conn.Close();
                    return;
                }

                // Check if already in cart
                SqlCommand existCmd = new SqlCommand(
                    "SELECT MaGH, SoLuong FROM GIOHANG WHERE MaTK = @MaTK AND MaVe = @MaVe", conn);
                existCmd.Parameters.AddWithValue("@MaTK", maTK);
                existCmd.Parameters.AddWithValue("@MaVe", maVe);
                SqlDataReader reader = existCmd.ExecuteReader();

                if (reader.Read())
                {
                    int maGH = (int)reader["MaGH"];
                    int currentQty = (int)reader["SoLuong"];
                    reader.Close();

                    SqlCommand updateCmd = new SqlCommand(
                        "UPDATE GIOHANG SET SoLuong = @SoLuong WHERE MaGH = @MaGH", conn);
                    updateCmd.Parameters.AddWithValue("@SoLuong", currentQty + soLuong);
                    updateCmd.Parameters.AddWithValue("@MaGH", maGH);
                    updateCmd.ExecuteNonQuery();
                }
                else
                {
                    reader.Close();
                    SqlCommand insertCmd = new SqlCommand(
                        "INSERT INTO GIOHANG (MaTK, MaVe, SoLuong) VALUES (@MaTK, @MaVe, @SoLuong)", conn);
                    insertCmd.Parameters.AddWithValue("@MaTK", maTK);
                    insertCmd.Parameters.AddWithValue("@MaVe", maVe);
                    insertCmd.Parameters.AddWithValue("@SoLuong", soLuong);
                    insertCmd.ExecuteNonQuery();
                }

                conn.Close();
            }

            lblMsg.Text = "✅ Đã thêm vào giỏ hàng!";
            lblMsg.Style["background"] = "#e8f5e9";
            lblMsg.Style["color"] = "#2e7d32";
            lblMsg.Visible = true;
        }
    }
}
