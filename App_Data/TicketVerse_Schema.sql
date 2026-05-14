-- =============================================
-- TICKETVERSE DATABASE SCHEMA
-- Sàn Mua Bán Vé Sự Kiện & Trải Nghiệm
-- =============================================

-- 1. LOẠI SỰ KIỆN
CREATE TABLE LOAISUKIEN (
    MaLoai INT IDENTITY(1,1) PRIMARY KEY,
    TenLoai NVARCHAR(100) NOT NULL,
    MoTa NVARCHAR(255),
    Icon NVARCHAR(10),
    MauSac NVARCHAR(7)
);

-- 2. TÀI KHOẢN
CREATE TABLE TAIKHOAN (
    MaTK INT IDENTITY(1,1) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    Email NVARCHAR(150) NOT NULL UNIQUE,
    MatKhau NVARCHAR(255) NOT NULL,
    SoDienThoai NVARCHAR(15),
    DiaChi NVARCHAR(255),
    AnhDaiDien NVARCHAR(255) DEFAULT 'default-avatar.png',
    VaiTro NVARCHAR(20) DEFAULT 'KhachHang',
    NgayTao DATETIME DEFAULT GETDATE()
);

-- 3. SỰ KIỆN
CREATE TABLE SUKIEN (
    MaSK INT IDENTITY(1,1) PRIMARY KEY,
    TenSK NVARCHAR(200) NOT NULL,
    MoTa NVARCHAR(500),
    MoTaChiTiet NTEXT,
    MaLoai INT FOREIGN KEY REFERENCES LOAISUKIEN(MaLoai),
    DiaDiem NVARCHAR(255),
    ThoiGianBatDau DATETIME NOT NULL,
    ThoiGianKetThuc DATETIME,
    HinhAnh NVARCHAR(255),
    HinhBanner NVARCHAR(255),
    TrangThai NVARCHAR(20) DEFAULT N'SapDienRa',
    LuotXem INT DEFAULT 0,
    NgayTao DATETIME DEFAULT GETDATE()
);

-- 4. VÉ
CREATE TABLE VE (
    MaVe INT IDENTITY(1,1) PRIMARY KEY,
    MaSK INT FOREIGN KEY REFERENCES SUKIEN(MaSK),
    TenLoaiVe NVARCHAR(50) NOT NULL,
    GiaVe DECIMAL(18,0) NOT NULL,
    SoLuongTong INT NOT NULL,
    SoLuongConLai INT NOT NULL,
    MoTa NVARCHAR(255),
    MauSac NVARCHAR(7) DEFAULT '#667EEA'
);

-- 5. GIỎ HÀNG
CREATE TABLE GIOHANG (
    MaGH INT IDENTITY(1,1) PRIMARY KEY,
    MaTK INT FOREIGN KEY REFERENCES TAIKHOAN(MaTK),
    MaVe INT FOREIGN KEY REFERENCES VE(MaVe),
    SoLuong INT DEFAULT 1,
    NgayThem DATETIME DEFAULT GETDATE()
);

-- 6. ĐƠN HÀNG
CREATE TABLE DONHANG (
    MaDH INT IDENTITY(1,1) PRIMARY KEY,
    MaTK INT FOREIGN KEY REFERENCES TAIKHOAN(MaTK),
    NgayDat DATETIME DEFAULT GETDATE(),
    TongTien DECIMAL(18,0) NOT NULL,
    TrangThai NVARCHAR(20) DEFAULT N'ChoThanhToan',
    MaDonPayOS NVARCHAR(100),
    GhiChu NVARCHAR(500)
);

-- 7. CHI TIẾT ĐƠN HÀNG
CREATE TABLE CHITIETDONHANG (
    MaCTDH INT IDENTITY(1,1) PRIMARY KEY,
    MaDH INT FOREIGN KEY REFERENCES DONHANG(MaDH),
    MaVe INT FOREIGN KEY REFERENCES VE(MaVe),
    SoLuong INT NOT NULL,
    DonGia DECIMAL(18,0) NOT NULL,
    MaQR NVARCHAR(100)
);

