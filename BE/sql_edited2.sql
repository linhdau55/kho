-- Xóa và tạo lại cơ sở dữ liệu
DROP DATABASE IF EXISTS QuanLyKho;
CREATE DATABASE QuanLyKho;
USE QuanLyKho;

-- Tạo bảng NHÀ_CUNG_CẤP
CREATE TABLE NHA_CUNG_CAP (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    ma_NCC VARCHAR(255) UNIQUE,
    ten_NCC VARCHAR(255),
    so_Dien_Thoai VARCHAR(20),
    dia_Chi VARCHAR(255)
);

-- Tạo bảng DANH_MỤC
CREATE TABLE DANH_MUC (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    ten_Danh_Muc VARCHAR(255)
);

-- Tạo bảng KHO
CREATE TABLE KHO (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    ma_Kho VARCHAR(255) UNIQUE,
    ton_Kho INT,
    dia_Chi VARCHAR(255),
    danh_Muc_Id INT,
    FOREIGN KEY (danh_Muc_Id) REFERENCES DANH_MUC(ID)
);

-- Tạo bảng NHÀ_SẢN_XUẤT
CREATE TABLE NHA_SAN_XUAT (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    ten_nSX VARCHAR(255)
);

-- Tạo bảng HÀNG_HÓA
CREATE TABLE HANG_HOA (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    ma_Hang VARCHAR(255) UNIQUE,
    ten_Hang VARCHAR(255),
    mo_Ta TEXT,
    gia_Ban DECIMAL(10,2),
    so_Luong INT,
    nSX_Id INT,
    danh_Muc_Id INT,
    FOREIGN KEY (nSX_Id) REFERENCES NHA_SAN_XUAT(ID),
    FOREIGN KEY (danh_Muc_Id) REFERENCES DANH_MUC(ID)
);

-- Tạo bảng TỒN_KHO
CREATE TABLE TON_KHO (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    hang_Hoa_Id INT,
    kho_Id INT UNIQUE,
    so_Luong INT,
    nSX_Id INT,
    tong_Gia_Tri_PN DECIMAL(15,2),
    tong_Gia_Tri_PX DECIMAL(15,2),
    danh_muc_Id INT,
    FOREIGN KEY (hang_Hoa_Id) REFERENCES HANG_HOA(ID),
    FOREIGN KEY (kho_Id) REFERENCES KHO(ID),
    FOREIGN KEY (nSX_Id) REFERENCES NHA_SAN_XUAT(ID),
    FOREIGN KEY (danh_muc_Id) REFERENCES DANH_MUC(ID)
);

-- Tạo bảng NHÂN_VIÊN
CREATE TABLE NHAN_VIEN (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    ma_NV VARCHAR(255) UNIQUE,
    ho_Ten VARCHAR(255),
    chuc_Vu VARCHAR(255),
    so_Dien_Thoai VARCHAR(20) UNIQUE,
    dia_Chi VARCHAR(255),
    mat_Khau VARCHAR(255)
);

-- Tạo bảng PHIẾU_NHẬP
CREATE TABLE PHIEU_NHAP (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    ma_Phieu VARCHAR(255) UNIQUE,
    ten_Nhap VARCHAR(255),
    nha_Cung_Cap_Id INT,
    kho_Id INT,
    nhan_Vien_Id INT,
    tong_Gia_Tri DECIMAL(15,2),
    ngay_Nhap DATE,
    hang_hoa_Id INT,
    danh_muc_Id INT,
    FOREIGN KEY (nha_Cung_Cap_Id) REFERENCES NHA_CUNG_CAP(ID),
    FOREIGN KEY (kho_Id) REFERENCES KHO(ID),
    FOREIGN KEY (nhan_Vien_Id) REFERENCES NHAN_VIEN(ID),
    FOREIGN KEY (hang_hoa_Id) REFERENCES HANG_HOA(ID),
    FOREIGN KEY (danh_muc_Id) REFERENCES DANH_MUC(ID)
);

