<%@ Page Title="" Language="C#" MasterPageFile="~/QLNH.master" AutoEventWireup="true" CodeBehind="MonAn.aspx.cs" Inherits="TranTrongNhan_35011.MonAn" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <b>Chọn loại món ăn: </b>
    <asp:DropDownList ID="ddlLoai" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlLoai_SelectedIndexChanged">
    </asp:DropDownList>
    <br /><br />

    <asp:Label ID="lblTitle" runat="server" Text="DANH SÁCH MÓN ĂN" Font-Bold="true" Font-Size="Large" ForeColor="#8B0000"></asp:Label>
    <br /><br />

    <asp:GridView ID="gvMonAn" runat="server" AutoGenerateColumns="false" BorderWidth="1" CellPadding="5" Width="100%"
        HeaderStyle-BackColor="#8B0000" HeaderStyle-ForeColor="White" RowStyle-VerticalAlign="Middle">
        <Columns>
            <asp:TemplateField HeaderText="Hình Ảnh">
                <ItemTemplate>
                    <img src='Images/<%# Eval("HinhAnh") %>' width="80" height="60"
                        style="object-fit:cover"
                        onerror="this.src='Images/noimage.png'; this.onerror=null;" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="TenMon" HeaderText="Tên Món" />
            <asp:BoundField DataField="MoTa" HeaderText="Mô Tả" />
            <asp:BoundField DataField="DonGia" HeaderText="Đơn Giá" DataFormatString="{0:N0} đ" />
            <asp:BoundField DataField="TenLoaiMon" HeaderText="Loại Món" />
        </Columns>
    </asp:GridView>

    <asp:Label ID="lblNoData" runat="server" Text="Không có dữ liệu." Visible="false" ForeColor="Red"></asp:Label>

</asp:Content>
