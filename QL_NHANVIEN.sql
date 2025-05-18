
CREATE DATABASE QuanLyNhanVien;
GO

-- Sử dụng Database
USE QuanLyNhanVien;
GO

-- Tạo bảng PHONGBAN
CREATE TABLE PHONGBAN (
    MAPH VARCHAR(10) ,
    TENPH NVARCHAR(50),
    DIADIEM NVARCHAR(100),
	CONSTRAINT PK_PHONGBAN PRIMARY KEY(MAPH)
);


-- Tạo bảng NHANVIEN
CREATE TABLE NHANVIEN (
    MANV VARCHAR(10) ,
    HOTEN NVARCHAR(50),
    NGAYSINH DATE,
    PHAI NVARCHAR(3),
    DIACHI NVARCHAR(100),
    LUONG INT,
    MANQL VARCHAR(10),
    MAPH VARCHAR(10),
	CONSTRAINT PK_NHANVIEN PRIMARY KEY(MANV),
    CONSTRAINT FK_NHANVIEN_PHONGBAN FOREIGN KEY(MAPH) REFERENCES PHONGBAN(MAPH),
    CONSTRAINT FK_NHANVIEN_NHANVIEN FOREIGN KEY (MANQL) REFERENCES NHANVIEN(MANV)
);


-- Tạo bảng DEAN
CREATE TABLE DEAN (
    MADA VARCHAR(10) ,
    TENDA NVARCHAR(100),
    DIADIEMDA NVARCHAR(100),
    NGAYBD DATE,
	CONSTRAINT PK_DEAN PRIMARY KEY(MADA)
);


-- Tạo bảng PHANCONG
CREATE TABLE PHANCONG (
    MANV VARCHAR(10),
    MADA VARCHAR(10),
    NGAYPC DATE,
    PRIMARY KEY (MANV, MADA),
    CONSTRAINT FK_PHANCONG_NHANVIEN FOREIGN KEY(MANV) REFERENCES NHANVIEN(MANV),
    CONSTRAINT FK_PHANCONG_DEAN FOREIGN KEY(MADA) REFERENCES DEAN(MADA)
);


-- Tạo bảng THANNHAN
CREATE TABLE THANNHAN (
    MANV VARCHAR(10),
    TENTN NVARCHAR(50),
    PHAI NVARCHAR(3),
    NGAYSINH DATE,
    QUANHE NVARCHAR(20),
    PRIMARY KEY (MANV, TENTN),
    CONSTRAINT FK_THANNHAN_NHANVIEN FOREIGN KEY(MANV) REFERENCES NHANVIEN(MANV)
);

-- Tạo bảng THENHANVIEN
CREATE TABLE THENHANVIEN (
    MANV VARCHAR(10) ,
    NGAYCAP DATE,
    CONSTRAINT FK_THENHANVIEN_NHANVIEN FOREIGN KEY(MANV) REFERENCES NHANVIEN(MANV),
	CONSTRAINT PK_THENHANVIEN PRIMARY KEY(MANV)
);

-- Nhập liệu vào bảng PHONGBAN
INSERT INTO PHONGBAN (MAPH, TENPH, DIADIEM) VALUES
('PH001', N'Kế hoạch', N'Tầng 1 nhà A'),
('PH002', N'Quản trị', N'Tầng 1 nhà B'),
('PH003', N'Nhân sự', N'Tầng 2 nhà A'),
('PH004', N'Tài vụ', N'Tầng 3 nhà A'),
('PH005', N'Đầu tư', N'Tầng 2 nhà B'),
('PH006', N'Vật tư', N'Tầng 3 nhà B'),
('PH007', N'Tư vấn', N'Tầng 3 nhà B');


