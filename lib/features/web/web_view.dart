import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends GetView {
  const WebView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final String pageUrl = Get.parameters['pageUrl'] ?? '';
    return Scaffold(
      appBar: AppBar(title: const Text('WebView')),
      body: Container(
        color: AppColor.whiteColor,
        child: WebViewWidget(
          controller: WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted) // 启用 JavaScript
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
    );
  }
}