-- 8. THANH TOÁN
CREATE TABLE THANHTOAN (
    MaTT INT IDENTITY(1,1) PRIMARY KEY,
    MaDH INT FOREIGN KEY REFERENCES DONHANG(MaDH),
    PhuongThuc NVARCHAR(50) DEFAULT 'PayOS',
    SoTien DECIMAL(18,0) NOT NULL,
    TrangThai NVARCHAR(20) DEFAULT 'Pending',
    MaGiaoDich NVARCHAR(100),
    ThoiGian DATETIME DEFAULT GETDATE()
);

-- 9. ĐÁNH GIÁ
CREATE TABLE DANHGIA (
    MaDG INT IDENTITY(1,1) PRIMARY KEY,
    MaTK INT FOREIGN KEY REFERENCES TAIKHOAN(MaTK),
    MaSK INT FOREIGN KEY REFERENCES SUKIEN(MaSK),
    SoSao INT CHECK (SoSao BETWEEN 1 AND 5),
    NoiDung NVARCHAR(500),
    NgayDG DATETIME DEFAULT GETDATE()
);

-- =============================================
-- DỮ LIỆU MẪU
-- =============================================

-- Loại sự kiện
INSERT INTO LOAISUKIEN VALUES (N'Concert & Âm nhạc', N'Đêm nhạc, live show, festival âm nhạc', N'🎵', '#667EEA');
INSERT INTO LOAISUKIEN VALUES (N'Sân khấu & Kịch', N'Kịch nói, nhạc kịch, xiếc, múa', N'🎭', '#F093FB');
INSERT INTO LOAISUKIEN VALUES (N'Thể thao', N'Bóng đá, tennis, marathon, esports', N'⚽', '#4FACFE');
INSERT INTO LOAISUKIEN VALUES (N'Workshop & Học tập', N'Khóa học ngắn, hội thảo, seminar', N'🎓', '#FA709A');
INSERT INTO LOAISUKIEN VALUES (N'Lễ hội & Giải trí', N'Lễ hội ẩm thực, carnival, hội chợ', N'🎪', '#FEE140');
INSERT INTO LOAISUKIEN VALUES (N'Chiếu phim & Điện ảnh', N'Premiere, chiếu phim ngoài trời, film fest', N'🎬', '#00E676');

-- Tài khoản
INSERT INTO TAIKHOAN (HoTen, Email, MatKhau, SoDienThoai, VaiTro)
VALUES (N'Admin TicketVerse', 'admin@ticketverse.vn', 'admin123', '0901234567', 'Admin');
INSERT INTO TAIKHOAN (HoTen, Email, MatKhau, SoDienThoai, VaiTro)
VALUES (N'Nguyễn Văn An', 'an@gmail.com', '123456', '0912345678', 'KhachHang');
INSERT INTO TAIKHOAN (HoTen, Email, MatKhau, SoDienThoai, VaiTro)
VALUES (N'Trần Thị Bình', 'binh@gmail.com', '123456', '0923456789', 'KhachHang');
INSERT INTO TAIKHOAN (HoTen, Email, MatKhau, SoDienThoai, VaiTro)
VALUES (N'Lê Minh Châu', 'chau@gmail.com', '123456', '0934567890', 'KhachHang');
INSERT INTO TAIKHOAN (HoTen, Email, MatKhau, SoDienThoai, VaiTro)
VALUES (N'Phạm Đức Duy', 'duy@gmail.com', '123456', '0945678901', 'KhachHang');

-- Sự kiện
INSERT INTO SUKIEN (TenSK, MoTa, MoTaChiTiet, MaLoai, DiaDiem, ThoiGianBatDau, ThoiGianKetThuc, HinhAnh, HinhBanner, TrangThai, LuotXem)
VALUES (
    N'Sơn Tùng M-TP Live Concert 2026',
    N'Đêm nhạc hoành tráng với hàng loạt bản hit đình đám',
    N'<p>Sơn Tùng M-TP trở lại với concert quy mô lớn nhất năm 2026. Với dàn âm thanh hiện đại, sân khấu hoành tráng và hàng nghìn hiệu ứng ánh sáng, đây chắc chắn là sự kiện không thể bỏ lỡ.</p><p>Lineup: Sơn Tùng M-TP, các nghệ sĩ khách mời đặc biệt.</p>',
    1, N'Sân vận động Quốc gia Mỹ Đình, Hà Nội',
    '2026-07-20 19:00', '2026-07-20 23:00',
    'sontung-concert.jpg', 'sontung-banner.jpg', N'DangBan', 3500
);

