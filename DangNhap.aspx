<%@ Page Title="Đăng Nhập" Language="C#" MasterPageFile="~/TicketVerse.master" AutoEventWireup="true" CodeBehind="DangNhap.aspx.cs" Inherits="TranTrongNhan_35011.DangNhap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="tv-auth-page" style="margin-top: 70px;">
        <div class="tv-auth-card">
            <div style="text-align:center; font-size:48px; margin-bottom:12px;">🎫</div>
            <h2>Đăng Nhập</h2>
            <p class="tv-subtitle">Chào mừng trở lại TicketVerse!</p>

            <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="false"
                style="display:block; text-align:center; margin-bottom:16px; padding:12px; background:#ffebee; border-radius:12px; font-size:14px;"></asp:Label>

            <div class="tv-form-group">
                <label class="tv-label">📧 Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="tv-input" placeholder="Nhập email của bạn" TextMode="Email" />
            </div>
            <div class="tv-form-group">
                <label class="tv-label">🔒 Mật khẩu</label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="tv-input" placeholder="Nhập mật khẩu" TextMode="Password" />
            </div>
            <div style="margin-top: 24px;">
                <asp:Button ID="btnLogin" runat="server" Text="Đăng Nhập →" OnClick="btnLogin_Click"
                    CssClass="tv-btn tv-btn-primary" style="width:100%; justify-content:center; font-size:16px; padding:16px;" />
            </div>
            <p style="text-align:center; margin-top:24px; color:var(--clr-text2); font-size:14px;">
                Chưa có tài khoản? <a href="DangKy.aspx" style="color:var(--clr-primary); font-weight:600;">Đăng ký ngay</a>
            </p>
        </div>
    </div>
</asp:Content>
