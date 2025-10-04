-- =============================================
-- Online Alışveriş Platformu Veritabanı
-- Dosya: 06_join_queries.sql
-- Açıklama: JOIN sorguları
-- =============================================

USE OnlineShoppingDB;
GO

-- =============================================
-- 1. DETAYLI SİPARİŞ RAPORU (Müşteri + Ürün + Satıcı)
-- =============================================
PRINT '1. Detaylı sipariş raporu:';
GO

SELECT TOP 20
    s.id AS siparis_no,
    s.tarih AS siparis_tarihi,
    m.ad + ' ' + m.soyad AS musteri_adi,
    m.sehir AS musteri_sehri,
    u.ad AS urun_adi,
    k.ad AS kategori,
    sat.ad AS satici,
    sd.adet,
    sd.fiyat AS birim_fiyat,
    sd.adet * sd.fiyat AS toplam_fiyat,
    s.odeme_turu
FROM Siparis s
INNER JOIN Musteri m ON s.musteri_id = m.id
INNER JOIN Siparis_Detay sd ON s.id = sd.siparis_id
INNER JOIN Urun u ON sd.urun_id = u.id
INNER JOIN Kategori k ON u.kategori_id = k.id
INNER JOIN Satici sat ON u.satici_id = sat.id
ORDER BY s.tarih DESC;
GO

-- =============================================
-- 2. HİÇ SATILMAMIŞ ÜRÜNLER (LEFT JOIN)
-- =============================================
PRINT '2. Hiç satılmamış ürünler:';
GO

SELECT 
    u.id,
    u.ad AS urun_adi,
    u.fiyat,
    u.stok,
    k.ad AS kategori,
    s.ad AS satici
FROM Urun u
INNER JOIN Kategori k ON u.kategori_id = k.id
INNER JOIN Satici s ON u.satici_id = s.id
LEFT JOIN Siparis_Detay sd ON u.id = sd.urun_id
WHERE sd.id IS NULL
ORDER BY u.fiyat DESC;
GO

-- =============================================
-- 3. HİÇ SİPARİŞ VERMEMİŞ MÜŞTERİLER
-- =============================================
PRINT '3. Hiç sipariş vermemiş müşteriler:';
GO

SELECT 
    m.id,
    m.ad + ' ' + m.soyad AS musteri_adi,
    m.email,
    m.sehir,
    m.kayit_tarihi
FROM Musteri m
LEFT JOIN Siparis s ON m.id = s.musteri_id
WHERE s.id IS NULL
ORDER BY m.kayit_tarihi;
GO

-- =============================================
-- 4. MÜŞTERİ SİPARİŞ GEÇMİŞİ (Her müşterinin tüm siparişleri)
-- =============================================
PRINT '4. Müşteri sipariş geçmişi:';
GO

SELECT 
    m.id AS musteri_id,
    m.ad + ' ' + m.soyad AS musteri_adi,
    m.sehir,
    COUNT(s.id) AS toplam_siparis,
    SUM(s.toplam_tutar) AS toplam_harcama,
    AVG(s.toplam_tutar) AS ortalama_siparis,
    MIN(s.tarih) AS ilk_siparis_tarihi,
    MAX(s.tarih) AS son_siparis_tarihi
FROM Musteri m
LEFT JOIN Siparis s ON m.id = s.musteri_id
GROUP BY m.id, m.ad, m.soyad, m.sehir
HAVING COUNT(s.id) > 0
ORDER BY toplam_harcama DESC;
GO

-- =============================================
-- 5. ÜRÜN - SATICI - KATEGORİ İLİŞKİSİ
-- =============================================
PRINT '5. Ürün, satıcı ve kategori ilişkisi:';
GO

SELECT 
    k.ad AS kategori,
    s.ad AS satici,
    COUNT(u.id) AS urun_sayisi,
    AVG(u.fiyat) AS ortalama_fiyat,
    SUM(u.stok) AS toplam_stok,
    MIN(u.fiyat) AS en_ucuz,
    MAX(u.fiyat) AS en_pahali
FROM Kategori k
INNER JOIN Urun u ON k.id = u.kategori_id
INNER JOIN Satici s ON u.satici_id = s.id
GROUP BY k.ad, s.ad
ORDER BY kategori, satici;
GO

