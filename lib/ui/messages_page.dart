import 'package:flutter/material.dart';

import '../styles/text_styles.dart';
import 'chat_page.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  static const String routeName = '/messages';

  @override
  Widget build(BuildContext context) {
    final items = <_MessageItem>[
      const _MessageItem('Kevin Louis', 'Hello William, Thankyou for your app', '2m ago',
          avatar: 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?q=80&w=200&auto=format&fit=crop', status: '•'),
      const _MessageItem('Olivia James', 'OK. Lorem ipsum dolor sect...', '2m ago',
          avatar: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=200&auto=format&fit=crop', trailing: 'Unread'),
      const _MessageItem('Cindy Sinambela', 'OK. Lorem ipsum dolor sect...', '2m ago',
          avatar: 'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?q=80&w=200&auto=format&fit=crop', trailing: 'Pending', dot: true),
      const _MessageItem('Sam Verdinand', 'Roger that sir, thankyou', '2m ago',
          avatar: 'https://images.unsplash.com/photo-1547425260-76bcadfb4f2c?q=80&w=200&auto=format&fit=crop', dot: true),
      const _MessageItem('David Mckanzie', 'Lorem ipsum dolor sit amet, consect...', '2m ago',
          avatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=200&auto=format&fit=crop', trailing: 'Read'),
      const _MessageItem('Daphne Putri', 'OK. Lorem ipsum dolor sect...', '2m ago',
          avatar: 'https://images.unsplash.com/photo-1544005316-04ce1f3a4f1b?q=80&w=200&auto=format&fit=crop', trailing: 'Unread'),
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
        title: const Text('Messages', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700)),
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
          _SearchBar(),
          const SizedBox(height: 16),
          ...items.map((e) => _MessageTile(item: e)).expand((w) => [w, const SizedBox(height: 12)]),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search...',
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

class _MessageItem {
  final String name;
  final String preview;
  final String time;
  final String avatar;
  final String? trailing;
  final bool dot;
  const _MessageItem(this.name, this.preview, this.time,
      {required this.avatar, this.trailing, this.dot = false, this.status});
  final String? status; // e.g., • green dot
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({required this.item});
  final _MessageItem item;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(ChatPage.routeName, arguments: item.name);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CircleAvatar(radius: 34, backgroundImage: NetworkImage(item.avatar)),
              if (item.dot)
                const Positioned(
                  bottom: 0,
                  left: 0,
                  child: CircleAvatar(radius: 10, backgroundColor: Colors.white),
                ),
              if (item.dot)
                const Positioned(
                  bottom: 2,
                  left: 2,
                  child: CircleAvatar(radius: 8, backgroundColor: primaryGreen),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(item.name,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black87)),
                    ),
                    Text(item.time, style: const TextStyle(color: subtitleColor)),
                  ],
                ),
                const SizedBox(height: 6),
                Text(item.preview, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.black87)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    if (item.trailing != null)
                      Text(item.trailing!, style: const TextStyle(color: subtitleColor)),
                    const SizedBox(width: 8),
                    const Icon(Icons.check, color: Colors.grey, size: 18),
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


