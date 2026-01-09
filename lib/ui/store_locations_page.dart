import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../styles/text_styles.dart';
import 'store_map_page.dart';
import '../models/store_map_args.dart';

class StoreLocationsPage extends StatelessWidget {
  const StoreLocationsPage({super.key});

  static const String routeName = '/store-locations';

  @override
  Widget build(BuildContext context) {
    final stores = <_StoreInfo>[
      const _StoreInfo(
        name: 'Centre Point Plaza',
        hours: '09:00 AM - 10:00 PM',
        distanceKm: 3.5,
        center: LatLng(3.589665, 98.673826), // Medan
        imageUrl: 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?q=80&w=1200&auto=format&fit=crop',
      ),
      const _StoreInfo(
        name: 'Medan Plaza',
        hours: '09:00 AM - 10:00 PM',
        distanceKm: 7.5,
        center: LatLng(3.585242, 98.671751), // Medan Plaza area
        imageUrl: 'https://images.unsplash.com/photo-1504754524776-8f4f37790ca0?q=80&w=1200&auto=format&fit=crop',
      ),
      const _StoreInfo(
        name: 'Ombe Coffee - Monas',
        hours: '08:00 AM - 09:00 PM',
        distanceKm: 12.3,
        center: LatLng(-6.175392, 106.827153), // Jakarta Monas
        imageUrl: 'https://images.unsplash.com/photo-1517705008128-361805f42e86?q=80&w=1200&auto=format&fit=crop',
      ),
      const _StoreInfo(
        name: 'Ombe Coffee - Surabaya',
        hours: '08:00 AM - 10:00 PM',
        distanceKm: 18.7,
        center: LatLng(-7.257472, 112.752090), // Surabaya
        imageUrl: 'https://images.unsplash.com/photo-1457460866886-40ef8d4b42a0?q=80&w=1200&auto=format&fit=crop',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Our Stores', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.more_vert, color: Colors.black54),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          _SearchBar(),
          const SizedBox(height: 16),
          const _ChipsRow(),
          const SizedBox(height: 24),
          Text(
            'We have ${stores.length * 23} Outled ready to serve you',
            style: const TextStyle(fontSize: 20, color: Colors.black87, height: 1.4),
          ),
          const SizedBox(height: 16),
          ...stores.map((s) => _StoreCard(info: s)).expand((w) => [w, const SizedBox(height: 16)]),
        ],
      ),
    );
  }
}

class _StoreInfo {
  final String name;
  final String hours;
  final double distanceKm;
  final LatLng center;
  final String imageUrl;
  const _StoreInfo({required this.name, required this.hours, required this.distanceKm, required this.center, required this.imageUrl});
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search address',
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: const Color(0xFFF6F7F7),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
      ),
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
        _FilledChip(label: 'Near Me', selected: true),
        _OutlinedChip(label: 'Popular'),
        _OutlinedChip(label: 'Top Rated'),
      ],
    );
  }
}

class _FilledChip extends StatelessWidget {
  const _FilledChip({required this.label, this.selected = false});
  final String label;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      decoration: BoxDecoration(
        color: selected ? primaryGreen : Colors.transparent,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: primaryGreen, width: 2),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.white : primaryGreen,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _OutlinedChip extends StatelessWidget {
  const _OutlinedChip({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFB4D4C7), width: 2),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _StoreCard extends StatelessWidget {
  const _StoreCard({required this.info});
  final _StoreInfo info;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 6)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    info.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: _DirectionsButton(onPressed: () {
                    Navigator.of(context).pushNamed(
                      StoreMapPage.routeName,
                      arguments: StoreMapArgs(storeName: info.name, address: info.hours, center: info.center),
                    );
                  }),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(info.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black87)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.access_time, color: subtitleColor, size: 20),
                        const SizedBox(width: 8),
                        Text(info.hours, style: const TextStyle(color: Colors.black54)),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: primaryGreen),
                        const SizedBox(width: 6),
                        Text('${info.distanceKm.toStringAsFixed(1)} Km', style: const TextStyle(color: primaryGreen, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DirectionsButton extends StatelessWidget {
  const _DirectionsButton({required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF2046CF),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Row(
            children: const [
              Icon(Icons.info_outline, color: Colors.white),
              SizedBox(width: 8),
              Text('Directions', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ),
    );
  }
}


