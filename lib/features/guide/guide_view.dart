import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/features/apphead/app_head_view.dart';

class GuideView extends GetView {
  const GuideView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Container(
          color: AppColor.bgColor,
          child: Stack(
            children: [
              Image.asset('assets/images/login_bg_image.png'),
              SafeArea(
                child: AppHeadView(
                  title: 'Borrowing Guide',
                  onTap: () {
                    Get.back();
                    FindHomeVc.getHomeVc();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 40.h + 12.h,
                ),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/guide_head1_image.png',
                        width: 375.w,
                        height: 275.h,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 12.h),
                      Image.asset(
                        'assets/images/guide_head2_image.png',
                        width: 351.w,
                        height: 818.h,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: MediaQuery.of(context).padding.bottom),
                    ],
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
