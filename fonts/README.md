# Font Files - Pepi

Folder ini untuk menyimpan file font **Pepi**.

## 📥 Cara Menambahkan Font File

1. **Download font Pepi** (jika belum punya)
   - Pepi Semi Bold: `Pepi-SemiBold.ttf`
   - Pepi Bold: `Pepi-Bold.ttf`
   - Pepi Regular: `Pepi-Regular.ttf`

2. **Copy file font ke folder ini** (`fonts/`)
   - Letakkan file dengan nama yang sesuai:
     - `Pepi-SemiBold.ttf`
     - `Pepi-Bold.ttf`
     - `Pepi-Regular.ttf`

3. **Jalankan command:**
   ```bash
   flutter pub get
   ```

4. **Restart aplikasi** (hot restart tidak cukup untuk font)

## 📝 Font yang Sudah Dikonfigurasi

Konfigurasi font sudah ditambahkan di `pubspec.yaml`:

```yaml
fonts:
  - family: Pepi
    fonts:
      - asset: fonts/Pepi-SemiBold.ttf
        weight: 600
      - asset: fonts/Pepi-Bold.ttf
        weight: 700
      - asset: fonts/Pepi-Regular.ttf
        weight: 400
```

## ✅ Setelah Menambahkan Font

Semua text style di aplikasi sudah menggunakan font **Pepi**:
- `OmbeTextStyles.headingLarge` → Pepi Bold
- `OmbeTextStyles.headingMedium` → Pepi Semi Bold (600)
- `OmbeTextStyles.bodyMedium` → Pepi Regular

## 🔗 Sumber Font Pepi

Jika belum punya font file, cari di:
- Google Fonts (jika tersedia)
- Font sharing websites
- Design resources

## ⚠️ Catatan

- File font harus format `.ttf` atau `.otf`
- Nama file harus sesuai dengan yang ada di `pubspec.yaml`
- Setelah menambahkan font, jalankan `flutter clean` jika font tidak muncul

