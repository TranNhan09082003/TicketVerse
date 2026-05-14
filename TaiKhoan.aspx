<%@ Page Title="Tài Khoản & Lịch Sử" Language="C#" MasterPageFile="~/TicketVerse.master" AutoEventWireup="true" CodeBehind="TaiKhoan.aspx.cs" Inherits="TranTrongNhan_35011.TaiKhoan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="max-width:1280px; margin:100px auto 0; padding:0 40px;">
        
        <div style="display:grid; grid-template-columns:300px 1fr; gap:40px;">
            
            <!-- LEFT: Profile Sidebar -->
            <div>
                <div style="background:white; border-radius:20px; padding:32px; box-shadow:var(--sh-card); text-align:center;">
                    <div style="width:100px; height:100px; border-radius:50%; background:var(--grad-fun); color:white; font-size:40px; display:flex; align-items:center; justify-content:center; margin:0 auto 16px;">
                        👤
                    </div>
                    <h2 style="font-family:'Outfit'; font-size:24px; margin-bottom:4px;">
                        <asp:Label ID="lblHoTen" runat="server" />
                    </h2>
                    <p style="color:var(--clr-text2); margin-bottom:24px;">
                        <asp:Label ID="lblEmail" runat="server" />
                    </p>
                    
                    <hr style="border:none; border-top:1px solid var(--clr-border); margin:0 0 24px;" />
                    
                    <div style="text-align:left; margin-bottom:24px; display:grid; gap:12px;">
                        <div>
                            <div style="font-size:12px; color:var(--clr-text2);">SĐT</div>
                            <div style="font-weight:600;"><asp:Label ID="lblPhone" runat="server" /></div>
                        </div>
                        <div>
                            <div style="font-size:12px; color:var(--clr-text2);">Thành viên từ</div>
                            <div style="font-weight:600;"><asp:Label ID="lblNgayTao" runat="server" /></div>
                        </div>
                    </div>
                    
                    <asp:Button ID="btnLogout" runat="server" Text="Đăng Xuất" OnClick="btnLogout_Click"
                        CssClass="tv-btn tv-btn-secondary" style="width:100%; justify-content:center; background:#ffebee; color:#c62828;" />
                </div>
            </div>

            <!-- RIGHT: Order History -->
            <div>
                <h1 style="font-family:'Outfit'; font-size:32px; margin-bottom:24px;">📜 Lịch Sử Đơn Hàng</h1>
                
                <asp:Repeater ID="rptOrders" runat="server">
                    <ItemTemplate>
                        <div style="background:white; border-radius:20px; padding:24px; box-shadow:var(--sh-card); margin-bottom:20px; display:flex; justify-content:space-between; align-items:center;">
                            <div>
                                <div style="display:flex; align-items:center; gap:12px; margin-bottom:8px;">
                                    <span style="font-family:'Outfit'; font-weight:800; font-size:18px;">#<%# Eval("MaDonPayOS") %></span>
                                    <span class='tv-badge <%# Eval("TrangThai").ToString() == "DaThanhToan" ? "tv-badge-success" : "tv-badge-danger" %>'>
                                        <%# Eval("TrangThai").ToString() == "DaThanhToan" ? "✓ Đã thanh toán" : "⌛ Chờ thanh toán" %>
                                    </span>
                                </div>
                                <div style="color:var(--clr-text2); font-size:14px; margin-bottom:8px;">
                                    Ngày đặt: <%# Eval("NgayDat", "{0:dd/MM/yyyy HH:mm}") %>
                                </div>
                                <div style="font-weight:600; color:var(--clr-primary);">
                                    <%# Eval("SoLuongVe") %> vé điện tử
                                </div>
                            </div>
                            <div style="text-align:right;">
                                <div style="font-size:13px; color:var(--clr-text2); margin-bottom:4px;">Tổng tiền</div>
                                <div style="font-family:'Outfit'; font-size:24px; font-weight:800; color:var(--clr-pink); margin-bottom:12px;">
                                    <%# Eval("TongTien", "{0:N0}") %> đ
                                </div>
                                <a href='DonHang.aspx?id=<%# Eval("MaDH") %>' class="tv-btn tv-btn-primary" style="padding:8px 20px; font-size:14px;">
                                    Xem Vé →
                                </a>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <asp:Label ID="lblNoOrders" runat="server" Visible="false"
                    style="display:block; text-align:center; padding:60px 20px; background:white; border-radius:20px; color:var(--clr-text2); font-size:16px;">
                    Bạn chưa có đơn hàng nào.<br /><br />
                    <a href="DanhSachSuKien.aspx" class="tv-btn tv-btn-primary">Khám Phá Sự Kiện Ngay</a>
                </asp:Label>
            </div>
            
        </div>
    </div>
</asp:Content>
