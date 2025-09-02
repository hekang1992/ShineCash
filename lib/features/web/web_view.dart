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
                  child: Obx(
                    () => controller.isLoading.value
                        ? LinearProgressIndicator(
                            value: controller.progress.value,
                            backgroundColor: Colors.white,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColor.pinkColor,
                            ),
                            minHeight: 2.h,
                          )
                        : Container(),
                  ),
                ),
              ),
              Obx(() {
                return Padding(
                  padding: EdgeInsets.only(
                    top: controller.isLoading.value
                        ? MediaQuery.of(context).padding.top + 54.h
                        : MediaQuery.of(context).padding.top + 52.h,
                  ),
                  child: Container(
                    color: AppColor.whiteColor,
                    child: WebViewWidget(controller: controller.webcontroller),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
