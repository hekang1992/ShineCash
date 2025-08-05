import 'package:get/route_manager.dart';
import 'package:shinecash/splash/splash_controller.dart';
import 'package:shinecash/splash/splash_view.dart';
import 'package:get/get.dart';

class ShineAppRouter {
  //启动页
  static const String splash = '/splash';

  static final routes = [
    GetPage(
      name: splash,
      page: () => SplashView(),
      transition: Transition.noTransition,
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SplashController());
      }),
    ),
  ];
}
