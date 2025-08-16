import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressListView extends StatelessWidget {
  final double pix;
  const ProgressListView({super.key, required this.pix});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 20.h,
          width: 350.w,
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(26),
            borderRadius: BorderRadius.all(Radius.circular(10.sp)),
          ),
        ),
        Container(
          height: 20.h,
          width: 350.w * pix,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.sp)),
          ),
        ),
      ],
    );
  }
}