INSERT INTO SUKIEN (TenSK, MoTa, MoTaChiTiet, MaLoai, DiaDiem, ThoiGianBatDau, ThoiGianKetThuc, HinhAnh, HinhBanner, TrangThai, LuotXem)
VALUES (
    N'V-League 2026: HAGL vs Hà Nội FC',
    N'Trận cầu kinh điển của bóng đá Việt Nam',
    N'<p>Đại chiến giữa hai gã khổng lồ của V-League. Trận đấu được mong chờ nhất mùa giải với Công Phượng và dàn sao trẻ tài năng.</p>',
    3, N'Sân vận động Pleiku, Gia Lai',
    '2026-06-15 17:30', '2026-06-15 19:30',
    'vleague-hagl.jpg', 'vleague-banner.jpg', N'DangBan', 2100
);

INSERT INTO SUKIEN (TenSK, MoTa, MoTaChiTiet, MaLoai, DiaDiem, ThoiGianBatDau, ThoiGianKetThuc, HinhAnh, HinhBanner, TrangThai, LuotXem)
VALUES (
    N'Workshop Barista - Nghệ Thuật Pha Cà Phê',
    N'Học pha cà phê chuyên nghiệp từ barista hàng đầu',
    N'<p>Workshop 3 giờ với barista quốc tế. Bạn sẽ học cách pha espresso, latte art, và cold brew tại nhà. Bao gồm nguyên liệu và dụng cụ.</p>',
    4, N'The Coffee House Lab, Quận 1, TP.HCM',
    '2026-06-08 09:00', '2026-06-08 12:00',
    'barista-workshop.jpg', 'barista-banner.jpg', N'DangBan', 890
);

INSERT INTO SUKIEN (TenSK, MoTa, MoTaChiTiet, MaLoai, DiaDiem, ThoiGianBatDau, ThoiGianKetThuc, HinhAnh, HinhBanner, TrangThai, LuotXem)
VALUES (
    N'Lễ Hội Ẩm Thực Đường Phố Sài Gòn 2026',
    N'100+ gian hàng ẩm thực từ khắp Việt Nam và quốc tế',
    N'<p>Lễ hội ẩm thực lớn nhất miền Nam quy tụ 100+ gian hàng. Có khu vực biểu diễn live music, trò chơi vận động, và food challenge.</p>',
    5, N'Công viên 23/9, Quận 1, TP.HCM',
    '2026-08-01 10:00', '2026-08-03 22:00',
    'food-festival.jpg', 'food-banner.jpg', N'SapDienRa', 5200
);

INSERT INTO SUKIEN (TenSK, MoTa, MoTaChiTiet, MaLoai, DiaDiem, ThoiGianBatDau, ThoiGianKetThuc, HinhAnh, HinhBanner, TrangThai, LuotXem)
VALUES (
    N'Nhạc Kịch "Tấm Cám" Phiên Bản Hiện Đại',
    N'Câu chuyện cổ tích Việt Nam trong diện mạo hoàn toàn mới',
    N'<p>Nhạc kịch Tấm Cám được dàn dựng với phong cách Broadway. Âm nhạc nguyên bản, vũ đạo hiện đại, và công nghệ sân khấu 3D mapping.</p>',
    2, N'Nhà hát Thành phố, Quận 1, TP.HCM',
    '2026-07-05 19:30', '2026-07-05 21:30',
    'tam-cam-musical.jpg', 'tam-cam-banner.jpg', N'DangBan', 1750
);

