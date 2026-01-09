/// Helper class untuk akses asset (icons, images) dengan mudah
/// 
/// Contoh penggunaan:
/// ```dart
/// Image.asset(AppAssets.logo)
/// Image.asset(AppAssets.coffeeCup, width: 48, height: 48)
/// SvgPicture.asset(AppAssets.onboardCoffee)
/// ```
class AppAssets {
  // Private constructor agar tidak bisa di-instantiate
  AppAssets._();

  // ========== ICONS (PNG/JPG) ==========
  
  /// Logo aplikasi Ombe
  static const String logo = 'assets/icons/icons8-coffee-50.png';
  
  /// Coffee cup icon
  static const String coffeeCup = 'assets/icons/icons8-coffee-50.png';
  
  /// User icon
  static const String user = 'assets/icons/user.png';
  
  /// Home icon
  static const String home = 'assets/icons/home.png';
  
  /// Menu icon
  static const String menu = 'assets/icons/menu.png';
  
  /// Search icon
  static const String search = 'assets/icons/search.png';
  
  /// Cart icon
  static const String cart = 'assets/icons/cart.png';
  
  /// Profile icon
  static const String profile = 'assets/icons/profile.png';
  
  /// Settings icon
  static const String settings = 'assets/icons/settings.png';
  
  /// Logout icon
  static const String logout = 'assets/icons/logout.png';

  // ========== IMAGES (PNG/JPG) ==========
  
  /// Welcome/Onboarding image
  static const String welcome = 'assets/images/welcome.jpg';
  
  /// Background image
  static const String background = 'assets/images/background.jpg';
  
  /// Placeholder image
  static const String placeholder = 'assets/images/placeholder.png';

  // ========== SVG IMAGES ==========
  
  /// Onboarding coffee illustration SVG
  static const String onboardCoffee = 'assets/images/onboard-image-coffee.svg';

  // ========== HELPER METHODS ==========
  
  /// Get icon path dengan validasi
  static String iconPath(String iconName) {
    return 'assets/icons/$iconName.png';
  }
  
  /// Get image path dengan validasi
  static String imagePath(String imageName) {
    return 'assets/images/$imageName.png';
  }
}


