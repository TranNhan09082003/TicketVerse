using System;
using System.Data;
using System.Data.SqlClient;
using TranTrongNhan_35011.Models;

namespace TranTrongNhan_35011
{
    public partial class DanhSachSuKien : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadLoai();

                // Check query string params
                string loai = Request.QueryString["loai"];
                string search = Request.QueryString["search"];

                if (!string.IsNullOrEmpty(loai))
                    ddlLoai.SelectedValue = loai;
                if (!string.IsNullOrEmpty(search))
                    txtSearch.Text = search;

                LoadEvents();
            }
        }

        private void LoadLoai()
        {
            using (SqlConnection conn = KetNoi.GetTicketVerseConnection())
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT MaLoai, TenLoai FROM LOAISUKIEN", conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                DataRow dr = dt.NewRow();
                dr["MaLoai"] = 0;
                dr["TenLoai"] = "-- Tất cả --";
                dt.Rows.InsertAt(dr, 0);

                ddlLoai.DataSource = dt;
                ddlLoai.DataTextField = "TenLoai";
                ddlLoai.DataValueField = "MaLoai";
                ddlLoai.DataBind();
            }
        }

        private void LoadEvents()
        {
            using (SqlConnection conn = KetNoi.GetTicketVerseConnection())
            {
                string sql = @"SELECT s.MaSK, s.TenSK, s.MoTa, s.DiaDiem, s.ThoiGianBatDau, 
                               s.HinhAnh, s.TrangThai, s.LuotXem,
                               l.TenLoai, l.Icon,
                               (SELECT MIN(GiaVe) FROM VE WHERE MaSK = s.MaSK) AS GiaMin
                               FROM SUKIEN s 
                               JOIN LOAISUKIEN l ON s.MaLoai = l.MaLoai 
                               WHERE 1=1";

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;

                // Filter by category
                string loai = ddlLoai.SelectedValue;
                if (!string.IsNullOrEmpty(loai) && loai != "0")
                {
                    sql += " AND s.MaLoai = @MaLoai";
                    cmd.Parameters.AddWithValue("@MaLoai", int.Parse(loai));
                }

                // Filter by status
                string trangThai = ddlTrangThai.SelectedValue;
                if (!string.IsNullOrEmpty(trangThai))
                {
                    sql += " AND s.TrangThai = @TrangThai";
                    cmd.Parameters.AddWithValue("@TrangThai", trangThai);
                }

                // Search
                string search = txtSearch.Text.Trim();
                if (!string.IsNullOrEmpty(search))
                {
                    sql += " AND (s.TenSK LIKE @Search OR s.MoTa LIKE @Search OR s.DiaDiem LIKE @Search)";
                    cmd.Parameters.AddWithValue("@Search", "%" + search + "%");
                }

                // Sort
                string sort = ddlSort.SelectedValue;
                switch (sort)
                {
                    case "popular":
                        sql += " ORDER BY s.LuotXem DESC";
                        break;
                    case "price_asc":
                        sql += " ORDER BY GiaMin ASC";
                        break;
                    case "price_desc":
                        sql += " ORDER BY GiaMin DESC";
                        break;
                    case "date_asc":
                        sql += " ORDER BY s.ThoiGianBatDau ASC";
                        break;
                    default:
                        sql += " ORDER BY s.NgayTao DESC";
                        break;
                }

                cmd.CommandText = sql;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                lblCount.Text = dt.Rows.Count.ToString();

                if (dt.Rows.Count > 0)
                {
                    rptEvents.DataSource = dt;
                    rptEvents.DataBind();
                    lblNoData.Visible = false;
                }
                else
                {
                    rptEvents.DataSource = null;
                    rptEvents.DataBind();
                    lblNoData.Visible = true;
                }
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            LoadEvents();
        }
    }
}
