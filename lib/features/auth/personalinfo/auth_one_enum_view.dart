import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/http/http_model.dart';
import 'package:shinecash/features/auth/personalinfo/personal_controller.dart';
import 'package:shinecash/features/auth/personalinfo/pop_list_view.dart';
import 'package:shinecash/features/auth/work/workinfo_controller.dart';
import 'package:shinecash/features/base_controller.dart';
import 'package:shinecash/features/login/customer_btn.dart';

class AuthOneEnumView extends StatelessWidget {
  final VoidCallback onTap;
  final TemporaryModel model;
  final List<SincerelyModel> listModel;
  final BaseController controller;
  final int fatherIndex;

  const AuthOneEnumView({
    super.key,
    required this.onTap,
    required this.model,
    required this.listModel,
    required this.controller,
    required this.fatherIndex,
  });

  @override
  Widget build(BuildContext context) {
    int selectedIndex = model.selectIndex ?? 0;
    return Container(
      height: 500.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12.sp)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 11.sp),
            child: Row(
              children: [
                SizedBox(width: 12.w),
                Spacer(),
                Text(
                  model.acquainted ?? '',
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 16.sp,
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
                  ),
                ),
                SizedBox(width: 12.w),
              ],
            ),
          ),
          SizedBox(height: 12.sp),
          Expanded(
            child: StatefulBuilder(
              builder: (context, setState) {
                return ListView.builder(
                  itemCount: listModel.length,
                  itemBuilder: (context, index) {
                    return PopListView(
                      index: model.selectIndex ?? 0,
                      isSelected: index == selectedIndex,
                      title: listModel[index].pens ?? '',
                      onSelected: (int value) {
                        setState(() {
                          selectedIndex = index;
                          model.selectIndex = index;
                        });
                      },
                    );
                  },
                );
              },
            ),
          ),
          SafeArea(
            child: CustomBtn(
              width: 351.w,
              height: 52.h,
              fontSize: 16.sp,
              text: 'Confirm',
              onPressed: () {
                final selectedItem = listModel[selectedIndex];
                if (controller is PersonalController) {
                  final v1Controller = controller as PersonalController;
                  v1Controller.textControllers[fatherIndex].text =
                      selectedItem.pens ?? '';
                } else if (controller is WorkinfoController) {
                  final v2Controller = controller as WorkinfoController;
                  v2Controller.textControllers[fatherIndex].text =
                      selectedItem.pens ?? '';
                }

                model.angrily = (selectedItem.many ?? 0).toString();
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }
}
