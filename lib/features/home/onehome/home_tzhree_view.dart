import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTzhreeView extends StatelessWidget {
  final String name1;
  final String name2;
  final String name3;
  final String name4;
  final VoidCallback onTap1;
  final VoidCallback onTap2;

  const HomeTzhreeView({
    super.key,
    required this.name1,
    required this.name2,
    required this.name3,
    required this.name4,
    required this.onTap1,
    required this.onTap2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/$name1',
          width: 351.w,
          // height: 60.h,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 12.h),
        Stack(
          children: [
            Image.asset(
              'assets/images/$name2',
              width: 351.w,
              // height: 60.h,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 351.w,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: onTap1,
                      child: Container(color: Colors.transparent, height: 80.h),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: onTap2,
                      child: Container(color: Colors.transparent, height: 80.h),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Image.asset(
          'assets/images/$name3',
          width: 351.w,
          // height: 60.h,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 12.h),
        Image.asset(
          'assets/images/$name4',
          width: 351.w,
          // height: 60.h,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}
