import 'package:flutter/material.dart';
import 'ui/login_page.dart';
import 'ui/onboarding_page.dart';
import 'ui/signup_page.dart';
import 'ui/welcome_page.dart';
import 'ui/homepage.dart';
import 'ui/notifications_page.dart';
import 'ui/store_map_page.dart';
import 'ui/delivery_tracking_page.dart';
import 'ui/store_locations_page.dart';
import 'ui/rewards_page.dart';
import 'ui/profile_page.dart';
import 'ui/order_review_page.dart';
import 'ui/messages_page.dart';
import 'ui/chat_page.dart';
import 'ui/elements_page.dart';
import 'ui/settings_page.dart';
import 'ui/product_page.dart';
import 'ui/cart_page.dart';
// Payment pages
import 'ui/checkout_page.dart';
import 'ui/payment_success_page.dart';
import 'ui/payment_failed_page.dart';
import 'ui/order_history_page.dart';
import 'styles/text_styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ombe',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryGreen,
          primary: primaryGreen,
          secondary: primaryGreen,
          brightness: Brightness.light,
        ),
        // Menambahkan style teks ke TextTheme
        // Font Pepi akan digunakan setelah file font ditambahkan dan di-uncomment di pubspec.yaml
        // Sekarang bisa diakses dengan: Theme.of(context).textTheme.headlineLarge
        textTheme: const TextTheme(
          // Display styles (untuk judul besar)
          displayLarge: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black87),
          displayMedium: TextStyle(fontSize: 36, fontWeight: FontWeight.w600, color: Colors.black87),
          displaySmall: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: Colors.black87),
          
          // Headline styles (untuk judul)
          headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.black87),
          headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black87),
          headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black87),
          
          // Title styles (untuk sub judul)
          titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
          titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
          titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
          
          // Body styles (untuk paragraf)
          bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black87, height: 1.5),
          bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black87, height: 1.5),
          bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black87, height: 1.4),
          
          // Label styles (untuk label form)
          labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: subtitleColor),
          labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: subtitleColor),
          labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: subtitleColor),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: UnderlineInputBorder(),
        ),
        useMaterial3: true,
      ),
      routes: {
        OnboardingPage.routeName: (context) => const OnboardingPage(),
        WelcomePage.routeName: (context) => const WelcomePage(),
        LoginPage.routeName: (context) => const LoginPage(),
        SignUpPage.routeName: (context) => const SignUpPage(),
        HomePage.routeName: (context) => const HomePage(),
        NotificationsPage.routeName: (context) => const NotificationsPage(),
        StoreMapPage.routeName: (context) => const StoreMapPage(),
        DeliveryTrackingPage.routeName: (context) => const DeliveryTrackingPage(),
        StoreLocationsPage.routeName: (context) => const StoreLocationsPage(),
        RewardsPage.routeName: (context) => const RewardsPage(),
        ProfilePage.routeName: (context) => const ProfilePage(),
        OrderReviewPage.routeName: (context) => const OrderReviewPage(),
        MessagesPage.routeName: (context) => const MessagesPage(),
        ChatPage.routeName: (context) => const ChatPage(),
        ElementsPage.routeName: (context) => const ElementsPage(),
        SettingsPage.routeName: (context) => const SettingsPage(),
        ProductPage.routeName: (context) => const ProductPage(),
        CartPage.routeName: (context) => const CartPage(),
        // Payment routes
        CheckoutPage.routeName: (context) => const CheckoutPage(),
        PaymentSuccessPage.routeName: (context) => const PaymentSuccessPage(orderId: ''),
        PaymentFailedPage.routeName: (context) => const PaymentFailedPage(orderId: '', status: ''),
        OrderHistoryPage.routeName: (context) => const OrderHistoryPage(),
      },
      initialRoute: OnboardingPage.routeName,
    );
  }
}

