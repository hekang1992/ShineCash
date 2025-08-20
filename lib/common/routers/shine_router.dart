import 'package:shinecash/common/tabbar/tabbar_controller.dart';
import 'package:shinecash/common/tabbar/tabbar_view.dart';
import 'package:shinecash/features/auth/certificationlist/certification_list_controller.dart';
import 'package:shinecash/features/auth/certificationlist/certification_list_view.dart';
import 'package:shinecash/features/auth/imageface/image_list_controller.dart';
import 'package:shinecash/features/auth/imageface/image_list_view.dart';
import 'package:shinecash/features/auth/listpage/tin_list_controller.dart';
import 'package:shinecash/features/auth/listpage/tin_list_view.dart';
import 'package:shinecash/features/auth/personalinfo/personal_controller.dart';
import 'package:shinecash/features/auth/personalinfo/personal_view.dart';
import 'package:shinecash/features/auth/phonelist/phone_list_controller.dart';
import 'package:shinecash/features/auth/phonelist/phone_list_view.dart';
import 'package:shinecash/features/auth/work/workinfo_controller.dart';
import 'package:shinecash/features/auth/work/workinfo_view.dart';
import 'package:shinecash/features/center/delete_controller.dart';
import 'package:shinecash/features/center/delete_view.dart';
import 'package:shinecash/features/center/setting_controller.dart';
import 'package:shinecash/features/center/setting_view.dart';
import 'package:shinecash/features/guide/guide_view.dart';
import 'package:shinecash/features/login/login_controller.dart';
import 'package:shinecash/features/login/login_view.dart';
import 'package:shinecash/features/web/web_controller.dart';
import 'package:shinecash/features/web/web_view.dart';
import 'package:shinecash/features/splash/splash_controller.dart';
import 'package:shinecash/features/splash/splash_view.dart';
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

  /// 介绍页
  static const String guide = '/guide';

  /// 认证列表页
  static const String authList = '/authList';

  /// tin
  static const String tinList = '/tinList';

  ///image
  static const String imagePhoto = '/imagePhoto';

  ///personal
  static const String personal = '/personal';

  ///work
  static const String work = '/work';

  ///setting
  static const String setting = '/setting';

  ///delete
  static const String delete = '/delete';

  ///delete
  static const String phonelist = '/phonelist';

  static final routes = [
    GetPage(
      name: splash,
      page: () => SplashView(),
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
      binding: BindingsBuilder(() {
        Get.lazyPut(() => TabbarController());
      }),
    ),

    GetPage(
      name: login,
      page: () => LoginView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => LoginController());
      }),
    ),

    GetPage(name: guide, page: () => GuideView()),

    GetPage(
      name: authList,
      page: () => CertificationListView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CertificationListController());
      }),
    ),

    GetPage(
      name: tinList,
      page: () => TinListView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => TinListController());
      }),
    ),

    GetPage(
      name: imagePhoto,
      page: () => ImageListView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ImageListController());
      }),
    ),

    GetPage(
      name: personal,
      page: () => PersonalView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PersonalController());
      }),
    ),

    GetPage(
      name: work,
      page: () => WorkinfoView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => WorkinfoController());
      }),
    ),

    GetPage(
      name: setting,
      page: () => SettingView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SettingController());
      }),
    ),

    GetPage(
      name: delete,
      page: () => DeleteView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => DeleteController());
      }),
    ),

    GetPage(
      name: phonelist,
      page: () => PhoneListView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PhoneListController());
      }),
    ),
  ];
}
