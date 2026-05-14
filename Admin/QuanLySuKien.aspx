<%@ Page Title="Quản Lý Sự Kiện" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeBehind="QuanLySuKien.aspx.cs" Inherits="TranTrongNhan_35011.Admin.QuanLySuKien" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="display:flex; justify-content:space-between; align-items:flex-end; margin-bottom:24px;">
        <div>
            <h1 class="admin-title" style="margin-bottom:8px;">Quản Lý Sự Kiện</h1>
            <p style="color:var(--clr-text2); margin:0;">Thêm, sửa, xóa các sự kiện trên hệ thống</p>
        </div>
        <div>
            <asp:Button ID="btnAdd" runat="server" Text="+ Thêm Sự Kiện Mới" OnClick="btnAdd_Click" CssClass="tv-btn tv-btn-primary" />
        </div>
    </div>

    <!-- Error/Success Message -->
    <asp:Label ID="lblMessage" runat="server" Visible="false" style="display:block; margin-bottom:20px; padding:12px 20px; border-radius:12px; font-weight:600;"></asp:Label>

    <div class="admin-card" style="padding:0; overflow:hidden;">
        <div style="padding:24px; border-bottom:1px solid var(--clr-border); display:flex; gap:16px;">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="tv-input" placeholder="Tìm tên sự kiện..." style="max-width:300px;" />
            <asp:Button ID="btnSearch" runat="server" Text="Tìm Kiếm" OnClick="btnSearch_Click" CssClass="tv-btn tv-btn-secondary" style="padding:10px 20px;" />
        </div>

        <div style="overflow-x:auto;">
            <asp:GridView ID="gvSuKien" runat="server" AutoGenerateColumns="False" CssClass="admin-table"
                DataKeyNames="MaSK" OnRowCommand="gvSuKien_RowCommand" OnRowDeleting="gvSuKien_RowDeleting"
                GridLines="None">
                <Columns>
                    <asp:BoundField DataField="MaSK" HeaderText="ID" ItemStyle-Width="50px" />
                    <asp:TemplateField HeaderText="Sự Kiện">
                        <ItemTemplate>
                            <div style="display:flex; align-items:center; gap:12px;">
                                <img src='../Assets/images/events/<%# Eval("HinhAnh") %>' style="width:48px; height:48px; border-radius:8px; object-fit:cover;" onerror="this.src='../Assets/images/events/default-event.jpg';" />
                                <div>
                                    <div style="font-weight:600;"><%# Eval("TenSK") %></div>
                                    <div style="font-size:12px; color:var(--clr-text2);"><%# Eval("TenLoai") %></div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="ThoiGianBatDau" HeaderText="Thời Gian" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                    <asp:BoundField DataField="LuotXem" HeaderText="Lượt Xem" DataFormatString="{0:N0}" />
                    <asp:TemplateField HeaderText="Trạng Thái">
                        <ItemTemplate>
                            <span class='tv-badge <%# Eval("TrangThai").ToString() == "DangBan" ? "tv-badge-success" : "tv-badge-danger" %>'>
                                <%# Eval("TrangThai").ToString() == "DangBan" ? "Đang bán" : (Eval("TrangThai").ToString() == "SapDienRa" ? "Sắp tới" : "Hết vé") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Thao Tác" ItemStyle-Width="150px">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditEvent" CommandArgument='<%# Eval("MaSK") %>' style="color:var(--clr-primary); margin-right:12px; text-decoration:none; font-weight:600;">Sửa</asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("MaSK") %>' style="color:var(--clr-pink); text-decoration:none; font-weight:600;" OnClientClick="return confirm('Bạn có chắc chắn muốn xóa sự kiện này không?');">Xóa</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div style="padding:40px; text-align:center; color:var(--clr-text2);">
                        Không có dữ liệu sự kiện nào.
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
