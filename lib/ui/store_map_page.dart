import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../styles/text_styles.dart';
import 'homepage.dart';
import '../models/store_map_args.dart';

class StoreMapPage extends StatelessWidget {
  const StoreMapPage({
    super.key,
    this.storeName = 'Ombe Coffee Shop',
    this.address = 'Franklin Avenue 2263',
    this.note = 'Sent at 08:23 AM',
    this.center = const LatLng(28.6139, 77.2090), // Default: New Delhi (example)
    this.zoom = 13.0,
  });

  static const String routeName = '/store-map';

  final String storeName;
  final String address;
  final String note;
  final LatLng center;
  final double zoom;

  @override
  Widget build(BuildContext context) {
    // read optional arguments (if pushed from store list)
    String sName = storeName;
    String addr = address;
    LatLng cen = center;
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is StoreMapArgs) {
      sName = args.storeName;
      addr = args.address;
      cen = args.center;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () async {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).pushReplacementNamed(HomePage.routeName);
            }
          },
        ),
        title: const Text(
          'Store Location',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Map
          FlutterMap(
            options: MapOptions(
              initialCenter: cen,
              initialZoom: zoom,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.ombe',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: cen,
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    child: _MapPin(),
                  ),
                ],
              ),
            ],
          ),

          // ETA chip (floating)
          Positioned(
            left: 20,
            right: 20,
            top: 140,
            child: _EtaChip(),
          ),

          // Bottom layered panels (driver header + itinerary)
          Align(
            alignment: Alignment.bottomCenter,
            child: _BottomPanels(
              storeName: sName,
              address: addr,
              note: note,
            ),
          ),
        ],
      ),
    );
  }
}

class _EtaChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 6),
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.timer_rounded, color: primaryGreen),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Estimated Time',
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),
              SizedBox(height: 4),
              Text(
                '5–10 min',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black87),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _BottomPanels extends StatelessWidget {
  const _BottomPanels({
    required this.storeName,
    required this.address,
    required this.note,
  });

  final String storeName;
  final String address;
  final String note;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Driver header card (green)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: _DriverHeaderCard(),
            ),
            const SizedBox(height: 8),
            // Itinerary white panel
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _StepTile(
                    icon: Icons.location_on_rounded,
                    title: 'Sweet Corner St.',
                    subtitle: address,
                    iconBg: const Color(0xFFE6F1EC),
                  ),
                  // Connector dotted line
                  const _DottedConnector(height: 28),
                  _StepTile(
                    icon: Icons.store_mall_directory_rounded,
                    title: storeName,
                    subtitle: note,
                    iconBg: Colors.white,
                    outlined: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DriverHeaderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primaryGreen,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
      child: Row(
        children: [
          // Avatar (use local asset to avoid network/CORS issues on web)
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              'assets/icons/icons8-coffee-50.png',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          // Name and ID
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mr. Shandy',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'ID 2445556',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          // Action buttons
          _RoundIconBtn(icon: Icons.call_rounded),
          const SizedBox(width: 10),
          _RoundIconBtn(icon: Icons.chat_bubble_rounded),
        ],
      ),
    );
  }
}

class _RoundIconBtn extends StatelessWidget {
  const _RoundIconBtn({required this.icon});
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.18),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: () {},
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  const _StepTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconBg,
    this.outlined = false,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconBg;
  final bool outlined;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: iconBg,
            shape: BoxShape.circle,
            border: outlined ? Border.all(color: primaryGreen, width: 2) : null,
          ),
          child: Icon(icon, color: primaryGreen, size: 28),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 16, color: subtitleColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DottedConnector extends StatelessWidget {
  const _DottedConnector({this.height = 24});
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: _DottedPainter(),
      ),
    );
  }
}

class _DottedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double dashHeight = 4;
    const double dashSpace = 6;
    double y = 0;
    final Paint paint = Paint()
      ..color = const Color(0xFFC9C9C9)
      ..strokeWidth = 2;
    final double x = 32; // centered under left icons
    while (y < size.height) {
      canvas.drawLine(Offset(x, y), Offset(x, y + dashHeight), paint);
      y += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MapPin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 6),
          )
        ],
      ),
      alignment: Alignment.center,
      child: const Icon(Icons.location_on_rounded, color: primaryGreen, size: 28),
    );
  }
}


