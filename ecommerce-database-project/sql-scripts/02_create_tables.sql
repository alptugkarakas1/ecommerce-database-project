-- =============================================
-- Online Alışveriş Platformu Veritabanı
-- Dosya: 02_create_tables.sql
-- Açıklama: Tüm tabloları oluşturma scripti
-- =============================================

USE OnlineShoppingDB;
GO

-- =============================================
-- 1. MÜŞTERİ TABLOSU
-- =============================================
CREATE TABLE Musteri (
    id INT PRIMARY KEY IDENTITY(1,1),
    ad NVARCHAR(50) NOT NULL,
    soyad NVARCHAR(50) NOT NULL,
    email NVARCHAR(100) UNIQUE NOT NULL,
    sehir NVARCHAR(50) NOT NULL,
    kayit_tarihi DATE NOT NULL DEFAULT GETDATE()
);
GO

-- =============================================
-- 2. KATEGORİ TABLOSU
-- =============================================
CREATE TABLE Kategori (
    id INT PRIMARY KEY IDENTITY(1,1),
    ad NVARCHAR(100) NOT NULL UNIQUE
);
GO

-- =============================================
-- 3. SATICI TABLOSU
-- =============================================
CREATE TABLE Satici (
    id INT PRIMARY KEY IDENTITY(1,1),
    ad NVARCHAR(100) NOT NULL,
    adres NVARCHAR(255) NOT NULL
);
GO

-- =============================================
-- 4. ÜRÜN TABLOSU
-- =============================================
CREATE TABLE Urun (
    id INT PRIMARY KEY IDENTITY(1,1),
    ad NVARCHAR(200) NOT NULL,
    fiyat DECIMAL(10,2) NOT NULL CHECK (fiyat >= 0),
    stok INT NOT NULL DEFAULT 0 CHECK (stok >= 0),
    kategori_id INT NOT NULL,
    satici_id INT NOT NULL,
    FOREIGN KEY (kategori_id) REFERENCES Kategori(id),
    FOREIGN KEY (satici_id) REFERENCES Satici(id)
);
GO

-- =============================================
-- 5. SİPARİŞ TABLOSU
-- =============================================
CREATE TABLE Siparis (
    id INT PRIMARY KEY IDENTITY(1,1),
    musteri_id INT NOT NULL,
    tarih DATETIME NOT NULL DEFAULT GETDATE(),
    toplam_tutar DECIMAL(10,2) NOT NULL CHECK (toplam_tutar >= 0),
    odeme_turu NVARCHAR(50) NOT NULL CHECK (odeme_turu IN ('Kredi Kartı', 'Banka Kartı', 'Havale', 'Kapıda Ödeme')),
    FOREIGN KEY (musteri_id) REFERENCES Musteri(id)
);
GO

-- =============================================
-- 6. SİPARİŞ DETAY TABLOSU
-- =============================================
CREATE TABLE Siparis_Detay (
    id INT PRIMARY KEY IDENTITY(1,1),
    siparis_id INT NOT NULL,
    urun_id INT NOT NULL,
    adet INT NOT NULL CHECK (adet > 0),
    fiyat DECIMAL(10,2) NOT NULL CHECK (fiyat >= 0),
    FOREIGN KEY (siparis_id) REFERENCES Siparis(id),
    FOREIGN KEY (urun_id) REFERENCES Urun(id)
);
GO

-- =============================================
-- INDEX'LER (Performans için)
-- =============================================
CREATE INDEX idx_musteri_sehir ON Musteri(sehir);
CREATE INDEX idx_urun_kategori ON Urun(kategori_id);
CREATE INDEX idx_urun_satici ON Urun(satici_id);
CREATE INDEX idx_siparis_musteri ON Siparis(musteri_id);
CREATE INDEX idx_siparis_tarih ON Siparis(tarih);
CREATE INDEX idx_siparis_detay_siparis ON Siparis_Detay(siparis_id);
CREATE INDEX idx_siparis_detay_urun ON Siparis_Detay(urun_id);
GO

PRINT 'Tüm tablolar başarıyla oluşturuldu!';
GO