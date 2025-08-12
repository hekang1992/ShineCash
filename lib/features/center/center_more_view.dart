import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/http/http_toast.dart';
import 'package:shinecash/features/center/center_controller.dart';

class CenterMoreView extends GetView<CenterController> {
  const CenterMoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24.sp, right: 24.sp),
      child: Column(
        children: [
          Row(
            children: [
              Container(color: Colors.amber, width: 4.w, height: 16.h),
              SizedBox(width: 8.w),
              Text(
                'More Features',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColor.blackColor,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          GridView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 3,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.4,
              crossAxisCount: 2,
              crossAxisSpacing: 15.sp,
              mainAxisSpacing: 15.sp,
            ),
            itemBuilder: (context, index) {
              final name = controller.nameStr[index];
              return listItemView(
                oneStr: name,
                twoStr: name,
                onTap: () {
                  ToastManager.showToast(name);
                },
              );
            },
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

Widget listItemView({
  required String? oneStr,
  required String? twoStr,
  required VoidCallback onTap,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Color(0XFFEEEEFC),
      borderRadius: BorderRadius.circular(16.sp),
    ),
    child: InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/$oneStr.png',
            width: 48.w,
            height: 48.h,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 12.h),
          Text(
            '$twoStr',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColor.blackColor,
            ),
          ),
        ],
      ),
    ),
  );
}
