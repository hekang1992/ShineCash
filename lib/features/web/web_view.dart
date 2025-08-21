import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/features/apphead/app_head_view.dart';
import 'package:shinecash/features/web/web_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends GetView<WebController> {
  WebView({super.key}) {
    Get.put(WebController());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: double.infinity,
          color: AppColor.bgColor,
          child: Stack(
            children: [
              Obx(() {
                return SafeArea(
                  child: AppHeadView(
                    title: controller.title.value,
                    onTap: controller.handleBack,
                  ),
                );
              }),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 52.h,
                ),
                child: Container(
                  color: AppColor.whiteColor,
                  child: WebViewWidget(controller: controller.webcontroller),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
