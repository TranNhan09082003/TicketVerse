using System;
using System.Web.UI;

namespace TranTrongNhan_35011
{
    public partial class Contact : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtName.Text) || string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                lblMsg.Text = "❌ Vui lòng nhập đầy đủ Tên và Email!";
                lblMsg.Style["background"] = "#ffebee";
                lblMsg.Style["color"] = "#c62828";
                lblMsg.Visible = true;
                return;
            }

            // Demo logic
            lblMsg.Text = "✅ Cảm ơn " + txtName.Text + "! Chúng tôi đã nhận được tin nhắn và sẽ phản hồi sớm nhất.";
            lblMsg.Style["background"] = "#e8f5e9";
            lblMsg.Style["color"] = "#2e7d32";
            lblMsg.Visible = true;

            // Clear form
            txtName.Text = "";
            txtEmail.Text = "";
            txtContent.Text = "";
        }
    }
}