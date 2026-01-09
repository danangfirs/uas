import 'package:flutter/material.dart';

import '../styles/text_styles.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  static const String routeName = '/rewards';

  @override
  Widget build(BuildContext context) {
    final rewards = <_RewardItem>[
      const _RewardItem('Extra Deluxe Gayo Coffee Packages', '+250', 'June 18, 2020  |  4:00 AM'),
      const _RewardItem('Buy 10 Brewed Coffee Packages', '+100', 'June 18, 2020  |  4:00 AM'),
      const _RewardItem('Ice Coffee Morning', '+50', 'June 18, 2020  |  4:00 AM'),
      const _RewardItem('Hot Blend Coffee with Morning Cakes', '+100', 'June 18, 2020  |  4:00 AM'),
    ];

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
        title: const Text('Rewards', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.more_vert, color: Colors.black54),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          _PointsCard(points: 87550, onRedeem: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Redeem clicked')));
          }),
          const SizedBox(height: 24),
          // History header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('History Reward', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black87)),
              Row(children: [Text('Newest', style: TextStyle(color: subtitleColor)), Icon(Icons.expand_more, color: subtitleColor)])
            ],
          ),
          const SizedBox(height: 8),
          const Divider(height: 1),
          // Items
          ...rewards.map((e) => _RewardTile(item: e)).expand((w) => [w, const Divider(height: 1)])
        ],
      ),
    );
  }
}

class _PointsCard extends StatelessWidget {
  const _PointsCard({required this.points, required this.onRedeem});
  final int points;
  final VoidCallback onRedeem;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primaryGreen,
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF0A7A56), Color(0xFF128E64)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('My Points', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Text(
            points.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 44, fontWeight: FontWeight.w700, letterSpacing: 1),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.18),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: onRedeem,
              child: const Text('Redeem Gift', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}

class _RewardItem {
  final String title;
  final String pointsText;
  final String dateText;
  const _RewardItem(this.title, this.pointsText, this.dateText);
}

class _RewardTile extends StatelessWidget {
  const _RewardTile({required this.item});
  final _RewardItem item;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Clicked: ${item.title}')));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title/date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black87)),
                  const SizedBox(height: 10),
                  Text(item.dateText, style: const TextStyle(color: subtitleColor)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Points
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(item.pointsText, style: const TextStyle(color: primaryGreen, fontWeight: FontWeight.w800, fontSize: 24)),
                const SizedBox(height: 10),
                const Text('Pts', style: TextStyle(color: subtitleColor)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


