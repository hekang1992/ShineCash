import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/http/http_toast.dart';
import 'package:shinecash/features/apphead/app_head_view.dart';
import 'package:shinecash/features/center/delete_controller.dart';
import 'package:shinecash/features/login/customer_btn.dart';

class DeleteView extends GetView<DeleteController> {
  const DeleteView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColor.bgColor,
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              SafeArea(
                child: AppHeadView(
                  title: 'Delete An Account',
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 82.h,
                ),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/sha_image_de.png',
                        width: 44.w,
                        height: 44.h,
                      ),
                      SizedBox(height: 14.h),
                      Text(
                        'Apply for account closure',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Image.asset(
                            'assets/images/cycle_auth_image.png',
                            width: 37.w,
                            height: 23.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: Container(
                              width: 351.w,
                              height: 541.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.sp),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Account cancellation will result in permanent invalidation and irreversibility, and you will forfeit the following rights, benefits, and services.',
                                      style: TextStyle(
                                        color: Color(0XFF888888),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 16.sp),
                                    listTermView(
                                      one: '①',
                                      two:
                                          'Disable access to the app and related services',
                                    ),
                                    SizedBox(height: 16.sp),
                                    listTermView(
                                      one: '②',
                                      two:
                                          'All personal data will be permanently deleted, cannot be reversed',
                                    ),
                                    SizedBox(height: 16.sp),
                                    listTermView(
                                      one: '③',
                                      two:
                                          'Outstanding loans must be settled beforehand',
                                    ),
                                    SizedBox(height: 16.sp),
                                    listTermView(
                                      one: '④',
                                      two:
                                          'After cancellation, no more notifications or promotional materials will be sent!',
                                    ),
                                    SizedBox(height: 32.sp),
                                    CustomBtn(
                                      width: 320.w,
                                      height: 52.h,
                                      fontSize: 15.sp,
                                      text: 'Confirm Cancellation',
                                      onPressed: () async {
                                        final isClick =
                                            controller.isClick.value;
                                        if (isClick == false) {
                                          ToastManager.showToast(
                                            'Please confirm the cancellation terms before deciding to delete your account.',
                                          );
                                        } else {
                                          await controller.deleteInfo();
                                        }
                                      },
                                    ),
                                    SizedBox(height: 12.w),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Obx(() {
                                          final isClick =
                                              controller.isClick.value;
                                          return InkWell(
                                            onTap: () =>
                                                controller.changeValue(isClick),
                                            child: Image.asset(
                                              isClick
                                                  ? 'assets/images/login_sel_image.png'
                                                  : 'assets/images/login_nor_image.png',
                                              width: 14.sp,
                                              height: 14.sp,
                                              fit: BoxFit.contain,
                                            ),
                                          );
                                        }),
                                        SizedBox(width: 8.sp),
                                        Text(
                                          'I have read and agreed to the above',
                                          style: TextStyle(
                                            color: Color(0xff888888),
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget listTermView({required String one, required String two}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        one,
        style: TextStyle(
          color: Color(0xff7262EC),
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Text(
          two,
          style: TextStyle(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      SizedBox(width: 10.sp),
    ],
  );
}
