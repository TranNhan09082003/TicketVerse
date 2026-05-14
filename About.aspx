<%@ Page Title="Giới Thiệu" Language="C#" MasterPageFile="~/TicketVerse.master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="TranTrongNhan_35011.About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <!-- Hero Section -->
    <div style="background:var(--grad-fun); padding:100px 40px 80px; text-align:center; color:white; position:relative; overflow:hidden;">
        <!-- Decorative blobs -->
        <div style="position:absolute; width:300px; height:300px; background:rgba(255,255,255,0.1); border-radius:50%; top:-100px; left:-100px; filter:blur(40px);"></div>
        <div style="position:absolute; width:400px; height:400px; background:rgba(255,255,255,0.1); border-radius:50%; bottom:-200px; right:-100px; filter:blur(60px);"></div>
        
        <div style="position:relative; z-index:1; max-width:800px; margin:0 auto;">
            <div style="font-size:64px; margin-bottom:16px;">🚀</div>
            <h1 style="font-family:'Outfit'; font-size:48px; font-weight:900; margin-bottom:24px;">
                Về TicketVerse
            </h1>
            <p style="font-size:18px; opacity:0.9; line-height:1.6;">
                Chúng tôi không chỉ bán vé. Chúng tôi kết nối bạn với những trải nghiệm tuyệt vời nhất, những cảm xúc chân thật nhất và những kỷ niệm khó quên.
            </p>
        </div>
    </div>

    <!-- Sứ Mệnh & Tầm Nhìn -->
    <div style="max-width:1280px; margin:80px auto; padding:0 40px;">
        <div style="display:grid; grid-template-columns:1fr 1fr; gap:60px; align-items:center;">
            <div>
                <h2 style="font-family:'Outfit'; font-size:36px; margin-bottom:24px;">
                    Sứ mệnh của chúng tôi 🌟
                </h2>
                <p style="color:var(--clr-text2); font-size:16px; line-height:1.8; margin-bottom:24px;">
                    TicketVerse ra đời từ một ý tưởng trong đồ án môn học Kỹ thuật Thương mại Điện tử của nhóm 6 sinh viên đam mê công nghệ. Nhận thấy việc mua vé sự kiện hiện nay đôi khi còn phức tạp và nhàm chán, chúng tôi quyết định xây dựng một nền tảng "Colorful & Fun" - mang lại niềm vui ngay từ khoảnh khắc bạn đặt mua chiếc vé đầu tiên.
                </p>
                <div style="display:grid; gap:16px;">
                    <div style="display:flex; align-items:center; gap:16px; background:white; padding:16px 24px; border-radius:16px; box-shadow:var(--sh-card);">
                        <span style="font-size:24px;">⚡</span>
                        <span style="font-weight:600;">Giao dịch siêu tốc, an toàn tuyệt đối</span>
                    </div>
                    <div style="display:flex; align-items:center; gap:16px; background:white; padding:16px 24px; border-radius:16px; box-shadow:var(--sh-card);">
                        <span style="font-size:24px;">🎨</span>
                        <span style="font-weight:600;">Trải nghiệm người dùng đầy màu sắc</span>
                    </div>
                    <div style="display:flex; align-items:center; gap:16px; background:white; padding:16px 24px; border-radius:16px; box-shadow:var(--sh-card);">
                        <span style="font-size:24px;">🤝</span>
                        <span style="font-weight:600;">Hỗ trợ tận tâm 24/7</span>
                    </div>
                </div>
            </div>
            <div style="position:relative;">
                <img src="https://images.unsplash.com/photo-1492684223066-81342ee5ff30?w=800&q=80" alt="Sự kiện" style="width:100%; border-radius:24px; box-shadow:0 20px 40px rgba(0,0,0,0.1);" />
                <div style="position:absolute; bottom:-30px; left:-30px; background:white; padding:24px; border-radius:20px; box-shadow:var(--sh-card); display:flex; gap:16px; align-items:center;">
                    <div style="font-family:'Outfit'; font-size:40px; font-weight:900; color:var(--clr-primary);">10k+</div>
                    <div style="font-weight:600; color:var(--clr-text2); line-height:1.4;">Vé đã được<br />bán ra</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Team Section -->
    <div style="background:#f8f9fa; padding:80px 0;">
        <div style="max-width:1280px; margin:0 auto; padding:0 40px; text-align:center;">
            <h2 style="font-family:'Outfit'; font-size:36px; margin-bottom:16px;">Đội Ngũ Sáng Lập 👾</h2>
            <p style="color:var(--clr-text2); margin-bottom:60px; font-size:16px;">Những con người đứng sau dự án đồ án nhóm đầy tâm huyết này.</p>
            
            <div style="display:grid; grid-template-columns:repeat(3, 1fr); gap:40px;">
                <!-- Member 1 -->
                <div style="background:white; padding:40px 24px; border-radius:24px; box-shadow:var(--sh-card); transition:transform 0.3s;" onmouseover="this.style.transform='translateY(-10px)'" onmouseout="this.style.transform='none'">
                    <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Felix&backgroundColor=b6e3f4" alt="Team" style="width:120px; height:120px; border-radius:50%; margin-bottom:20px; box-shadow:0 10px 20px rgba(0,0,0,0.1);" />
                    <h3 style="font-family:'Outfit'; font-size:20px; margin-bottom:8px;">Trần Trọng Nhân</h3>
                    <p style="color:var(--clr-primary); font-weight:600; font-size:14px; margin-bottom:16px;">Project Manager / Fullstack</p>
                    <p style="color:var(--clr-text2); font-size:14px;">MSSV: 35011<br />Người khởi xướng TicketVerse</p>
                </div>

                <!-- Member 2 -->
                <div style="background:white; padding:40px 24px; border-radius:24px; box-shadow:var(--sh-card); transition:transform 0.3s;" onmouseover="this.style.transform='translateY(-10px)'" onmouseout="this.style.transform='none'">
                    <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Aneka&backgroundColor=ffdfbf" alt="Team" style="width:120px; height:120px; border-radius:50%; margin-bottom:20px; box-shadow:0 10px 20px rgba(0,0,0,0.1);" />
                    <h3 style="font-family:'Outfit'; font-size:20px; margin-bottom:8px;">Thành viên 2</h3>
                    <p style="color:var(--clr-primary); font-weight:600; font-size:14px; margin-bottom:16px;">Frontend Developer</p>
                    <p style="color:var(--clr-text2); font-size:14px;">Chuyên gia UI/UX<br />Tạo ra giao diện Colorful</p>
                </div>

                <!-- Member 3 -->
                <div style="background:white; padding:40px 24px; border-radius:24px; box-shadow:var(--sh-card); transition:transform 0.3s;" onmouseover="this.style.transform='translateY(-10px)'" onmouseout="this.style.transform='none'">
                    <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Jack&backgroundColor=c0aede" alt="Team" style="width:120px; height:120px; border-radius:50%; margin-bottom:20px; box-shadow:0 10px 20px rgba(0,0,0,0.1);" />
                    <h3 style="font-family:'Outfit'; font-size:20px; margin-bottom:8px;">Thành viên 3</h3>
                    <p style="color:var(--clr-primary); font-weight:600; font-size:14px; margin-bottom:16px;">Backend Developer</p>
                    <p style="color:var(--clr-text2); font-size:14px;">Phù thủy cơ sở dữ liệu<br />Xử lý logic giỏ hàng & thanh toán</p>
                </div>

                <!-- Member 4 -->
                <div style="background:white; padding:40px 24px; border-radius:24px; box-shadow:var(--sh-card); transition:transform 0.3s;" onmouseover="this.style.transform='translateY(-10px)'" onmouseout="this.style.transform='none'">
                    <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Mimi&backgroundColor=ffb6b9" alt="Team" style="width:120px; height:120px; border-radius:50%; margin-bottom:20px; box-shadow:0 10px 20px rgba(0,0,0,0.1);" />
                    <h3 style="font-family:'Outfit'; font-size:20px; margin-bottom:8px;">Thành viên 4</h3>
                    <p style="color:var(--clr-primary); font-weight:600; font-size:14px; margin-bottom:16px;">QA & Tester</p>
                    <p style="color:var(--clr-text2); font-size:14px;">Người tìm diệt bug<br />Đảm bảo chất lượng hệ thống</p>
                </div>

                <!-- Member 5 -->
                <div style="background:white; padding:40px 24px; border-radius:24px; box-shadow:var(--sh-card); transition:transform 0.3s;" onmouseover="this.style.transform='translateY(-10px)'" onmouseout="this.style.transform='none'">
                    <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Leo&backgroundColor=d1f4d9" alt="Team" style="width:120px; height:120px; border-radius:50%; margin-bottom:20px; box-shadow:0 10px 20px rgba(0,0,0,0.1);" />
                    <h3 style="font-family:'Outfit'; font-size:20px; margin-bottom:8px;">Thành viên 5</h3>
                    <p style="color:var(--clr-primary); font-weight:600; font-size:14px; margin-bottom:16px;">Business Analyst</p>
                    <p style="color:var(--clr-text2); font-size:14px;">Phân tích yêu cầu<br />Xây dựng kịch bản luồng User</p>
                </div>

                <!-- Member 6 -->
                <div style="background:white; padding:40px 24px; border-radius:24px; box-shadow:var(--sh-card); transition:transform 0.3s;" onmouseover="this.style.transform='translateY(-10px)'" onmouseout="this.style.transform='none'">
                    <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Chloe&backgroundColor=f4d1e6" alt="Team" style="width:120px; height:120px; border-radius:50%; margin-bottom:20px; box-shadow:0 10px 20px rgba(0,0,0,0.1);" />
                    <h3 style="font-family:'Outfit'; font-size:20px; margin-bottom:8px;">Thành viên 6</h3>
                    <p style="color:var(--clr-primary); font-weight:600; font-size:14px; margin-bottom:16px;">Content & Marketing</p>
                    <p style="color:var(--clr-text2); font-size:14px;">Chuẩn bị dữ liệu mẫu<br />Viết tài liệu báo cáo đồ án</p>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