-- =============================================
-- 6. SİPARİŞ DETAY RAPORU (Tüm Bilgiler)
-- =============================================
PRINT '6. Sipariş detay raporu:';
GO

SELECT TOP 30
    s.id AS siparis_id,
    s.tarih,
    m.ad + ' ' + m.soyad AS musteri,
    m.email,
    m.sehir,
    s.odeme_turu,
    s.toplam_tutar AS siparis_toplami,
    u.ad AS urun,
    k.ad AS kategori,
    sat.ad AS satici,
    sd.adet,
    sd.fiyat,
    sd.adet * sd.fiyat AS ara_toplam
FROM Siparis s
INNER JOIN Musteri m ON s.musteri_id = m.id
INNER JOIN Siparis_Detay sd ON s.id = sd.siparis_id
INNER JOIN Urun u ON sd.urun_id = u.id
INNER JOIN Kategori k ON u.kategori_id = k.id
INNER JOIN Satici sat ON u.satici_id = sat.id
ORDER BY s.tarih DESC, s.id;
GO

-- =============================================
-- 7. SATICI - MÜŞTERİ İLİŞKİSİ
-- =============================================
PRINT '7. Satıcı - müşteri ilişkisi:';
GO

SELECT 
    sat.ad AS satici,
    m.sehir AS musteri_sehri,
    COUNT(DISTINCT m.id) AS benzersiz_musteri_sayisi,
    COUNT(s.id) AS siparis_sayisi,
    SUM(sd.adet * sd.fiyat) AS toplam_ciro
FROM Satici sat
INNER JOIN Urun u ON sat.id = u.satici_id
INNER JOIN Siparis_Detay sd ON u.id = sd.urun_id
INNER JOIN Siparis s ON sd.siparis_id = s.id
INNER JOIN Musteri m ON s.musteri_id = m.id
GROUP BY sat.ad, m.sehir
ORDER BY satici, toplam_ciro DESC;
GO

-- =============================================
-- 8. KATEGORİ BAZLI MÜŞTERİ TERCİHLERİ
-- =============================================
PRINT '8. Kategori bazlı müşteri tercihleri:';
GO

SELECT 
    m.sehir,
    k.ad AS kategori,
    COUNT(DISTINCT m.id) AS musteri_sayisi,
    COUNT(s.id) AS siparis_sayisi,
    SUM(sd.adet) AS toplam_urun_adedi,
    SUM(sd.adet * sd.fiyat) AS kategori_cirosu
FROM Musteri m
INNER JOIN Siparis s ON m.id = s.musteri_id
INNER JOIN Siparis_Detay sd ON s.id = sd.siparis_id
INNER JOIN Urun u ON sd.urun_id = u.id
INNER JOIN Kategori k ON u.kategori_id = k.id
GROUP BY m.sehir, k.ad
HAVING COUNT(s.id) >= 2
ORDER BY m.sehir, kategori_cirosu DESC;
GO

-- =============================================
-- 9. CROSS JOIN - TÜM KATEGORİ-SATICI KOMBİNASYONLARI
-- =============================================
PRINT '9. Kategori-Satıcı kombinasyonları:';
GO

SELECT 
    k.ad AS kategori,
    s.ad AS satici,
    ISNULL(COUNT(u.id), 0) AS urun_sayisi
FROM Kategori k
CROSS JOIN Satici s
LEFT JOIN Urun u ON k.id = u.kategori_id AND s.id = u.satici_id
GROUP BY k.ad, s.ad
ORDER BY kategori, satici;
GO

-- =============================================
-- 10. SELF JOIN - AYNI ŞEHİRDEKİ MÜŞTERİLER
-- =============================================
PRINT '10. Aynı şehirdeki müşteriler:';
GO

SELECT DISTINCT
    m1.sehir,
    COUNT(DISTINCT m1.id) AS musteri_sayisi
FROM Musteri m1
INNER JOIN Musteri m2 ON m1.sehir = m2.sehir AND m1.id <> m2.id
GROUP BY m1.sehir
ORDER BY musteri_sayisi DESC;
GO

PRINT 'JOIN sorguları tamamlandı!';
GO