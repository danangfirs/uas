import 'package:flutter/material.dart';

import '../styles/text_styles.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  static const String routeName = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notifications = true;
  bool marketing = false;
  bool darkMode = false; // demo only (theme not fully wired)

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
        title: const Text('Settings', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700)),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          // Profile summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 6))],
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage('https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=200&auto=format&fit=crop'),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('William Smith', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.black87)),
                      SizedBox(height: 4),
                      Text('example@gmail.com', style: TextStyle(color: subtitleColor)),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(foregroundColor: primaryGreen),
                  child: const Text('Edit'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const _SectionLabel('General'),
          _SwitchTile(
            icon: Icons.notifications_active_outlined,
            title: 'App Notifications',
            value: notifications,
            onChanged: (v) => setState(() => notifications = v),
          ),
          _SwitchTile(
            icon: Icons.campaign_outlined,
            title: 'Marketing Notifications',
            value: marketing,
            onChanged: (v) => setState(() => marketing = v),
          ),
          _SwitchTile(
            icon: Icons.dark_mode_outlined,
            title: 'Dark Mode',
            value: darkMode,
            onChanged: (v) => setState(() => darkMode = v),
          ),
          const SizedBox(height: 24),
          const _SectionLabel('Security'),
          _NavTile(icon: Icons.lock_outline, title: 'Change Password', onTap: () {}),
          _NavTile(icon: Icons.privacy_tip_outlined, title: 'Privacy Policy', onTap: () {}),
          _NavTile(icon: Icons.description_outlined, title: 'Terms of Service', onTap: () {}),
          const SizedBox(height: 24),
          const _SectionLabel('Support'),
          _NavTile(icon: Icons.help_outline, title: 'Help Center', onTap: () {}),
          _NavTile(icon: Icons.mail_outline, title: 'Contact Us', onTap: () {}),
          const SizedBox(height: 24),
          // Logout
          SizedBox(
            width: double.infinity,
            height: 56,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                shape: const StadiumBorder(),
              ),
              child: const Text('LOG OUT', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87)),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({required this.icon, required this.title, required this.value, required this.onChanged});
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE9EBEC)),
      ),
      child: ListTile(
        leading: CircleAvatar(radius: 20, backgroundColor: const Color(0xFFE6F1EC), child: Icon(icon, color: primaryGreen)),
        title: Text(title, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
        trailing: Switch(value: value, onChanged: onChanged, activeColor: primaryGreen),
        onTap: () => onChanged(!value),
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  const _NavTile({required this.icon, required this.title, required this.onTap});
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE9EBEC)),
      ),
      child: ListTile(
        leading: CircleAvatar(radius: 20, backgroundColor: const Color(0xFFE6F1EC), child: Icon(icon, color: primaryGreen)),
        title: Text(title, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}


