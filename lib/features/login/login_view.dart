import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/utils/save_idfv_info.dart';
import 'package:shinecash/features/login/login_controller.dart';

class LoginView extends GetView {
  LoginView({super.key}) {
    final _ = Get.put(LoginController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        child: Container(color: Colors.blue),
        onTap: () async {
          await GetIDFVInfo.requestIDFA();
        },
      ),
    );
  }
}
