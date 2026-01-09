# Ombe Coffee - Mobile App

Aplikasi pemesanan kopi mobile yang dibangun dengan Flutter. Mendukung platform Android, iOS, dan Web.

## Tech Stack

- **Framework**: Flutter 3.x
- **State Management**: Provider
- **HTTP Client**: Dio
- **Local Storage**: SharedPreferences
- **Payment Gateway**: Midtrans (Sandbox)
- **Backend**: Laravel REST API (deployed on Railway)

## Fitur Utama

- Autentikasi (Login, Register, Reset Password)
- Katalog Produk dengan Kategori
- Pencarian dan Filter Produk
- Keranjang Belanja
- Checkout dengan Midtrans Payment
- Riwayat Pesanan
- Profil Pengguna

## Struktur Project

```
lib/
├── main.dart                 # Entry point
├── models/                   # Data models
│   ├── user.dart
│   ├── product.dart
│   ├── category.dart
│   ├── cart_item.dart
│   └── order.dart
├── providers/                # State management
│   ├── auth_provider.dart
│   ├── cart_provider.dart
│   └── product_provider.dart
├── services/                 # API services
│   └── api_service.dart
├── ui/                       # UI screens
│   ├── splash_screen.dart
│   ├── login_page.dart
│   ├── register_page.dart
│   ├── home/
│   ├── cart/
│   ├── checkout/
│   ├── payment/
│   └── profile/
└── widgets/                  # Reusable widgets
```

## Instalasi

### Prasyarat

- Flutter SDK 3.x
- Dart SDK
- Android Studio / VS Code
- Git

### Langkah Instalasi

1. Clone repository
   ```bash
   git clone https://github.com/danangfirs/uas.git
   cd uas
   ```

2. Install dependencies
   ```bash
   flutter pub get
   ```

3. Jalankan aplikasi
   ```bash
   # Web
   flutter run -d chrome

   # Android
   flutter run -d android

   # iOS
   flutter run -d ios
   ```

## Build APK

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

## Konfigurasi

### API Endpoint

File: `lib/services/api_service.dart`

```dart
static const String baseUrl = 'https://ombes.up.railway.app/api';
```

### Backend Repository

Backend Laravel tersedia di repository terpisah: [ombes](https://github.com/danangfirs/ombes)

## Akun Demo

| Email              | Password | Role     |
|--------------------|----------|----------|
| admin@ombe.com     | password | Admin    |
| john@example.com   | password | Customer |

## Screenshot

*Coming soon*

## Lisensi

Project ini dibuat untuk keperluan tugas UAS Praktikum Web Semester 
