using System;
using System.Data;
using System.Data.SqlClient;
using TranTrongNhan_35011.Models;

namespace TranTrongNhan_35011
{
    public partial class QLNH : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadLoaiMon();
                LoadSoMonChinh();
            }
        }

        private void LoadLoaiMon()
        {
            SqlConnection conn = KetNoi.GetConnection();
            string sql = "SELECT MaLoaiMon, TenLoaiMon FROM LOAIMONAN";
            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            rptLoaiMon.DataSource = dt;
            rptLoaiMon.DataBind();
        }

        private void LoadSoMonChinh()
        {
            SqlConnection conn = KetNoi.GetConnection();
            string sql = "SELECT COUNT(*) FROM MONAN WHERE MaLoaiMon = (SELECT MaLoaiMon FROM LOAIMONAN WHERE TenLoaiMon = N'Món chính')";
            SqlCommand cmd = new SqlCommand(sql, conn);
            conn.Open();
            int soMon = (int)cmd.ExecuteScalar();
            conn.Close();
            lblSoMon.Text = soMon.ToString();
        }
    }
}