INSERT INTO SUKIEN (TenSK, MoTa, MoTaChiTiet, MaLoai, DiaDiem, ThoiGianBatDau, ThoiGianKetThuc, HinhAnh, HinhBanner, TrangThai, LuotXem)
VALUES (
    N'Premiere: Lật Mặt 9 - Nhà Sản Xuất Lý Hải',
    N'Suất chiếu đặc biệt với sự tham gia của đạo diễn và diễn viên',
    N'<p>Suất chiếu premiere Lật Mặt 9 với red carpet, giao lưu cùng Lý Hải và dàn diễn viên. Tặng poster có chữ ký cho 100 khán giả đầu tiên.</p>',
    6, N'CGV Vincom Đồng Khởi, TP.HCM',
    '2026-06-25 18:00', '2026-06-25 21:00',
    'lat-mat-9.jpg', 'lat-mat-banner.jpg', N'DangBan', 4100
);

INSERT INTO SUKIEN (TenSK, MoTa, MoTaChiTiet, MaLoai, DiaDiem, ThoiGianBatDau, ThoiGianKetThuc, HinhAnh, HinhBanner, TrangThai, LuotXem)
VALUES (
    N'Marathon Đà Nẵng 2026',
    N'Giải chạy marathon bên bờ biển đẹp nhất Việt Nam',
    N'<p>Giải marathon quốc tế qua cầu Rồng, bờ biển Mỹ Khê, và bán đảo Sơn Trà. Các cự ly: 5K, 10K, 21K, 42K. Có timing chip và huy chương finisher.</p>',
    3, N'Quảng trường 29/3, Đà Nẵng',
    '2026-09-14 04:30', '2026-09-14 12:00',
    'marathon-danang.jpg', 'marathon-banner.jpg', N'SapDienRa', 3200
);

INSERT INTO SUKIEN (TenSK, MoTa, MoTaChiTiet, MaLoai, DiaDiem, ThoiGianBatDau, ThoiGianKetThuc, HinhAnh, HinhBanner, TrangThai, LuotXem)
VALUES (
    N'Đen Vâu - Live in Đà Lạt',
    N'Đêm nhạc acoustic giữa rừng thông Đà Lạt',
    N'<p>Đen Vâu mang đến đêm nhạc acoustic intimate giữa rừng thông. Số lượng giới hạn 500 vé để đảm bảo trải nghiệm tốt nhất.</p>',
    1, N'Thung Lũng Tình Yêu, Đà Lạt',
    '2026-08-16 18:00', '2026-08-16 22:00',
    'denvau-dalat.jpg', 'denvau-banner.jpg', N'DangBan', 4800
);

INSERT INTO SUKIEN (TenSK, MoTa, MoTaChiTiet, MaLoai, DiaDiem, ThoiGianBatDau, ThoiGianKetThuc, HinhAnh, HinhBanner, TrangThai, LuotXem)
VALUES (
    N'Workshop UI/UX Design cho người mới bắt đầu',
    N'Từ zero tới hero trong 1 ngày với chuyên gia Google',
    N'<p>Workshop thực hành Figma, nguyên lý thiết kế, user research, và prototyping. Mỗi học viên sẽ hoàn thành 1 project portfolio cuối khóa.</p>',
    4, N'WeWork Bitexco, Quận 1, TP.HCM',
    '2026-06-22 08:30', '2026-06-22 17:30',
    'uiux-workshop.jpg', 'uiux-banner.jpg', N'DangBan', 650
);

INSERT INTO SUKIEN (TenSK, MoTa, MoTaChiTiet, MaLoai, DiaDiem, ThoiGianBatDau, ThoiGianKetThuc, HinhAnh, HinhBanner, TrangThai, LuotXem)
VALUES (
    N'Saigon Comic Con 2026',
    N'Lễ hội cosplay và văn hóa pop lớn nhất Đông Nam Á',
    N'<p>3 ngày lễ hội với 200+ booth trưng bày, cuộc thi cosplay quốc tế, giao lưu manga artist Nhật Bản, gaming zone, và khu vực mua sắm merchandise.</p>',
    5, N'SECC, Quận 7, TP.HCM',
    '2026-10-10 09:00', '2026-10-12 21:00',
    'comic-con.jpg', 'comic-con-banner.jpg', N'SapDienRa', 8900
);

