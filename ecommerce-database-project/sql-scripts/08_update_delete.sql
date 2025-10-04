-- =============================================
-- Online Alışveriş Platformu Veritabanı
-- Dosya: 08_update_delete.sql
-- Açıklama: Veri güncelleme ve silme işlemleri
-- =============================================

USE OnlineShoppingDB;
GO

-- =============================================
-- 1. STOK GÜNCELLEME - Sipariş Sonrası Stok Azaltma
-- =============================================
PRINT '1. Stok güncelleme örneği:';
GO

-- Örnek: Ürün ID 1'in stoğunu azalt
UPDATE Urun
SET stok = stok - 1
WHERE id = 1 AND stok > 0;

SELECT id, ad, stok FROM Urun WHERE id = 1;
GO

-- =============================================
-- 2. FİYAT GÜNCELLEME - Kategori Bazlı İndirim
-- =============================================
PRINT '2. Kategori bazlı fiyat indirimi:';
GO

-- Elektronik kategorisine %5 indirim (Örnek - yorumda bırakıldı)
/*
UPDATE u
SET u.fiyat = u.fiyat * 0.95
FROM Urun u
INNER JOIN Kategori k ON u.kategori_id = k.id
WHERE k.ad = 'Elektronik';
*/

-- İndirim öncesi ve sonrası kontrolü
SELECT 
    u.ad,
    k.ad AS kategori,
    u.fiyat AS guncel_fiyat,
    u.fiyat * 0.95 AS indirimli_fiyat
FROM Urun u
INNER JOIN Kategori k ON u.kategori_id = k.id
WHERE k.ad = 'Elektronik';
GO

-- =============================================
-- 3. MÜŞTERİ BİLGİ GÜNCELLEME
-- =============================================
PRINT '3. Müşteri bilgi güncelleme:';
GO

-- Örnek: Müşteri şehir değişikliği
/*
UPDATE Musteri
SET sehir = 'Bursa'
WHERE id = 1;
*/

SELECT id, ad, soyad, sehir FROM Musteri WHERE id = 1;
GO

-- =============================================
-- 4. TOPLU GÜNCELLEME - Düşük Stoklu Ürünlerin İşaretlenmesi
-- =============================================
PRINT '4. Düşük stoklu ürünler:';
GO

-- Stok durumu kontrolü (Gerçek güncelleme yapılmıyor, sadece rapor)
SELECT 
    u.id,
    u.ad,
    u.stok,
    CASE 
        WHEN u.stok = 0 THEN 'STOK YOK'
        WHEN u.stok < 10 THEN 'KRİTİK STOK'
        WHEN u.stok < 20 THEN 'DÜŞÜK STOK'
        ELSE 'NORMAL'
    END AS stok_durumu
FROM Urun u
WHERE u.stok < 20
ORDER BY u.stok ASC;
GO

-- =============================================
-- 5. SİPARİŞ İPTAL SENARYOSU (DELETE)
-- =============================================
PRINT '5. Sipariş iptal işlemi örneği:';
GO

-- UYARI: Bu işlemler dikkatli yapılmalı!
-- Önce sipariş detayları, sonra sipariş silinmeli

/*
-- Örnek sipariş silme (ID 999 varsayımsal)
BEGIN TRANSACTION;

-- Önce sipariş detaylarını sil
DELETE FROM Siparis_Detay WHERE siparis_id = 999;

-- Sonra siparişi sil
DELETE FROM Siparis WHERE id = 999;

COMMIT;
*/

-- Mevcut siparişleri kontrol et
SELECT TOP 5 
    s.id,
    s.tarih,
    s.toplam_tutar,
    COUNT(sd.id) AS urun_sayisi
FROM Siparis s
LEFT JOIN Siparis_Detay sd ON s.id = sd.siparis_id
GROUP BY s.id, s.tarih, s.toplam_tutar
ORDER BY s.id DESC;
GO

-- =============================================
-- 6. ÜRÜN SİLME - Satılmamış Ürünleri Temizleme
-- =============================================
PRINT '6. Satılmamış ürün temizleme (simülasyon):';
GO

-- Silme işlemi öncesi kontrol
SELECT 
    u.id,
    u.ad,
    u.fiyat,
    u.stok,
    COUNT(sd.id) AS satis_sayisi
