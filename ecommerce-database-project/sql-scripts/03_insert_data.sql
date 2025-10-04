-- =============================================
-- Online Alışveriş Platformu Veritabanı
-- Dosya: 03_insert_data.sql
-- Açıklama: Örnek veri ekleme scripti (50 müşteri, 100 ürün, 150 sipariş)
-- =============================================

USE OnlineShoppingDB;
GO

-- =============================================
-- 1. KATEGORİ VERİLERİ (10 Kategori)
-- =============================================
INSERT INTO Kategori (ad) VALUES
('Elektronik'),
('Moda & Giyim'),
('Ev & Yaşam'),
('Kitap & Müzik'),
('Spor & Outdoor'),
('Kozmetik & Kişisel Bakım'),
('Oyuncak & Hobi'),
('Otomotiv'),
('Anne & Bebek'),
('Süpermarket');
GO

-- =============================================
-- 2. SATICI VERİLERİ (15 Satıcı)
-- =============================================
INSERT INTO Satici (ad, adres) VALUES
('TechMaster Store', 'İstanbul, Kadıköy'),
('Fashion Point', 'Ankara, Çankaya'),
('Home Decor Co', 'İzmir, Bornova'),
('BookWorld', 'İstanbul, Beyoğlu'),
('Sport Plus', 'Bursa, Nilüfer'),
('BeautyZone', 'Antalya, Muratpaşa'),
('ToyLand', 'İstanbul, Üsküdar'),
('AutoParts Pro', 'Kocaeli, Gebze'),
('Baby Care', 'İzmir, Konak'),
('Fresh Market', 'Ankara, Keçiören'),
('Digital World', 'İstanbul, Şişli'),
('Style House', 'İzmir, Karşıyaka'),
('Smart Home', 'Ankara, Yenimahalle'),
('Sports Arena', 'İstanbul, Beşiktaş'),
('Family Shop', 'Bursa, Osmangazi');
GO

