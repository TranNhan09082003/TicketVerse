<%@ Page Title="Giỏ Hàng" Language="C#" MasterPageFile="~/TicketVerse.master" AutoEventWireup="true" CodeBehind="GioHang.aspx.cs" Inherits="TranTrongNhan_35011.GioHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div style="max-width:1280px; margin:100px auto 0; padding:0 40px;">
        <h1 style="font-family:'Outfit'; font-size:32px; margin-bottom:32px;">🛒 Giỏ Hàng</h1>

        <asp:Panel ID="pnlEmpty" runat="server" Visible="false"
            style="text-align:center; padding:80px 20px; background:white; border-radius:20px; box-shadow:var(--sh-card);">
            <div style="font-size:64px; margin-bottom:16px;">🎫</div>
            <h2 style="font-family:'Outfit'; margin-bottom:8px;">Giỏ hàng trống</h2>
            <p style="color:var(--clr-text2); margin-bottom:24px;">Hãy khám phá các sự kiện hấp dẫn!</p>
            <a href="DanhSachSuKien.aspx" class="tv-btn tv-btn-primary">Khám Phá Sự Kiện →</a>
        </asp:Panel>

        <asp:Panel ID="pnlCart" runat="server">
            <div style="display:grid; grid-template-columns:1fr 360px; gap:32px;">
                <!-- Cart Items -->
                <div>
                    <asp:Repeater ID="rptCart" runat="server" OnItemCommand="rptCart_ItemCommand">
                        <ItemTemplate>
                            <div class="tv-cart-item">
                                <img src='Assets/images/events/<%# Eval("HinhAnh") %>' alt=""
                                    onerror="this.src='Assets/images/events/default-event.jpg';" />
                                <div style="flex:1;">
                                    <div style="font-weight:700; margin-bottom:4px;"><%# Eval("TenSK") %></div>
                                    <div style="font-size:13px; color:var(--clr-text2);">
                                        <span style="display:inline-flex; align-items:center; gap:4px;">
                                            <span style="width:8px; height:8px; border-radius:50%; background:<%# Eval("MauSac") %>; display:inline-block;"></span>
                                            <%# Eval("TenLoaiVe") %>
                                        </span>
                                    </div>
                                    <div style="font-family:'Outfit'; font-weight:700; color:var(--clr-pink); margin-top:8px;">
                                        <%# Eval("GiaVe", "{0:N0}") %> đ × <%# Eval("SoLuong") %>
                                    </div>
                                </div>
                                <div style="text-align:right;">
                                    <div style="font-family:'Outfit'; font-size:20px; font-weight:800; color:var(--clr-primary); margin-bottom:8px;">
                                        <%# Eval("ThanhTien", "{0:N0}") %> đ
                                    </div>
                                    <asp:LinkButton ID="btnRemove" runat="server" CommandName="Remove"
                                        CommandArgument='<%# Eval("MaGH") %>'
                                        style="color:var(--clr-pink); font-size:13px; font-weight:600;"
                                        OnClientClick="return confirm('Xóa vé này khỏi giỏ hàng?');">
                                        🗑️ Xóa
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <!-- Summary -->
                <div class="tv-cart-summary">
                    <h3 style="font-family:'Outfit'; font-size:20px; margin-bottom:24px;">📋 Tóm Tắt Đơn Hàng</h3>
                    <div style="display:flex; justify-content:space-between; margin-bottom:12px; font-size:15px;">
                        <span style="color:var(--clr-text2);">Số lượng vé:</span>
                        <strong><asp:Label ID="lblTotalQty" runat="server" /></strong>
                    </div>
                    <hr style="border:none; border-top:1px solid var(--clr-border); margin:16px 0;" />
                    <div style="display:flex; justify-content:space-between; margin-bottom:24px;">
                        <span style="font-size:18px; font-weight:700;">Tổng cộng:</span>
                        <span style="font-family:'Outfit'; font-size:24px; font-weight:800; color:var(--clr-pink);">
                            <asp:Label ID="lblTotalPrice" runat="server" /> đ
                        </span>
                    </div>
                    <asp:Button ID="btnCheckout" runat="server" Text="Thanh Toán →" OnClick="btnCheckout_Click"
                        CssClass="tv-btn tv-btn-primary" style="width:100%; justify-content:center; font-size:16px; padding:16px;" />
                    <a href="DanhSachSuKien.aspx" style="display:block; text-align:center; margin-top:16px; color:var(--clr-primary); font-weight:600; font-size:14px;">
                        ← Tiếp tục mua sắm
                    </a>
                </div>
            </div>
        </asp:Panel>
    </div>

</asp:Content>
