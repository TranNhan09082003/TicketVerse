<%@ Page Title="Chi Tiết Đơn Hàng" Language="C#" MasterPageFile="~/TicketVerse.master" AutoEventWireup="true" CodeBehind="DonHang.aspx.cs" Inherits="TranTrongNhan_35011.DonHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="max-width:1000px; margin:100px auto 0; padding:0 40px;">
        
        <!-- Success Banner -->
        <asp:Panel ID="pnlSuccess" runat="server" Visible="false" 
            style="background:linear-gradient(135deg, #00E676, #1DB954); color:white; padding:32px; border-radius:20px; text-align:center; margin-bottom:32px; box-shadow:0 10px 30px rgba(0,230,118,0.2);">
            <div style="font-size:48px; margin-bottom:12px;">🎉</div>
            <h1 style="font-family:'Outfit'; font-size:28px; margin-bottom:8px;">Thanh Toán Thành Công!</h1>
            <p style="font-size:16px; opacity:0.9;">Cảm ơn bạn đã mua vé tại TicketVerse. Dưới đây là vé điện tử của bạn.</p>
        </asp:Panel>

        <!-- Order Header -->
        <div style="display:flex; justify-content:space-between; align-items:flex-end; margin-bottom:24px;">
            <div>
                <h2 style="font-family:'Outfit'; font-size:28px; margin-bottom:8px;">
                    Đơn Hàng <asp:Label ID="lblMaDon" runat="server" style="color:var(--clr-primary);" />
                </h2>
                <div style="color:var(--clr-text2); font-size:15px;">
                    Ngày đặt: <asp:Label ID="lblNgayDat" runat="server" />
                </div>
            </div>
            <div style="text-align:right;">
                <div style="font-size:14px; color:var(--clr-text2); margin-bottom:4px;">Tổng thanh toán</div>
                <div style="font-family:'Outfit'; font-size:24px; font-weight:800; color:var(--clr-pink);">
                    <asp:Label ID="lblTongTien" runat="server" /> đ
                </div>
                <div style="display:inline-block; margin-top:8px; padding:4px 12px; background:#e8f5e9; color:#2e7d32; border-radius:8px; font-size:13px; font-weight:600;">
                    ✓ Đã thanh toán (PayOS)
                </div>
            </div>
        </div>

        <hr style="border:none; border-top:1px solid var(--clr-border); margin:32px 0;" />

        <!-- E-Tickets List -->
        <h3 style="font-family:'Outfit'; font-size:22px; margin-bottom:24px;">🎫 Vé Điện Tử Của Bạn</h3>
        
        <div style="display:grid; gap:24px;">
            <asp:Repeater ID="rptTickets" runat="server">
                <ItemTemplate>
                    <div style="background:white; border-radius:20px; display:flex; overflow:hidden; box-shadow:var(--sh-card); position:relative;">
                        
                        <!-- Left: Event Info -->
                        <div style="flex:1; padding:32px; display:flex; gap:24px; border-right:2px dashed var(--clr-border);">
                            <img src='Assets/images/events/<%# Eval("HinhAnh") %>' alt="" 
                                style="width:120px; height:120px; border-radius:12px; object-fit:cover;" 
                                onerror="this.src='Assets/images/events/default-event.jpg';" />
                            <div>
                                <div style="color:var(--clr-primary); font-weight:700; font-size:13px; margin-bottom:8px; text-transform:uppercase; letter-spacing:1px;">
                                    <%# Eval("TenLoaiVe") %>
                                </div>
                                <h4 style="font-family:'Outfit'; font-size:20px; margin-bottom:12px;"><%# Eval("TenSK") %></h4>
                                <div style="font-size:14px; color:var(--clr-text2); display:grid; gap:8px;">
                                    <span>📅 <%# Eval("ThoiGianBatDau", "{0:dd/MM/yyyy HH:mm}") %></span>
                                    <span>📍 <%# Eval("DiaDiem") %></span>
                                </div>
                            </div>
                        </div>

                        <!-- Right: QR Code -->
                        <div style="width:240px; background:#f8f9fa; padding:32px; display:flex; flex-direction:column; align-items:center; justify-content:center; text-align:center;">
                            <img src='https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=<%# Eval("MaQR") %>' alt="QR Ticket" 
                                style="width:120px; height:120px; border-radius:8px; margin-bottom:16px; mix-blend-mode:multiply;" />
                            <div style="font-family:monospace; font-size:14px; font-weight:700; letter-spacing:2px; color:var(--clr-text2);">
                                <%# Eval("MaQR") %>
                            </div>
                            <div style="font-size:12px; color:#888; margin-top:8px;">
                                Quét mã khi Check-in
                            </div>
                        </div>

                        <!-- Cutout circles to look like a ticket -->
                        <div style="position:absolute; width:40px; height:40px; background:var(--clr-bg); border-radius:50%; top:-20px; right:220px; box-shadow:inset 0 -5px 10px rgba(0,0,0,0.02);"></div>
                        <div style="position:absolute; width:40px; height:40px; background:var(--clr-bg); border-radius:50%; bottom:-20px; right:220px; box-shadow:inset 0 5px 10px rgba(0,0,0,0.02);"></div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <div style="text-align:center; margin-top:40px; margin-bottom:60px;">
            <a href="DanhSachSuKien.aspx" class="tv-btn tv-btn-secondary">Tiếp Tục Khám Phá Sự Kiện</a>
        </div>
    </div>
</asp:Content>
