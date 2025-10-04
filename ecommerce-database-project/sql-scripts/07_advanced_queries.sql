-- =============================================
-- Online Alışveriş Platformu Veritabanı
-- Dosya: 07_advanced_queries.sql
-- Açıklama: İleri seviye sorgular (Subqueries, CTE, Window Functions)
-- =============================================

USE OnlineShoppingDB;
GO

-- =============================================
-- 1. EN ÇOK KAZANÇ SAĞLAYAN İLK 3 KATEGORİ
-- =============================================
PRINT '1. En çok kazanç sağlayan ilk 3 kategori:';
GO

SELECT TOP 3
    k.ad AS kategori,
    SUM(sd.adet * sd.fiyat) AS toplam_kazanc,
    COUNT(DISTINCT sd.siparis_id) AS siparis_sayisi,
    SUM(sd.adet) AS satiş_adedi
FROM Kategori k
INNER JOIN Urun u ON k.id = u.kategori_id
INNER JOIN Siparis_Detay sd ON u.id = sd.urun_id
GROUP BY k.ad
ORDER BY toplam_kazanc DESC;
GO

-- =============================================
-- 2. ORTALAMA SİPARİŞ TUTARINI GEÇEN SİPARİŞLER (Subquery)
-- =============================================
PRINT '2. Ortalamanın üzerindeki siparişler:';
GO

SELECT 
    s.id AS siparis_no,
    m.ad + ' ' + m.soyad AS musteri,
    s.tarih,
    s.toplam_tutar,
    s.odeme_turu,
    (SELECT AVG(toplam_tutar) FROM Siparis) AS genel_ortalama,
    s.toplam_tutar - (SELECT AVG(toplam_tutar) FROM Siparis) AS ortalamadan_fark
FROM Siparis s
INNER JOIN Musteri m ON s.musteri_id = m.id
WHERE s.toplam_tutar > (SELECT AVG(toplam_tutar) FROM Siparis)
ORDER BY s.toplam_tutar DESC;
GO

-- =============================================
-- 3. EN AZ BİR KEZ ELEKTRONİK ÜRÜN SATIN ALAN MÜŞTERİLER
-- =============================================
PRINT '3. Elektronik ürün alan müşteriler:';
GO

SELECT DISTINCT
    m.id,
    m.ad + ' ' + m.soyad AS musteri_adi,
    m.sehir,
    (SELECT COUNT(*) 
     FROM Siparis s2 
     WHERE s2.musteri_id = m.id) AS toplam_siparis_sayisi,
    (SELECT SUM(s2.toplam_tutar) 
     FROM Siparis s2 
     WHERE s2.musteri_id = m.id) AS toplam_harcama
FROM Musteri m
WHERE m.id IN (
    SELECT DISTINCT s.musteri_id
    FROM Siparis s
    INNER JOIN Siparis_Detay sd ON s.id = sd.siparis_id
    INNER JOIN Urun u ON sd.urun_id = u.id
    INNER JOIN Kategori k ON u.kategori_id = k.id
    WHERE k.ad = 'Elektronik'
)
ORDER BY toplam_harcama DESC;
GO

-- =============================================
-- 4. CTE İLE AYLIK CİRO ANALİZİ
-- =============================================
PRINT '4. CTE ile aylık ciro analizi:';
GO

WITH AylikCiro AS (
    SELECT 
        YEAR(tarih) AS yil,
        MONTH(tarih) AS ay,
        SUM(toplam_tutar) AS aylik_toplam,
        COUNT(*) AS siparis_sayisi
    FROM Siparis
    GROUP BY YEAR(tarih), MONTH(tarih)
)
SELECT 
    yil,
    ay,
    aylik_toplam,
    siparis_sayisi,
    aylik_toplam / siparis_sayisi AS ortalama_siparis,
    LAG(aylik_toplam) OVER (ORDER BY yil, ay) AS onceki_ay_ciro,
    aylik_toplam - LAG(aylik_toplam) OVER (ORDER BY yil, ay) AS ay_bazli_artis
FROM AylikCiro
ORDER BY yil, ay;
GO

-- =============================================
-- 5. WINDOW FUNCTION - ÜRÜN SATIŞ SIRALAMALARI
-- =============================================
PRINT '5. Kategori içinde ürün satış sıralaması:';
GO

SELECT 
    kategori,
    urun_adi,
    toplam_satis,
    satis_sirasi,
    CASE 
        WHEN satis_sirasi = 1 THEN 'En Çok Satan'
        WHEN satis_sirasi = 2 THEN 'İkinci'
        WHEN satis_sirasi = 3 THEN 'Üçüncü'
        ELSE CAST(satis_sirasi AS NVARCHAR(10)) + '. Sıra'
    END AS kategori_performansi
FROM (
    SELECT 
        k.ad AS kategori,
        u.ad AS urun_adi,
        SUM(sd.adet * sd.fiyat) AS toplam_satis,
        ROW_NUMBER() OVER (PARTITION BY k.ad ORDER BY SUM(sd.adet * sd.fiyat) DESC) AS satis_sirasi
    FROM Kategori k
    INNER JOIN Urun u ON k.id = u.kategori_id
    INNER JOIN Siparis_Detay sd ON u.id = sd.urun_id
    GROUP BY k.ad, u.ad
) AS siralama
WHERE satis_sirasi <= 3
ORDER BY kategori, satis_sirasi;
GO

