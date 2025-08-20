import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/http/http_request.dart';
import 'package:shinecash/common/http/http_toast.dart';
import 'package:shinecash/common/tabbar/tabbar_controller.dart';
import 'package:shinecash/common/utils/image_pop.dart';
import 'package:shinecash/features/apphead/app_head_view.dart';
import 'package:shinecash/features/web/web_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends GetView<WebController> {
  WebView({super.key}) {
    final _ = Get.put(WebController());
  }

  @override
  Widget build(BuildContext context) {
    final String pageUrl = Get.arguments['pageUrl'] ?? '';
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Container(
          height: double.infinity,
          color: AppColor.bgColor,
          child: Stack(
            children: [
              Obx(() {
                return SafeArea(
                  child: AppHeadView(
                    title: controller.title.value,
                    onTap: () async {
                      if (await controller.webcontroller.canGoBack()) {
                        controller.webcontroller.goBack();
                      } else {
                        Get.back();
                      }
                    },
                  ),
                );
              }),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 52.h,
                ),
                child: Container(
                  color: AppColor.whiteColor,
                  child: WebViewWidget(
                    controller: controller.webcontroller
                      ..setJavaScriptMode(
                        JavaScriptMode.unrestricted,
                      ) // 启用 JavaScript
                      ..setNavigationDelegate(
                        NavigationDelegate(
                          onPageStarted: (url) {
                            ToastManager.showLoading();
                          },
                          onPageFinished: (url) async {
                            ToastManager.hideLoading();
                            final title =
                                await controller.webcontroller.getTitle() ?? '';
                            controller.title.value = title;
                          },
                          onWebResourceError: (error) {
                            ToastManager.hideLoading();
                          },
                        ),
                      )
                      ..addJavaScriptChannel(
                        'mistake',
                        onMessageReceived: (message) async {
                          Get.back();
                        },
                      )
                      ..addJavaScriptChannel(
                        'live',
                        onMessageReceived: (message) async {
                          ToAppStoreChannel.toAppChanel();
                        },
                      )
                      ..addJavaScriptChannel(
                        'lived',
                        onMessageReceived: (message) async {},
                      )
                      ..addJavaScriptChannel(
                        'five',
                        onMessageReceived: (message) async {},
                      )
                      ..addJavaScriptChannel(
                        'hundred',
                        onMessageReceived: (message) async {},
                      )
                      ..addJavaScriptChannel(
                        'composedly',
                        onMessageReceived: (message) async {
                          Get.back();
                          final tab = Get.find<TabbarController>();
                          tab.changeIndex(0);
                        },
                      )
                      ..loadRequest(Uri.parse(pageUrl)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
