CREATE TABLE KHOA (
    MaKhoa NVARCHAR(10) PRIMARY KEY,
    TenKhoa NVARCHAR(100)
);

CREATE TABLE LOP (
    MaLop NVARCHAR(10) PRIMARY KEY,
    TenLop NVARCHAR(100),
    MaKhoa NVARCHAR(10),
    FOREIGN KEY (MaKhoa) REFERENCES KHOA(MaKhoa)
);

CREATE TABLE SINHVIEN (
    MaSV NVARCHAR(10) PRIMARY KEY,
    HoTen NVARCHAR(100),
    NgaySinh DATE,
    Phai NVARCHAR(3),
    MaLop NVARCHAR(10),
    FOREIGN KEY (MaLop) REFERENCES LOP(MaLop)
);

CREATE TABLE MONHOC (
    MaMH NVARCHAR(10) PRIMARY KEY,
    TenMH NVARCHAR(100),
    SoTC INT
);

CREATE TABLE KETQUA (
    MaSV NVARCHAR(10),
    MaMH NVARCHAR(10),
    Diem FLOAT,
    PRIMARY KEY (MaSV, MaMH),
    FOREIGN KEY (MaSV) REFERENCES SINHVIEN(MaSV),
    FOREIGN KEY (MaMH) REFERENCES MONHOC(MaMH)
);

-- KHOA
INSERT INTO KHOA VALUES
('KH01', 'Công nghệ thông tin'),
('KH02', 'Kinh tế'),
('KH03', 'Ngoại ngữ');

-- LOP
INSERT INTO LOP VALUES
('L01', 'ĐH CNTT khóa 07', 'KH01'),
('L02', 'ĐH Kinh tế 08', 'KH02'),
('L03', 'ĐH Ngôn ngữ 09', 'KH03');

-- SINHVIEN
INSERT INTO SINHVIEN VALUES
('SV01', 'Nguyễn Văn A', '2003-01-10', 'Nam', 'L01'),
('SV02', 'Trần Thị B', '2003-03-22', 'Nữ', 'L02'),
('SV03', 'Lê Văn C', '2004-05-15', 'Nam', 'L01');

-- MONHOC
INSERT INTO MONHOC VALUES
('MH01', 'Cơ sở dữ liệu', 3),
('MH02', 'Kinh tế vi mô', 2),
('MH03', 'Tiếng Anh cơ bản', 3);

-- KETQUA
INSERT INTO KETQUA VALUES
('SV01', 'MH01', 8.5),
('SV01', 'MH03', 7.0),
('SV02', 'MH02', 9.0),
('SV03', 'MH01', 6.5);

SELECT * FROM SINHVIEN;
SELECT * FROM KETQUA;
SELECT * FROM MONHOC;
SELECT * FROM LOP;
SELECT * FROM KHOA;

--DELETE FROM KETQUA;
--DELETE FROM SINHVIEN;
--DELETE FROM MONHOC;
--DELETE FROM LOP;
--DELETE FROM KHOA;

-- mã và tên những lớp thuộc khoa Công nghệ thông tin

SELECT MaLop, TenLop 
FROM LOP, KHOA
WHERE LOP.MaKhoa = KHOA.MaKhoa AND KHOA.TenKhoa = 'Công nghệ thông tin';

-- Cho biết mã và họ tên những sinh viên phái nam thuộc lớp có mã lớp là ‘L01’

SELECT MaSV, HoTen
FROM SINHVIEN
WHERE Phai = 'Nam' AND MaLop = 'L01';

-- Cho biết mã và họ tên những sinh viên phái nam thuộc lớp có mã lớp là ‘L01’ hoặc phái nữ học lớp có mã là ‘L02’

SELECT MaSV, HoTen
FROM SINHVIEN
WHERE (Phai = 'Nam' AND MaLop = 'L01') 
OR (Phai = 'Nữ' AND.MaLop = 'L02');

-- Cho biết mã và họ tên những sinh viên phái nam thuộc lớp có tên lớp là ‘ĐH Ngôn ngữ 09’

SELECT MaSV, HoTen
FROM SINHVIEN, LOP
WHERE SINHVIEN.MaLop = LOP.MaLop AND Phai = 'Nam' AND LOP.TenLop = 'ĐH Ngôn ngữ 09';

-- Liệt kê danh sách những môn học (MaMH) do sinh viên có mã ‘SV01’ đã học

SELECT MaMH 
FROM SINHVIEN, KETQUA
WHERE SINHVIEN.MaSV = KETQUA.MaSV AND SINHVIEN.MaSV = 'SV01';

SELECT MaMH 
FROM KETQUA
WHERE MaSV = 'SV01';

-- Liệt kê danh sách những môn học (MaMH, TenMH) do sinh viên có mã ‘SV01’ đã học.

SELECT MONHOC.MaMH, TenMH
FROM KETQUA, MONHOC
WHERE KETQUA.MaMH = MONHOC.MaMH AND MaSV = 'SV01';

