import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/http/http_model.dart';
import 'package:shinecash/features/login/customer_btn.dart';

class OrderListView extends GetView {
  final CenturiesModel listModel;
  final VoidCallback onTap;
  const OrderListView({
    super.key,
    required this.listModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
                ClipOval(
                  child: Image.network(
                    listModel.imaginary ?? '',
                    width: 32.w,
                    height: 32.h,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 8.sp),
                Text(
                  listModel.correspondent ?? '',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                if ((listModel.appeal ?? '').isNotEmpty)
                  Container(
                    padding: EdgeInsets.only(left: 8.sp, right: 8.sp),
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: AppColor.orderTypeColor,
                      borderRadius: BorderRadius.all(Radius.circular(12.sp)),
                    ),
                    child: Center(
                      child: Text(
                        listModel.appeal ?? '',
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
              width: 327.w,
              decoration: BoxDecoration(
                color: Color(0xffEEEEFC),
                borderRadius: BorderRadius.all(Radius.circular(9.sp)),
              ),
              child: Column(
                children: [
                  SizedBox(height: 16.sp),
                  for (ContainedModel model in listModel.contained ?? [])
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 16.sp),
                            Text(
                              model.acquainted ?? '',
                              style: TextStyle(
                                color: Color(0xff555555),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Spacer(),
                            Text(
                              model.significant ?? '',
                              style: TextStyle(
                                color: Color(0xff555555),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: 16.sp),
                          ],
                        ),
                        SizedBox(height: 12.sp),
                      ],
                    ),
                ],
              ),
            ),
            SizedBox(height: 8.sp),
            if ((listModel.perceived ?? '').isNotEmpty)
              CustomBtn(
                fontSize: 16.sp,
                width: 327.w,
                height: 44.h,
                text: listModel.perceived ?? '',
                onPressed: () {},
              ),
            SizedBox(height: 8.sp),
          ],
        ),
      ),
    );
  }
}
