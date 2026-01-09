import 'package:flutter/material.dart';

// Color constants (dipindahkan ke sini untuk konsistensi)
const Color primaryGreen = Color(0xFF0A7A56);
const Color subtitleColor = Color(0xFF6B6B6B);
const Color beige = Color(0xFFF2DBB8);
const Color lightGray = Color(0xFFE0E0E0);

/// Kumpulan Text Style untuk aplikasi Ombe
/// Menggunakan font family: Pepi
/// 
/// Cara penggunaan:
/// 1. Text('Hello', style: OmbeTextStyles.headingLarge)
/// 2. Text('Hello', style: Theme.of(context).textTheme.headlineLarge)
/// 3. Text('Hello', style: OmbeTextStyles.bodyText.copyWith(color: Colors.red))
class OmbeTextStyles {
  // Private constructor agar tidak bisa di-instantiate
  OmbeTextStyles._();

  // Font family constant
  // Akan menggunakan font Pepi jika sudah ditambahkan di pubspec.yaml
  // Jika belum, Flutter akan menggunakan default font
  static const String? fontFamily = null; // Set ke 'Pepi' setelah font ditambahkan

  // ========== HEADING STYLES ==========
  
  /// Style untuk heading besar (36px, bold)
  /// Digunakan untuk: Brand name, judul utama
  static const TextStyle headingLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
    letterSpacing: -0.5,
    height: 1.2,
  );

  /// Style untuk heading medium (28px, semibold)
  /// Digunakan untuk: Sub judul, section title
  static const TextStyle headingMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
    height: 1.2,
  );

  /// Style untuk heading kecil (24px, semibold)
  /// Digunakan untuk: Card title, list item title
  static const TextStyle headingSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
    height: 1.2,
  );

  // ========== BODY STYLES ==========
  
  /// Style untuk body text besar (18px, regular)
  /// Digunakan untuk: Paragraf penting, deskripsi utama
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
    height: 1.5,
  );

  /// Style untuk body text medium (16px, regular)
  /// Digunakan untuk: Paragraf normal, deskripsi
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
    height: 1.5,
  );

  /// Style untuk body text kecil (14px, regular)
  /// Digunakan untuk: Caption, hint text
  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
    height: 1.4,
  );

  // ========== SUBTITLE STYLES ==========
  
  /// Style untuk subtitle besar (18px, gray)
  /// Digunakan untuk: Deskripsi dengan warna abu-abu
  static const TextStyle subtitleLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: subtitleColor,
    height: 1.5,
  );

  /// Style untuk subtitle medium (16px, gray)
  /// Digunakan untuk: Label form, teks sekunder
  static const TextStyle subtitleMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: subtitleColor,
    height: 1.5,
  );

  /// Style untuk subtitle kecil (14px, gray)
  /// Digunakan untuk: Caption sekunder, hint
  static const TextStyle subtitleSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: subtitleColor,
    height: 1.4,
  );

  // ========== BUTTON STYLES ==========
  
  /// Style untuk tombol besar (18px, bold, uppercase)
  /// Digunakan untuk: Primary button, CTA button
  static const TextStyle buttonLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
    color: Colors.white,
  );

  /// Style untuk tombol medium (16px, semibold)
  /// Digunakan untuk: Secondary button
  static const TextStyle buttonMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
  );

  /// Style untuk tombol kecil (14px, semibold)
  /// Digunakan untuk: Text button, link
  static const TextStyle buttonSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
    color: primaryGreen,
    decoration: TextDecoration.underline,
    decorationColor: primaryGreen,
  );

  // ========== LABEL STYLES ==========
  
  /// Style untuk label form (16px, semibold, gray)
  /// Digunakan untuk: Form field labels
  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: subtitleColor,
  );

  /// Style untuk label kecil (14px, semibold, gray)
  /// Digunakan untuk: Small labels
  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: subtitleColor,
  );
}

