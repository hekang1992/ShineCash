import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LogOutView extends StatelessWidget {
  final VoidCallback onTap;

  const LogOutView({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          // 图片作为背景
          Image.asset(
            'assets/images/log_out_imge.png',
            width: 263.w,
            height: 230.h,
            fit: BoxFit.cover,
          ),

          // 左下角方块
          Positioned(
            left: 0,
            bottom: 0,
            child: InkWell(
              onTap: () => Get.back(),
              child: Container(
                width: 125.w,
                height: 80.h,
                color: Colors.transparent,
              ),
            ),
          ),

          // 右下角方块
          Positioned(
            right: 0,
            bottom: 0,
            child: InkWell(
              onTap: onTap,
              child: Container(
                width: 125.w,
                height: 80.h,
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
