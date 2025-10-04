-- =============================================
-- Online Alışveriş Platformu Veritabanı
-- Dosya: 01_create_database.sql
-- Açıklama: Veritabanı oluşturma scripti
-- =============================================

-- Eğer veritabanı varsa sil (dikkatli kullanın!)
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'OnlineShoppingDB')
BEGIN
    ALTER DATABASE OnlineShoppingDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE OnlineShoppingDB;
END
GO

-- Yeni veritabanı oluştur
CREATE DATABASE OnlineShoppingDB;
GO

-- Veritabanını kullan
USE OnlineShoppingDB;
GO

PRINT 'OnlineShoppingDB veritabanı başarıyla oluşturuldu!';
GO