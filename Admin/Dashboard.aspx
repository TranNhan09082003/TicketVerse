<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="TranTrongNhan_35011.Admin.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="display:flex; justify-content:space-between; align-items:flex-end; margin-bottom:24px;">
        <div>
            <h1 class="admin-title" style="margin-bottom:8px;">Tổng Quan (Dashboard)</h1>
            <p style="color:var(--clr-text2); margin:0;">Cập nhật số liệu mới nhất của hệ thống TicketVerse</p>
        </div>
    </div>

    <!-- KPI Cards -->
    <div style="display:grid; grid-template-columns:repeat(4, 1fr); gap:24px; margin-bottom:32px;">
        <div class="admin-card" style="margin:0; border-left:4px solid var(--clr-primary);">
            <div style="font-size:14px; color:var(--clr-text2); margin-bottom:8px;">Tổng Doanh Thu</div>
            <div style="font-family:'Outfit'; font-size:28px; font-weight:800; color:var(--clr-text);">
                <asp:Label ID="lblDoanhThu" runat="server" />
            </div>
        </div>
        <div class="admin-card" style="margin:0; border-left:4px solid var(--clr-pink);">
            <div style="font-size:14px; color:var(--clr-text2); margin-bottom:8px;">Vé Đã Bán</div>
            <div style="font-family:'Outfit'; font-size:28px; font-weight:800; color:var(--clr-text);">
                <asp:Label ID="lblVeBan" runat="server" />
            </div>
        </div>
        <div class="admin-card" style="margin:0; border-left:4px solid #00E676;">
            <div style="font-size:14px; color:var(--clr-text2); margin-bottom:8px;">Số Sự Kiện Mở Bán</div>
            <div style="font-family:'Outfit'; font-size:28px; font-weight:800; color:var(--clr-text);">
                <asp:Label ID="lblSuKien" runat="server" />
            </div>
        </div>
        <div class="admin-card" style="margin:0; border-left:4px solid #FEE140;">
            <div style="font-size:14px; color:var(--clr-text2); margin-bottom:8px;">Tổng Khách Hàng</div>
            <div style="font-family:'Outfit'; font-size:28px; font-weight:800; color:var(--clr-text);">
                <asp:Label ID="lblKhachHang" runat="server" />
            </div>
        </div>
    </div>

    <!-- Chart & Recent Orders -->
    <div style="display:grid; grid-template-columns:2fr 1fr; gap:24px;">
        
        <!-- Chart -->
        <div class="admin-card">
            <h3 style="font-family:'Outfit'; font-size:18px; margin-bottom:20px;">Biểu Đồ Doanh Thu 7 Ngày Gần Nhất</h3>
            <canvas id="revenueChart" style="width:100%; height:300px;"></canvas>
        </div>

        <!-- Recent Orders -->
        <div class="admin-card">
            <h3 style="font-family:'Outfit'; font-size:18px; margin-bottom:20px;">Đơn Hàng Mới Nhất</h3>
            <asp:Repeater ID="rptRecentOrders" runat="server">
                <ItemTemplate>
                    <div style="display:flex; justify-content:space-between; align-items:center; border-bottom:1px solid var(--clr-border); padding:12px 0;">
                        <div>
                            <div style="font-weight:600; margin-bottom:4px;">#<%# Eval("MaDonPayOS") %></div>
                            <div style="font-size:12px; color:var(--clr-text2);"><%# Eval("NgayDat", "{0:dd/MM HH:mm}") %></div>
                        </div>
                        <div style="text-align:right;">
                            <div style="font-weight:700; color:var(--clr-pink); margin-bottom:4px;"><%# Eval("TongTien", "{0:N0}") %>đ</div>
                            <span class='tv-badge <%# Eval("TrangThai").ToString() == "DaThanhToan" ? "tv-badge-success" : "tv-badge-danger" %>' style="font-size:11px; padding:2px 6px;">
                                <%# Eval("TrangThai").ToString() == "DaThanhToan" ? "Đã TT" : "Chờ" %>
                            </span>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <div style="text-align:center; margin-top:16px;">
                <a href="QuanLyDonHang.aspx" style="font-size:13px; color:var(--clr-primary); font-weight:600;">Xem tất cả →</a>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ScriptContent" runat="server">
    <!-- Inline data cho Chart.js -->
    <asp:Literal ID="litChartData" runat="server" />
</asp:Content>