-- Tạo bảng PHIẾU_XUẤT
CREATE TABLE PHIEU_XUAT (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    ma_Phieu VARCHAR(255) UNIQUE,
    ngay_Xuat DATE,
    kho_Id INT,
    nhan_Vien_Id INT,
    tong_Gia_Tri DECIMAL(15,2),
    hang_Hoa_Id INT,
    danh_muc_Id INT,
    FOREIGN KEY (kho_Id) REFERENCES KHO(ID),
    FOREIGN KEY (nhan_Vien_Id) REFERENCES NHAN_VIEN(ID),
    FOREIGN KEY (hang_Hoa_Id) REFERENCES HANG_HOA(ID),
    FOREIGN KEY (danh_muc_Id) REFERENCES DANH_MUC(ID)
);

ALTER TABLE phieu_nhap ADD COLUMN so_Luong INT DEFAULT 0;
ALTER TABLE phieu_xuat ADD COLUMN so_Luong INT DEFAULT 0;

-- Tạo bảng BÁO_CÁO
CREATE TABLE BAO_CAO (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    ma_Bao_Cao VARCHAR(255) UNIQUE,
    ngay_Bao_Cao DATE,
    loai_Bao_Cao VARCHAR(255),
    nSX_Id INT UNIQUE,
    nhan_Vien_Id INT UNIQUE,
    danh_Muc_Id INT UNIQUE,
    FOREIGN KEY (nSX_Id) REFERENCES NHA_SAN_XUAT(ID),
    FOREIGN KEY (nhan_Vien_Id) REFERENCES NHAN_VIEN(ID),
    FOREIGN KEY (danh_Muc_Id) REFERENCES DANH_MUC(ID)
);

-- Tạo bảng CHI_TIẾT_BÁO_CÁO
CREATE TABLE CHI_TIET_BAO_CAO (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    bao_Cao_Id INT UNIQUE,
    hang_Hoa_Id INT UNIQUE,
    so_Luong INT,
    gia_Tri DECIMAL(15,2),
    FOREIGN KEY (bao_Cao_Id) REFERENCES BAO_CAO(ID),
    FOREIGN KEY (hang_Hoa_Id) REFERENCES HANG_HOA(ID)
);

ALTER TABLE hang_hoa
ADD COLUMN danh_Muc_Id INT(11),
ADD CONSTRAINT fk_danh_muc
FOREIGN KEY (danh_Muc_Id) REFERENCES danh_muc(ID) ON DELETE CASCADE;

-- Thêm dữ liệu cho bảng NHÀ_CUNG_CẤP
INSERT INTO NHA_CUNG_CAP (ma_NCC, ten_NCC, so_Dien_Thoai, dia_Chi) VALUES 
('001', 'Nguyễn Thành Nguyên', '0912345678', 'Hà Nội'),
('002', 'Trần Hà Thanh Thanh', '0802345678', 'TPHCM'),
('003', 'Lê Văn An', '0703456789', 'Đà Nẵng'),
('004', 'Phạm Thị Hoa', '0987654321', 'Hải Phòng'),
('005', 'Nguyễn Văn Bình', '0913456789', 'Cần Thơ'),
('006', 'Trần Thị Lan', '0904567890', 'Huế'),
('007', 'Hồ Văn Dũng', '0925678901', 'Nha Trang'),
('008', 'Võ Thị Mai', '0936789012', 'Biên Hòa'),
('009', 'Đỗ Văn Nam', '0947890123', 'Vũng Tàu'),
('010', 'Phan Thị Linh', '0958901234', 'Buôn Mê Thuột'),
('011', 'Ngô Văn Toàn', '0969012345', 'Long Xuyên'),
('012', 'Lý Thị Thảo', '0970123456', 'Rạch Giá'),
('013', 'Hoàng Văn Tuấn', '0811234567', 'Cà Mau'),
('014', 'Đặng Thị Nga', '0822345678', 'Vĩnh Long'),
('015', 'Bùi Văn Quang', '0833456789', 'Bến Tre'),
('016', 'Trương Thị Mỹ', '0844567890', 'Trà Vinh'),
('017', 'Cao Văn Kiên', '0855678901', 'Sóc Trăng'),
('018', 'Lưu Thị Hà', '0866789012', 'Đồng Tháp'),
('019', 'Vũ Văn Đức', '0877890123', 'Tây Ninh'),
('020', 'Đinh Thị Phương', '0888901234', 'An Giang');