-- =============================================
-- 3. MÜŞTERİ VERİLERİ (50 Müşteri)
-- =============================================
INSERT INTO Musteri (ad, soyad, email, sehir, kayit_tarihi) VALUES
('Ahmet', 'Yılmaz', 'ahmet.yilmaz@email.com', 'İstanbul', '2024-01-15'),
('Ayşe', 'Demir', 'ayse.demir@email.com', 'Ankara', '2024-01-20'),
('Mehmet', 'Kaya', 'mehmet.kaya@email.com', 'İzmir', '2024-02-05'),
('Fatma', 'Şahin', 'fatma.sahin@email.com', 'İstanbul', '2024-02-10'),
('Ali', 'Çelik', 'ali.celik@email.com', 'Bursa', '2024-02-15'),
('Zeynep', 'Aydın', 'zeynep.aydin@email.com', 'Antalya', '2024-03-01'),
('Mustafa', 'Öztürk', 'mustafa.ozturk@email.com', 'İstanbul', '2024-03-05'),
('Elif', 'Arslan', 'elif.arslan@email.com', 'Ankara', '2024-03-10'),
('Hüseyin', 'Doğan', 'huseyin.dogan@email.com', 'İzmir', '2024-03-15'),
('Emine', 'Yıldız', 'emine.yildiz@email.com', 'Kocaeli', '2024-03-20'),
('Can', 'Kurt', 'can.kurt@email.com', 'İstanbul', '2024-04-01'),
('Merve', 'Koç', 'merve.koc@email.com', 'Ankara', '2024-04-05'),
('Burak', 'Aksoy', 'burak.aksoy@email.com', 'İzmir', '2024-04-10'),
('Selin', 'Özkan', 'selin.ozkan@email.com', 'Bursa', '2024-04-15'),
('Emre', 'Yavuz', 'emre.yavuz@email.com', 'İstanbul', '2024-04-20'),
('Deniz', 'Polat', 'deniz.polat@email.com', 'Antalya', '2024-05-01'),
('Berk', 'Güneş', 'berk.gunes@email.com', 'İstanbul', '2024-05-05'),
('Sude', 'Taş', 'sude.tas@email.com', 'Ankara', '2024-05-10'),
('Cem', 'Bulut', 'cem.bulut@email.com', 'İzmir', '2024-05-15'),
('Naz', 'Yıldırım', 'naz.yildirim@email.com', 'İstanbul', '2024-05-20'),
('Onur', 'Çiftçi', 'onur.ciftci@email.com', 'Kocaeli', '2024-06-01'),
('Esra', 'Acar', 'esra.acar@email.com', 'İstanbul', '2024-06-05'),
('Barış', 'Şimşek', 'baris.simsek@email.com', 'Ankara', '2024-06-10'),
('İrem', 'Konak', 'irem.konak@email.com', 'İzmir', '2024-06-15'),
('Kaan', 'Erdoğan', 'kaan.erdogan@email.com', 'Bursa', '2024-06-20'),
('Gizem', 'Kaplan', 'gizem.kaplan@email.com', 'İstanbul', '2024-07-01'),
('Tolga', 'Duman', 'tolga.duman@email.com', 'Antalya', '2024-07-05'),
('Hazal', 'Aslan', 'hazal.aslan@email.com', 'İstanbul', '2024-07-10'),
('Oğuz', 'Korkmaz', 'oguz.korkmaz@email.com', 'Ankara', '2024-07-15'),
('Ece', 'Durmaz', 'ece.durmaz@email.com', 'İzmir', '2024-07-20'),
('Serkan', 'Yaman', 'serkan.yaman@email.com', 'İstanbul', '2024-08-01'),
('Burcu', 'Özdemir', 'burcu.ozdemir@email.com', 'Kocaeli', '2024-08-05'),
('Murat', 'Erdem', 'murat.erdem@email.com', 'İstanbul', '2024-08-10'),
('Pınar', 'Sözer', 'pinar.sozer@email.com', 'Ankara', '2024-08-15'),
('Cenk', 'Akın', 'cenk.akin@email.com', 'İzmir', '2024-08-20'),
('Tuğba', 'Tekin', 'tugba.tekin@email.com', 'Bursa', '2024-09-01'),
('Volkan', 'Başar', 'volkan.basar@email.com', 'İstanbul', '2024-09-05'),
('Gamze', 'Ünlü', 'gamze.unlu@email.com', 'Antalya', '2024-09-10'),
('Hakan', 'Balcı', 'hakan.balci@email.com', 'İstanbul', '2024-09-15'),
('Canan', 'Uysal', 'canan.uysal@email.com', 'Ankara', '2024-09-20'),
('Sinan', 'Karadağ', 'sinan.karadag@email.com', 'İzmir', '2024-09-25'),
('Aylin', 'Mutlu', 'aylin.mutlu@email.com', 'İstanbul', '2024-09-28'),
('Kerem', 'Ceylan', 'kerem.ceylan@email.com', 'Kocaeli', '2024-09-29'),
('Dilara', 'Uğur', 'dilara.ugur@email.com', 'İstanbul', '2024-09-30'),
('Taner', 'Özer', 'taner.ozer@email.com', 'Ankara', '2024-09-30'),
('Sibel', 'Kır', 'sibel.kir@email.com', 'İzmir', '2024-09-30'),
('Yusuf', 'Sarı', 'yusuf.sari@email.com', 'Bursa', '2024-09-30'),
('Sevgi', 'Yüksel', 'sevgi.yuksel@email.com', 'İstanbul', '2024-09-30'),
('Tarkan', 'Bozkurt', 'tarkan.bozkurt@email.com', 'Antalya', '2024-09-30'),
('Fulya', 'Keskin', 'fulya.keskin@email.com', 'İstanbul', '2024-09-30');
GO

-- =============================================
-- 4. ÜRÜN VERİLERİ (100 Ürün)
-- =============================================

-- Elektronik (10 ürün)
INSERT INTO Urun (ad, fiyat, stok, kategori_id, satici_id) VALUES
('iPhone 15 Pro', 45999.99, 25, 1, 1),
('Samsung Galaxy S24', 38999.99, 30, 1, 1),
('MacBook Air M2', 42999.99, 15, 1, 11),
('iPad Pro 12.9"', 35999.99, 20, 1, 1),
('Sony WH-1000XM5 Kulaklık', 8999.99, 40, 1, 11),
('LG 55" OLED TV', 28999.99, 12, 1, 11),
('Canon EOS R6 Fotoğraf Makinesi', 52999.99, 8, 1, 1),
('PlayStation 5', 18999.99, 10, 1, 11),
('Nintendo Switch OLED', 8499.99, 22, 1, 1),
('Apple Watch Series 9', 12999.99, 35, 1, 11);

-- Moda & Giyim (10 ürün)
INSERT INTO Urun (ad, fiyat, stok, kategori_id, satici_id) VALUES
('Levi''s 501 Kot Pantolon', 899.99, 50, 2, 2),
('Nike Air Max Spor Ayakkabı', 2499.99, 45, 2, 2),
('Zara Kadın Ceket', 1299.99, 30, 2, 12),
('Mavi Erkek Gömlek', 449.99, 60, 2, 2),
('Adidas Eşofman Takımı', 1599.99, 40, 2, 12),
('Koton Kadın Elbise', 699.99, 35, 2, 2),
('LC Waikiki Sweatshirt', 349.99, 70, 2, 12),
('Pull&Bear Jean Ceket', 799.99, 25, 2, 2),
('H&M Basic Tişört', 199.99, 100, 2, 12),
('Puma Günlük Ayakkabı', 1799.99, 38, 2, 2);

