import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/http/http_model.dart';
import 'package:shinecash/features/login/customer_btn.dart';

class OrderListView extends GetView {
  final CenturiesModel listModel;
  const OrderListView({super.key, required this.listModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12.sp, right: 12.sp, top: 12.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(9.sp)),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.sp),
          Row(
            children: [
              SizedBox(width: 12.sp),
              Text('image'),
              SizedBox(width: 8.sp),
              Text('ProductName'),
              Spacer(),
              Container(
                padding: EdgeInsets.only(left: 8.sp, right: 8.sp),
                height: 36.h,
                decoration: BoxDecoration(
                  color: AppColor.orderTypeColor,
                  borderRadius: BorderRadius.all(Radius.circular(12.sp)),
                ),
                child: Center(
                  child: Text(
                    'data',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.sp),
            ],
          ),
          SizedBox(height: 10.sp),
          Container(
            height: 148.h,
            width: 327.w,
            decoration: BoxDecoration(
              color: Color(0xffEEEEFC),
              borderRadius: BorderRadius.all(Radius.circular(9.sp)),
            ),
          ),
          SizedBox(height: 8.sp),
          CustomBtn(
            fontSize: 16.sp,
            width: 327.w,
            height: 44.h,
            text: 'text',
            onPressed: () {},
          ),
          SizedBox(height: 8.sp),
        ],
      ),
    );
  }
}
