<%@ Page Title="Thanh Toán & Đặt Vé" Language="C#" MasterPageFile="~/TicketVerse.master" AutoEventWireup="true" CodeBehind="ThanhToan.aspx.cs" Inherits="TranTrongNhan_35011.ThanhToan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="max-width:1280px; margin:100px auto 0; padding:0 40px;">
        <h1 style="font-family:'Outfit'; font-size:32px; margin-bottom:32px;">💳 Thanh Toán</h1>

        <asp:Label ID="lblError" runat="server" Visible="false"
            style="display:block; margin-bottom:24px; padding:16px; background:#ffebee; border-radius:12px; font-size:15px; color:#c62828;"></asp:Label>

        <div style="display:grid; grid-template-columns:1fr 400px; gap:40px;">
            
            <!-- Left: Payment Method & Details -->
            <div>
                <!-- Payment Method (PayOS) -->
                <div style="background:white; border-radius:20px; padding:32px; box-shadow:var(--sh-card); margin-bottom:32px;">
                    <h2 style="font-family:'Outfit'; font-size:20px; margin-bottom:24px; display:flex; align-items:center; gap:8px;">
                        <span>🏦</span> Phương thức thanh toán
                    </h2>
                    
                    <div style="border:2px solid #667EEA; border-radius:16px; padding:20px; background:rgba(102,126,234,0.05); cursor:pointer;">
                        <div style="display:flex; justify-content:space-between; align-items:center;">
                            <div style="display:flex; align-items:center; gap:16px;">
                                <div style="width:48px; height:48px; background:white; border-radius:12px; display:flex; align-items:center; justify-content:center; font-weight:900; font-family:'Outfit'; color:#667EEA; box-shadow:0 4px 12px rgba(0,0,0,0.05);">
                                    QR
                                </div>
                                <div>
                                    <div style="font-weight:700; font-size:16px; margin-bottom:4px;">Chuyển khoản VietQR / PayOS</div>
                                    <div style="color:var(--clr-text2); font-size:13px;">Quét mã QR bằng ứng dụng ngân hàng</div>
                                </div>
                            </div>
                            <div style="width:24px; height:24px; border-radius:50%; background:#667EEA; display:flex; align-items:center; justify-content:center; color:white;">✓</div>
                        </div>
                    </div>
                </div>

                <!-- User Details -->
                <div style="background:white; border-radius:20px; padding:32px; box-shadow:var(--sh-card);">
                    <h2 style="font-family:'Outfit'; font-size:20px; margin-bottom:24px; display:flex; align-items:center; gap:8px;">
                        <span>👤</span> Thông tin người nhận vé
                    </h2>
                    
                    <div style="display:grid; grid-template-columns:1fr 1fr; gap:20px;">
                        <div>
                            <label class="tv-label">Họ và tên</label>
                            <asp:TextBox ID="txtHoTen" runat="server" CssClass="tv-input" ReadOnly="true" style="background:#f8f9fa;" />
                        </div>
                        <div>
                            <label class="tv-label">Số điện thoại</label>
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="tv-input" ReadOnly="true" style="background:#f8f9fa;" />
                        </div>
                        <div style="grid-column: 1 / -1;">
                            <label class="tv-label">Email (Nhận vé điện tử)</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="tv-input" ReadOnly="true" style="background:#f8f9fa;" />
                        </div>
                        <div style="grid-column: 1 / -1;">
                            <label class="tv-label">Ghi chú thêm</label>
                            <asp:TextBox ID="txtGhiChu" runat="server" CssClass="tv-input" TextMode="MultiLine" Rows="2" placeholder="Yêu cầu đặc biệt..." />
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right: Order Summary -->
            <div>
                <div style="background:white; border-radius:20px; padding:32px; box-shadow:var(--sh-card); position:sticky; top:90px;">
                    <h3 style="font-family:'Outfit'; font-size:20px; margin-bottom:24px;">🧾 Đơn hàng của bạn</h3>
                    
                    <asp:Repeater ID="rptSummary" runat="server">
                        <ItemTemplate>
                            <div style="display:flex; justify-content:space-between; margin-bottom:16px; padding-bottom:16px; border-bottom:1px dashed var(--clr-border);">
                                <div>
                                    <div style="font-weight:600; font-size:14px; margin-bottom:4px;"><%# Eval("TenSK") %></div>
                                    <div style="font-size:12px; color:var(--clr-text2);">
                                        <%# Eval("TenLoaiVe") %> x <%# Eval("SoLuong") %>
                                    </div>
                                </div>
                                <div style="font-weight:700; font-family:'Outfit';">
                                    <%# Eval("ThanhTien", "{0:N0}") %> đ
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <div style="margin-top:24px;">
                        <div style="display:flex; justify-content:space-between; margin-bottom:12px; font-size:15px; color:var(--clr-text2);">
                            <span>Tạm tính:</span>
                            <span><asp:Label ID="lblTamTinh" runat="server" /> đ</span>
                        </div>
                        <div style="display:flex; justify-content:space-between; margin-bottom:16px; font-size:15px; color:var(--clr-text2);">
                            <span>Phí xuất vé (0%):</span>
                            <span>0 đ</span>
                        </div>
                        
                        <div style="padding:16px; background:rgba(254, 225, 64, 0.1); border-radius:12px; margin-bottom:24px;">
                            <div style="display:flex; justify-content:space-between; align-items:center;">
                                <span style="font-weight:700;">TỔNG TIỀN</span>
                                <span style="font-family:'Outfit'; font-size:26px; font-weight:800; color:var(--clr-pink);">
                                    <asp:Label ID="lblTongTien" runat="server" /> đ
                                </span>
                            </div>
                        </div>

                        <p style="font-size:12px; color:var(--clr-text2); text-align:center; margin-bottom:16px;">
                            Bằng việc bấm Đặt vé, bạn đồng ý với Điều khoản sử dụng của TicketVerse.
                        </p>

                        <asp:Button ID="btnConfirm" runat="server" Text="Xác Nhận & Đặt Vé →" OnClick="btnConfirm_Click"
                            CssClass="tv-btn tv-btn-primary" style="width:100%; justify-content:center; font-size:16px; padding:16px;" />
                    </div>
                </div>
            </div>

        </div>
    </div>

    <!-- MOCK PAYOS MODAL -->
    <asp:Panel ID="pnlPayOS" runat="server" Visible="false" style="position:fixed; inset:0; background:rgba(0,0,0,0.8); z-index:9999; display:flex; align-items:center; justify-content:center; backdrop-filter:blur(5px);">
        <div style="background:white; border-radius:24px; width:400px; padding:40px; text-align:center; position:relative; box-shadow:0 20px 60px rgba(0,0,0,0.3);">
            <div style="margin-bottom:20px;">
                <img src="https://payos.vn/wp-content/uploads/sites/13/2023/07/logo-payos.svg" alt="PayOS" style="height:32px;" />
            </div>
            <h3 style="font-family:'Outfit'; font-size:22px; margin-bottom:8px;">Quét mã để thanh toán</h3>
            <p style="color:var(--clr-text2); font-size:14px; margin-bottom:24px;">Mở ứng dụng ngân hàng và quét mã VietQR</p>
            
            <div style="background:#f8f9fa; padding:20px; border-radius:16px; margin-bottom:24px; border:1px solid #eee;">
                <!-- Giả lập QR code image -->
                <img src="https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=TicketVerse_Mock_Payment" alt="QR Code" style="width:200px; height:200px; border-radius:8px;" />
            </div>

            <div style="font-family:'Outfit'; font-size:28px; font-weight:800; color:var(--clr-pink); margin-bottom:8px;">
                <asp:Label ID="lblPayOSAmount" runat="server" /> đ
            </div>
            <p style="font-size:13px; color:var(--clr-text2); margin-bottom:24px;">Đơn hàng: <strong style="color:#333;"><asp:Label ID="lblPayOSCode" runat="server" /></strong></p>

            <asp:Button ID="btnSimulateSuccess" runat="server" Text="Đã Thanh Toán Thành Công" OnClick="btnSimulateSuccess_Click"
                CssClass="tv-btn tv-btn-primary" style="width:100%; justify-content:center;" />
                
            <div style="margin-top:16px;">
                <a href="GioHang.aspx" style="font-size:14px; color:var(--clr-text2); text-decoration:underline;">Hủy thanh toán</a>
            </div>
        </div>
    </asp:Panel>

</asp:Content>
