import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeOneView extends StatelessWidget {
  final String name1;
  final String name2;
  final String name3;

  final VoidCallback onTap;

  const HomeOneView({
    super.key,
    required this.name1,
    required this.name2,
    required this.name3,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name1,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            Text(
              name2,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Spacer(),
        InkWell(
          onTap: onTap,
          child: Image.asset(
            'assets/images/center_head_iamge.png',
            width: 40.w,
            height: 40.h,
          ),
        ),
        SizedBox(width: 12.w),
      ],
    );
  }
}
