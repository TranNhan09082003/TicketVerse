<%@ Page Title="Quản Lý Người Dùng" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="QuanLyNguoiDung.aspx.cs" Inherits="TranTrongNhan_35011.Admin.QuanLyNguoiDung" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="display:flex; justify-content:space-between; align-items:flex-end; margin-bottom:24px;">
        <div>
            <h1 class="admin-title" style="margin-bottom:8px;">Quản Lý Người Dùng</h1>
            <p style="color:var(--clr-text2); margin:0;">Danh sách khách hàng và admin trên hệ thống</p>
        </div>
    </div>

    <div class="admin-card" style="padding:0; overflow:hidden;">
        <div style="padding:24px; border-bottom:1px solid var(--clr-border); display:flex; gap:16px;">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="tv-input" placeholder="Tìm tên hoặc email..." style="max-width:300px;" />
            <asp:Button ID="btnSearch" runat="server" Text="Tìm Kiếm" OnClick="btnSearch_Click" CssClass="tv-btn tv-btn-secondary" style="padding:10px 20px;" />
        </div>

        <div style="overflow-x:auto;">
            <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" CssClass="admin-table" GridLines="None">
                <Columns>
                    <asp:BoundField DataField="MaTK" HeaderText="ID" ItemStyle-Width="50px" />
                    <asp:TemplateField HeaderText="Người Dùng">
                        <ItemTemplate>
                            <div style="display:flex; align-items:center; gap:12px;">
                                <div style="width:40px; height:40px; border-radius:50%; background:var(--grad-fun); color:white; display:flex; align-items:center; justify-content:center; font-weight:700;">
                                    <%# Eval("HoTen").ToString().Substring(0, 1) %>
                                </div>
                                <div>
                                    <div style="font-weight:600;"><%# Eval("HoTen") %></div>
                                    <div style="font-size:12px; color:var(--clr-text2);"><%# Eval("Email") %></div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="SoDienThoai" HeaderText="Số Điện Thoại" />
                    <asp:BoundField DataField="NgayTao" HeaderText="Ngày Đăng Ký" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:TemplateField HeaderText="Vai Trò">
                        <ItemTemplate>
                            <span class='tv-badge <%# Eval("VaiTro").ToString() == "Admin" ? "tv-badge-danger" : "tv-badge-success" %>'>
                                <%# Eval("VaiTro") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div style="padding:40px; text-align:center; color:var(--clr-text2);">
                        Không tìm thấy người dùng nào.
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
