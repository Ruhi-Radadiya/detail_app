import 'package:get/get.dart';

import '../view/screens/add_detail.dart';
import '../view/screens/detail_page.dart';
import '../view/screens/home_page.dart';
import '../view/screens/login_page.dart';
import '../view/screens/splash_screen.dart';

class Routes {
  static String splash = '/';
  static String login = '/login';
  static String home = '/home';
  static String details = '/details';
  static String add = '/add';
}

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: Routes.details,
      page: () => DetailScreen(detail: Get.arguments),
    ),
    GetPage(
      name: Routes.add,
      page: () => AddDetailScreen(),
    ),
  ];
}
