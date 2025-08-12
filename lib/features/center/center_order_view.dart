import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/http/http_toast.dart';
import 'package:shinecash/features/center/center_controller.dart';

class CenterOrderView extends GetView<CenterController> {
  const CenterOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(left: 24.sp, right: 24.sp),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.pinkColor,
          borderRadius: BorderRadius.all(Radius.circular(16.sp)),
        ),
        child: SizedBox(
          height: 88.h,
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 3,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 20.sp,
            ),
            itemBuilder: (context, index) {
              final name = controller.nameStr[index];
              return listItemView(
                oneStr: name,
                twoStr: name,
                onTap: () {
                  ToastManager.showToast(name);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget listItemView({
  required String? oneStr,
  required String? twoStr,
  required VoidCallback onTap,
}) {
  return Container(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/$oneStr.png',
            width: 29.w,
            height: 28.h,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 5.h),
          Text(
            '$twoStr',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColor.whiteColor,
            ),
          ),
        ],
      ),
    ),
  );
}
