import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shinecash/common/constants/constant.dart';

class HomeTwoView extends StatelessWidget {
  final String name1;
  final String name2;
  final String name3;
  final String name4;
  final VoidCallback onTap;

  const HomeTwoView({
    super.key,
    required this.name1,
    required this.name2,
    required this.name3,
    required this.name4,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Image.asset('assets/images/$name1', width: 350.w, height: 283.h),
          Container(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 90.h),
                Text(
                  name2,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppColor.whiteColor,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  name3,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 40.sp,
                    color: AppColor.whiteColor,
                  ),
                ),
                SizedBox(height: 55.h),
                Text(
                  name4,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: AppColor.blackColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
