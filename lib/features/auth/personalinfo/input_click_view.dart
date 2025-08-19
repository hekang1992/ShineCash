import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/http/http_model.dart';

class InputClickView extends StatelessWidget {
  final TemporaryModel model;
  final TextEditingController controller; // 接收 controller
  final bool enable;
  final VoidCallback onTap;
  const InputClickView({
    super.key,
    required this.onTap,
    required this.enable,
    required this.model,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enable ? null : onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.sp),
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.acquainted ?? '',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: AppColor.blackColor,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              height: 52.h,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(9.sp)),
                border: Border.all(color: Color(0XFFEEEEFC), width: 1.sp),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 8.sp, left: 8.sp),
                child: TextField(
                  onChanged: (value) {
                    model.angrily = value;
                  },
                  autofocus: false,
                  enabled: enable,
                  style: TextStyle(
                    color: AppColor.orderTypeColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  controller: controller,
                  textAlign: TextAlign.left,
                  keyboardType: model.regrets == 1
                      ? TextInputType.number
                      : TextInputType.text,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: model.conversation ?? '',
                    hintStyle: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