-- Truy vấn dữ liệu từ NHÀ_CUNG_CẤP
SELECT * FROM NHA_CUNG_CAP;
SELECT * FROM NHA_CUNG_CAP WHERE ID = 1;

-- Cập nhật số điện thoại của nhà cung cấp
UPDATE NHA_CUNG_CAP SET so_Dien_Thoai = '0987654322' WHERE ma_NCC = 'NCC001';

-- Xóa nhà cung cấp
DELETE FROM NHA_CUNG_CAP WHERE ID = 1;
DELETE FROM NHA_CUNG_CAP WHERE ma_NCC = '001';

-- Thêm dữ liệu cho bảng DANH_MỤC
INSERT INTO DANH_MUC (ten_Danh_Muc) VALUES ('Giày'), ('Áo'), ('Quần'), ('Mũ'), ('Phụ kiện');

-- Truy vấn dữ liệu từ DANH_MỤC
SELECT * FROM DANH_MUC;
SELECT * FROM DANH_MUC WHERE ID = 1;
SELECT * FROM DANH_MUC WHERE ten_Danh_Muc = 'Giày';

-- Cập nhật tên danh mục
UPDATE DANH_MUC SET ten_Danh_Muc = 'Giày lười' WHERE ID = 1;

-- Thêm dữ liệu cho bảng KHO
INSERT INTO KHO (ma_Kho, ton_Kho, dia_Chi, danh_Muc_Id) VALUES 
('KHO001', 100, 'Hà Nội', 1),
('KHO002', 120, 'TPHCM', 2),
('KHO003', 150, 'Hải Phòng', 3),
('KHO004', 170, 'Huế', 4),
('KHO005', 190, 'Đà Nẵng', 5);

-- Truy vấn dữ liệu từ KHO
SELECT * FROM KHO;
SELECT * FROM KHO WHERE ID = 1;
SELECT * FROM KHO WHERE ma_Kho = 'KHO001';

-- Cập nhật số lượng tồn kho
UPDATE KHO SET ton_Kho = 200 WHERE ma_Kho = 'KHO001';

-- Xóa kho
DELETE FROM KHO WHERE ID = 1;
DELETE FROM KHO WHERE ma_Kho = 'KHO001';

-- Tạo dữ liệu cho bảng NHÀ_SẢN_XUẤT
INSERT INTO NHA_SAN_XUAT (ten_nSX) VALUES ('Nike'), ('Adidas'), ('Puma'), ('Reebok');

-- Truy vấn dữ liệu từ NHÀ_SẢN_XUẤT
SELECT * FROM NHA_SAN_XUAT;
SELECT * FROM NHA_SAN_XUAT WHERE ID = 1;

-- Cập nhật tên nhà sản xuất
UPDATE NHA_SAN_XUAT SET ten_nSX = 'Nike Sportswear' WHERE ID = 1;

-- Thêm dữ liệu cho bảng HÀNG_HÓA
INSERT INTO HANG_HOA (ma_Hang, ten_Hang, mo_Ta, gia_Ban, so_Luong, nSX_Id, danh_Muc_Id) VALUES 
('HH001', 'Giày Nike Air Max', 'Giày thể thao', 2500000, 50, 1, 1),
('HH002', 'Áo Adidas', 'Áo phông nam', 300000, 100, 2, 2),
('HH003', 'Quần Puma', 'Quần thể thao', 500000, 70, 3, 3);

-- Truy vấn dữ liệu từ HÀNG_HÓA
SELECT * FROM HANG_HOA;
SELECT * FROM HANG_HOA WHERE ID = 1;

-- Cập nhật giá bán của hàng hóa
UPDATE HANG_HOA SET gia_Ban = 2800000 WHERE ma_Hang = 'HH001';

