<%@ Page Title="Liên Hệ" Language="C#" MasterPageFile="~/TicketVerse.master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="TranTrongNhan_35011.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <!-- Hero Section -->
    <div style="background:var(--grad-primary); padding:100px 40px 80px; text-align:center; color:white;">
        <div style="font-size:64px; margin-bottom:16px;">💌</div>
        <h1 style="font-family:'Outfit'; font-size:48px; font-weight:900; margin-bottom:16px;">
            Liên Hệ TicketVerse
        </h1>
        <p style="font-size:18px; opacity:0.9;">
            Bạn có câu hỏi hoặc cần hỗ trợ? Đừng ngần ngại liên hệ với chúng tôi!
        </p>
    </div>

    <!-- Contact Content -->
    <div style="max-width:1280px; margin:60px auto; padding:0 40px; display:grid; grid-template-columns:1fr 1fr; gap:60px;">
        
        <!-- Left: Contact Info -->
        <div>
            <h2 style="font-family:'Outfit'; font-size:32px; margin-bottom:24px;">Thông Tin Liên Hệ</h2>
            <p style="color:var(--clr-text2); margin-bottom:40px; font-size:16px; line-height:1.6;">
                TicketVerse luôn sẵn sàng lắng nghe và giải đáp mọi thắc mắc của bạn về việc đặt vé, hoàn hủy, hoặc hợp tác bán vé trên nền tảng.
            </p>

            <div style="display:grid; gap:24px;">
                <!-- Info 1 -->
                <div style="display:flex; gap:20px;">
                    <div style="width:56px; height:56px; border-radius:16px; background:rgba(102,126,234,0.1); color:var(--clr-primary); font-size:24px; display:flex; align-items:center; justify-content:center;">
                        📍
                    </div>
                    <div>
                        <div style="font-weight:700; font-size:18px; margin-bottom:4px;">Địa Chỉ Trụ Sở</div>
                        <div style="color:var(--clr-text2); font-size:15px;">236B Lê Văn Sỹ, Phường 1, Tân Bình, TP.HCM</div>
                    </div>
                </div>

                <!-- Info 2 -->
                <div style="display:flex; gap:20px;">
                    <div style="width:56px; height:56px; border-radius:16px; background:rgba(255,107,107,0.1); color:var(--clr-pink); font-size:24px; display:flex; align-items:center; justify-content:center;">
                        📞
                    </div>
                    <div>
                        <div style="font-weight:700; font-size:18px; margin-bottom:4px;">Hotline Hỗ Trợ</div>
                        <div style="color:var(--clr-text2); font-size:15px;">1900 3501 (8:00 - 22:00)</div>
                    </div>
                </div>

                <!-- Info 3 -->
                <div style="display:flex; gap:20px;">
                    <div style="width:56px; height:56px; border-radius:16px; background:rgba(0,230,118,0.1); color:#00E676; font-size:24px; display:flex; align-items:center; justify-content:center;">
                        ✉️
                    </div>
                    <div>
                        <div style="font-weight:700; font-size:18px; margin-bottom:4px;">Email Support</div>
                        <div style="color:var(--clr-text2); font-size:15px;">support@ticketverse.vn</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right: Contact Form -->
        <div style="background:white; border-radius:24px; padding:40px; box-shadow:0 20px 60px rgba(0,0,0,0.05);">
            <h3 style="font-family:'Outfit'; font-size:24px; margin-bottom:24px;">Gửi tin nhắn cho chúng tôi</h3>
            
            <asp:Label ID="lblMsg" runat="server" Visible="false" style="display:block; padding:16px; border-radius:12px; margin-bottom:24px; font-weight:600;"></asp:Label>

            <div style="margin-bottom:16px;">
                <label class="tv-label">Họ và Tên</label>
                <asp:TextBox ID="txtName" runat="server" CssClass="tv-input" placeholder="Ví dụ: Nguyễn Văn A" />
            </div>

            <div style="margin-bottom:16px;">
                <label class="tv-label">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="tv-input" placeholder="Ví dụ: email@gmail.com" />
            </div>

            <div style="margin-bottom:16px;">
                <label class="tv-label">Chủ Đề</label>
                <asp:DropDownList ID="ddlSubject" runat="server" CssClass="tv-input">
                    <asp:ListItem Value="HoTro" Text="Hỗ trợ đặt vé" />
                    <asp:ListItem Value="HopTac" Text="Hợp tác kinh doanh" />
                    <asp:ListItem Value="BaoLoi" Text="Báo lỗi website" />
                    <asp:ListItem Value="Khac" Text="Khác" />
                </asp:DropDownList>
            </div>

            <div style="margin-bottom:24px;">
                <label class="tv-label">Nội Dung</label>
                <asp:TextBox ID="txtContent" runat="server" CssClass="tv-input" TextMode="MultiLine" Rows="4" placeholder="Nhập tin nhắn của bạn..." />
            </div>

            <asp:Button ID="btnSend" runat="server" Text="Gửi Tin Nhắn 🚀" OnClick="btnSend_Click" CssClass="tv-btn tv-btn-primary" style="width:100%; justify-content:center; padding:16px; font-size:16px;" />
        </div>

    </div>

</asp:Content>
