using System.Data.SqlClient;
using System.Configuration;

namespace TranTrongNhan_35011.Models
{
    public class KetNoi
    {
        // Connection cho project cũ (Quản Lý Nhà Hàng)
        public static SqlConnection GetConnection()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["QuanLyNhaHang"].ConnectionString;
            SqlConnection conn = new SqlConnection(connectionString);
            return conn;
        }

        // Connection cho TicketVerse
        public static SqlConnection GetTicketVerseConnection()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["TicketVerse"].ConnectionString;
            SqlConnection conn = new SqlConnection(connectionString);
            return conn;
        }
    }
}
