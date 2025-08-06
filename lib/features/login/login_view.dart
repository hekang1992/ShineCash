import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/features/login/login_controller.dart';

class LoginView extends GetView {
  LoginView({super.key}) {
    final _ = Get.put(LoginController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
              padding: EdgeInsets.only(top: 80.sp),
              child: _loginView(),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _loginView() {
  return Container(color: AppColor.textColor);
}
