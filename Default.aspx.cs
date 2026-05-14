using System;
using System.Web.UI;

namespace TranTrongNhan_35011
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("TrangChu.aspx");
        }
    }
}