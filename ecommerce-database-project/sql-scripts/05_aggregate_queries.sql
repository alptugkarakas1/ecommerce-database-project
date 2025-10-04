-- =============================================
-- Online Alışveriş Platformu Veritabanı
-- Dosya: 05_aggregate_queries.sql
-- Açıklama: Aggregate ve Group By sorguları
-- =============================================

USE OnlineShoppingDB;
GO

-- =============================================
-- 1. ŞEHİRLERE GÖRE MÜŞTERİ SAYISI
-- =============================================
PRINT '1. Şehirlere göre müşteri sayısı:';
GO

SELECT 
    sehir,
    COUNT(*) AS musteri_sayisi,
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Musteri) AS yuzde_dagilim
FROM Musteri
GROUP BY sehir
ORDER BY musteri_sayisi DESC;
GO

-- =============================================
-- 2. KATEGORİ BAZLI TOPLAM SATIŞLAR
-- =============================================
PRINT '2. Kategori bazlı toplam satışlar:';
GO

SELECT 
    k.ad AS kategori_adi,
    COUNT(DISTINCT sd.siparis_id) AS siparis_sayisi,
    SUM(sd.adet) AS toplam_urun_adedi,
    SUM(sd.adet * sd.fiyat) AS toplam_satis,
    AVG(sd.fiyat) AS ortalama_urun_fiyati
FROM Kategori k
INNER JOIN Urun u ON k.id = u.kategori_id
INNER JOIN Siparis_Detay sd ON u.id = sd.urun_id
GROUP BY k.ad
ORDER BY toplam_satis DESC;
GO

-- =============================================
-- 3. AYLARA GÖRE SİPARİŞ SAYISI VE CİRO
-- =============================================
PRINT '3. Aylara göre sipariş analizi:';
GO

SELECT 
    YEAR(tarih) AS yil,
    MONTH(tarih) AS ay,
    DATENAME(MONTH, tarih) AS ay_adi,
    COUNT(*) AS siparis_sayisi,
    SUM(toplam_tutar) AS aylik_ciro,
    AVG(toplam_tutar) AS ortalama_siparis
FROM Siparis
GROUP BY YEAR(tarih), MONTH(tarih), DATENAME(MONTH, tarih)
ORDER BY yil, ay;
GO

-- =============================================
-- 4. ŞEHİR VE KATEGORİ BAZLI ANALİZ
-- =============================================
PRINT '4. Şehir ve kategori bazlı satış analizi:';
GO

SELECT 
    m.sehir,
    k.ad AS kategori,
    COUNT(DISTINCT s.id) AS siparis_sayisi,
    SUM(sd.adet * sd.fiyat) AS toplam_satis
FROM Musteri m
INNER JOIN Siparis s ON m.id = s.musteri_id
INNER JOIN Siparis_Detay sd ON s.id = sd.siparis_id
INNER JOIN Urun u ON sd.urun_id = u.id
INNER JOIN Kategori k ON u.kategori_id = k.id
GROUP BY m.sehir, k.ad
HAVING SUM(sd.adet * sd.fiyat) > 5000
ORDER BY m.sehir, toplam_satis DESC;
GO

-- =============================================
-- 5. SATICI PERFORMANS ANALİZİ
-- =============================================
PRINT '5. Satıcı performans analizi:';
GO

SELECT 
    s.ad AS satici_adi,
    COUNT(DISTINCT u.id) AS urun_sayisi,
    COUNT(DISTINCT sd.siparis_id) AS siparis_sayisi,
    SUM(sd.adet) AS toplam_satis_adedi,
    SUM(sd.adet * sd.fiyat) AS toplam_ciro,
    AVG(sd.fiyat) AS ortalama_urun_fiyati
FROM Satici s
INNER JOIN Urun u ON s.id = u.satici_id
INNER JOIN Siparis_Detay sd ON u.id = sd.urun_id
GROUP BY s.ad
ORDER BY toplam_ciro DESC;
GO

-- =============================================
-- 6. ÇEYREK BAZLI CİRO ANALİZİ
-- =============================================
PRINT '6. Çeyrek bazlı ciro analizi:';
GO

SELECT 
    YEAR(tarih) AS yil,
    DATEPART(QUARTER, tarih) AS ceyrek,
    COUNT(*) AS siparis_sayisi,
    SUM(toplam_tutar) AS ceyrek_cirosu,
    AVG(toplam_tutar) AS ortalama_siparis,
    MIN(toplam_tutar) AS min_siparis,
    MAX(toplam_tutar) AS max_siparis
FROM Siparis
GROUP BY YEAR(tarih), DATEPART(QUARTER, tarih)
ORDER BY yil, ceyrek;
GO

-- =============================================
-- 7. MÜŞTERİ SEGMENTASYONu (Harcama Bazlı)
-- =============================================
PRINT '7. Müşteri segmentasyonu:';
GO

SELECT 
    CASE 
        WHEN toplam_harcama >= 50000 THEN 'VIP Müşteri'
        WHEN toplam_harcama >= 20000 THEN 'Sadık Müşteri'
        WHEN toplam_harcama >= 5000 THEN 'Orta Müşteri'
        ELSE 'Yeni Müşteri'
    END AS musteri_segmenti,
    COUNT(*) AS musteri_sayisi,
    AVG(toplam_harcama) AS ortalama_harcama,
    SUM(toplam_harcama) AS segment_cirosu
FROM (
    SELECT 
        m.id,
        SUM(s.toplam_tutar) AS toplam_harcama
    FROM Musteri m
    INNER JOIN Siparis s ON m.id = s.musteri_id
    GROUP BY m.id
) AS musteri_harcamalari
GROUP BY 
    CASE 
        WHEN toplam_harcama >= 50000 THEN 'VIP Müşteri'
        WHEN toplam_harcama >= 20000 THEN 'Sadık Müşteri'
        WHEN toplam_harcama >= 5000 THEN 'Orta Müşteri'
        ELSE 'Yeni Müşteri'
    END
ORDER BY 
    CASE musteri_segmenti
        WHEN 'VIP Müşteri' THEN 1
        WHEN 'Sadık Müşteri' THEN 2
        WHEN 'Orta Müşteri' THEN 3
        ELSE 4
    END;
GO

-- =============================================
-- 8. HAFTALIK SİPARİŞ TRENDİ
-- =============================================
PRINT '8. Haftalık sipariş trendi:';
GO

SELECT 
    DATEPART(WEEK, tarih) AS hafta_no,
    DATENAME(WEEKDAY, tarih) AS gun_adi,
    COUNT(*) AS siparis_sayisi,
    SUM(toplam_tutar) AS haftalik_ciro
FROM Siparis
GROUP BY DATEPART(WEEK, tarih), DATENAME(WEEKDAY, tarih)
ORDER BY hafta_no;
GO

PRINT 'Aggregate sorgular tamamlandı!';
GO