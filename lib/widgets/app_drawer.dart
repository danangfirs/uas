import 'package:flutter/material.dart';
import '../styles/text_styles.dart';
import 'coffee_logo.dart';
import '../ui/login_page.dart';
import '../ui/homepage.dart';
import '../ui/notifications_page.dart';
import '../ui/store_map_page.dart';
import '../ui/delivery_tracking_page.dart';
import '../ui/store_locations_page.dart';
import '../ui/rewards_page.dart';
import '../ui/profile_page.dart';
import '../ui/order_review_page.dart';
import '../ui/messages_page.dart';
import '../ui/elements_page.dart';
import '../ui/settings_page.dart';

class AppDrawer extends StatelessWidget {
  final String? currentRoute;

  const AppDrawer({
    super.key,
    this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    final isHome = currentRoute == HomePage.routeName;
    final isNotifications = currentRoute == NotificationsPage.routeName;

    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            // Header: Logo + Close Button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CoffeeLogo(size: 40),
                      const SizedBox(width: 12),
                      const Text(
                        'Ombe',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.grey,
                      size: 24,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Menu Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _MenuItem(
                    icon: Icons.home,
                    title: 'Home',
                    isActive: isHome,
                    onTap: () {
                      Navigator.of(context).pop();
                      if (!isHome) {
                        Navigator.of(context).pushReplacementNamed(
                          HomePage.routeName,
                        );
                      }
                    },
                  ),
                  _MenuItem(
                    icon: Icons.notifications_outlined,
                    title: 'Notifications (2)',
                    badge: '2',
                    isActive: isNotifications,
                    onTap: () {
                      Navigator.of(context).pop(); // Close drawer first
                      if (!isNotifications) {
                        // Use Future.microtask to ensure drawer is closed before navigation
                        Future.microtask(() {
                          Navigator.of(context).pushNamed(
                            NotificationsPage.routeName,
                          );
                        });
                      }
                    },
                  ),
                  _MenuItem(
                    icon: Icons.location_on_outlined,
                    title: 'Store Locations',
                    onTap: () {
                      Navigator.of(context).pop();
                      Future.microtask(() {
                        Navigator.of(context).pushNamed(StoreLocationsPage.routeName);
                      });
                    },
                  ),
                  _MenuItem(
                    icon: Icons.access_time,
                    title: 'Delivery Tracking',
                    onTap: () {
                      Navigator.of(context).pop();
                      Future.microtask(() {
                        Navigator.of(context).pushNamed(DeliveryTrackingPage.routeName);
                      });
                    },
                  ),
                  _MenuItem(
                    icon: Icons.card_giftcard_outlined,
                    title: 'Rewards',
                    onTap: () {
                      Navigator.of(context).pop();
                      Future.microtask(() {
                        Navigator.of(context).pushNamed(RewardsPage.routeName);
                      });
                    },
                  ),
                  _MenuItem(
                    icon: Icons.person_outline,
                    title: 'Profile',
                    onTap: () {
                      Navigator.of(context).pop();
                      Future.microtask(() {
                        Navigator.of(context).pushNamed(ProfilePage.routeName);
                      });
                    },
                  ),
                  _MenuItem(
                    icon: Icons.star_outline,
                    title: 'Order Review',
                    onTap: () {
                      Navigator.of(context).pop();
                      Future.microtask(() {
                        Navigator.of(context).pushNamed(OrderReviewPage.routeName);
                      });
                    },
                  ),
                  _MenuItem(
                    icon: Icons.chat_bubble_outline,
                    title: 'Message',
                    onTap: () {
                      Navigator.of(context).pop();
                      Future.microtask(() {
                        Navigator.of(context).pushNamed(MessagesPage.routeName);
                      });
                    },
                  ),
                  _MenuItem(
                    icon: Icons.grid_view_outlined,
                    title: 'Elements',
                    onTap: () {
                      Navigator.of(context).pop();
                      Future.microtask(() {
                        Navigator.of(context).pushNamed(ElementsPage.routeName);
                      });
                    },
                  ),
                  _MenuItem(
                    icon: Icons.settings_outlined,
                    title: 'Setting',
                    onTap: () {
                      Navigator.of(context).pop();
                      Future.microtask(() {
                        Navigator.of(context).pushNamed(SettingsPage.routeName);
                      });
                    },
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Logout Button
            _MenuItem(
              icon: Icons.power_settings_new,
              title: 'Logout',
              isLogout: true,
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed(
                  LoginPage.routeName,
                );
              },
            ),
            // Footer
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Ombe Coffee App',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isActive;
  final bool isLogout;
  final String? badge;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    this.isActive = false,
    this.isLogout = false,
    this.badge,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = isLogout
        ? Colors.red
        : isActive
            ? primaryGreen
            : Colors.grey[600]!;
    final textColor = isLogout
        ? Colors.red
        : isActive
            ? primaryGreen
            : Colors.grey[600]!;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              // Icon with badge if notifications
              badge != null
                  ? SizedBox(
                      width: 32,
                      height: 32,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Icon(
                              icon,
                              color: iconColor,
                              size: 24,
                            ),
                          ),
                          Positioned(
                            right: -2,
                            top: -2,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: primaryGreen,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Icon(
                      icon,
                      color: iconColor,
                      size: 24,
                    ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

