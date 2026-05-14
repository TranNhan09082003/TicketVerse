using System;
using System.Web.UI;
using System.Web.UI.HtmlControls;

namespace TranTrongNhan_35011.Admin
{
    public partial class AdminMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Bảo mật: Phải là Admin mới được vào
            if (Session["MaTK"] == null || Session["VaiTro"]?.ToString() != "Admin")
            {
                Response.Redirect("~/DangNhap.aspx");
                return;
            }

            if (!IsPostBack)
            {
                lblAdminName.Text = Session["HoTen"]?.ToString();
                SetActiveMenu();
            }
        }

        private void SetActiveMenu()
        {
            string url = Request.Url.AbsolutePath.ToLower();
            if (url.Contains("dashboard")) menuDashboard.Attributes["class"] = "active";
            else if (url.Contains("sukien")) menuSuKien.Attributes["class"] = "active";
            else if (url.Contains("donhang")) menuDonHang.Attributes["class"] = "active";
            else if (url.Contains("nguoidung")) menuNguoiDung.Attributes["class"] = "active";
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/TrangChu.aspx");
        }
    }
}
