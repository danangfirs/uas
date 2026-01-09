import 'package:flutter/material.dart';

import '../styles/text_styles.dart';

/// ElementsPage: katalog komponen UI untuk referensi & reuse
class ElementsPage extends StatelessWidget {
  const ElementsPage({super.key});

  static const String routeName = '/elements';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Elements', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700)),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: const [
          _SectionTitle('Buttons'),
          _ButtonsRow(),
          SizedBox(height: 24),
          _SectionTitle('Chips'),
          _ChipsRow(),
          SizedBox(height: 24),
          _SectionTitle('Inputs'),
          _InputsDemo(),
          SizedBox(height: 24),
          _SectionTitle('Cards'),
          _CardDemo(),
          SizedBox(height: 24),
          _SectionTitle('Colors'),
          _ColorsDemo(),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black87));
  }
}

class _ButtonsRow extends StatelessWidget {
  const _ButtonsRow();
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: primaryGreen, foregroundColor: Colors.white, shape: const StadiumBorder()),
          child: const Text('Primary'),
        ),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(foregroundColor: primaryGreen, side: const BorderSide(color: primaryGreen), shape: const StadiumBorder()),
          child: const Text('Outlined'),
        ),
        TextButton(onPressed: () {}, style: TextButton.styleFrom(foregroundColor: primaryGreen), child: const Text('Text Button')),
        IconButton(onPressed: () {}, icon: const Icon(Icons.favorite, color: primaryGreen)),
      ],
    );
  }
}

class _ChipsRow extends StatelessWidget {
  const _ChipsRow();
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      children: [
        _chip(true, 'Active'),
        _chip(false, 'Default'),
        _chip(false, 'Disabled', disabled: true),
      ],
    );
  }

  Widget _chip(bool filled, String label, {bool disabled = false}) {
    final Color border = filled ? primaryGreen : const Color(0xFFB4D4C7);
    final Color bg = filled ? primaryGreen : Colors.white;
    final Color fg = filled ? Colors.white : Colors.black87;
    return Opacity(
      opacity: disabled ? 0.5 : 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(28), border: Border.all(color: border, width: 2)),
        child: Text(label, style: TextStyle(color: fg, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class _InputsDemo extends StatelessWidget {
  const _InputsDemo();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        TextField(decoration: InputDecoration(hintText: 'Search address')),
        SizedBox(height: 12),
        TextField(decoration: InputDecoration(hintText: 'Your name')),
      ],
    );
  }
}

class _CardDemo extends StatelessWidget {
  const _CardDemo();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 6))],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
            child: Image.network(
              'https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=400&auto=format&fit=crop',
              width: 120,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: ListTile(
              title: Text('Creamy Latte Coffee', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black87)),
              subtitle: Text('Beverages'),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
        ],
      ),
    );
  }
}

class _ColorsDemo extends StatelessWidget {
  const _ColorsDemo();
  @override
  Widget build(BuildContext context) {
    final colors = const [
      primaryGreen,
      Color(0xFFF2DBB8),
      Color(0xFF6B6B6B),
      Color(0xFFF6F7F7),
      Color(0xFF2046CF),
    ];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: colors
          .map((c) => Container(width: 60, height: 60, decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(12))))
          .toList(),
    );
  }
}


