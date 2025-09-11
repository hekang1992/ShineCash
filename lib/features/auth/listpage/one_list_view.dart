import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shinecash/common/constants/constant.dart';

class OneListView extends StatelessWidget {
  final String title;
  final List<String>? address;
  final Function(String) onTap;

  const OneListView({
    super.key,
    required this.title,
    this.address,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 8.0.sp,
        left: 12.sp,
        right: 12.sp,
        bottom: 8.sp,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(color: Colors.amber, width: 4.w, height: 16.h),
              SizedBox(width: 8.w),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColor.blackColor,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: false,
              itemCount: address?.length ?? 0,
              itemBuilder: (context, index) {
                final title = address?[index] ?? '';
                return typeListView(title: title, onTap: () => onTap(title));
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget typeListView({required String title, required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 50.h,
      width: 327.w,
      margin: EdgeInsets.only(bottom: 8.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.sp)),
        border: Border.all(color: Color(0XFFEEEEFC)),
      ),
      child: Row(
        children: [
          SizedBox(width: 10.sp),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          Image.asset(
            'assets/images/next_btn_image.png',
            width: 7.w,
            height: 12.h,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 10.sp),
        ],
      ),
    ),
  );
}
