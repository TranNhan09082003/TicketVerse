<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Redirecting to TicketVerse...</title>
    <!-- Chuyển hướng ngay lập tức bằng HTML -->
    <meta http-equiv="refresh" content="0;url=TrangChu.aspx" />
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align: center; margin-top: 100px; font-family: sans-serif;">
            <h2>Đang chuyển hướng vào TicketVerse...</h2>
            <p>Nếu trình duyệt không tự chuyển, <a href="TrangChu.aspx">bấm vào đây</a>.</p>
            <script>
                // Chuyển hướng ngay lập tức bằng JavaScript
                window.location.href = "TrangChu.aspx";
            </script>
        </div>
    </form>
</body>
</html>