-- Xóa hàng hóa
DELETE FROM HANG_HOA WHERE ID = 1;

-- Thêm dữ liệu cho bảng TỒN_KHO
INSERT INTO TON_KHO (hang_Hoa_Id, kho_Id, so_Luong, nSX_Id, tong_Gia_Tri_PN, tong_Gia_Tri_PX, danh_muc_Id) VALUES 
(1, 1, 30, 1, 75000000, 100000000, 1),
(2, 2, 40, 2, 12000000, 25000000, 2);

-- Truy vấn dữ liệu từ TỒN_KHO
SELECT * FROM TON_KHO;
SELECT * FROM TON_KHO WHERE ID = 1;

-- Cập nhật số lượng tồn kho
UPDATE TON_KHO SET so_Luong = 35 WHERE hang_Hoa_Id = 1;

-- Thêm dữ liệu cho bảng NHÂN_VIÊN
INSERT INTO NHAN_VIEN (ma_NV, ho_Ten, chuc_Vu, so_Dien_Thoai, dia_Chi) VALUES 
('NV001', 'Nguyễn Văn A', 'Quản lý', '0901234567', 'Hà Nội'),
('NV002', 'Trần Thị B', 'Nhân viên bán hàng', '0902345678', 'TPHCM');

-- Truy vấn dữ liệu từ NHÂN_VIÊN
SELECT * FROM NHAN_VIEN;
SELECT * FROM NHAN_VIEN WHERE ID = 1;

-- Cập nhật thông tin nhân viên
UPDATE NHAN_VIEN SET ho_Ten = 'Nguyễn Văn B' WHERE ma_NV = 'NV001';

-- Thêm dữ liệu cho bảng PHIẾU_NHẬP
INSERT INTO PHIEU_NHAP (ma_Phieu, ten_Nhap, nha_Cung_Cap_Id, kho_Id, nhan_Vien_Id, tong_Gia_Tri, ngay_Nhap, hang_hoa_Id, danh_muc_Id) VALUES 
('PN001', 'Nhập hàng tháng 1', 1, 1, 1, 20000000, '2024-01-15', 1, 1),
('PN002', 'Nhập hàng tháng 2', 2, 2, 2, 30000000, '2024-02-15', 2, 2);

-- Truy vấn dữ liệu từ PHIẾU_NHẬP
SELECT * FROM PHIEU_NHAP;
SELECT * FROM PHIEU_NHAP WHERE ID = 1;

-- Cập nhật thông tin phiếu nhập
UPDATE PHIEU_NHAP SET tong_Gia_Tri = 25000000 WHERE ma_Phieu = 'PN001';

-- Xóa phiếu nhập
DELETE FROM PHIEU_NHAP WHERE ID = 1;

-- Thêm dữ liệu cho bảng PHIẾU_XUẤT
INSERT INTO PHIEU_XUAT (ma_Phieu, ngay_Xuat, kho_Id, nhan_Vien_Id, tong_Gia_Tri, hang_Hoa_Id, danh_muc_Id) VALUES 
('PX001', '2024-03-10', 1, 1, 30000000, 1, 1),
('PX002', '2024-04-10', 2, 2, 20000000, 2, 2);

-- Truy vấn dữ liệu từ PHIẾU_XUẤT
SELECT * FROM PHIEU_XUAT;
SELECT * FROM PHIEU_XUAT WHERE ID = 1;

-- Cập nhật thông tin phiếu xuất
UPDATE PHIEU_XUAT SET tong_Gia_Tri = 25000000 WHERE ma_Phieu = 'PX001';

-- Xóa phiếu xuất
DELETE FROM PHIEU_XUAT WHERE ID = 1;

-- Thêm dữ liệu cho bảng BÁO_CÁO
INSERT INTO BAO_CAO (ma_Bao_Cao, ngay_Bao_Cao, loai_Bao_Cao, nSX_Id, nhan_Vien_Id, danh_Muc_Id) VALUES 
('BC001', '2024-05-01', 'Báo cáo hàng hóa', 1, 1, 1),
('BC002', '2024-06-01', 'Báo cáo doanh thu', 2, 2, 2);