-- =============================================
-- 6. MÜŞTERİ SADAKAT ANALİZİ (RFM Analizi Basit Versiyonu)
-- =============================================
PRINT '6. Müşteri sadakat analizi (RFM):';
GO

WITH MusteriAnaliz AS (
    SELECT 
        m.id,
        m.ad + ' ' + m.soyad AS musteri_adi,
        DATEDIFF(DAY, MAX(s.tarih), GETDATE()) AS son_alisveriş_gun,
        COUNT(s.id) AS siparis_sayisi,
        SUM(s.toplam_tutar) AS toplam_harcama
    FROM Musteri m
    INNER JOIN Siparis s ON m.id = s.musteri_id
    GROUP BY m.id, m.ad, m.soyad
)
SELECT 
    musteri_adi,
    son_alisveriş_gun AS recency,
    siparis_sayisi AS frequency,
    toplam_harcama AS monetary,
    CASE 
        WHEN son_alisveriş_gun <= 30 AND siparis_sayisi >= 5 THEN 'Şampiyon Müşteri'
        WHEN son_alisveriş_gun <= 60 AND siparis_sayisi >= 3 THEN 'Sadık Müşteri'
        WHEN son_alisveriş_gun <= 90 THEN 'Potansiyel Müşteri'
        ELSE 'Kayıp Risk Müşteri'
    END AS musteri_segmenti
FROM MusteriAnaliz
ORDER BY toplam_harcama DESC;
GO

-- =============================================
-- 7. EN ÇOK BİRLİKTE SATILAN ÜRÜNLER
-- =============================================
PRINT '7. En çok birlikte satılan ürünler:';
GO

SELECT TOP 10
    u1.ad AS urun_1,
    u2.ad AS urun_2,
    COUNT(*) AS birlikte_satiş_sayisi
FROM Siparis_Detay sd1
INNER JOIN Siparis_Detay sd2 ON sd1.siparis_id = sd2.siparis_id AND sd1.urun_id < sd2.urun_id
INNER JOIN Urun u1 ON sd1.urun_id = u1.id
INNER JOIN Urun u2 ON sd2.urun_id = u2.id
GROUP BY u1.ad, u2.ad
ORDER BY birlikte_satiş_sayisi DESC;
GO

-- =============================================
-- 8. RECURSIVE CTE - KATEGORİ HİYERARŞİSİ (Gelecek geliştirmeler için)
-- =============================================
PRINT '8. Kategori analizi:';
GO

SELECT 
    k.ad AS kategori,
    COUNT(u.id) AS urun_sayisi,
    ISNULL(SUM(sd.adet * sd.fiyat), 0) AS kategori_cirosu,
    RANK() OVER (ORDER BY ISNULL(SUM(sd.adet * sd.fiyat), 0) DESC) AS ciro_sirasi
FROM Kategori k
LEFT JOIN Urun u ON k.id = u.kategori_id
LEFT JOIN Siparis_Detay sd ON u.id = sd.urun_id
GROUP BY k.ad
ORDER BY kategori_cirosu DESC;
GO

-- =============================================
-- 9. YÜKSEK DEĞERLİ MÜŞTERİLERİN ÜRÜN TERCİHLERİ
-- =============================================
PRINT '9. VIP müşterilerin ürün tercihleri:';
GO

WITH VIPMusteriler AS (
    SELECT TOP 10 
        m.id
    FROM Musteri m
    INNER JOIN Siparis s ON m.id = s.musteri_id
    GROUP BY m.id
    ORDER BY SUM(s.toplam_tutar) DESC
)
SELECT 
    k.ad AS kategori,
    COUNT(DISTINCT sd.siparis_id) AS vip_siparis_sayisi,
    SUM(sd.adet) AS toplam_adet,
    SUM(sd.adet * sd.fiyat) AS vip_kategori_cirosu
FROM VIPMusteriler vm
INNER JOIN Siparis s ON vm.id = s.musteri_id
INNER JOIN Siparis_Detay sd ON s.id = sd.siparis_id
INNER JOIN Urun u ON sd.urun_id = u.id
INNER JOIN Kategori k ON u.kategori_id = k.id
GROUP BY k.ad
ORDER BY vip_kategori_cirosu DESC;
GO

-- =============================================
-- 10. PERFORMANS RAPORU - SATICI KARŞILAŞTIRMASI
-- =============================================
PRINT '10. Satıcı performans karşılaştırması:';
GO

SELECT 
    s.ad AS satici,
    COUNT(DISTINCT u.id) AS urun_cesidi,
    SUM(u.stok) AS toplam_stok,
    ISNULL(SUM(sd.adet), 0) AS satilan_adet,
    ISNULL(SUM(sd.adet * sd.fiyat), 0) AS toplam_ciro,
    CASE 
        WHEN ISNULL(SUM(sd.adet * sd.fiyat), 0) >= 100000 THEN 'Yıldız Satıcı'
        WHEN ISNULL(SUM(sd.adet * sd.fiyat), 0) >= 50000 THEN 'Başarılı Satıcı'
        WHEN ISNULL(SUM(sd.adet * sd.fiyat), 0) >= 10000 THEN 'Orta Satıcı'
        ELSE 'Gelişmeli Satıcı'
    END AS performans_seviyesi
FROM Satici s
INNER JOIN Urun u ON s.id = u.satici_id
LEFT JOIN Siparis_Detay sd ON u.id = sd.urun_id
GROUP BY s.ad
ORDER BY toplam_ciro DESC;
GO

PRINT 'İleri seviye sorgular tamamlandı!';
GO