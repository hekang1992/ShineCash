import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/features/login/customer_btn.dart';

class AppCommonFooterView extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const AppCommonFooterView({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.sp),
          topRight: Radius.circular(30.sp),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 12.sp,
          left: 12.sp,
          right: 12.sp,
          bottom: 20.sp,
        ),
        child: CustomBtn(fontSize: 15.sp, text: title, onPressed: onTap),
      ),
    );
  }
}