-- Truy vấn dữ liệu từ BÁO_CÁO
SELECT * FROM BAO_CAO;
SELECT * FROM BAO_CAO WHERE ID = 1;

-- Cập nhật thông tin báo cáo
UPDATE BAO_CAO SET loai_Bao_Cao = 'Báo cáo tồn kho' WHERE ma_Bao_Cao = 'BC001';

-- Xóa báo cáo
DELETE FROM BAO_CAO WHERE ID = 1;

-- Thêm dữ liệu cho bảng CHI_TIẾT_BÁO_CÁO
INSERT INTO CHI_TIET_BAO_CAO (bao_Cao_Id, hang_Hoa_Id, so_Luong, gia_Tri) VALUES 
(1, 1, 20, 50000000),
(2, 2, 30, 60000000);

-- Truy vấn dữ liệu từ CHI_TIẾT_BÁO_CÁO
SELECT * FROM CHI_TIET_BAO_CAO;
SELECT * FROM CHI_TIET_BAO_CAO WHERE ID = 1;

-- Cập nhật thông tin chi tiết báo cáo
UPDATE CHI_TIET_BAO_CAO SET so_Luong = 25 WHERE bao_Cao_Id = 1;

-- Xóa chi tiết báo cáo
DELETE FROM CHI_TIET_BAO_CAO WHERE ID = 1;

-- 1. Lấy danh sách hàng tồn
SELECT 
    H.ten_Hang AS Ten_Hang,
    T.so_Luong AS Ton_Kho,
    K.ma_Kho AS Ma_Kho
FROM 
    TON_KHO T
JOIN 
    HANG_HOA H ON T.hang_Hoa_Id = H.ID
JOIN 
    KHO K ON T.kho_Id = K.ID;

-- 2. Lịch sử giao dịch hàng hóa (Phiếu xuất)
SELECT 
    PX.ma_Phieu AS Ma_Phieu_Xuat,
    PX.ngay_Xuat AS Ngay_Xuat,
    H.ten_Hang AS Ten_Hang,
    PX.tong_Gia_Tri AS Tong_Gia_Tri,
    NV.ho_Ten AS Nhan_Vien
FROM 
    PHIEU_XUAT PX
JOIN 
    HANG_HOA H ON PX.hang_Hoa_Id = H.ID
JOIN 
    NHAN_VIEN NV ON PX.nhan_Vien_Id = NV.ID;

-- 3. Lịch sử giao dịch hàng hóa (Phiếu nhập)
SELECT 
    PN.ma_Phieu AS Ma_Phieu_Nhap,
    PN.ngay_Nhap AS Ngay_Nhap,
    H.ten_Hang AS Ten_Hang,
    PN.tong_Gia_Tri AS Tong_Gia_Tri,
    NV.ho_Ten AS Nhan_Vien
FROM 
    PHIEU_NHAP PN
JOIN 
    HANG_HOA H ON PN.hang_hoa_Id = H.ID
JOIN 
    NHAN_VIEN NV ON PN.nhan_Vien_Id = NV.ID;

-- 4. Lấy thông tin nhà cung cấp
SELECT 
    NCC.ma_NCC AS Ma_Nha_Cung_Cap,
    NCC.ten_NCC AS Ten_Nha_Cung_Cap,
    NCC.so_Dien_Thoai AS So_Dien_Thoai,
    NCC.dia_Chi AS Dia_Chi
FROM 
    NHA_CUNG_CAP NCC;

-- 5. Phân quyền người dùng 
SELECT 
    NV.ma_NV AS Ma_Nhan_Vien,
    NV.ho_Ten AS Ho_Ten,
    NV.chuc_Vu AS Chuc_Vu
FROM 
    NHAN_VIEN NV;

-- 6. Lấy danh sách hàng hóa theo danh mục
SELECT 
    H.ten_Hang AS Ten_Hang, 
    D.ten_Danh_Muc AS Ten_Danh_Muc 
