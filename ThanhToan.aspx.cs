using System;
using System.Data;
using System.Data.SqlClient;
using TranTrongNhan_35011.Models;

namespace TranTrongNhan_35011
{
    public partial class ThanhToan : System.Web.UI.Page
    {
        private decimal _tongTien = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["MaTK"] == null)
            {
                Response.Redirect("DangNhap.aspx?url=ThanhToan.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadUserInfo();
                LoadOrderSummary();
            }
        }

        private void LoadUserInfo()
        {
            int maTK = int.Parse(Session["MaTK"].ToString());
            using (SqlConnection conn = KetNoi.GetTicketVerseConnection())
            {
                string sql = "SELECT HoTen, Email, SoDienThoai FROM TAIKHOAN WHERE MaTK = @MaTK";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@MaTK", maTK);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtHoTen.Text = reader["HoTen"].ToString();
                    txtEmail.Text = reader["Email"].ToString();
                    txtPhone.Text = reader["SoDienThoai"].ToString();
                }
                conn.Close();
            }
        }

        private void LoadOrderSummary()
        {
            int maTK = int.Parse(Session["MaTK"].ToString());
            using (SqlConnection conn = KetNoi.GetTicketVerseConnection())
            {
                string sql = @"SELECT g.SoLuong, v.TenLoaiVe, v.GiaVe,
                               s.TenSK, (g.SoLuong * v.GiaVe) AS ThanhTien
                               FROM GIOHANG g
                               JOIN VE v ON g.MaVe = v.MaVe
                               JOIN SUKIEN s ON v.MaSK = s.MaSK
                               WHERE g.MaTK = @MaTK";
                
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@MaTK", maTK);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    Response.Redirect("GioHang.aspx");
                    return;
                }

                rptSummary.DataSource = dt;
                rptSummary.DataBind();

                foreach (DataRow row in dt.Rows)
                {
                    _tongTien += Convert.ToDecimal(row["ThanhTien"]);
                }

                lblTamTinh.Text = _tongTien.ToString("N0");
                lblTongTien.Text = _tongTien.ToString("N0");
                
                // Store in ViewState to use later
                ViewState["TongTien"] = _tongTien;
            }
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            int maTK = int.Parse(Session["MaTK"].ToString());
            decimal tongTien = Convert.ToDecimal(ViewState["TongTien"]);
            string ghiChu = txtGhiChu.Text.Trim();
            
            // Generate a fake PayOS Order Code (number)
            Random rnd = new Random();
            string payosCode = rnd.Next(100000, 999999).ToString() + DateTime.Now.ToString("HHmm");

            // 1. Create Order (Pending state)
            int newMaDH = 0;
            using (SqlConnection conn = KetNoi.GetTicketVerseConnection())
            {
                conn.Open();
                SqlTransaction trans = conn.BeginTransaction();
                try
                {
                    // Check if enough tickets are available
                    string checkSql = @"SELECT g.MaVe, g.SoLuong, v.SoLuongConLai, v.TenLoaiVe 
                                      FROM GIOHANG g JOIN VE v ON g.MaVe = v.MaVe 
                                      WHERE g.MaTK = @MaTK";
                    SqlCommand checkCmd = new SqlCommand(checkSql, conn, trans);
                    checkCmd.Parameters.AddWithValue("@MaTK", maTK);
                    SqlDataReader reader = checkCmd.ExecuteReader();
                    
                    bool outOfStock = false;
                    string errMsgs = "";
                    while (reader.Read())
                    {
                        if (Convert.ToInt32(reader["SoLuong"]) > Convert.ToInt32(reader["SoLuongConLai"]))
                        {
                            outOfStock = true;
                            errMsgs += $"Vé {reader["TenLoaiVe"]} không đủ số lượng. ";
                        }
                    }
                    reader.Close();

                    if (outOfStock)
                    {
                        lblError.Text = "⚠️ " + errMsgs + "Vui lòng cập nhật lại giỏ hàng.";
                        lblError.Visible = true;
                        trans.Rollback();
                        return;
                    }

                    // Insert DONHANG
                    string insertDh = @"INSERT INTO DONHANG (MaTK, TongTien, TrangThai, MaDonPayOS, GhiChu) 
                                        OUTPUT INSERTED.MaDH
                                        VALUES (@MaTK, @TongTien, 'ChoThanhToan', @PayOS, @GhiChu)";
                    SqlCommand cmdDh = new SqlCommand(insertDh, conn, trans);
                    cmdDh.Parameters.AddWithValue("@MaTK", maTK);
                    cmdDh.Parameters.AddWithValue("@TongTien", tongTien);
                    cmdDh.Parameters.AddWithValue("@PayOS", payosCode);
                    cmdDh.Parameters.AddWithValue("@GhiChu", ghiChu);
                    newMaDH = (int)cmdDh.ExecuteScalar();

                    // Copy GIOHANG to CHITIETDONHANG
                    string insertCT = @"INSERT INTO CHITIETDONHANG (MaDH, MaVe, SoLuong, DonGia)
                                        SELECT @MaDH, g.MaVe, g.SoLuong, v.GiaVe
                                        FROM GIOHANG g JOIN VE v ON g.MaVe = v.MaVe
                                        WHERE g.MaTK = @MaTK";
                    SqlCommand cmdCT = new SqlCommand(insertCT, conn, trans);
                    cmdCT.Parameters.AddWithValue("@MaDH", newMaDH);
                    cmdCT.Parameters.AddWithValue("@MaTK", maTK);
                    cmdCT.ExecuteNonQuery();

                    trans.Commit();
                    
                    // Save for the fake PayOS success
                    Session["CurrentMaDH"] = newMaDH;
                    lblPayOSAmount.Text = tongTien.ToString("N0");
                    lblPayOSCode.Text = "#" + payosCode;
                    
                    // Show Fake PayOS Modal
                    pnlPayOS.Visible = true;
                }
                catch (Exception ex)
                {
                    trans.Rollback();
                    lblError.Text = "⚠️ Đã xảy ra lỗi: " + ex.Message;
                    lblError.Visible = true;
                }
            }
        }

        protected void btnSimulateSuccess_Click(object sender, EventArgs e)
        {
            if (Session["CurrentMaDH"] != null)
            {
                int maDH = (int)Session["CurrentMaDH"];
                int maTK = int.Parse(Session["MaTK"].ToString());

                using (SqlConnection conn = KetNoi.GetTicketVerseConnection())
                {
                    conn.Open();
                    SqlTransaction trans = conn.BeginTransaction();
                    try
                    {
                        // 1. Update DONHANG status
                        SqlCommand cmdUpd = new SqlCommand("UPDATE DONHANG SET TrangThai = 'DaThanhToan' WHERE MaDH = @MaDH", conn, trans);
                        cmdUpd.Parameters.AddWithValue("@MaDH", maDH);
                        cmdUpd.ExecuteNonQuery();

                        // 2. Reduce Ticket Quantity AND Generate QR Code for each ticket
                        // In reality, QR is 1 per ticket. For simplicity, we just save a hash to MaQR
                        string sqlCT = "SELECT MaCTDH, MaVe, SoLuong FROM CHITIETDONHANG WHERE MaDH = @MaDH";
                        SqlCommand cmdGetCT = new SqlCommand(sqlCT, conn, trans);
                        cmdGetCT.Parameters.AddWithValue("@MaDH", maDH);
                        
                        DataTable dtCT = new DataTable();
                        SqlDataAdapter daCT = new SqlDataAdapter(cmdGetCT);
                        daCT.Fill(dtCT);

                        foreach (DataRow row in dtCT.Rows)
                        {
                            int maVe = (int)row["MaVe"];
                            int soLuong = (int)row["SoLuong"];
                            int maCTDH = (int)row["MaCTDH"];

                            // Reduce qty
                            SqlCommand cmdDec = new SqlCommand("UPDATE VE SET SoLuongConLai = SoLuongConLai - @Qty WHERE MaVe = @MaVe", conn, trans);
                            cmdDec.Parameters.AddWithValue("@Qty", soLuong);
                            cmdDec.Parameters.AddWithValue("@MaVe", maVe);
                            cmdDec.ExecuteNonQuery();

                            // Gen QR String
                            string qr = Guid.NewGuid().ToString().Substring(0, 8).ToUpper() + "-" + maDH + "-" + maVe;
                            SqlCommand cmdQR = new SqlCommand("UPDATE CHITIETDONHANG SET MaQR = @QR WHERE MaCTDH = @MaCT", conn, trans);
                            cmdQR.Parameters.AddWithValue("@QR", qr);
                            cmdQR.Parameters.AddWithValue("@MaCT", maCTDH);
                            cmdQR.ExecuteNonQuery();
                        }

                        // 3. Clear GIOHANG
                        SqlCommand cmdDel = new SqlCommand("DELETE FROM GIOHANG WHERE MaTK = @MaTK", conn, trans);
                        cmdDel.Parameters.AddWithValue("@MaTK", maTK);
                        cmdDel.ExecuteNonQuery();

                        // 4. Insert THANHTOAN record
                        decimal total = Convert.ToDecimal(ViewState["TongTien"]);
                        SqlCommand cmdTT = new SqlCommand(@"INSERT INTO THANHTOAN (MaDH, PhuongThuc, SoTien, TrangThai, MaGiaoDich) 
                                                          VALUES (@MaDH, 'PayOS', @Total, 'Success', @TxnCode)", conn, trans);
                        cmdTT.Parameters.AddWithValue("@MaDH", maDH);
                        cmdTT.Parameters.AddWithValue("@Total", total);
                        cmdTT.Parameters.AddWithValue("@TxnCode", "PAYOS_" + DateTime.Now.Ticks.ToString());
                        cmdTT.ExecuteNonQuery();

                        trans.Commit();
                        
                        Session["tv_cart_count"] = 0; // Clear JS badge

                        // Redirect to Order Detail / Success Page
                        Response.Redirect("DonHang.aspx?id=" + maDH + "&success=1");
                    }
                    catch (Exception ex)
                    {
                        trans.Rollback();
                        lblError.Text = "⚠️ Lỗi khi xử lý thanh toán: " + ex.Message;
                        lblError.Visible = true;
                        pnlPayOS.Visible = false;
                    }
                }
            }
        }
    }
}
