<%@ Page Title="Trang Chủ" Language="C#" MasterPageFile="~/TicketVerse.master" AutoEventWireup="true" CodeBehind="TrangChu.aspx.cs" Inherits="TranTrongNhan_35011.TrangChu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- HERO SECTION -->
    <section class="tv-hero">
        <div class="tv-blob tv-blob-1"></div>
        <div class="tv-blob tv-blob-2"></div>
        <div class="tv-blob tv-blob-3"></div>
        <div class="tv-hero-content">
            <h1>✨ Khám Phá Trải Nghiệm<br/>Đỉnh Cao Giải Trí ✨</h1>
            <p>Concert, Workshop, Thể thao, Lễ hội — Tất cả trong tầm tay bạn</p>
            <div class="tv-hero-search">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="" placeholder="Tìm sự kiện bạn yêu thích..." />
                <asp:Button ID="btnSearch" runat="server" Text="🔍 Tìm kiếm" OnClick="btnSearch_Click" />
            </div>
        </div>
    </section>

    <!-- CATEGORY PILLS -->
    <div class="tv-categories">
        <asp:Repeater ID="rptCategories" runat="server">
            <ItemTemplate>
                <a href='DanhSachSuKien.aspx?loai=<%# Eval("MaLoai") %>' class="tv-cat-pill">
                    <span class="tv-cat-icon"><%# Eval("Icon") %></span>
                    <%# Eval("TenLoai") %>
                </a>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <!-- HOT EVENTS -->
    <section class="tv-section">
        <div class="tv-section-header">
            <span class="tv-emoji">🔥</span>
            <h2>Sự Kiện Hot Nhất</h2>
            <p>Đừng bỏ lỡ những sự kiện được yêu thích nhất</p>
        </div>
        <div class="tv-events-grid">
            <asp:Repeater ID="rptHotEvents" runat="server">
                <ItemTemplate>
                    <a href='ChiTietSuKien.aspx?id=<%# Eval("MaSK") %>' class="tv-event-card tv-reveal">
                        <div class="tv-event-card-img-wrap">
                            <img src='Assets/images/events/<%# Eval("HinhAnh") %>' alt='<%# Eval("TenSK") %>' class="tv-event-card-img"
                                onerror="this.src='Assets/images/events/default-event.jpg';" />
                            <span class="tv-event-card-badge hot">🔥 HOT</span>
                        </div>
                        <div class="tv-event-card-body">
                            <div class="tv-event-card-cat">
                                <%# Eval("Icon") %> <%# Eval("TenLoai") %>
                            </div>
                            <h3 class="tv-event-card-title"><%# Eval("TenSK") %></h3>
                            <div class="tv-event-card-meta">
                                <span>📅 <%# Eval("ThoiGianBatDau", "{0:dd/MM/yyyy HH:mm}") %></span>
                                <span>📍 <%# Eval("DiaDiem") %></span>
                            </div>
                            <div class="tv-event-card-footer">
                                <div class="tv-event-card-price">
                                    <%# Eval("GiaMin", "{0:N0}") %> đ
                                    <small>từ</small>
                                </div>
                                <span class="tv-btn-buy">Mua Vé →</span>
                            </div>
                        </div>
                    </a>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </section>

    <!-- COUNTDOWN -->
    <section class="tv-section" style="padding-top: 0;">
        <asp:Panel ID="pnlCountdown" runat="server">
            <div class="tv-countdown-section" data-countdown="">
                <div class="tv-countdown-info">
                    <p style="font-size: 14px; opacity: 0.7; margin-bottom: 4px;">⏰ SẮP DIỄN RA</p>
                    <h3><asp:Label ID="lblCountdownTitle" runat="server" /></h3>
                    <p><asp:Label ID="lblCountdownInfo" runat="server" /></p>
                    <div class="tv-countdown-timer">
                        <div class="tv-countdown-box"><span class="num">00</span><span class="label">Ngày</span></div>
                        <div class="tv-countdown-box"><span class="num">00</span><span class="label">Giờ</span></div>
                        <div class="tv-countdown-box"><span class="num">00</span><span class="label">Phút</span></div>
                        <div class="tv-countdown-box"><span class="num">00</span><span class="label">Giây</span></div>
                    </div>
                    <br />
                    <a href="#" id="lnkCountdownEvent" runat="server" class="tv-btn tv-btn-primary">Mua Vé Ngay →</a>
                </div>
            </div>
        </asp:Panel>
    </section>

    <!-- UPCOMING EVENTS -->
    <section class="tv-section">
        <div class="tv-section-header">
            <span class="tv-emoji">🎯</span>
            <h2>Sắp Diễn Ra</h2>
            <p>Đặt vé ngay trước khi hết!</p>
        </div>
        <div class="tv-events-grid">
            <asp:Repeater ID="rptUpcoming" runat="server">
                <ItemTemplate>
                    <a href='ChiTietSuKien.aspx?id=<%# Eval("MaSK") %>' class="tv-event-card tv-reveal">
                        <div class="tv-event-card-img-wrap">
                            <img src='Assets/images/events/<%# Eval("HinhAnh") %>' alt='<%# Eval("TenSK") %>' class="tv-event-card-img"
                                onerror="this.src='Assets/images/events/default-event.jpg';" />
                            <span class="tv-event-card-badge soon">⏰ Sắp tới</span>
                        </div>
                        <div class="tv-event-card-body">
                            <div class="tv-event-card-cat">
                                <%# Eval("Icon") %> <%# Eval("TenLoai") %>
                            </div>
                            <h3 class="tv-event-card-title"><%# Eval("TenSK") %></h3>
                            <div class="tv-event-card-meta">
                                <span>📅 <%# Eval("ThoiGianBatDau", "{0:dd/MM/yyyy HH:mm}") %></span>
                                <span>📍 <%# Eval("DiaDiem") %></span>
                            </div>
                            <div class="tv-event-card-footer">
                                <div class="tv-event-card-price">
                                    <%# Eval("GiaMin", "{0:N0}") %> đ
                                    <small>từ</small>
                                </div>
                                <span class="tv-btn-buy">Mua Vé →</span>
                            </div>
                        </div>
                    </a>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </section>

    <!-- STATS -->
    <section class="tv-stats">
        <div class="tv-stat tv-reveal">
            <div class="tv-stat-num" data-count="1200" data-suffix="+">0</div>
            <div class="tv-stat-label">Vé Đã Bán</div>
        </div>
        <div class="tv-stat tv-reveal">
            <div class="tv-stat-num" data-count="50" data-suffix="+">0</div>
            <div class="tv-stat-label">Sự Kiện</div>
        </div>
        <div class="tv-stat tv-reveal">
            <div class="tv-stat-num" data-count="500" data-suffix="+">0</div>
            <div class="tv-stat-label">Đánh Giá 5 Sao</div>
        </div>
        <div class="tv-stat tv-reveal">
            <div class="tv-stat-num" data-count="10000" data-suffix="+">0</div>
            <div class="tv-stat-label">Người Dùng</div>
        </div>
    </section>

</asp:Content>
