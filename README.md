# tahmin-verisi

[football-data.co.uk](https://www.football-data.co.uk) maç verilerinin otomatik aynası.
GitHub Actions 6 saatte bir `indir.sh` betiğini çalıştırır ve yeni veri varsa repoya kaydeder.

- `mmz4281/<sezon>/<lig>.csv`: bu sezon ve geçen sezonun maçları (skor, şut, korner, faul, kart, hakem, oranlar)
- `fixtures.csv`: gelecek maçlar ve oranlar
- `durum.txt`: son güncelleme zamanı ve indirilemeyen dosya sayısı

Elle güncellemek için: **Actions → Veri guncelle → Run workflow**.
