<%@ Page Title="Danh Sách Sự Kiện" Language="C#" MasterPageFile="~/TicketVerse.master" AutoEventWireup="true" CodeBehind="DanhSachSuKien.aspx.cs" Inherits="TranTrongNhan_35011.DanhSachSuKien" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- HEADER -->
    <section class="tv-hero" style="min-height:280px; padding:60px 40px 50px;">
        <div class="tv-blob tv-blob-1"></div>
        <div class="tv-blob tv-blob-2"></div>
        <div class="tv-hero-content">
            <h1>🎯 Khám Phá Sự Kiện</h1>
            <p>Tìm kiếm và lọc sự kiện phù hợp với bạn</p>
        </div>
    </section>

    <!-- FILTER BAR -->
    <div style="max-width:1280px; margin:-30px auto 0; padding:0 40px; position:relative; z-index:10;">
        <div style="background:white; border-radius:20px; padding:24px 32px; box-shadow:0 8px 30px rgba(102,126,234,0.12); display:flex; flex-wrap:wrap; gap:16px; align-items:flex-end;">
            <div style="flex:1; min-width:200px;">
                <label class="tv-label">🔍 Tìm kiếm</label>
                <asp:TextBox ID="txtSearch" runat="server" CssClass="tv-input" placeholder="Tên sự kiện..." />
            </div>
            <div style="min-width:180px;">
                <label class="tv-label">📂 Loại sự kiện</label>
                <asp:DropDownList ID="ddlLoai" runat="server" CssClass="tv-input" />
            </div>
            <div style="min-width:160px;">
                <label class="tv-label">📊 Trạng thái</label>
                <asp:DropDownList ID="ddlTrangThai" runat="server" CssClass="tv-input">
                    <asp:ListItem Value="" Text="-- Tất cả --" />
                    <asp:ListItem Value="DangBan" Text="🟢 Đang bán" />
                    <asp:ListItem Value="SapDienRa" Text="🔵 Sắp diễn ra" />
                    <asp:ListItem Value="HetVe" Text="🔴 Hết vé" />
                </asp:DropDownList>
            </div>
            <div style="min-width:150px;">
                <label class="tv-label">💰 Sắp xếp</label>
                <asp:DropDownList ID="ddlSort" runat="server" CssClass="tv-input">
                    <asp:ListItem Value="newest" Text="Mới nhất" />
                    <asp:ListItem Value="popular" Text="Phổ biến nhất" />
                    <asp:ListItem Value="price_asc" Text="Giá tăng dần" />
                    <asp:ListItem Value="price_desc" Text="Giá giảm dần" />
                    <asp:ListItem Value="date_asc" Text="Sắp diễn ra" />
                </asp:DropDownList>
            </div>
            <div>
                <asp:Button ID="btnFilter" runat="server" Text="Lọc →" OnClick="btnFilter_Click"
                    CssClass="tv-btn tv-btn-primary" style="padding:14px 28px;" />
            </div>
        </div>
    </div>

    <!-- RESULTS -->
    <section class="tv-section">
        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:24px;">
            <p style="color:var(--clr-text2);">
                Tìm thấy <strong><asp:Label ID="lblCount" runat="server" Text="0" /></strong> sự kiện
            </p>
        </div>

        <div class="tv-events-grid">
            <asp:Repeater ID="rptEvents" runat="server">
                <ItemTemplate>
                    <a href='ChiTietSuKien.aspx?id=<%# Eval("MaSK") %>' class="tv-event-card tv-reveal">
                        <div class="tv-event-card-img-wrap">
                            <img src='Assets/images/events/<%# Eval("HinhAnh") %>' alt='<%# Eval("TenSK") %>' class="tv-event-card-img"
                                onerror="this.src='Assets/images/events/default-event.jpg';" />
                            <span class='tv-event-card-badge <%# Eval("TrangThai").ToString()=="DangBan" ? "hot" : "soon" %>'>
                                <%# Eval("TrangThai").ToString()=="DangBan" ? "🎫 Đang bán" : "⏰ Sắp tới" %>
                            </span>
                        </div>
                        <div class="tv-event-card-body">
                            <div class="tv-event-card-cat">
                                <%# Eval("Icon") %> <%# Eval("TenLoai") %>
                            </div>
                            <h3 class="tv-event-card-title"><%# Eval("TenSK") %></h3>
                            <div class="tv-event-card-meta">
                                <span>📅 <%# Eval("ThoiGianBatDau", "{0:dd/MM/yyyy HH:mm}") %></span>
                                <span>📍 <%# Eval("DiaDiem") %></span>
                                <span>👁️ <%# Eval("LuotXem", "{0:N0}") %> lượt xem</span>
                            </div>
                            <div class="tv-event-card-footer">
                                <div class="tv-event-card-price">
                                    <%# Eval("GiaMin", "{0:N0}") %> đ
                                    <small>từ</small>
                                </div>
                                <span class="tv-btn-buy">Xem Chi Tiết →</span>
                            </div>
                        </div>
                    </a>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <asp:Label ID="lblNoData" runat="server" Visible="false"
            style="display:block; text-align:center; padding:60px; color:var(--clr-text2); font-size:18px;">
            😔 Không tìm thấy sự kiện nào phù hợp.
        </asp:Label>
    </section>

</asp:Content>