FROM 
    HANG_HOA H 
JOIN 
    TON_KHO T ON H.ID = T.hang_Hoa_Id 
JOIN 
    DANH_MUC D ON T.danh_muc_Id = D.ID;

-- 7.Thống kê tổng giá trị hàng hóa trong kho
SELECT 
    SUM(T.tong_Gia_Tri_PN) AS Tong_Gia_Tri_Hang_Hoa 
FROM 
    TON_KHO T;

-- 8. Tính tổng số lượng hàng hóa trong kho
SELECT 
    SUM(T.so_Luong) AS Tong_So_Luong_Hang_Hoa 
FROM 
    TON_KHO T;

-- 9. Tính tổng giá trị hàng tồn kho
SELECT 
    SUM(T.tong_Gia_Tri_PX) AS Tong_Gia_Tri_Hang_Ton_Kho 
FROM 
    TON_KHO T;

-- 10. Tính giá bán trung bình của hàng hóa
SELECT 
    AVG(H.gia_Ban) AS Gia_Ban_Trung_Binh 
FROM 
    HANG_HOA H;

-- 11. Tính tổng doanh thu từ phiếu xuất
SELECT 
    SUM(PX.tong_Gia_Tri) AS Tong_Doanh_Thu 
FROM 
    PHIEU_XUAT PX;

-- 12. Tính số lượng hàng hóa đã nhập theo tháng
SELECT 
    MONTH(PN.ngay_Nhap) AS Thang, 
    SUM(PN.tong_Gia_Tri) AS Tong_So_Luong_Nhap 
FROM 
    PHIEU_NHAP PN 
GROUP BY 
    MONTH(PN.ngay_Nhap);

-- 13. Tính số lượng hàng hóa đã xuất theo tháng
SELECT 
    MONTH(PX.ngay_Xuat) AS Thang, 
    SUM(PX.tong_Gia_Tri) AS Tong_So_Luong_Xuat 
FROM 
    PHIEU_XUAT PX 
GROUP BY 
    MONTH(PX.ngay_Xuat);

-- 14. Tính số lượng hàng hóa của từng nhà cung cấp
SELECT 
    NCC.ten_NCC AS Ten_Nha_Cung_Cap, 
    SUM(PN.tong_Gia_Tri) AS Tong_So_Luong_Hang_Nhap 
FROM 
    PHIEU_NHAP PN 
JOIN 
    NHA_CUNG_CAP NCC ON PN.nha_Cung_Cap_Id = NCC.ID 
GROUP BY 
    NCC.ten_NCC;
-- 15 Tìm kiếm hàng hóa không có trong kho
SELECT 
    H.ten_Hang AS Ten_Hang, 
    H.gia_Ban AS Gia_Ban 
FROM 
    HANG_HOA H 
LEFT JOIN 
    TON_KHO T ON H.ID = T.hang_Hoa_Id 
WHERE 
    T.so_Luong IS NULL OR T.so_Luong = 0;
-- 16. Tính tổng doanh thu và tổng số lượng hàng hóa đã xuất trong một khoảng thời gian'
SELECT 
    SUM(PX.tong_Gia_Tri) AS Tong_Doanh_Thu, 
    SUM(H.so_Luong) AS Tong_So_Luong_Xuat 
FROM 
    PHIEU_XUAT PX 
JOIN 
    HANG_HOA H ON PX.hang_Hoa_Id = H.ID 
WHERE 
    PX.ngay_Xuat BETWEEN '2024-01-01' AND '2024-12-31';

-- 17. Tính số lượng hàng hóa theo trạng thái
SELECT 
    CASE 
        WHEN T.so_Luong > 0 THEN 'Có sẵn'
        ELSE 'Hết hàng'
    END AS Trang_Thai, 
    COUNT(H.ID) AS So_Luong_Hang 
FROM 
    HANG_HOA H 
LEFT JOIN 
    TON_KHO T ON H.ID = T.hang_Hoa_Id 
GROUP BY 
    Trang_Thai;


