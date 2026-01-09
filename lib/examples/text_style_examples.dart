import 'package:flutter/material.dart';
import '../styles/text_styles.dart';
import '../styles/text_extensions.dart';

/// Contoh-contoh cara menggunakan style teks
/// 
/// File ini menunjukkan berbagai cara menambahkan dan menggunakan style teks
class TextStyleExamples extends StatelessWidget {
  const TextStyleExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Text Style Examples')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ========== CARA 1: Menggunakan OmbeTextStyles langsung ==========
          _buildSection(
            'Cara 1: Menggunakan OmbeTextStyles',
            [
              Text('Heading Large', style: OmbeTextStyles.headingLarge),
              const SizedBox(height: 8),
              Text('Body Medium', style: OmbeTextStyles.bodyMedium),
              const SizedBox(height: 8),
              Text('Subtitle', style: OmbeTextStyles.subtitleMedium),
            ],
          ),

          const SizedBox(height: 32),

          // ========== CARA 2: Menggunakan Theme TextTheme ==========
          _buildSection(
            'Cara 2: Menggunakan Theme TextTheme',
            [
              Text('Heading', style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 8),
              Text('Body', style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),

          const SizedBox(height: 32),

          // ========== CARA 3: Menggunakan copyWith untuk modifikasi ==========
          _buildSection(
            'Cara 3: Modifikasi dengan copyWith',
            [
              Text(
                'Custom Style',
                style: OmbeTextStyles.headingMedium.copyWith(
                  color: primaryGreen,
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Modified Body',
                style: OmbeTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // ========== CARA 4: Membuat style baru inline ==========
          _buildSection(
            'Cara 4: Style Inline (untuk one-off)',
            [
              const Text(
                'Inline Style',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: primaryGreen,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // ========== CARA 5: Membuat style dengan extension ==========
          _buildSection(
            'Cara 5: Menggunakan Extension (lihat text_extensions.dart)',
            [
              Text('Heading', style: context.ombHeadingLarge()),
              const SizedBox(height: 8),
              Text('Body', style: context.ombBodyMedium()),
            ],
          ),

          const SizedBox(height: 32),

          // ========== CONTOH KOMBINASI ==========
          _buildSection(
            'Contoh Kombinasi untuk Login Page',
            [
              // Brand name
              Row(
                children: [
                  const Icon(Icons.coffee, color: primaryGreen, size: 32),
                  const SizedBox(width: 8),
                  Text('Ombe', style: OmbeTextStyles.headingLarge),
                ],
              ),
              const SizedBox(height: 16),
              // Title
              Text('Sign In', style: OmbeTextStyles.headingLarge),
              const SizedBox(height: 8),
              // Description
              Text(
                'Silakan masuk ke akun Anda',
                style: OmbeTextStyles.subtitleLarge,
              ),
              const SizedBox(height: 16),
              // Label
              Text('Email', style: OmbeTextStyles.labelMedium),
              const SizedBox(height: 16),
              // Button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: Text('LOGIN', style: OmbeTextStyles.buttonLarge),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: OmbeTextStyles.headingSmall.copyWith(
            color: primaryGreen,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }
}

