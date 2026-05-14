using System;
using System.Data;
using System.Data.SqlClient;
using TranTrongNhan_35011.Models;

namespace TranTrongNhan_35011
{
    public partial class DonHang : System.Web.UI.Page
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
                string id = Request.QueryString["id"];
                string success = Request.QueryString["success"];

                if (string.IsNullOrEmpty(id))
                {
                    Response.Redirect("TrangChu.aspx");
                    return;
                }

                if (success == "1")
                {
                    pnlSuccess.Visible = true;
                    // Reset cart JS logic
                    ClientScript.RegisterStartupScript(GetType(), "clearCart", 
                        "sessionStorage.setItem('tv_cart_count', 0); TicketCart.updateBadge();", true);
                }

                LoadOrderDetails(int.Parse(id));
            }
        }

        private void LoadOrderDetails(int maDH)
        {
            int maTK = int.Parse(Session["MaTK"].ToString());

            using (SqlConnection conn = KetNoi.GetTicketVerseConnection())
            {
                // 1. Get Order Info
                string sqlDH = "SELECT MaDonPayOS, NgayDat, TongTien, TrangThai FROM DONHANG WHERE MaDH = @MaDH AND MaTK = @MaTK";
                SqlCommand cmdDH = new SqlCommand(sqlDH, conn);
                cmdDH.Parameters.AddWithValue("@MaDH", maDH);
                cmdDH.Parameters.AddWithValue("@MaTK", maTK);
                
                conn.Open();
                SqlDataReader reader = cmdDH.ExecuteReader();
                if (reader.Read())
                {
                    lblMaDon.Text = "#" + reader["MaDonPayOS"].ToString();
                    lblNgayDat.Text = Convert.ToDateTime(reader["NgayDat"]).ToString("dd/MM/yyyy HH:mm");
                    lblTongTien.Text = Convert.ToDecimal(reader["TongTien"]).ToString("N0");
                    
                    if (reader["TrangThai"].ToString() != "DaThanhToan")
                    {
                        // Handle unpaid order case if needed, but for now we assume it's paid or we just show the tickets
                    }
                }
                else
                {
                    // Order not found or doesn't belong to user
                    Response.Redirect("TrangChu.aspx");
                }
                reader.Close();

                // 2. Get E-Tickets
                // We explode quantity so if a user bought 2 tickets, we show 2 rows.
                // SQL trick using an tally/numbers approach or just logic. 
                // Since our CHITIETDONHANG groups by ticket type, we will handle it in DataTable to multiply rows.

                string sqlCT = @"SELECT c.SoLuong, c.MaQR, v.TenLoaiVe, s.TenSK, s.HinhAnh, s.ThoiGianBatDau, s.DiaDiem
                                 FROM CHITIETDONHANG c
                                 JOIN VE v ON c.MaVe = v.MaVe
                                 JOIN SUKIEN s ON v.MaSK = s.MaSK
                                 WHERE c.MaDH = @MaDH";
                
                SqlCommand cmdCT = new SqlCommand(sqlCT, conn);
                cmdCT.Parameters.AddWithValue("@MaDH", maDH);
                SqlDataAdapter da = new SqlDataAdapter(cmdCT);
                DataTable dtOriginal = new DataTable();
                da.Fill(dtOriginal);

                // Create a new DataTable to hold individual tickets (1 row = 1 physical ticket)
                DataTable dtTickets = dtOriginal.Clone();
                
                foreach (DataRow row in dtOriginal.Rows)
                {
                    int qty = Convert.ToInt32(row["SoLuong"]);
                    string baseQR = row["MaQR"].ToString();
                    
                    for (int i = 1; i <= qty; i++)
                    {
                        DataRow newRow = dtTickets.NewRow();
                        newRow.ItemArray = row.ItemArray;
                        // Suffix the QR so each ticket is unique: e.g. "ABCD-1-2-1", "ABCD-1-2-2"
                        newRow["MaQR"] = baseQR + "-" + i;
                        dtTickets.Rows.Add(newRow);
                    }
                }

                rptTickets.DataSource = dtTickets;
                rptTickets.DataBind();

                conn.Close();
            }
        }
    }
}
