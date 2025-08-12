import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/http/http_request.dart';
import 'package:shinecash/common/routers/shine_router.dart';
import 'package:shinecash/features/login/customer_btn.dart';
import 'package:shinecash/features/login/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  // LoginView({super.key}) {
  //   final _ = Get.put(LoginController());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            Container(color: AppColor.bgColor),
            Image.asset(
              'assets/images/login_bg_image.png',
              width: MediaQuery.of(context).size.width,
              height: 268.h,
              fit: BoxFit.cover,
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: 40.sp, left: 12.sp, right: 12.sp),
                child: _loginView(controller),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _loginView(LoginController controller) {
  return SingleChildScrollView(
    physics: AlwaysScrollableScrollPhysics(),
    child: SizedBox(
      height: 650.h,
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 60.sp),
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(24.r),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                height: 120.h,
                color: Colors.transparent,
                child: Row(
                  children: [
                    SizedBox(width: 10.w),
                    Image.asset(
                      'assets/images/login_logo_image.png',
                      width: 120.w,
                      height: 120.h,
                    ),
                    SizedBox(width: 15.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Welcome!',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Shine Cash',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColor.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.h),
              _phoneView(controller),
              SizedBox(height: 16.h),
              _codeView(
                controller,
                onPressed: () {
                  controller.getCode(
                    controller.phoneController.text,
                    type: 'code',
                  );
                },
              ),
              SizedBox(height: 32.h),
              CustomBtn(
                text: 'Login',
                fontSize: 18.sp,
                width: 311.w,
                height: 52.h,
                onPressed: () {
                  final String phone = controller.phoneController.text;
                  final String code = controller.codeController.text;
                  controller.toLogin(phone: phone, code: code);
                },
              ),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () {
                  controller.getCode(controller.phoneController.text);
                },
                child: Image.asset(
                  'assets/images/voice_imge.png',
                  width: 138.w,
                  height: 20.h,
                  fit: BoxFit.cover,
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      final bool isClick = controller.isclickAgreement.value;
                      controller.changeType(!isClick);
                    },
                    child: Obx(
                      () => Image.asset(
                        controller.isclickAgreement.value
                            ? 'assets/images/login_sel_image.png'
                            : 'assets/images/login_nor_image.png',
                        width: 15.w,
                        height: 15.h,
                      ),
                    ),
                  ),
                  SizedBox(width: 6.w),
                  InkWell(
                    onTap: () {
                      Get.toNamed(
                        ShineAppRouter.web,
                        parameters: {'pageUrl': '$websiteUrl'},
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'I have read and agree with ',
                            style: TextStyle(
                              color: Color(0xFF888888),
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy agreement',
                            style: TextStyle(
                              color: AppColor.bgColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _phoneView(LoginController controller) {
  return Padding(
    padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
    child: Container(
      width: double.infinity,
      height: 52.h,
      decoration: BoxDecoration(
        color: Color(0XFFEEEEFC),
        borderRadius: BorderRadius.all(Radius.circular(14.r)),
      ),
      child: Row(
        children: [
          SizedBox(width: 16.w),
          Text(
            '+63',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColor.blackColor,
            ),
          ),
          SizedBox(width: 16.w),
          Container(color: Colors.black, width: 1.w, height: 12.h),
          SizedBox(width: 16.w),
          Expanded(
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.number,
              controller: controller.phoneController,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: 'Please enter phone number',
                hintStyle: TextStyle(
                  color: Color(0xFF888888),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
        ],
      ),
    ),
  );
}

Widget _codeView(LoginController controller, {VoidCallback? onPressed}) {
  return Padding(
    padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
    child: Container(
      width: double.infinity,
      height: 52.h,
      decoration: BoxDecoration(
        color: Color(0XFFEEEEFC),
        borderRadius: BorderRadius.all(Radius.circular(14.r)),
      ),
      child: Row(
        children: [
          SizedBox(width: 16.w),
          Expanded(
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.number,
              controller: controller.codeController,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: 'Please enter verification code',
                hintStyle: TextStyle(
                  color: Color(0xFF888888),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Obx(
            () => CustomBtn(
              text: controller.seconds.value == 0
                  ? 'Send'
                  : '${controller.seconds.value}s',
              width: 44.w,
              height: 44.h,
              onPressed: controller.seconds.value == 0 ? onPressed : null,
            ),
          ),
          SizedBox(width: 4.w),
        ],
      ),
    ),
  );
}