-- Ev & Yaşam (10 ürün)
INSERT INTO Urun (ad, fiyat, stok, kategori_id, satici_id) VALUES
('Philips Airfryer', 3299.99, 28, 3, 3),
('Karaca Çeyiz Seti 85 Parça', 4999.99, 15, 3, 3),
('Arzum Blender', 899.99, 45, 3, 13),
('Fakir Süpürge', 2499.99, 20, 3, 3),
('English Home Yatak Örtüsü', 649.99, 50, 3, 13),
('Madame Coco Koltuk Takımı', 18999.99, 5, 3, 3),
('Tefal Tencere Seti', 1299.99, 35, 3, 13),
('İkea Çalışma Masası', 2999.99, 12, 3, 3),
('Jumbo Halı 200x300', 4499.99, 18, 3, 13),
('Vivense Kanepe', 12999.99, 8, 3, 3);

-- Kitap & Müzik (10 ürün)
INSERT INTO Urun (ad, fiyat, stok, kategori_id, satici_id) VALUES
('Suç ve Ceza - Dostoyevski', 89.99, 100, 4, 4),
('1984 - George Orwell', 79.99, 80, 4, 4),
('Simyacı - Paulo Coelho', 69.99, 120, 4, 4),
('Tutunamayanlar - Oğuz Atay', 99.99, 60, 4, 4),
('İnce Memed - Yaşar Kemal', 75.99, 70, 4, 4),
('Yamaha Akustik Gitar', 3499.99, 15, 4, 4),
('Marshall Bluetooth Hoparlör', 2899.99, 25, 4, 4),
('Kürk Mantolu Madonna', 65.99, 90, 4, 4),
('Harry Potter Seti', 599.99, 40, 4, 4),
('Game of Thrones Kitap Seti', 899.99, 30, 4, 4);

-- Spor & Outdoor (10 ürün)
INSERT INTO Urun (ad, fiyat, stok, kategori_id, satici_id) VALUES
('Decathlon Koşu Bandı', 4999.99, 10, 5, 5),
('Wilson Tenis Raketi', 1299.99, 25, 5, 5),
('Domyos Yoga Matı', 249.99, 60, 5, 14),
('Quechua Çadır 3 Kişilik', 2199.99, 18, 5, 5),
('Nike Futbol Topu', 399.99, 50, 5, 14),
('Reebok Dambıl Seti', 899.99, 30, 5, 5),
('Columbia Outdoor Ceket', 3499.99, 22, 5, 14),
('The North Face Sırt Çantası', 1899.99, 35, 5, 5),
('Salomon Trekking Ayakkabısı', 2799.99, 28, 5, 14),
('Speedo Yüzücü Gözlüğü', 299.99, 45, 5, 5);

-- Kozmetik & Kişisel Bakım (10 ürün)
INSERT INTO Urun (ad, fiyat, stok, kategori_id, satici_id) VALUES
('L''Oreal Paris Krem', 249.99, 80, 6, 6),
('MAC Ruj', 449.99, 60, 6, 6),
('Nivea Cilt Bakım Seti', 199.99, 100, 6, 6),
('Braun Epilasyon Cihazı', 1899.99, 25, 6, 6),
('Philips Saç Kurutma Makinesi', 899.99, 40, 6, 6),
('Maybelline Maskara', 149.99, 90, 6, 6),
('Garnier Güneş Kremi', 179.99, 70, 6, 6),
('The Ordinary Serum', 349.99, 55, 6, 6),
('Johnson''s Baby Şampuan', 89.99, 120, 6, 6),
('Gillette Tıraş Bıçağı Seti', 199.99, 75, 6, 6);

-- Oyuncak & Hobi (10 ürün)
INSERT INTO Urun (ad, fiyat, stok, kategori_id, satici_id) VALUES
('LEGO Star Wars Seti', 1499.99, 30, 7, 7),
('Barbie Bebek', 349.99, 50, 7, 7),
('Hot Wheels Araba Seti', 199.99, 60, 7, 7),
('Monopoly Türkiye', 299.99, 45, 7, 7),
('Hasbro Puzzle 1000 Parça', 149.99, 55, 7, 7),
('Nerf Oyuncak Silah', 449.99, 35, 7, 7),
('Baby Alive Bebek', 599.99, 28, 7, 7),
('Ravensburger Kutu Oyunu', 249.99, 40, 7, 7),
('RC Helikopter', 899.99, 20, 7, 7),
('Play-Doh Hamur Seti', 179.99, 70, 7, 7);

