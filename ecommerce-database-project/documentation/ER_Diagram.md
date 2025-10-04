## Tablo Detayları

### 1. Musteri (Müşteri Tablosu)
- **Primary Key**: id
- **Alanlar**: ad, soyad, email, sehir, kayit_tarihi
- **İlişkiler**: Bir müşteri birden fazla sipariş verebilir

### 2. Kategori (Kategori Tablosu)
- **Primary Key**: id
- **Alanlar**: ad
- **İlişkiler**: Bir kategoride birden fazla ürün olabilir

### 3. Satici (Satıcı Tablosu)
- **Primary Key**: id
- **Alanlar**: ad, adres
- **İlişkiler**: Bir satıcı birden fazla ürün satabilir

### 4. Urun (Ürün Tablosu)
- **Primary Key**: id
- **Foreign Keys**: kategori_id, satici_id
- **Alanlar**: ad, fiyat, stok
- **İlişkiler**: Bir ürün bir kategoriye ve bir satıcıya aittir

### 5. Siparis (Sipariş Tablosu)
- **Primary Key**: id
- **Foreign Key**: musteri_id
- **Alanlar**: tarih, toplam_tutar, odeme_turu
- **İlişkiler**: Bir sipariş bir müşteriye aittir

### 6. Siparis_Detay (Sipariş Detay Tablosu)
- **Primary Key**: id
- **Foreign Keys**: siparis_id, urun_id
- **Alanlar**: adet, fiyat
- **İlişkiler**: Sipariş ve ürün arasındaki many-to-many ilişkiyi çözer

## Normalizasyon

Veritabanı **3NF** kurallarına uygun:
- ✅ 1NF: Atomic values
- ✅ 2NF: No partial dependency
- ✅ 3NF: No transitive dependency

## İndeksler

- musteri.sehir
- urun.kategori_id
- urun.satici_id
- siparis.musteri_id
- siparis.tarih