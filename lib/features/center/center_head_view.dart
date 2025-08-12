import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/features/center/center_controller.dart';
import 'package:shinecash/features/center/center_more_view.dart';
import 'package:shinecash/features/center/center_order_view.dart';

class CenterHeadView extends GetView<CenterController> {
  const CenterHeadView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(color: Colors.transparent),
        Obx(() {
          final model = controller.model.value;
          final listArray = model.expect?.centuries ?? [];
          return Align(
            child: Padding(
              padding: EdgeInsets.only(top: 70.sp),
              child: Container(
                height: 530.h + listArray.length * 20.h,
                width: 350.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(24.sp)),
                ),
              ),
            ),
          );
        }),
        Column(
          children: [
            Image.asset(
              'assets/images/center_head_iamge.png',
              fit: BoxFit.cover,
              width: 120.w,
              height: 120.h,
            ),
            SizedBox(height: 15.h),
            Obx(() {
              return Text(
                controller.model.value.expect?.userInfo?.userphone ?? '',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColor.blackColor,
                ),
              );
            }),
            SizedBox(height: 24.h),
            CenterOrderView(),
            SizedBox(height: 24.h),
            CenterMoreView(),
          ],
        ),
      ],
    );
  }
}