INSERT INTO SUKIEN (TenSK, MoTa, MoTaChiTiet, MaLoai, DiaDiem, ThoiGianBatDau, ThoiGianKetThuc, HinhAnh, HinhBanner, TrangThai, LuotXem)
VALUES (
    N'Stand-up Comedy Night - Saigon Tếu',
    N'Đêm hài kịch cháy vé với các comedian hàng đầu',
    N'<p>Line-up: Xuân Nghị, Lê Nhân, Color Man và các comedian đang hot trên TikTok. 2 tiếng cười không ngớt với chủ đề đời sống GenZ.</p>',
    2, N'Soul Live Project, Quận 1, TP.HCM',
    '2026-06-28 20:00', '2026-06-28 22:00',
    'standup-comedy.jpg', 'standup-banner.jpg', N'DangBan', 1200
);

INSERT INTO SUKIEN (TenSK, MoTa, MoTaChiTiet, MaLoai, DiaDiem, ThoiGianBatDau, ThoiGianKetThuc, HinhAnh, HinhBanner, TrangThai, LuotXem)
VALUES (
    N'Liên Hoan Phim Ngắn Sinh Viên 2026',
    N'Nơi tỏa sáng của các nhà làm phim trẻ',
    N'<p>Chiếu 30 phim ngắn xuất sắc nhất từ các trường đại học. Có ban giám khảo chuyên nghiệp và giải thưởng trị giá 50 triệu đồng.</p>',
    6, N'Đại học Sân khấu Điện ảnh TP.HCM',
    '2026-07-12 08:00', '2026-07-13 20:00',
    'film-festival.jpg', 'film-banner.jpg', N'SapDienRa', 720
);

-- Vé cho các sự kiện
-- Sơn Tùng Concert (MaSK=1)
INSERT INTO VE VALUES (1, N'VVIP - Front Stage', 3500000, 200, 180, N'Khu vực sát sân khấu, quà tặng exclusive, meet & greet', '#FF6B6B');
INSERT INTO VE VALUES (1, N'VIP - Khán đài A', 2000000, 500, 420, N'Khán đài A tầm nhìn tốt, tặng lightstick', '#667EEA');
INSERT INTO VE VALUES (1, N'Standard', 800000, 2000, 1650, N'Khu vực đứng tự do', '#4FACFE');

-- V-League (MaSK=2)
INSERT INTO VE VALUES (2, N'VIP - Khán đài chính', 500000, 300, 250, N'Khán đài chính có mái che', '#FF6B6B');
INSERT INTO VE VALUES (2, N'Thường', 150000, 5000, 4200, N'Khán đài phụ', '#4FACFE');

-- Barista Workshop (MaSK=3)
INSERT INTO VE VALUES (3, N'Tiêu chuẩn', 450000, 30, 22, N'Bao gồm nguyên liệu và dụng cụ mang về', '#FA709A');

-- Food Festival (MaSK=4)
INSERT INTO VE VALUES (4, N'VIP Pass 3 ngày', 350000, 500, 500, N'Ra vào tự do 3 ngày, tặng voucher 200k', '#FF6B6B');
INSERT INTO VE VALUES (4, N'Vé ngày', 120000, 3000, 3000, N'Vé vào cổng 1 ngày', '#4FACFE');

-- Tấm Cám Musical (MaSK=5)
INSERT INTO VE VALUES (5, N'Hạng A', 1200000, 100, 85, N'Hàng 1-5, trung tâm', '#FF6B6B');
INSERT INTO VE VALUES (5, N'Hạng B', 800000, 200, 170, N'Hàng 6-12', '#667EEA');
INSERT INTO VE VALUES (5, N'Hạng C', 400000, 300, 260, N'Hàng 13-20, hai bên', '#4FACFE');