FROM Urun u
LEFT JOIN Siparis_Detay sd ON u.id = sd.urun_id
GROUP BY u.id, u.ad, u.fiyat, u.stok
HAVING COUNT(sd.id) = 0;

/*
-- Hiç satılmamış ürünleri sil (DİKKAT!)
DELETE FROM Urun
WHERE id NOT IN (SELECT DISTINCT urun_id FROM Siparis_Detay);
*/
GO

-- =============================================
-- 7. TRUNCATE KULLANIMI (Tüm veriyi silme)
-- =============================================
PRINT '7. TRUNCATE örneği (DİKKATLİ KULLANILMALI!):';
GO

/*
-- Tüm sipariş detaylarını siler (geri alınamaz!)
TRUNCATE TABLE Siparis_Detay;

-- Tüm siparişleri siler
TRUNCATE TABLE Siparis;

-- NOT: Foreign key varsa önce child tablolar temizlenmeli!
*/

-- Tablo boyutlarını kontrol et
SELECT 
    'Musteri' AS tablo,
    COUNT(*) AS kayit_sayisi
FROM Musteri
UNION ALL
SELECT 'Siparis', COUNT(*) FROM Siparis
UNION ALL
SELECT 'Siparis_Detay', COUNT(*) FROM Siparis_Detay
UNION ALL
SELECT 'Urun', COUNT(*) FROM Urun
UNION ALL
SELECT 'Kategori', COUNT(*) FROM Kategori
UNION ALL
SELECT 'Satici', COUNT(*) FROM Satici;
GO

-- =============================================
-- 8. TRANSACTION KULLANIMI - Güvenli Güncelleme
-- =============================================
PRINT '8. Transaction ile güvenli işlem:';
GO

BEGIN TRANSACTION;

    -- Örnek: Sipariş sonrası stok güncelleme
    DECLARE @urun_id INT = 1;
    DECLARE @siparis_adet INT = 2;
    
    -- Stok kontrolü
    IF EXISTS (SELECT 1 FROM Urun WHERE id = @urun_id AND stok >= @siparis_adet)
    BEGIN
        -- Stok yeterli, güncelle
        UPDATE Urun
        SET stok = stok - @siparis_adet
        WHERE id = @urun_id;
        
        PRINT 'Stok güncellendi!';
        COMMIT;
    END
    ELSE
    BEGIN
        PRINT 'Yetersiz stok! İşlem iptal edildi.';
        ROLLBACK;
    END

GO

-- =============================================
-- 9. BATCH DELETE - Eski Siparişleri Arşivleme
-- =============================================
PRINT '9. Eski sipariş analizi:';
GO

-- 6 aydan eski siparişler
SELECT 
    YEAR(tarih) AS yil,
    MONTH(tarih) AS ay,
    COUNT(*) AS siparis_sayisi
FROM Siparis
WHERE tarih < DATEADD(MONTH, -6, GETDATE())
GROUP BY YEAR(tarih), MONTH(tarih)
ORDER BY yil, ay;

/*
-- Eski siparişleri silme (Önce detaylar, sonra ana tablo)
DELETE sd
FROM Siparis_Detay sd
INNER JOIN Siparis s ON sd.siparis_id = s.id
WHERE s.tarih < '2024-01-01';

DELETE FROM Siparis
WHERE tarih < '2024-01-01';
*/
GO

-- =============================================
-- 10. SOFT DELETE - Silme İşareti ile Pasif Yapma
-- =============================================
PRINT '10. Soft delete yaklaşımı:';
GO

-- Gerçek senaryoda "aktif" veya "silinmis" column'u olurdu
/*
ALTER TABLE Urun ADD aktif BIT DEFAULT 1;

-- Ürünü pasif yap (silme yerine)
UPDATE Urun
SET aktif = 0
WHERE id = 999;

-- Sadece aktif ürünleri getir
SELECT * FROM Urun WHERE aktif = 1;
*/

PRINT 'Güncelleme ve silme işlemleri tamamlandı!';
PRINT 'NOT: Önemli işlemler yorum satırında bırakıldı. Dikkatli kullanın!';
GO