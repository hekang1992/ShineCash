import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeThreeView extends StatelessWidget {
  final String name1;
  final String name2;
  final String name3;
  final String name4;

  const HomeThreeView({
    super.key,
    required this.name1,
    required this.name2,
    required this.name3,
    required this.name4,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
        Image.asset(
          'assets/images/$name2',
          width: 351.w,
          // height: 60.h,
          fit: BoxFit.cover,
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
