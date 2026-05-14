using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using TranTrongNhan_35011.Models;

namespace TranTrongNhan_35011.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadKPIs();
                LoadRecentOrders();
                GenerateChartScript();
            }
        }

        private void LoadKPIs()
        {
            using (SqlConnection conn = KetNoi.GetTicketVerseConnection())
            {
                conn.Open();

                // Doanh thu (DaThanhToan)
                SqlCommand cmdRevenue = new SqlCommand("SELECT SUM(TongTien) FROM DONHANG WHERE TrangThai = 'DaThanhToan'", conn);
                object revObj = cmdRevenue.ExecuteScalar();
                lblDoanhThu.Text = revObj != DBNull.Value ? Convert.ToDecimal(revObj).ToString("N0") + "đ" : "0đ";

                // Vé đã bán (tổng số lượng trong CHITIETDONHANG của đơn DaThanhToan)
                SqlCommand cmdTickets = new SqlCommand(@"SELECT SUM(c.SoLuong) FROM CHITIETDONHANG c 
                                                         JOIN DONHANG d ON c.MaDH = d.MaDH 
                                                         WHERE d.TrangThai = 'DaThanhToan'", conn);
                object tktObj = cmdTickets.ExecuteScalar();
                lblVeBan.Text = tktObj != DBNull.Value ? Convert.ToInt32(tktObj).ToString("N0") : "0";

                // Số sự kiện đang bán
                SqlCommand cmdEvents = new SqlCommand("SELECT COUNT(*) FROM SUKIEN WHERE TrangThai = 'DangBan'", conn);
                lblSuKien.Text = cmdEvents.ExecuteScalar().ToString();

                // Tổng khách hàng
                SqlCommand cmdUsers = new SqlCommand("SELECT COUNT(*) FROM TAIKHOAN WHERE VaiTro = 'KhachHang'", conn);
                lblKhachHang.Text = cmdUsers.ExecuteScalar().ToString();

                conn.Close();
            }
        }

        private void LoadRecentOrders()
        {
            using (SqlConnection conn = KetNoi.GetTicketVerseConnection())
            {
                string sql = "SELECT TOP 5 MaDonPayOS, NgayDat, TongTien, TrangThai FROM DONHANG ORDER BY NgayDat DESC";
                SqlDataAdapter da = new SqlDataAdapter(sql, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptRecentOrders.DataSource = dt;
                rptRecentOrders.DataBind();
            }
        }

        private void GenerateChartScript()
        {
            // Trong thực tế, bạn sẽ query GROUP BY CAST(NgayDat AS DATE)
            // Để demo, chúng ta tạo dữ liệu mẫu 7 ngày gần nhất
            StringBuilder script = new StringBuilder();
            script.AppendLine("<script>");
            script.AppendLine("document.addEventListener('DOMContentLoaded', function() {");
            script.AppendLine("  const ctx = document.getElementById('revenueChart').getContext('2d');");
            
            // Lấy 7 ngày gần nhất để làm label
            string[] labels = new string[7];
            for (int i = 6; i >= 0; i--) {
                labels[6 - i] = "'" + DateTime.Now.AddDays(-i).ToString("dd/MM") + "'";
            }
            
            // Dữ liệu mẫu (mỗi ngày random 5tr -> 25tr)
            Random rnd = new Random();
            string[] data = new string[7];
            for (int i = 0; i < 7; i++) {
                data[i] = rnd.Next(5000000, 25000000).ToString();
            }

            script.AppendLine($"  const labels = [{string.Join(",", labels)}];");
            script.AppendLine($"  const data = [{string.Join(",", data)}];");
            
            script.AppendLine(@"
  new Chart(ctx, {
    type: 'doughnut',
    data: {
      labels: labels,
      datasets: [{
        label: 'Doanh thu (VNĐ)',
        data: data,
        backgroundColor: [
            '#FF6B6B', '#4ECDC4', '#45B7D1', '#96CEB4', 
            '#FFEEAD', '#D4A5A5', '#9B59B6'
        ],
        borderWidth: 2,
        hoverOffset: 10
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      cutout: '60%',
      plugins: {
        legend: { position: 'right' }
      }
    }
  });
});
</script>");

            litChartData.Text = script.ToString();
        }
    }
}
