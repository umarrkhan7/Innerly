import 'package:get/get.dart';
import 'app_routes.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import '../../features/auth/bindings/auth_binding.dart';

class AppPages {
  AppPages();

  static final pages = [
    GetPage(name: Routes.splash, page: () => const SplashPage()),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.signup,
      page: () => const SignupPage(),
      binding: AuthBinding(),
    ),
    // GetPage(name: Routes.home, page: () => const PlaceholderPage(title: 'Home')),
    // GetPage(name: Routes.settings, page: () => const SettingsPage()),
  ];
}