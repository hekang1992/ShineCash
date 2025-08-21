import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shinecash/common/constants/constant.dart';

class AppHeadView extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool? isShowBack;
  const AppHeadView({
    super.key,
    required this.title,
    required this.onTap,
    this.isShowBack = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      height: 40.h,
      child: Row(
        children: [
          SizedBox(width: 17.w),
          if (isShowBack == true)
            InkWell(
              onTap: onTap,
              child: Image.asset(
                'assets/images/app_back_image.png',
                width: 22.w,
                height: 22.h,
                fit: BoxFit.contain,
              ),
            ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColor.whiteColor,
                ),
              ),
            ),
          ),
          if (isShowBack == true)
            SizedBox(width: 39.sp)
          else
            SizedBox(width: 22.sp),
        ],
      ),
    );
  }
}
