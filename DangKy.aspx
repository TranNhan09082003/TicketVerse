<%@ Page Title="Đăng Ký" Language="C#" MasterPageFile="~/TicketVerse.master" AutoEventWireup="true" CodeBehind="DangKy.aspx.cs" Inherits="TranTrongNhan_35011.DangKy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="tv-auth-page" style="margin-top: 70px;">
        <div class="tv-auth-card" style="max-width:480px;">
            <div style="text-align:center; font-size:48px; margin-bottom:12px;">🎉</div>
            <h2>Tạo Tài Khoản</h2>
            <p class="tv-subtitle">Tham gia TicketVerse ngay hôm nay!</p>

            <asp:Label ID="lblError" runat="server" Visible="false"
                style="display:block; text-align:center; margin-bottom:16px; padding:12px; background:#ffebee; border-radius:12px; font-size:14px; color:#c62828;"></asp:Label>
            <asp:Label ID="lblSuccess" runat="server" Visible="false"
                style="display:block; text-align:center; margin-bottom:16px; padding:12px; background:#e8f5e9; border-radius:12px; font-size:14px; color:#2e7d32;"></asp:Label>

            <div class="tv-form-group">
                <label class="tv-label">👤 Họ và tên</label>
                <asp:TextBox ID="txtHoTen" runat="server" CssClass="tv-input" placeholder="Nguyễn Văn A" />
            </div>
            <div class="tv-form-group">
                <label class="tv-label">📧 Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="tv-input" placeholder="email@example.com" TextMode="Email" />
            </div>
            <div class="tv-form-group">
                <label class="tv-label">📱 Số điện thoại</label>
                <asp:TextBox ID="txtPhone" runat="server" CssClass="tv-input" placeholder="0901234567" />
            </div>
            <div class="tv-form-group">
                <label class="tv-label">🔒 Mật khẩu</label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="tv-input" placeholder="Tối thiểu 6 ký tự" TextMode="Password" />
            </div>
            <div class="tv-form-group">
                <label class="tv-label">🔒 Xác nhận mật khẩu</label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="tv-input" placeholder="Nhập lại mật khẩu" TextMode="Password" />
            </div>
            <div style="margin-top: 24px;">
                <asp:Button ID="btnRegister" runat="server" Text="Đăng Ký →" OnClick="btnRegister_Click"
                    CssClass="tv-btn tv-btn-secondary" style="width:100%; justify-content:center; font-size:16px; padding:16px;" />
            </div>
            <p style="text-align:center; margin-top:24px; color:var(--clr-text2); font-size:14px;">
                Đã có tài khoản? <a href="DangNhap.aspx" style="color:var(--clr-primary); font-weight:600;">Đăng nhập</a>
            </p>
        </div>
    </div>
</asp:Content>