-- Lật Mặt 9 Premiere (MaSK=6)
INSERT INTO VE VALUES (6, N'Premiere VIP', 500000, 100, 70, N'Hàng đầu, giao lưu đạo diễn, tặng poster ký tên', '#FF6B6B');
INSERT INTO VE VALUES (6, N'Premiere Standard', 250000, 200, 150, N'Ghế ngồi tiêu chuẩn, popcorn combo', '#4FACFE');

-- Marathon (MaSK=7)
INSERT INTO VE VALUES (7, N'42K Full Marathon', 800000, 1000, 1000, N'Áo chạy, BIB, huy chương finisher, timing chip', '#FF6B6B');
INSERT INTO VE VALUES (7, N'21K Half Marathon', 600000, 2000, 2000, N'Áo chạy, BIB, huy chương, timing chip', '#667EEA');
INSERT INTO VE VALUES (7, N'10K Fun Run', 350000, 3000, 3000, N'Áo chạy, BIB, huy chương', '#4FACFE');
INSERT INTO VE VALUES (7, N'5K Cộng Đồng', 200000, 5000, 5000, N'Áo chạy và BIB', '#00E676');

-- Đen Vâu Đà Lạt (MaSK=8)
INSERT INTO VE VALUES (8, N'Golden Circle', 1500000, 100, 80, N'Khu vực gần sân khấu nhất, camping VIP', '#FF6B6B');
INSERT INTO VE VALUES (8, N'General', 600000, 400, 320, N'Khu vực tự do, mang theo thảm ngồi', '#4FACFE');

-- UI/UX Workshop (MaSK=9)
INSERT INTO VE VALUES (9, N'Tiêu chuẩn', 350000, 40, 28, N'Bao gồm lunch, coffee break, certificate', '#FA709A');

-- Comic Con (MaSK=10)
INSERT INTO VE VALUES (10, N'3-Day Pass VIP', 800000, 500, 500, N'Ra vào 3 ngày, quà tặng exclusive, early access', '#FF6B6B');
INSERT INTO VE VALUES (10, N'3-Day Pass', 450000, 2000, 2000, N'Ra vào 3 ngày', '#667EEA');
INSERT INTO VE VALUES (10, N'Vé 1 Ngày', 200000, 5000, 5000, N'Vé vào 1 ngày', '#4FACFE');

-- Stand-up Comedy (MaSK=11)
INSERT INTO VE VALUES (11, N'Front Row', 400000, 30, 22, N'Hàng đầu, có thể được mời lên sân khấu', '#FF6B6B');
INSERT INTO VE VALUES (11, N'Standard', 200000, 120, 95, N'Ghế ngồi tự do', '#4FACFE');

-- Film Festival (MaSK=12)
INSERT INTO VE VALUES (12, N'Full Pass 2 ngày', 150000, 200, 200, N'Xem tất cả phim, tham gia thảo luận', '#667EEA');
INSERT INTO VE VALUES (12, N'Vé lẻ 1 suất', 50000, 1000, 1000, N'Xem 1 suất chiếu', '#4FACFE');

-- Đánh giá mẫu
INSERT INTO DANHGIA VALUES (2, 1, 5, N'Concert tuyệt vời! Sân khấu hoành tráng, âm thanh cực đỉnh. Sẽ quay lại lần sau!', '2026-05-01');
INSERT INTO DANHGIA VALUES (3, 1, 4, N'Rất hay nhưng hơi đông, xếp hàng lâu. Sơn Tùng hát live rất tốt.', '2026-05-02');
INSERT INTO DANHGIA VALUES (4, 3, 5, N'Workshop chất lượng cao, barista hướng dẫn rất tận tình. Cà phê mang về ngon!', '2026-05-03');
INSERT INTO DANHGIA VALUES (2, 5, 5, N'Nhạc kịch Tấm Cám hay không tưởng! Sân khấu 3D mapping đỉnh cao.', '2026-05-04');
INSERT INTO DANHGIA VALUES (5, 8, 4, N'Không gian rừng thông Đà Lạt quá tuyệt, Đen hát rất tâm trạng.', '2026-05-05');
