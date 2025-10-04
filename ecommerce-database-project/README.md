# 🛒 Online Alışveriş Platformu Veritabanı Projesi

## 📋 Proje Hakkında
Bu proje, modern bir e-ticaret platformunun (Trendyol, Hepsiburada, Amazon benzeri) veritabanı tasarımını ve yönetimini içermektedir. SQL Server kullanılarak geliştirilmiştir.

## 🎯 Projenin Amacı
- Gerçek dünya e-ticaret sistemini modelleme
- İlişkisel veritabanı tasarımı
- Karmaşık SQL sorgularıyla veri analizi
- Raporlama ve iş zekası sorguları

## 📊 Veritabanı Yapısı

### Tablolar ve İlişkiler

#### 1. **Musteri** (Müşteri Bilgileri)
- `id` (PRIMARY KEY)
- `ad`, `soyad`, `email`
- `sehir`, `kayit_tarihi`

#### 2. **Kategori** (Ürün Kategorileri)
- `id` (PRIMARY KEY)
- `ad`

#### 3. **Satici** (Satıcı Bilgileri)
- `id` (PRIMARY KEY)
- `ad`, `adres`

#### 4. **Urun** (Ürün Bilgileri)
- `id` (PRIMARY KEY)
- `ad`, `fiyat`, `stok`
- `kategori_id` (FOREIGN KEY → Kategori)
- `satici_id` (FOREIGN KEY → Satici)

#### 5. **Siparis** (Sipariş Ana Bilgileri)
- `id` (PRIMARY KEY)
- `musteri_id` (FOREIGN KEY → Musteri)
- `tarih`, `toplam_tutar`, `odeme_turu`

#### 6. **Siparis_Detay** (Sipariş Detayları)
- `id` (PRIMARY KEY)
- `siparis_id` (FOREIGN KEY → Siparis)
- `urun_id` (FOREIGN KEY → Urun)
- `adet`, `fiyat`

### ER Diyagram İlişkileri
```
Musteri (1) ──────< (N) Siparis
Siparis (1) ──────< (N) Siparis_Detay
Urun (1) ──────< (N) Siparis_Detay
Kategori (1) ──────< (N) Urun
Satici (1) ──────< (N) Urun
```

## 📁 Proje Dosya Yapısı

```
📦 ecommerce-database-project
 ┣ 📂 sql-scripts
 ┃ ┣ 📜 01_create_database.sql       # Veritabanı oluşturma
 ┃ ┣ 📜 02_create_tables.sql         # Tablo yapıları
 ┃ ┣ 📜 03_insert_data.sql           # Örnek veri ekleme
 ┃ ┣ 📜 04_basic_queries.sql         # Temel sorgular
 ┃ ┣ 📜 05_aggregate_queries.sql     # Gruplama ve toplama
 ┃ ┣ 📜 06_join_queries.sql          # JOIN sorguları
 ┃ ┣ 📜 07_advanced_queries.sql      # İleri seviye sorgular
 ┃ ┗ 📜 08_update_delete.sql         # Güncelleme ve silme
 ┣ 📂 documentation
 ┃ ┣ 📜 ER_Diagram.md                # ER Diyagram açıklaması
 ┃ ┗ 📜 Project_Report.md            # Proje raporu
 ┣ 📜 README.md                      # Bu dosya
 ┗ 📜 .gitignore                     # Git ignore dosyası
```

## 🚀 Kurulum ve Kullanım

### Gereksinimler
- SQL Server 2019 veya üzeri
- SQL Server Management Studio (SSMS)

### Adım Adım Kurulum

1. **Repository'yi klonlayın**
```bash
git clone https://github.com/kullaniciadi/ecommerce-database-project.git
cd ecommerce-database-project
```

2. **SQL Server Management Studio'yu açın**

3. **Scriptleri sırasıyla çalıştırın**
   - `01_create_database.sql` - Veritabanını oluşturur
   - `02_create_tables.sql` - Tabloları oluşturur
   - `03_insert_data.sql` - Örnek verileri ekler
   - Diğer scriptler - Sorgu örnekleri

## 📈 Veri Seti İstatistikleri

- **50 Müşteri** - Farklı şehirlerden
- **10 Kategori** - Elektronik, Moda, Ev & Yaşam, vb.
- **15 Satıcı** - Çeşitli satıcı profilleri
- **100 Ürün** - Her kategoriden ürünler
- **150 Sipariş** - Gerçekçi sipariş dağılımı
- **300+ Sipariş Detayı** - Detaylı sipariş kalemleri

## 🔍 Örnek Sorgular

### Temel Raporlar
- ✅ En çok sipariş veren 5 müşteri
- ✅ En çok satılan ürünler
- ✅ En yüksek cirosu olan satıcılar
- ✅ Şehirlere göre müşteri dağılımı

### Aggregate & Group By
- ✅ Kategori bazlı toplam satışlar
- ✅ Aylara göre sipariş analizi
- ✅ Ortalama sipariş tutarları

### JOIN Sorguları
- ✅ Detaylı sipariş raporları (Müşteri + Ürün + Satıcı)
- ✅ Hiç satılmamış ürünler
- ✅ Hiç sipariş vermemiş müşteriler

### İleri Seviye
- ✅ En çok kazanç sağlayan kategoriler
- ✅ Ortalamanın üzerindeki siparişler
- ✅ Kategori bazlı müşteri segmentasyonu

## 🛠️ Teknik Detaylar

### Kullanılan SQL Özellikleri
- `CREATE TABLE` - Tablo oluşturma
- `PRIMARY KEY` & `FOREIGN KEY` - İlişkisel bütünlük
- `INSERT`, `UPDATE`, `DELETE` - Veri manipülasyonu
- `JOIN` (INNER, LEFT, RIGHT) - Tablo birleştirme
- `GROUP BY`, `HAVING` - Gruplama ve filtreleme
- `Aggregate Functions` (SUM, COUNT, AVG, MAX, MIN)
- `Subqueries` - Alt sorgular
- `ORDER BY` - Sıralama

### Performans İyileştirmeleri
- Primary key'ler otomatik olarak indexlenir
- Foreign key ilişkileri performans için optimize edilmiştir
- Sık kullanılan sorgular için index önerileri dokümantasyonda

## 📖 Dokümantasyon

Detaylı bilgi için `documentation` klasörüne bakınız:
- **ER_Diagram.md**: Veritabanı tasarım detayları
- **Project_Report.md**: Proje geliştirme süreci, karşılaşılan sorunlar ve çözümler

## 🎓 Öğrenme Çıktıları

Bu proje ile:
- ✅ İlişkisel veritabanı tasarımı prensiplerine hakim oldum
- ✅ Normalizasyon kurallarını uyguladım
- ✅ Karmaşık JOIN ve subquery sorgularını yazdım
- ✅ İş analitiği için SQL raporları oluşturdum
- ✅ Veri bütünlüğü ve constraint yönetimi öğrendim

## 👤 Geliştirici

**Alptuğ Karakaş**
- 📧 Email: alptugkarakas1@gmail.com
- 📅 Proje Tarihi: Ekim 2025