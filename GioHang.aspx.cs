using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using TranTrongNhan_35011.Models;

namespace TranTrongNhan_35011
{
    public partial class GioHang : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["MaTK"] == null)
            {
                Response.Redirect("DangNhap.aspx?url=GioHang.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadCart();
            }
        }

        private void LoadCart()
        {
            int maTK = int.Parse(Session["MaTK"].ToString());

            using (SqlConnection conn = KetNoi.GetTicketVerseConnection())
            {
                string sql = @"SELECT g.MaGH, g.SoLuong, v.TenLoaiVe, v.GiaVe, v.MauSac,
                               s.TenSK, s.HinhAnh, (g.SoLuong * v.GiaVe) AS ThanhTien
                               FROM GIOHANG g
                               JOIN VE v ON g.MaVe = v.MaVe
                               JOIN SUKIEN s ON v.MaSK = s.MaSK
                               WHERE g.MaTK = @MaTK
                               ORDER BY g.NgayThem DESC";

                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@MaTK", maTK);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    pnlCart.Visible = true;
                    pnlEmpty.Visible = false;

                    rptCart.DataSource = dt;
                    rptCart.DataBind();

                    int totalQty = 0;
                    decimal totalPrice = 0;

                    foreach (DataRow row in dt.Rows)
                    {
                        totalQty += Convert.ToInt32(row["SoLuong"]);
                        totalPrice += Convert.ToDecimal(row["ThanhTien"]);
                    }

                    lblTotalQty.Text = totalQty.ToString();
                    lblTotalPrice.Text = totalPrice.ToString("N0");

                    // Update session for JS cart badge
                    Session["tv_cart_count"] = totalQty;
                    ClientScript.RegisterStartupScript(GetType(), "updateBadge", 
                        $"sessionStorage.setItem('tv_cart_count', {totalQty}); TicketCart.updateBadge();", true);
                }
                else
                {
                    pnlCart.Visible = false;
                    pnlEmpty.Visible = true;
                    
                    Session["tv_cart_count"] = 0;
                    ClientScript.RegisterStartupScript(GetType(), "updateBadgeZero", 
                        "sessionStorage.setItem('tv_cart_count', 0); TicketCart.updateBadge();", true);
                }
            }
        }

        protected void rptCart_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Remove")
            {
                int maGH = int.Parse(e.CommandArgument.ToString());
                int maTK = int.Parse(Session["MaTK"].ToString());

                using (SqlConnection conn = KetNoi.GetTicketVerseConnection())
                {
                    string sql = "DELETE FROM GIOHANG WHERE MaGH = @MaGH AND MaTK = @MaTK";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@MaGH", maGH);
                    cmd.Parameters.AddWithValue("@MaTK", maTK);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }

                LoadCart();
            }
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            Response.Redirect("ThanhToan.aspx");
        }
    }
}
