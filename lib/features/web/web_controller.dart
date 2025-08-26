import 'package:get/get.dart';
import 'package:shinecash/common/devices/devices.dart';
import 'package:shinecash/common/http/http_toast.dart';
import 'package:shinecash/common/routers/shine_router.dart';
import 'package:shinecash/common/tabbar/tabbar_controller.dart';
import 'package:shinecash/common/utils/image_pop.dart';
import 'package:shinecash/features/auth/certificationlist/certification_list_controller.dart';
import 'package:shinecash/features/home/home_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebController extends GetxController {
  late final WebViewController webcontroller;
  final title = ''.obs;
  var startTime = '';
  var endTime = '';
  var orderID = '';
  var isLoan = false;

  @override
  void onInit() {
    super.onInit();

    final String pageUrl = Get.arguments['pageUrl'] ?? '';
    if (Get.arguments != null && Get.arguments.containsKey('orderID')) {
      orderID = Get.arguments['orderID'] ?? '';
    }

    webcontroller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            ToastManager.showLoading();
            title.value = 'Shine Cash';
          },
          onPageFinished: (url) async {
            ToastManager.hideLoading();
            final t = await webcontroller.getTitle() ?? '';
            if (t.isEmpty) {
              title.value = 'Shine Cash';
            } else {
              title.value = t;
            }
          },
          onWebResourceError: (error) {
            ToastManager.hideLoading();
            title.value = 'Shine Cash';
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
      ..addJavaScriptChannel(
        'lived',
        onMessageReceived: (_) async {
          isLoan = true;
          await PointTouchChannel.upLoadPoint(
            step: '9',
            startTime: DateTime.now().millisecondsSinceEpoch.toString(),
            endTime: DateTime.now().millisecondsSinceEpoch.toString(),
            orderID: orderID,
          );
          Future.delayed(Duration(milliseconds: 500));
          await PointTouchChannel.upLoadPoint(
            step: '10',
            startTime: DateTime.now().millisecondsSinceEpoch.toString(),
            endTime: DateTime.now().millisecondsSinceEpoch.toString(),
            orderID: orderID,
          );
        },
      )
      ..addJavaScriptChannel(
        'five',
        onMessageReceived: (_) async {
          startTime = DateTime.now().second.toString();
        },
      )
      ..addJavaScriptChannel(
        'hundred',
        onMessageReceived: (_) async {
          endTime = DateTime.now().second.toString();
          await PointTouchChannel.upLoadPoint(
            step: '8',
            startTime: startTime,
            endTime: endTime,
            orderID: '',
          );
        },
      )
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
        if (isLoan == true) {
          return currentRoute == ShineAppRouter.tab;
        } else {
          return currentRoute == ShineAppRouter.tab ||
              currentRoute == ShineAppRouter.authList ||
              currentRoute == ShineAppRouter.login ||
              currentRoute == ShineAppRouter.setting;
        }
      });
      if (Get.isRegistered<CertificationListController>()) {
        final cerVc = Get.find<CertificationListController>();
        await cerVc.initAuthListInfo(cerVc.productID);
      }
      if (Get.isRegistered<HomeController>()) {
        final homeVc = Get.find<HomeController>();
        await homeVc.initHomeInfo();
        await homeVc.uploadlocation();
        await homeVc.uploaddeviceInfo();
      }
    }
  }
}
