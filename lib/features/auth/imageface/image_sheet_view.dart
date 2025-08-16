import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/features/login/customer_btn.dart';

class ImageSheetView extends StatelessWidget {
  final String imageStr;
  final VoidCallback onTap;

  const ImageSheetView({
    super.key,
    required this.imageStr,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30.sp)),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 16.sp, left: 12.sp, right: 12.sp),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center, // 主轴居中
              children: [
                Expanded(
                  // 关键点：让文本居中
                  child: Center(
                    child: Text(
                      'Demonstration',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: onTap,
                  child: Image.asset(
                    'assets/images/closw_image_ac.png',
                    width: 12.w,
                    height: 12.h,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: 10.w),
              ],
            ),
            SizedBox(height: 10.h),
            Image.asset(
              'assets/images/$imageStr',
              width: 323.w,
              height: 321.h,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 12.h),
            CustomBtn(
              width: 350.w,
              height: 52.h,
              text: 'Next',
              onPressed: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
