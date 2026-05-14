<%@ Page Title="Quản Lý Đơn Hàng" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="QuanLyDonHang.aspx.cs" Inherits="TranTrongNhan_35011.Admin.QuanLyDonHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="display:flex; justify-content:space-between; align-items:flex-end; margin-bottom:24px;">
        <div>
            <h1 class="admin-title" style="margin-bottom:8px;">Quản Lý Đơn Hàng</h1>
            <p style="color:var(--clr-text2); margin:0;">Theo dõi và xử lý giao dịch vé</p>
        </div>
    </div>

    <asp:Label ID="lblMessage" runat="server" Visible="false" style="display:block; margin-bottom:20px; padding:12px 20px; border-radius:12px; font-weight:600;"></asp:Label>

    <div class="admin-card" style="padding:0; overflow:hidden;">
        <div style="padding:24px; border-bottom:1px solid var(--clr-border); display:flex; gap:16px;">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="tv-input" placeholder="Mã đơn hàng PayOS..." style="max-width:300px;" />
            <asp:DropDownList ID="ddlTrangThai" runat="server" CssClass="tv-input" style="max-width:200px;">
                <asp:ListItem Value="" Text="-- Tất cả trạng thái --" />
                <asp:ListItem Value="DaThanhToan" Text="Đã thanh toán" />
                <asp:ListItem Value="ChoThanhToan" Text="Chờ thanh toán" />
                <asp:ListItem Value="DaHuy" Text="Đã hủy" />
            </asp:DropDownList>
            <asp:Button ID="btnSearch" runat="server" Text="Lọc" OnClick="btnSearch_Click" CssClass="tv-btn tv-btn-secondary" style="padding:10px 20px;" />
        </div>

        <div style="overflow-x:auto;">
            <asp:GridView ID="gvDonHang" runat="server" AutoGenerateColumns="False" CssClass="admin-table"
                DataKeyNames="MaDH" OnRowCommand="gvDonHang_RowCommand" GridLines="None">
                <Columns>
                    <asp:BoundField DataField="MaDonPayOS" HeaderText="Mã Đơn PayOS" ItemStyle-Font-Bold="True" />
                    <asp:BoundField DataField="HoTen" HeaderText="Khách Hàng" />
                    <asp:BoundField DataField="NgayDat" HeaderText="Ngày Đặt" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                    <asp:BoundField DataField="TongTien" HeaderText="Tổng Tiền" DataFormatString="{0:N0} đ" ItemStyle-Font-Bold="True" ItemStyle-ForeColor="#E1306C" />
                    <asp:TemplateField HeaderText="Trạng Thái">
                        <ItemTemplate>
                            <span class='tv-badge <%# Eval("TrangThai").ToString() == "DaThanhToan" ? "tv-badge-success" : (Eval("TrangThai").ToString() == "ChoThanhToan" ? "tv-badge-warning" : "tv-badge-danger") %>'>
                                <%# Eval("TrangThai").ToString() == "DaThanhToan" ? "Đã thanh toán" : (Eval("TrangThai").ToString() == "ChoThanhToan" ? "Chờ thanh toán" : "Đã hủy") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Thao Tác">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnView" runat="server" CommandName="ViewDetail" CommandArgument='<%# Eval("MaDH") %>' style="color:var(--clr-primary); text-decoration:none; font-weight:600;">Xem chi tiết</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div style="padding:40px; text-align:center; color:var(--clr-text2);">
                        Không tìm thấy đơn hàng nào.
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
