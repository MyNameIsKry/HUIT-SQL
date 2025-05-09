CREATE TABLE KHACH (
    MaKH VARCHAR(10) PRIMARY KEY,
    TenKH VARCHAR(100),
    DiaChi VARCHAR(200),
    DienThoai VARCHAR(15)
);

CREATE TABLE HOADON (
    MaHD VARCHAR(10) PRIMARY KEY,
    NgayLap DATE,
    MaKH VARCHAR(10),
    FOREIGN KEY (MaKH) REFERENCES KHACH(MaKH)
);

CREATE TABLE HANGHOA (
    MaHG VARCHAR(10) PRIMARY KEY,
    TenHG VARCHAR(100),
    DVT VARCHAR(20),
    NhaSX VARCHAR(100),
    LoaiHang VARCHAR(50)
);

CREATE TABLE CHITIETHD (
    MaHD VARCHAR(10),
    MaHG VARCHAR(10),
    SoLuong INT,
    DonGia DECIMAL(10, 2),
    PRIMARY KEY (MaHD, MaHG),
    FOREIGN KEY (MaHD) REFERENCES HOADON(MaHD),
    FOREIGN KEY (MaHG) REFERENCES HANGHOA(MaHG)
);

-- KHACH
INSERT INTO KHACH VALUES 
('KH01', 'Nguyễn Văn A', 'Hà Nội', '0909123456'),
('KH02', 'Trần Thị B', 'TP.HCM', '0912233445'),
('KH03', 'Lê Văn C', 'Đà Nẵng', '0988776655'),
('KH04', 'Phạm Thị D', 'Cần Thơ', '0933445566'),
('KH05', 'Hoàng Văn E', 'Hải Phòng', '0944112233'),
('KH06', 'Ngô Thị F', 'Huế', '0977889900'),
('KH07', 'Đinh Văn G', 'Bình Dương', '0966778899');

-- HOADON
INSERT INTO HOADON VALUES 
('HD01', '2024-05-01', 'KH01'),
('HD02', '2024-05-02', 'KH02'),
('HD03', '2024-05-03', 'KH03'),
('HD04', '2024-05-04', 'KH04'),
('HD05', '2024-05-05', 'KH05'),
('HD06', '2024-05-06', 'KH06'),
('HD07', '2024-05-07', 'KH07');

-- HANGHOA
INSERT INTO HANGHOA VALUES 
('HH01', 'Sữa Vinamilk', 'Hộp', 'Vinamilk', 'Thực phẩm'),
('HH02', 'Bánh Oreo', 'Gói', 'Mondelez', 'Bánh kẹo'),
('HH03', 'Nước suối Lavie', 'Chai', 'Nestlé', 'Nước uống'),
('HH04', 'Dầu ăn Tường An', 'Chai', 'Tường An', 'Thực phẩm'),
('HH05', 'Bột giặt Omo', 'Túi', 'Unilever', 'Tẩy rửa'),
('HH06', 'Bia Heineken', 'Lon', 'Heineken', 'Đồ uống'),
('HH07', 'Mì Hảo Hảo', 'Gói', 'Acecook', 'Thực phẩm');

-- CHITIETHD
INSERT INTO CHITIETHD VALUES 
('HD01', 'HH01', 2, 25000),
('HD01', 'HH03', 1, 8000),
('HD02', 'HH02', 3, 12000),
('HD03', 'HH05', 1, 50000),
('HD04', 'HH07', 5, 3500),
('HD05', 'HH06', 6, 17000),
('HD06', 'HH04', 2, 30000);


SELECT * FROM HOADON;
SELECT * FROM KHACH;
SELECT * FROM HANGHOA;
SELECT * FROM CHITIETHD;

-- Cho biết mã và tên những khách hàng có địa chỉ ở TPHCM hay Hà Nội.

SELECT MaKH, TenKH
FROM KHACH
WHERE DiaChi = 'TP.HCM' OR DiaChi = 'Hà Nội';

-- Khách hàng nào có mua hàng trong ngày 2024-05-05

SELECT KHACH.MaKH, KHACH.TenKH 
FROM KHACH, HOADON
WHERE KHACH.MaKH = HOADON.MaKH AND NgayLap = '2024-05-05';

-- Khách hàng nào không mua hàng trong ngày 2024-05-05

SELECT k.MaKH, k.TenKH
FROM KHACH k
WHERE k.MaKH NOT IN(SELECT MaKH FROM HOADON hd WHERE k.MaKH = hd.MaKH AND hd.NgayLap = '2024-05-05');

SELECT k.MaKH, k.TenKH
FROM KHACH k
WHERE NOT EXISTS(SELECT k.MaKH, k.TenKH FROM HOADON hd WHERE k.MaKH = hd.MaKH AND hd.NgayLap = '2024-05-05');

-- 2024-05-01, khách hàng Nguyễn Văn A mua những mặt hàng nào (MaHG, TenHG, DVT)

SELECT MaHG, TenHG, DVT
FROM HANGHOA
WHERE MaHG IN (
    SELECT MaHG
    FROM CHITIETHD
    WHERE MaHD IN (
        SELECT MaHD
        FROM HOADON
        WHERE MaKH = (
            SELECT MaKH
            FROM KHACH
            WHERE TenKH = 'Nguyễn Văn A'
        ) AND NgayLap = '2024-05-01'
    )
);

-- Mã và tên những mặt hàng nào không bán ra trong ngày 2024-05-03

SELECT MaHG, TenHG
FROM HANGHOA
WHERE MaHG NOT IN (
	SELECT MaHG
	FROM CHITIETHD
	WHERE MaHD IN (
		SELECT MaHD
		FROM HOADON
		WHERE NgayLap = '2024-05-03'
	)
)

-- Cho biết mã hàng, tên hàng và tổng số lượng mặt hàng được bán ra tương ứng.

SELECT HANGHOA.MaHG, TenHG, SUM(SoLuong) as SoLuong
FROM CHITIETHD, HANGHOA
WHERE CHITIETHD.MaHG = HANGHOA.MaHG
GROUP BY HANGHOA.MaHG, TenHG;

-- Mã và tên những mặt hàng nào bán chạy nhất trong ngày 2024-05-02

SELECT MaHG, TenHG
FROM HANGHOA
WHERE MaHG IN (
	SELECT MaHG
	FROM CHITIETHD
	WHERE MaHD IN (
		SELECT MaHD
		FROM HOADON
		WHERE NgayLap = '2024-05-02'
	)
	GROUP BY MaHG
	HAVING SUM(SoLuong) >= ALL(
		SELECT SUM(SoLuong) as SoLuong
		FROM CHITIETHD
		WHERE MaHD IN (
			SELECT MaHD
			FROM HOADON
			WHERE NgayLap = '2024-05-02'
		)
		GROUP BY MaHG 
	)
)

