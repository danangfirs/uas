import 'package:flutter/material.dart';
import '../styles/text_styles.dart';
import '../widgets/app_drawer.dart';
import 'homepage.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  static const String routeName = '/notifications';

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<NotificationItem> _notifications = [
    NotificationItem(
      title: 'Apply Success',
      description: 'You has apply an job in Queenify Group as UI Designer',
      timeAgo: '10h ago',
      isUnread: true,
      hasMarkRead: true,
    ),
    NotificationItem(
      title: 'Interview Calls',
      description: 'Congratulations! You have interview calls tomorrow. Check schedule here..',
      timeAgo: '4m ago',
      isUnread: true,
      hasMarkRead: true,
    ),
    NotificationItem(
      title: 'Apply Success',
      description: 'You has apply an job in Queenify Group as UI Designer',
      timeAgo: '8h ago',
      isUnread: true,
      hasMarkRead: true,
    ),
    NotificationItem(
      title: 'Complete your profile',
      description: 'Please verify your profile information to continue using this app',
      timeAgo: '4h ago',
      isUnread: false,
      hasMarkRead: false,
    ),
  ];

  void _markAsRead(int index) {
    setState(() {
      _notifications[index].isUnread = false;
      _notifications[index].hasMarkRead = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: AppDrawer(currentRoute: NotificationsPage.routeName),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black87,
                size: 20,
              ),
            ),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                Navigator.of(context).pushReplacementNamed(HomePage.routeName);
              }
            },
          ),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black87,
              size: 24,
            ),
            onPressed: () {
              // Add more options menu
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return _NotificationCard(
            notification: notification,
            onMarkAsRead: notification.hasMarkRead
                ? () => _markAsRead(index)
                : null,
          );
        },
      ),
    );
  }
}

class NotificationItem {
  final String title;
  final String description;
  final String timeAgo;
  bool isUnread;
  bool hasMarkRead;

  NotificationItem({
    required this.title,
    required this.description,
    required this.timeAgo,
    required this.isUnread,
    required this.hasMarkRead,
  });
}

class _NotificationCard extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback? onMarkAsRead;

  const _NotificationCard({
    required this.notification,
    this.onMarkAsRead,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Green dot for unread
              if (notification.isUnread) ...[
                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(top: 6, right: 8),
                  decoration: const BoxDecoration(
                    color: primaryGreen,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
              Expanded(
                child: Text(
                  notification.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Description
          Text(
            notification.description,
            style: const TextStyle(
              fontSize: 14,
              color: subtitleColor,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          // Footer Row: Time + Mark as read button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Time with clock icon
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 14,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    notification.timeAgo,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              // Mark as read button
              if (onMarkAsRead != null)
                TextButton(
                  onPressed: onMarkAsRead,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Mark as read',
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