-- Nhập liệu vào bảng NHANVIEN
INSERT INTO NHANVIEN (MANV, HOTEN, NGAYSINH, PHAI, DIACHI, LUONG, MANQL, MAPH) VALUES
('NV0001', N'Nguyễn Văn Nam', '1988-07-12', N'Nam', N'Tây Ninh', 15000000, 'NV0009', 'PH003'),
('NV0002', N'Nguyễn Kim Anh', '1990-02-10', N'Nữ', N'TP. HCM', 8000000, 'NV0009', 'PH003'),
('NV0003', N'Nguyễn Thị Châu', '1979-10-12', N'Nữ', N'Vũng Tàu', 12000000, 'NV0006', 'PH003'),
('NV0004', N'Trần Văn Út', '1977-08-23', N'Nam', N'Hà Nội', 7000000, 'NV0005', 'PH002'),
('NV0005', N'Trần Lệ Quyên', '1987-12-22', N'Nữ', N'Hà Nội', 9000000, 'NV0005', 'PH002'),
('NV0006', N'Bùi Đức Chí', '1987-12-22', N'Nam', N'TP. HCM', 10000000, 'NV0008', 'PH003'),
('NV0007', N'Nguyễn Tuấn Anh', '1991-09-06', N'Nam', N'Tây Ninh', 3500000, 'NV0002', 'PH003'),
('NV0008', N'Đỗ Xuân Thủy', '1985-05-14', N'Nam', N'TP. HCM', 21000000, 'NV0002', 'PH003'),
('NV0009', N'Trần Minh Tú', '1985-09-17', N'Nam', N'Đồng Nai', 18000000, NULL, 'PH002'),
('NV0010', N'Trần Khánh An', '1987-11-13', N'Nữ', N'Khánh Hòa', 12000000, NULL, NULL),
('NV0011', N'Nguyễn Ngọc Phan', '1995-06-02', N'Nam', N'Đồng Nai', 13000000, NULL, NULL);

-- Nhập liệu vào bảng DEAN
INSERT INTO DEAN (MADA, TENDA, DIADIEMDA, NGAYBD) VALUES
('DA001', N'Đền bù giải tỏa', N'Phường 12, Q. Tân Bình', '2015-01-01'),
('DA002', N'Giải phóng mặt bằng', N'Phường 12, Q. Tân Bình', '2015-06-01'),
('DA003', N'Cải tạo mặt đường số 9', N'Phường Tây Thạnh, Q. Tân Phú', '2016-01-01'),
('DA004', N'Bắt đầu thi công', N'Phường 26, Q. Bình Thạnh', '2016-05-04'),
('DA005', N'Hoàn thiện mặt bằng', N'Phường Tân Quy, Quận 7', '2016-12-10');


-- Nhập liệu vào bảng PHANCONG
INSERT INTO PHANCONG (MANV, MADA, NGAYPC) VALUES
('NV0001', 'DA001', '2015-02-05'),
('NV0001', 'DA003', '2016-03-17'),
('NV0003', 'DA003', '2016-01-01'),
('NV0005', 'DA004', '2016-05-10'),
('NV0007', 'DA005', '2016-12-20');

-- Nhập liệu vào bảng THANNHAN
INSERT INTO THANNHAN (MANV, TENTN, PHAI, NGAYSINH, QUANHE) VALUES
('NV0001', N'Nguyễn Thị Tám', N'Nữ', '2015-09-05', N'Con'),
('NV0001', N'Nguyễn Văn Bình', N'Nam', '1983-05-22', N'Anh'),
('NV0002', N'Nguyễn Nghĩa Chính', N'Nam', '1998-03-07', N'Em'),
('NV0005', N'Lê Anh Hùng', N'Nam', '1978-04-05', N'Chồng'),
('NV0006', N'Bùi Đại An', N'Nam', '1976-12-03', N'Anh'),
('NV0008', N'Lê Thảo Nguyên', N'Nữ', '1985-06-12', N'Vợ'),
('NV0009', N'Trần Thanh Nhàn', N'Nữ', '1979-05-30', N'Chị');

-- Nhập liệu vào bảng THENHANVIEN
INSERT INTO THENHANVIEN (MANV, NGAYCAP) VALUES
('NV0001', '2018-03-05'),
('NV0002', '2019-03-17'),
('NV0003', '2020-01-01'),
('NV0004', '2020-05-10'),
('NV0005', '2021-12-20');

-- 1. Tạo bảng ảo hiển thị danh sách nhân viên (MANV, HOTEN), ngày cấp thẻ nhân viên tương ứng với từng nhân viên?
CREATE VIEW V_NHANVIEN_THENHANVIEN AS
SELECT
    NV.MANV,
    NV.HOTEN,
    THNV.NGAYCAP
