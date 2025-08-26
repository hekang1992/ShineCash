import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/routers/shine_router.dart';
import 'package:shinecash/features/center/center_controller.dart';

class CenterMoreView extends GetView<CenterController> {
  const CenterMoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24.sp, right: 24.sp),
      child: Column(
        children: [
          Row(
            children: [
              Container(color: Colors.amber, width: 4.w, height: 16.h),
              SizedBox(width: 8.w),
              Text(
                'More Features',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColor.blackColor,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Obx(() {
            final model = controller.model.value;
            return GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: model.expect?.centuries?.length ?? 0,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.4,
                crossAxisCount: 2,
                crossAxisSpacing: 15.sp,
                mainAxisSpacing: 15.sp,
              ),
              itemBuilder: (context, index) {
                final name = model.expect?.centuries?[index].acquainted ?? '';
                final finished = model.expect?.centuries?[index].finished ?? '';
                final cautiously =
                    model.expect?.centuries?[index].cautiously ?? '';
                return listItemView(
                  oneStr: finished,
                  twoStr: name,
                  onTap: () {
                    if (cautiously.contains(settingSchemeUrl)) {
                      Get.toNamed(
                        ShineAppRouter.setting,
                        arguments: {'model': controller.model.value},
                      );
                    } else {
                      Get.toNamed(
                        ShineAppRouter.web,
                        arguments: {'pageUrl': cautiously},
                      );
                    }
                  },
                );
              },
            );
          }),
          SizedBox(height: 24.h),
        ],
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
    decoration: BoxDecoration(
      color: Color(0XFFEEEEFC),
      borderRadius: BorderRadius.circular(16.sp),
    ),
    child: InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            oneStr ?? '',
            width: 48.w,
            height: 48.h,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 48.w,
                height: 48.h,
                color: const Color.fromARGB(255, 216, 194, 239), // 红色背景
                child: Icon(
                  Icons.error_outline,
                  color: Colors.white,
                  size: 24.w,
                ),
              );
            },
          ),

          SizedBox(height: 12.h),
          Text(
            '$twoStr',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColor.blackColor,
            ),
          ),
        ],
      ),
    ),
  );
}
