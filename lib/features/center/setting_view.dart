import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/routers/shine_router.dart';
import 'package:shinecash/features/apphead/app_head_view.dart';
import 'package:shinecash/features/auth/certificationlist/app_common_footer_view.dart';
import 'package:shinecash/features/center/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});

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
                  title: 'Configuration',
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 52.h,
                ),
                child: Column(
                  children: [
                    Container(
                      width: 351.w,
                      height: 52.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.sp),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 16.sp),
                          Text(
                            'Version Number',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColor.blackColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '1.0.0',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0XFF888888),
                            ),
                          ),
                          SizedBox(width: 16.sp),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.sp),
                    Container(
                      width: 351.w,
                      height: 105.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(9.sp)),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 12.sp),
                              Text(
                                'Loan Agreement',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.blackColor,
                                ),
                              ),
                              Spacer(),
                              Image.asset(
                                'assets/images/next_btn_image.png',
                                width: 7.sp,
                                height: 12.h,
                              ),
                              SizedBox(width: 12.sp),
                            ],
                          ),
                          Container(
                            color: Color(0XFF666666),
                            width: 320.w,
                            height: 1.h,
                          ),
                          Row(
                            children: [
                              SizedBox(width: 12.sp),
                              Text(
                                'Privacy Policy',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.blackColor,
                                ),
                              ),
                              Spacer(),
                              Image.asset(
                                'assets/images/next_btn_image.png',
                                width: 7.sp,
                                height: 12.h,
                              ),
                              SizedBox(width: 12.sp),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.sp),
                    InkWell(
                      onTap: () {
                        Get.toNamed(ShineAppRouter.delete);
                      },
                      child: Container(
                        width: 351.w,
                        height: 52.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.sp),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 16.sp),
                            Text(
                              'Delete An Account',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColor.blackColor,
                              ),
                            ),
                            Spacer(),
                            Image.asset(
                              'assets/images/next_btn_image.png',
                              width: 7.sp,
                              height: 12.h,
                            ),
                            SizedBox(width: 16.sp),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      height: 98.h,
                      width: double.infinity,
                      child: AppCommonFooterView(
                        title: 'Log Out',
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
