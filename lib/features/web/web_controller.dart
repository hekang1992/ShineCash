import 'package:get/get.dart';
import 'package:shinecash/common/http/http_toast.dart';
import 'package:shinecash/common/routers/shine_router.dart';
import 'package:shinecash/common/tabbar/tabbar_controller.dart';
import 'package:shinecash/common/utils/image_pop.dart';
import 'package:shinecash/features/auth/certificationlist/certification_list_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebController extends GetxController {
  late final WebViewController webcontroller;
  final title = ''.obs;

  @override
  void onInit() {
    super.onInit();

    final String pageUrl = Get.arguments['pageUrl'] ?? '';

    webcontroller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            ToastManager.showLoading();
          },
          onPageFinished: (url) async {
            ToastManager.hideLoading();
            final t = await webcontroller.getTitle() ?? '';
            title.value = t;
          },
          onWebResourceError: (error) {
            ToastManager.hideLoading();
          },
        ),
      )
      ..addJavaScriptChannel(
        'mistake',
        onMessageReceived: (_) async {
          handleBack();
        },
      )
      ..addJavaScriptChannel(
        'live',
        onMessageReceived: (_) async {
          ToAppStoreChannel.toAppChanel();
        },
      )
      ..addJavaScriptChannel('lived', onMessageReceived: (_) async {})
      ..addJavaScriptChannel('five', onMessageReceived: (_) async {})
      ..addJavaScriptChannel('hundred', onMessageReceived: (_) async {})
      ..addJavaScriptChannel(
        'composedly',
        onMessageReceived: (_) async {
          Get.back();
          final tab = Get.find<TabbarController>();
          tab.changeIndex(0);
        },
      )
      ..loadRequest(Uri.parse(pageUrl));
  }

  Future<void> handleBack() async {
    if (await webcontroller.canGoBack()) {
      webcontroller.goBack();
    } else {
      Get.until((route) {
        final currentRoute = route.settings.name?.split('?').first;
        return currentRoute == ShineAppRouter.tab ||
            currentRoute == ShineAppRouter.authList;
      });
      if (Get.isRegistered<CertificationListController>()) {
        final cerVc = Get.find<CertificationListController>();
        await cerVc.initAuthListInfo(cerVc.productID);
      }
    }
  }
}