FROM
    NHANVIEN NV
JOIN
    THENHANVIEN THNV ON NV.MANV = THNV.MANV;
GO

-- 2. Tìm những nhân viên (MANV, HOTEN, NGAYSINH, DIACHI, PHAI, LUONG, MANQL, MAPH) có lương trên 10.000.000 đồng.
SELECT *
FROM
    NHANVIEN
WHERE
    LUONG > 10000000;
GO

-- 3. Cho biết họ tên của những nhân viên nam ở TP. HCM hoặc nhân viên nữ ở Hà Nội.
SELECT HOTEN
FROM NHANVIEN
WHERE (PHAI = N'Nam' AND DIACHI LIKE N'%TP. HCM')
   OR (PHAI = N'Nữ' AND DIACHI LIKE N'%Hà Nội');
GO

-- 4. Cho biết mã người quản lý của nhân viên 'Nguyễn Kim Anh'.
SELECT MANQL
FROM NHANVIEN
WHERE HOTEN = N'Nguyễn Kim Anh';
GO

-- 5. Tìm mã và họ tên những nhân viên thuộc phòng 'Quản trị'.
SELECT NV.MANV, NV.HOTEN
FROM NHANVIEN NV
JOIN PHONGBAN PB ON NV.MAPH = PB.MAPH
WHERE PB.TENPH = N'Quản trị';
GO

-- 6. Liệt kê danh sách gồm mã, họ tên và địa chỉ của những nhân viên thuộc phòng 'Nhân sự'.
SELECT NV.MANV, NV.HOTEN, NV.DIACHI
FROM NHANVIEN NV
JOIN PHONGBAN PB ON NV.MAPH = PB.MAPH
WHERE PB.TENPH = N'Nhân sự';
GO

-- 7. Cho biết ngày sinh, địa chỉ và tên phòng làm việc của nhân viên 'Trần Lệ Quyên'.
SELECT NV.NGAYSINH, NV.DIACHI, PB.TENPH
FROM NHANVIEN NV
JOIN PHONGBAN PB ON NV.MAPH = PB.MAPH
WHERE NV.HOTEN = N'Trần Lệ Quyên';
GO

-- 8. Tìm những nhân viên có lương lớn hơn 15.000.000 đồng ở phòng 'Nhân sự' hoặc lương lớn hơn 20.000.000 đồng ở phòng 'Quản trị'.
--   Thông tin bao gồm tất cả các cột trên bảng NHANVIEN.
SELECT *
FROM NHANVIEN NV
JOIN PHONGBAN PB ON NV.MAPH = PB.MAPH
WHERE (PB.TENPH = N'Nhân sự' AND NV.LUONG > 15000000)
   OR (PB.TENPH = N'Quản trị' AND NV.LUONG > 20000000);
GO

-- 9. Phòng 'Quản trị' có bao nhiêu nhân viên?
SELECT COUNT(*) AS SoLuongNhanVien
FROM NHANVIEN NV
JOIN PHONGBAN PB ON NV.MAPH = PB.MAPH
WHERE PB.TENPH = N'Quản trị';
GO

-- 10. Tìm tên những nữ nhân viên và tên người thân của họ.
SELECT NV.HOTEN AS TenNhanVien, TN.TENTN AS TenNguoiThan
FROM NHANVIEN NV
JOIN THANNHAN TN ON NV.MANV = TN.MANV
WHERE NV.PHAI = N'Nữ';
GO

-- 11. Với mỗi nhân viên cho biết họ tên và số người thân của nhân viên đó.
SELECT NV.HOTEN, COUNT(TN.TENTN) AS SoNguoiThan
FROM NHANVIEN NV
LEFT JOIN THANNHAN TN ON NV.MANV = TN.MANV
GROUP BY NV.HOTEN;
GO

-- 12. Với mỗi phòng ban liệt kê tên phòng ban và lương trung bình của những nhân viên làm việc cho phòng ban đó.
SELECT PB.TENPH, AVG(NV.LUONG) AS LuongTrungBinh
FROM PHONGBAN PB
JOIN NHANVIEN NV ON PB.MAPH = NV.MAPH
GROUP BY PB.TENPH;
GO