-- Otomotiv (10 ürün)
INSERT INTO Urun (ad, fiyat, stok, kategori_id, satici_id) VALUES
('Bosch Akü', 1899.99, 25, 8, 8),
('Michelin Lastik Set', 4999.99, 15, 8, 8),
('Turtle Wax Cila', 299.99, 50, 8, 8),
('Garmin Navigasyon', 2499.99, 20, 8, 8),
('Xiaomi Araç Kamerası', 1299.99, 30, 8, 8),
('Castrol Motor Yağı', 449.99, 60, 8, 8),
('Osram Far Ampülü', 199.99, 80, 8, 8),
('3M Cam Filmi', 899.99, 35, 8, 8),
('Pioneer Oto Teyp', 1799.99, 22, 8, 8),
('Temsa Araç Paspası', 349.99, 45, 8, 8);

-- Anne & Bebek (10 ürün)
INSERT INTO Urun (ad, fiyat, stok, kategori_id, satici_id) VALUES
('Chicco Bebek Arabası', 3499.99, 18, 9, 9),
('Maxi-Cosi Oto Koltuğu', 2899.99, 20, 9, 9),
('Philips Avent Biberon Seti', 349.99, 60, 9, 9),
('Sleepy Bebek Bezi 5 No', 249.99, 100, 9, 9),
('Prima Islak Mendil', 89.99, 150, 9, 9),
('Mamas&Papas Park Yatak', 1799.99, 15, 9, 9),
('Beaba Mama Sandalyesi', 1299.99, 25, 9, 9),
('Tommee Tippee Emzik', 99.99, 80, 9, 9),
('Mothercare Bebek Battaniyesi', 299.99, 50, 9, 9),
('Baby Jem Banyo Küveti', 399.99, 35, 9, 9);

-- Süpermarket (10 ürün)
INSERT INTO Urun (ad, fiyat, stok, kategori_id, satici_id) VALUES
('Ülker Çikolata 80g', 15.99, 200, 10, 10),
('Nescafe Gold 200g', 189.99, 120, 10, 10),
('Pınar Süt 1L', 32.99, 150, 10, 10),
('Selpak Kağıt Havlu', 45.99, 100, 10, 10),
('Orkid Tuvalet Kağıdı', 89.99, 80, 10, 10),
('Domestos Çamaşır Suyu', 34.99, 90, 10, 10),
('Fairy Bulaşık Deterjanı', 52.99, 110, 10, 10),
('Duru Sabun 4lü', 39.99, 130, 10, 10),
('Eti Burçak 175g', 19.99, 180, 10, 10),
('Yudum Ayçiçek Yağı 5L', 259.99, 70, 10, 10);
GO

PRINT '100 ürün başarıyla eklendi!';
GO

-- =============================================
-- 5. SİPARİŞ VERİLERİ (150 Sipariş)
-- Bu kısımda gerçekçi siparişler oluşturuyoruz
-- =============================================

-- Ocak 2024 Siparişleri (15 sipariş)
INSERT INTO Siparis (musteri_id, tarih, toplam_tutar, odeme_turu) VALUES
(1, '2024-01-16 10:30:00', 46899.98, 'Kredi Kartı'),
(2, '2024-01-21 14:15:00', 1349.98, 'Banka Kartı'),
(3, '2024-01-22 09:45:00', 3549.98, 'Kredi Kartı'),
(4, '2024-01-25 16:20:00', 899.99, 'Kapıda Ödeme'),
(5, '2024-01-26 11:30:00', 2499.99, 'Kredi Kartı'),
(6, '2024-01-28 13:40:00', 649.98, 'Banka Kartı'),
(7, '2024-01-29 15:10:00', 4999.99, 'Havale'),
(8, '2024-01-30 10:20:00', 1299.98, 'Kredi Kartı'),
(9, '2024-01-30 14:50:00', 549.97, 'Banka Kartı'),
(10, '2024-01-31 09:15:00', 8999.99, 'Kredi Kartı'),
(11, '2024-01-31 16:30:00', 2899.98, 'Banka Kartı'),
(12, '2024-01-31 11:45:00', 899.99, 'Kapıda Ödeme'),
(13, '2024-01-31 13:20:00', 1799.99, 'Kredi Kartı'),
(14, '2024-01-31 15:40:00', 3499.99, 'Banka Kartı'),
(15, '2024-01-31 17:10:00', 12999.99, 'Havale');

-- Şubat 2024 Siparişleri (20 sipariş)
INSERT INTO Siparis (musteri_id, tarih, toplam_tutar, odeme_turu) VALUES
(16, '2024-02-01 10:30:00', 35999.99, 'Kredi Kartı'),
(17, '2024-02-02 14:20:00', 1599.98, 'Banka Kartı'),
(18, '2024