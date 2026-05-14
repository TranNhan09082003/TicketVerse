using System;
using System.Data;
using System.Data.SqlClient;
using TranTrongNhan_35011.Models;

namespace TranTrongNhan_35011
{
    public partial class MonAn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadLoai();
                string maLoai = Request.QueryString["maloai"];
                if (!string.IsNullOrEmpty(maLoai))
                    ddlLoai.SelectedValue = maLoai;
                LoadMonAn(ddlLoai.SelectedValue);
            }
        }

        private void LoadLoai()
        {
            SqlConnection conn = KetNoi.GetConnection();
            SqlDataAdapter da = new SqlDataAdapter("SELECT MaLoaiMon, TenLoaiMon FROM LOAIMONAN", conn);
            DataTable dt = new DataTable();
            da.Fill(dt);

            DataRow dr = dt.NewRow();
            dr["MaLoaiMon"] = 0;
            dr["TenLoaiMon"] = "-- Tất cả --";
            dt.Rows.InsertAt(dr, 0);

            ddlLoai.DataSource = dt;
            ddlLoai.DataTextField = "TenLoaiMon";
            ddlLoai.DataValueField = "MaLoaiMon";
            ddlLoai.DataBind();
        }

        private void LoadMonAn(string maLoai)
        {
            SqlConnection conn = KetNoi.GetConnection();
            string sql;
            if (maLoai == "0" || string.IsNullOrEmpty(maLoai))
            {
                sql = "SELECT m.TenMon, m.MoTa, m.DonGia, m.HinhAnh, l.TenLoaiMon FROM MONAN m JOIN LOAIMONAN l ON m.MaLoaiMon = l.MaLoaiMon";
                lblTitle.Text = "TẤT CẢ MÓN ĂN";
            }
            else
            {
                sql = "SELECT m.TenMon, m.MoTa, m.DonGia, m.HinhAnh, l.TenLoaiMon FROM MONAN m JOIN LOAIMONAN l ON m.MaLoaiMon = l.MaLoaiMon WHERE m.MaLoaiMon = " + maLoai;
                lblTitle.Text = "MÓN ĂN THEO LOẠI";
            }

            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                gvMonAn.DataSource = dt;
                gvMonAn.DataBind();
                lblNoData.Visible = false;
            }
            else
            {
                gvMonAn.DataSource = null;
                gvMonAn.DataBind();
                lblNoData.Visible = true;
            }
        }

        protected void ddlLoai_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadMonAn(ddlLoai.SelectedValue);
        }
    }
}
