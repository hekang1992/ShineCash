import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/state_manager.dart';
import 'package:shinecash/common/constants/constant.dart';

class PhoneCellView extends GetView {
  final String one;
  final String two;
  final String three;
  final VoidCallback onTap1;
  final VoidCallback onTap2;
  final int incColor1;
  final int incColor2;

  const PhoneCellView({
    super.key,
    required this.one,
    required this.two,
    required this.three,
    required this.onTap1,
    required this.onTap2,
    required this.incColor1,
    required this.incColor2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.sp),
        Text(
          one,
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColor.blackColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.sp),
        InkWell(
          onTap: onTap1,
          child: Container(
            height: 52.h,
            decoration: BoxDecoration(
              border: BoxBorder.all(width: 1, color: Color(0xffEEEEFC)),
              borderRadius: BorderRadius.circular(9.sp),
            ),
            child: Row(
              children: [
                SizedBox(width: 12.sp),
                Text(
                  two,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(incColor1),
                  ),
                ),
                Spacer(),
                Image.asset(
                  'assets/images/next_btn_image.png',
                  width: 7.w,
                  height: 12.h,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 12.sp),
              ],
            ),
          ),
        ),
        SizedBox(height: 8.sp),
        InkWell(
          onTap: onTap2,
          child: Container(
            height: 52.h,
            decoration: BoxDecoration(
              border: BoxBorder.all(width: 1, color: Color(0xffEEEEFC)),
              borderRadius: BorderRadius.circular(9.sp),
            ),
            child: Row(
              children: [
                SizedBox(width: 12.sp),
                Text(
                  three,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(incColor2),
                  ),
                ),
                Spacer(),
                Image.asset(
                  'assets/images/phoen_im_lis.png',
                  width: 14.w,
                  height: 12.h,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 12.sp),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
