import 'package:get/route_manager.dart';
import 'package:shinecash/common/tabbar/tabbar_controller.dart';
import 'package:shinecash/common/tabbar/tabbar_view.dart';
import 'package:shinecash/features/login/login_controller.dart';
import 'package:shinecash/features/login/login_view.dart';
import 'package:shinecash/splash/splash_controller.dart';
import 'package:shinecash/splash/splash_view.dart';
import 'package:get/get.dart';

class ShineAppRouter {
  // 启动页
  static const String splash = '/splash';

  /// tab页面
  static const String tab = '/tab';

  /// 登录页面
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
