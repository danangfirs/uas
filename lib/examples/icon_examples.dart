import 'package:flutter/material.dart';
import '../utils/asset_helper.dart';

/// Contoh-contoh penggunaan icon dari assets
class IconExamples extends StatelessWidget {
  const IconExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Icon Examples'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ========== CONTOH 1: Icon Sederhana ==========
          _buildSection(
            '1. Icon Sederhana',
            [
              Image.asset(
                AppAssets.logo,
                width: 48,
                height: 48,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ========== CONTOH 2: Icon di ListTile ==========
          _buildSection(
            '2. Icon di ListTile',
            [
              ListTile(
                leading: Image.asset(
                  AppAssets.coffeeCup,
                  width: 40,
                  height: 40,
                ),
                title: const Text('Coffee Item'),
                subtitle: const Text('Description here'),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ========== CONTOH 3: Icon di Button ==========
          _buildSection(
            '3. Icon di Button',
            [
              Row(
                children: [
                  IconButton(
                    icon: Image.asset(
                      AppAssets.home,
                      width: 24,
                      height: 24,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Image.asset(
                      AppAssets.search,
                      width: 24,
                      height: 24,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Image.asset(
                      AppAssets.cart,
                      width: 24,
                      height: 24,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ========== CONTOH 4: Icon dengan Error Handling ==========
          _buildSection(
            '4. Icon dengan Error Handling',
            [
              Image.asset(
                AppAssets.logo,
                width: 100,
                height: 100,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.error,
                    size: 100,
                    color: Colors.red,
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ========== CONTOH 5: Icon dengan Color Filter ==========
          _buildSection(
            '5. Icon dengan Color Filter',
            [
              Row(
                children: [
                  ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Colors.blue,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      AppAssets.logo,
                      width: 48,
                      height: 48,
                    ),
                  ),
                  const SizedBox(width: 16),
                  ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Colors.red,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      AppAssets.logo,
                      width: 48,
                      height: 48,
                    ),
                  ),
                  const SizedBox(width: 16),
                  ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Colors.green,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      AppAssets.logo,
                      width: 48,
                      height: 48,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ========== CONTOH 6: Icon di AppBar ==========
          _buildSection(
            '6. Icon di AppBar',
            [
              AppBar(
                title: Image.asset(
                  AppAssets.logo,
                  height: 32,
                ),
                centerTitle: true,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ========== CONTOH 7: Icon Responsive ==========
          _buildSection(
            '7. Icon Responsive',
            [
              LayoutBuilder(
                builder: (context, constraints) {
                  return Image.asset(
                    AppAssets.logo,
                    width: constraints.maxWidth * 0.5,
                    height: constraints.maxWidth * 0.5,
                    fit: BoxFit.contain,
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ========== CONTOH 8: Background Image ==========
          _buildSection(
            '8. Background Image',
            [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAssets.background),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Text Overlay',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }
}


