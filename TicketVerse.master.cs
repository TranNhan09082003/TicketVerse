using System;
using System.Web.UI;

namespace TranTrongNhan_35011
{
    public partial class TicketVerseMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckLoginStatus();
            }
        }

        private void CheckLoginStatus()
        {
            if (Session["MaTK"] != null)
            {
                pnlGuest.Visible = false;
                pnlUser.Visible = true;
                lblUserName.Text = Session["HoTen"]?.ToString() ?? "User";
            }
            else
            {
                pnlGuest.Visible = true;
                pnlUser.Visible = false;
            }
        }
    }
}
