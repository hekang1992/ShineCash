import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/http/http_model.dart';
import 'package:shinecash/features/auth/imageface/image_success_list_controller.dart';
import 'package:shinecash/features/login/customer_btn.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class ImageSuccessListView extends GetView<ImageSuccessListController> {
  final VoidCallback onTap;
  final void Function(ImageSuccessListController) sureTap;
  final BaseModel model;
  ImageSuccessListView({
    super.key,
    required this.model,
    required this.onTap,
    required this.sureTap,
  }) {
    final _ = Get.put(ImageSuccessListController());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.sp),
          topRight: Radius.circular(12.sp),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 12.sp, left: 12.sp, right: 12.sp),
        child: Column(
          children: [
            Row(
              children: [
                Spacer(),
                Text(
                  'Confirm Your Information',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: onTap,
                  child: Image.asset(
                    'assets/images/closw_image_ac.png',
                    width: 12.w,
                    height: 12.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.sp),
            inputCellView(
              enable: true,
              controller: controller.oneVc,
              model: model.expect?.favor?[0] ?? FavorModel(),
            ),
            inputCellView(
              enable: true,
              controller: controller.twoVc,
              model: model.expect?.favor?[1] ?? FavorModel(),
            ),
            inputCellView(
              enable: false,
              controller: controller.threeVc,
              model: model.expect?.favor?[2] ?? FavorModel(),
              onTap: () {
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  currentTime: DateFormat('dd-MM-yyyy').parse(
                    controller.threeVc.text.isEmpty
                        ? (model.expect?.favor?[2].remain ?? '')
                        : controller.threeVc.text,
                  ),
                  locale: LocaleType.en,
                  onConfirm: (date) {
                    final selectdate = DateFormat('dd-MM-yyyy').format(date);
                    controller.threeVc.text = selectdate;
                  },
                );
              },
            ),
            Spacer(),
            SizedBox(
              width: 351.w,
              height: 52.h,
              child: CustomBtn(
                text: 'Confirm',
                onPressed: () {
                  sureTap(controller);
                },
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 10.h),
          ],
        ),
      ),
    );
  }
}

Widget inputCellView({
  required TextEditingController controller,
  required bool enable,
  required FavorModel model,
  VoidCallback? onTap,
}) {
  if (controller.text.isEmpty) {
    controller.text = model.remain ?? '09-09-1990';
  }

  return InkWell(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.only(bottom: 10.sp),
      height: 52.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.sp)),
        border: BoxBorder.all(color: Color(0XFFEEEEFC)),
      ),
      child: Row(
        children: [
          SizedBox(width: 10.sp),
          Text(
            model.even ?? '',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: TextField(
              enabled: enable,
              style: TextStyle(
                color: AppColor.orderTypeColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              controller: controller,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: model.even ?? '',
                hintStyle: TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(width: 10.sp),
        ],
      ),
    ),
  );
}