-- Liệt kê danh sách những sinh viên (MaSV) có học môn với mã môn là ‘MH01’

SELECT *
FROM SINHVIEN, KETQUA
WHERE SINHVIEN.MaSV = KETQUA.MaSV AND KETQUA.MaMH = 'MH01';

-- Cho biết mã khoa, tên khoa và số lớp trong từng khoa.

SELECT KHOA.MaKhoa, TenKhoa, COUNT(MaLop) AS SoLop
FROM LOP, KHOA
WHERE LOP.MaKhoa = KHOA.MaKhoa
GROUP BY  KHOA.MaKhoa, TenKhoa;

-- Mã và tên những khoa nào có số lớp trên 5

SELECT KHOA.MaKhoa, TenKhoa, COUNT(MaLop) AS SoLop
FROM KHOA, LOP
WHERE LOP.MaKhoa = KHOA.MaKhoa
GROUP BY  KHOA.MaKhoa, TenKhoa
HAVING COUNT(MaLop) > 5;

-- Mã và tên những khoa có nhiều lớp nhất

SELECT KHOA.MaKhoa, TenKhoa, COUNt(LOP.MaLop) AS SoLop
FROM KHOA, LOP
WHERE LOP.MaKhoa = KHOA.MaKhoa
GROUP BY  KHOA.MaKhoa, TenKhoa
HAVING COUNT(LOP.MaLop) >= 
	ALL(
		SELECT COUNT(MaLop) AS SoLop
		FROM LOP
		GROUP BY MaLop
	);

-- Cho biết mã sinh viên và số môn học của từng sinh viên.

SELECT MaSV, COUNT(DISTINCT MaMH) AS SoLanHoc
FROM KETQUA
GROUP BY MASV;

-- Cho biết mã, họ tên và số môn học của từng sinh viên.

SELECT SINHVIEN.MaSV, HoTen, COUNT(MaMH) AS SoLanHoc
FROM KETQUA, SINHVIEN
WHERE KETQUA.MaSV = SINHVIEN.MaSV
GROUP BY SINHVIEN.MaSV, HoTen;

-- Cho biết mã và họ tên những sinh viên học trên 5 môn học.

SELECT SINHVIEN.MaSV, HoTen, COUNT(DISTINCT MaMH) AS SoLanHoc
FROM KETQUA, SINHVIEN
WHERE KETQUA.MaSV = SINHVIEN.MaSV
GROUP BY SINHVIEN.MaSV, HoTen
HAVING COUNT(DISTINCT MaMH) >= 5;

-- Cho biết mã, họ tên những sinh viên học nhiều môn nhất.

SELECT SINHVIEN.MaSV, HoTen, COUNT(DISTINCT MaMH) AS SoLanHoc
FROM KETQUA, SINHVIEN
WHERE KETQUA.MaSV = SINHVIEN.MaSV
GROUP BY SINHVIEN.MaSV, HoTen
HAVING COUNT(DISTINCT MaMH) >=
	ALL(
		SELECT COUNT(MaMH) AS SoLanHoc
		FROM KETQUA
		GROUP BY MaMH
	);

-- Cho biết mã môn học và số sinh viên học của từng môn.

SELECT MaMH, COUNT(DISTINCT MaSV) AS SoSVHoc
FROM KETQUA
GROUP BY MaMH;

-- Cho biết mã môn học, tên môn học và số lượng sinh viên học tương ứng.

SELECT KETQUA.MaMH, TenMH, COUNT(DISTINCT MaSV) AS SoSVHoc
FROM KETQUA, MONHOC
WHERE KETQUA.MaMH = MONHOC.MaMH 
GROUP BY KETQUA.MaMH, TenMH;

-- Cho biết mã và tên những môn học có ít nhất 20 sinh viên học

SELECT KETQUA.MaMH, TenMH, COUNT(DISTINCT MaSV) AS SoSVHoc
FROM KETQUA, MONHOC
WHERE KETQUA.MaMH = MONHOC.MaMH 
GROUP BY KETQUA.MaMH, TenMH
HAVING COUNT(DISTINCT MaSV) >= 20;

-- Cho biết mã và tên những môn học có nhiều sinh viên học nhất.

SELECT KETQUA.MaMH, TenMH, COUNT(DISTINCT MaSV) AS SoSVHoc
FROM KETQUA, MONHOC
WHERE KETQUA.MaMH = MONHOC.MaMH 
GROUP BY KETQUA.MaMH, TenMH
HAVING COUNT(DISTINCT MaSV) >= 
	ALL (
		SELECT COUNT(DISTINCT MaSV)
		FROM KETQUA
		GROUP BY MaMH
	);

-- Mã và tên những môn học nào không có sinh viên học.

SELECT M.MaMH, M.TenMH
FROM MONHOC M
WHERE NOT EXISTS(SELECT * FROM KETQUA K WHERE K.MaMH = M.MaMH);

