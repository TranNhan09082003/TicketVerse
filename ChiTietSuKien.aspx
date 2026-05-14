<%@ Page Title="Chi Tiết Sự Kiện" Language="C#" MasterPageFile="~/TicketVerse.master" AutoEventWireup="true" CodeBehind="ChiTietSuKien.aspx.cs" Inherits="TranTrongNhan_35011.ChiTietSuKien" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- BANNER -->
    <div style="margin-top:70px; position:relative; height:360px; overflow:hidden;">
        <asp:Image ID="imgBanner" runat="server" style="width:100%; height:100%; object-fit:cover; filter:brightness(0.6);"
            onerror="this.src='Assets/images/events/default-event.jpg';" />
        <div style="position:absolute; inset:0; background:linear-gradient(transparent 30%, rgba(0,0,0,0.8)); display:flex; align-items:flex-end; padding:40px;">
            <div style="color:white; max-width:800px;">
                <span class="tv-badge" style="background:rgba(255,255,255,0.2); color:white; backdrop-filter:blur(8px); margin-bottom:12px;">
                    <asp:Label ID="lblCatIcon" runat="server" /> <asp:Label ID="lblCatName" runat="server" />
                </span>
                <h1 style="font-family:'Outfit'; font-size:36px; font-weight:800; margin:12px 0 8px;">
                    <asp:Label ID="lblTenSK" runat="server" />
                </h1>
                <p style="opacity:0.9; font-size:16px;">
                    <asp:Label ID="lblMoTa" runat="server" />
                </p>
            </div>
        </div>
    </div>

    <!-- CONTENT -->
    <div style="max-width:1280px; margin:0 auto; padding:40px; display:grid; grid-template-columns:1fr 380px; gap:40px;">

        <!-- LEFT: Details -->
        <div>
            <!-- Event Info Cards -->
            <div style="display:grid; grid-template-columns:1fr 1fr; gap:16px; margin-bottom:32px;">
                <div style="background:white; padding:20px; border-radius:16px; box-shadow:var(--sh-card);">
                    <div style="font-size:13px; color:var(--clr-text2); margin-bottom:4px;">📅 Thời gian</div>
                    <div style="font-weight:700;"><asp:Label ID="lblThoiGian" runat="server" /></div>
                </div>
                <div style="background:white; padding:20px; border-radius:16px; box-shadow:var(--sh-card);">
                    <div style="font-size:13px; color:var(--clr-text2); margin-bottom:4px;">📍 Địa điểm</div>
                    <div style="font-weight:700;"><asp:Label ID="lblDiaDiem" runat="server" /></div>
                </div>
                <div style="background:white; padding:20px; border-radius:16px; box-shadow:var(--sh-card);">
                    <div style="font-size:13px; color:var(--clr-text2); margin-bottom:4px;">👁️ Lượt xem</div>
                    <div style="font-weight:700;"><asp:Label ID="lblLuotXem" runat="server" /></div>
                </div>
                <div style="background:white; padding:20px; border-radius:16px; box-shadow:var(--sh-card);">
                    <div style="font-size:13px; color:var(--clr-text2); margin-bottom:4px;">⭐ Đánh giá</div>
                    <div style="font-weight:700;"><asp:Label ID="lblRating" runat="server" /></div>
                </div>
            </div>

            <!-- Countdown -->
            <asp:Panel ID="pnlCountdown" runat="server">
                <div class="tv-countdown-section" style="margin:0 0 32px; padding:32px;">
                    <div class="tv-countdown-info" style="width:100%; text-align:center;">
                        <p style="font-size:14px; opacity:0.7; margin-bottom:4px;">⏰ SỰ KIỆN BẮT ĐẦU SAU</p>
                        <div class="tv-countdown-timer" style="justify-content:center; margin-top:16px;">
                            <div class="tv-countdown-box"><span class="num">00</span><span class="label">Ngày</span></div>
                            <div class="tv-countdown-box"><span class="num">00</span><span class="label">Giờ</span></div>
                            <div class="tv-countdown-box"><span class="num">00</span><span class="label">Phút</span></div>
                            <div class="tv-countdown-box"><span class="num">00</span><span class="label">Giây</span></div>
                        </div>
                    </div>
                </div>
            </asp:Panel>

            <!-- Description -->
            <div style="background:white; border-radius:20px; padding:32px; box-shadow:var(--sh-card); margin-bottom:32px;">
                <h2 style="font-family:'Outfit'; font-size:24px; margin-bottom:16px;">📝 Giới Thiệu Sự Kiện</h2>
                <div style="line-height:1.8; color:var(--clr-text2);">
                    <asp:Literal ID="litMoTaChiTiet" runat="server" />
                </div>
            </div>

            <!-- Reviews -->
            <div style="background:white; border-radius:20px; padding:32px; box-shadow:var(--sh-card);">
                <h2 style="font-family:'Outfit'; font-size:24px; margin-bottom:24px;">⭐ Đánh Giá</h2>
                <asp:Repeater ID="rptDanhGia" runat="server">
                    <ItemTemplate>
                        <div style="border-bottom:1px solid var(--clr-border); padding:16px 0;">
                            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:8px;">
                                <strong><%# Eval("HoTen") %></strong>
                                <span style="color:#FEE140; font-size:18px;"><%# new string('★', Convert.ToInt32(Eval("SoSao"))) + new string('☆', 5 - Convert.ToInt32(Eval("SoSao"))) %></span>
                            </div>
                            <p style="color:var(--clr-text2); margin:0;"><%# Eval("NoiDung") %></p>
                            <small style="color:#aaa;"><%# Eval("NgayDG", "{0:dd/MM/yyyy}") %></small>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:Label ID="lblNoReview" runat="server" Text="Chưa có đánh giá nào." Visible="false"
                    style="color:var(--clr-text2); display:block; text-align:center; padding:20px;" />
            </div>
        </div>

        <!-- RIGHT: Ticket Selection -->
        <div>
            <div style="background:white; border-radius:20px; padding:32px; box-shadow:var(--sh-card); position:sticky; top:90px;">
                <h3 style="font-family:'Outfit'; font-size:22px; margin-bottom:24px; text-align:center;">🎫 Chọn Vé</h3>

                <asp:Repeater ID="rptVe" runat="server">
                    <ItemTemplate>
                        <div style="border:2px solid var(--clr-border); border-radius:16px; padding:16px; margin-bottom:12px; transition:all 0.3s;"
                            onmouseover="this.style.borderColor='#667EEA'; this.style.transform='translateY(-2px)'"
                            onmouseout="this.style.borderColor='var(--clr-border)'; this.style.transform='none'">
                            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:8px;">
                                <span style="font-weight:700; display:flex; align-items:center; gap:8px;">
                                    <span style="width:12px; height:12px; border-radius:50%; background:<%# Eval("MauSac") %>; display:inline-block;"></span>
                                    <%# Eval("TenLoaiVe") %>
                                </span>
                                <span class="tv-badge <%# Convert.ToInt32(Eval("SoLuongConLai")) > 0 ? "tv-badge-success" : "tv-badge-danger" %>">
                                    <%# Convert.ToInt32(Eval("SoLuongConLai")) > 0 ? "Còn " + Eval("SoLuongConLai") + " vé" : "Hết vé" %>
                                </span>
                            </div>
                            <p style="font-size:13px; color:var(--clr-text2); margin:4px 0 12px;"><%# Eval("MoTa") %></p>
                            <div style="display:flex; justify-content:space-between; align-items:center;">
                                <span style="font-family:'Outfit'; font-size:22px; font-weight:800; color:var(--clr-pink);">
                                    <%# Eval("GiaVe", "{0:N0}") %> đ
                                </span>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <hr style="border:none; border-top:1px solid var(--clr-border); margin:20px 0;" />

                <div style="margin-bottom:16px;">
                    <label class="tv-label">Chọn loại vé</label>
                    <asp:DropDownList ID="ddlVe" runat="server" CssClass="tv-input" />
                </div>
                <div style="margin-bottom:20px;">
                    <label class="tv-label">Số lượng</label>
                    <asp:TextBox ID="txtSoLuong" runat="server" CssClass="tv-input" TextMode="Number" Text="1" />
                </div>

                <asp:Label ID="lblMsg" runat="server" Visible="false"
                    style="display:block; text-align:center; margin-bottom:12px; padding:10px; border-radius:12px; font-size:14px;" />

                <asp:Button ID="btnAddCart" runat="server" Text="🛒 Thêm Vào Giỏ Hàng" OnClick="btnAddCart_Click"
                    CssClass="tv-btn tv-btn-primary" style="width:100%; justify-content:center; font-size:16px; padding:16px;" />

                <a href="DanhSachSuKien.aspx" style="display:block; text-align:center; margin-top:16px; color:var(--clr-primary); font-weight:600; font-size:14px;">
                    ← Quay lại danh sách
                </a>
            </div>
        </div>
    </div>

</asp:Content>
