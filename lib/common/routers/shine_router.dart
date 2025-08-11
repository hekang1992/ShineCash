import 'package:get/route_manager.dart';
import 'package:shinecash/common/tabbar/tabbar_controller.dart';
import 'package:shinecash/common/tabbar/tabbar_view.dart';
import 'package:shinecash/features/login/login_controller.dart';
import 'package:shinecash/features/login/login_view.dart';
import 'package:shinecash/features/web/web_controller.dart';
import 'package:shinecash/features/web/web_view.dart';
import 'package:shinecash/splash/splash_controller.dart';
import 'package:shinecash/splash/splash_view.dart';
import 'package:get/get.dart';

class ShineAppRouter {
  /// 启动页
  static const String splash = '/splash';

  /// web页
  static const String web = '/web';

  /// tab页
  static const String tab = '/tab';

  /// 登录页
  static const String login = '/login';

  static final routes = [
    GetPage(
      name: splash,
      page: () => SplashView(),
      transition: Transition.noTransition,
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SplashController());
      }),
    ),

    GetPage(
      name: web,
      page: () => WebView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => WebController());
      }),
    ),

    GetPage(
      name: tab,
      page: () => TabbarView(),
      transition: Transition.noTransition,
      binding: BindingsBuilder(() {
        Get.lazyPut(() => TabbarController());
      }),
    ),

    GetPage(
      name: login,
      page: () => LoginView(),
      transition: Transition.noTransition,
      binding: BindingsBuilder(() {
        Get.lazyPut(() => LoginController());
      }),
    ),
  ];
}