-- 13. Cho biết danh sách những nhân viên (MANV, HOTEN) có trên hai thân nhân.
SELECT NV.MANV, NV.HOTEN
FROM NHANVIEN NV
JOIN THANNHAN TN ON NV.MANV = TN.MANV
GROUP BY NV.MANV, NV.HOTEN
HAVING COUNT(*) > 2;
GO

-- 14. Cho biết danh sách những nhân viên (MANV, HOTEN) không có thân nhân.
SELECT NV.MANV, NV.HOTEN
FROM NHANVIEN NV
LEFT JOIN THANNHAN TN ON NV.MANV = TN.MANV
WHERE TN.MANV IS NULL;
GO

-- 15. Cho biết mã và họ tên nhân viên có lương thấp nhất.
SELECT MANV, HOTEN
FROM NHANVIEN
WHERE LUONG = (SELECT MIN(LUONG) FROM NHANVIEN);
GO

-- 16. Cho biết mã và họ tên nhân viên có lương cao nhất phòng 'Nhân sự'.
SELECT NV.MANV, NV.HOTEN
FROM NHANVIEN NV
JOIN PHONGBAN PB ON NV.MAPH = PB.MAPH
WHERE PB.TENPH = N'Nhân sự'
  AND NV.LUONG = (SELECT MAX(LUONG) FROM NHANVIEN WHERE MAPH = 'PH003');
GO

-- 17. Cho biết tên những đề án có ít nhất hai nhân viên tham gia.
SELECT DA.TENDA
FROM DEAN DA
JOIN PHANCONG PC ON DA.MADA = PC.MADA
GROUP BY DA.TENDA
HAVING COUNT(PC.MANV) >= 2;
GO

-- 18. Những nhân viên nào (MANV, HOTEN) tham gia cả hai đề án 'DA003' và 'DA004'?
SELECT NV.MANV, NV.HOTEN
FROM NHANVIEN NV
WHERE NV.MANV IN (SELECT MANV FROM PHANCONG WHERE MADA = 'DA003')
  AND NV.MANV IN (SELECT MANV FROM PHANCONG WHERE MADA = 'DA004');
GO

-- 19. Những nhân viên nào (HOTEN) có lương lớn hơn lương cao nhất của các nhân viên phòng 'Quản trị'?
SELECT NV.HOTEN
FROM NHANVIEN NV
WHERE NV.LUONG > (SELECT MAX(LUONG) FROM NHANVIEN WHERE MAPH = 'PH002');
GO

-- 20. Phòng ban nào có số nhân viên nhiều hơn số nhân viên của phòng 'Kế hoạch'?
SELECT PB.TENPH
FROM PHONGBAN PB
JOIN NHANVIEN NV ON PB.MAPH = NV.MAPH
GROUP BY PB.TENPH
HAVING COUNT(*) > (SELECT COUNT(*) FROM NHANVIEN WHERE MAPH = 'PH001');
GO

-- 21. Liệt kê ba nhân viên (MANV, HOTEN) có mức lương cao nhất.
SELECT TOP 3 MANV, HOTEN
FROM NHANVIEN
ORDER BY LUONG DESC;
GO

-- 22. Cập nhật tăng 10% lương cho những nhân viên đã từng tham gia ít nhất hai đề án.
UPDATE NHANVIEN
SET LUONG = LUONG * 1.1
WHERE MANV IN (SELECT MANV FROM PHANCONG GROUP BY MANV HAVING COUNT(MADA) >= 2);
GO

-- 23. Cho biết mã và họ tên những nhân viên tham gia tất cả các đề án.
SELECT NV.MANV, NV.HOTEN
FROM NHANVIEN NV
WHERE NOT EXISTS (
    SELECT MADA FROM DEAN
    EXCEPT
    SELECT MADA FROM PHANCONG WHERE MANV = NV.MANV
);
GO

-- 24. Có bao nhiêu đề án bắt đầu từ ngày '01/01/2016'?
SELECT COUNT(*)
FROM DEAN
WHERE NGAYBD = '2016-01-01';
GO

-- 25. Tầng 1 nhà A có bao nhiêu phòng ban?
SELECT COUNT(*)
FROM PHONGBAN
WHERE DIADIEM = N'Tầng 1 nhà A';
GO