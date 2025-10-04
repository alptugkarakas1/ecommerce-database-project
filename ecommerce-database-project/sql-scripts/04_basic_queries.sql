-- =============================================
-- Online Alışveriş Platformu Veritabanı
-- Dosya: 04_basic_queries.sql
-- Açıklama: Temel sorgular ve raporlama
-- =============================================

USE OnlineShoppingDB;
GO

-- =============================================
-- 1. EN ÇOK SİPARİŞ VEREN 5 MÜŞTERİ
-- =============================================
PRINT '1. En çok sipariş veren 5 müşteri:';
GO

SELECT TOP 5
    m.id,
    m.ad + ' ' + m.soyad AS musteri_adi,
    m.sehir,
    COUNT(s.id) AS siparis_sayisi,
    SUM(s.toplam_tutar) AS toplam_harcama
FROM Musteri m
INNER JOIN Siparis s ON m.id = s.musteri_id
GROUP BY m.id, m.ad, m.soyad, m.sehir
ORDER BY siparis_sayisi DESC;
GO

-- =============================================
-- 2. EN ÇOK SATILAN ÜRÜNLER (Top 10)
-- =============================================
PRINT '2. En çok satılan ürünler:';
GO

SELECT TOP 10
    u.id,
    u.ad AS urun_adi,
    k.ad AS kategori,
    SUM(sd.adet) AS toplam_satis_adedi,
    SUM(sd.adet * sd.fiyat) AS toplam_ciro
FROM Urun u
INNER JOIN Siparis_Detay sd ON u.id = sd.urun_id
INNER JOIN Kategori k ON u.kategori_id = k.id
GROUP BY u.id, u.ad, k.ad
ORDER BY toplam_satis_adedi DESC;
GO

-- =============================================
-- 3. EN YÜKSEK CİROSU OLAN SATICILAR
-- =============================================
PRINT '3. En yüksek cirosu olan satıcılar:';
GO

SELECT 
    s.id,
    s.ad AS satici_adi,
    COUNT(DISTINCT sd.siparis_id) AS siparis_sayisi,
    SUM(sd.adet * sd.fiyat) AS toplam_ciro
FROM Satici s
INNER JOIN Urun u ON s.id = u.satici_id
INNER JOIN Siparis_Detay sd ON u.id = sd.urun_id
GROUP BY s.id, s.ad
ORDER BY toplam_ciro DESC;
GO

-- =============================================
-- 4. KATEGORILERE GÖRE ÜRÜN SAYISI
-- =============================================
PRINT '4. Kategorilere göre ürün sayısı:';
GO

SELECT 
    k.ad AS kategori_adi,
    COUNT(u.id) AS urun_sayisi,
    AVG(u.fiyat) AS ortalama_fiyat,
    SUM(u.stok) AS toplam_stok
FROM Kategori k
LEFT JOIN Urun u ON k.id = u.kategori_id
GROUP BY k.ad
ORDER BY urun_sayisi DESC;
GO

-- =============================================
-- 5. ÖDEME TÜRÜNE GÖRE SİPARİŞ DAĞILIMI
-- =============================================
PRINT '5. Ödeme türüne göre sipariş dağılımı:';
GO

SELECT 
    odeme_turu,
    COUNT(*) AS siparis_sayisi,
    SUM(toplam_tutar) AS toplam_tutar,
    AVG(toplam_tutar) AS ortalama_siparis_tutari
FROM Siparis
GROUP BY odeme_turu
ORDER BY siparis_sayisi DESC;
GO

-- =============================================
-- 6. EN PAHALΙ 10 ÜRÜN
-- =============================================
PRINT '6. En pahalı 10 ürün:';
GO

SELECT TOP 10
    u.ad AS urun_adi,
    u.fiyat,
    k.ad AS kategori,
    s.ad AS satici,
    u.stok
FROM Urun u
INNER JOIN Kategori k ON u.kategori_id = k.id
INNER JOIN Satici s ON u.satici_id = s.id
ORDER BY u.fiyat DESC;
GO

-- =============================================
-- 7. STOK DURUM RAPORU (Düşük Stoklu Ürünler)
-- =============================================
PRINT '7. Düşük stoklu ürünler (Stok < 20):';
GO

SELECT 
    u.ad AS urun_adi,
    u.stok,
    u.fiyat,
    k.ad AS kategori,
    s.ad AS satici
FROM Urun u
INNER JOIN Kategori k ON u.kategori_id = k.id
INNER JOIN Satici s ON u.satici_id = s.id
WHERE u.stok < 20
ORDER BY u.stok ASC;
GO

-- =============================================
-- 8. GÜNLÜK SİPARİŞ İSTATİSTİKLERİ
-- =============================================
PRINT '8. Günlük sipariş istatistikleri:';
GO

SELECT 
    CAST(tarih AS DATE) AS tarih,
    COUNT(*) AS siparis_sayisi,
    SUM(toplam_tutar) AS gunluk_ciro,
    AVG(toplam_tutar) AS ortalama_siparis
FROM Siparis
GROUP BY CAST(tarih AS DATE)
ORDER BY tarih DESC;
GO

PRINT 'Temel sorgular tamamlandı!';
GO