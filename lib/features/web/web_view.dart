import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
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
              SafeArea(
                child: AppHeadView(
                  title: 'title',
                  onTap: () async {
                    if (await controller.webcontroller.canGoBack()) {
                      controller.webcontroller.goBack();
                    } else {
                      Get.back();
                    }
                  },
                ),
              ),
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
                          onPageStarted: (url) => print('开始加载: $url'),
                          onPageFinished: (url) => print('加载完成: $url'),
                          onWebResourceError: (error) =>
                              print('错误: ${error.description}'),
                          onNavigationRequest: (request) {
                            if (request.url.contains('ads.com')) {
                              return NavigationDecision.prevent; // 拦截广告链接
                            }
                            return NavigationDecision.navigate; // 允许其他链接
                          },
                        ),
                      )
                      ..loadRequest(Uri.parse(pageUrl)), // 加载 URL
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
