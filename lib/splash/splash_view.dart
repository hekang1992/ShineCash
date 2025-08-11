import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shinecash/splash/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  SplashView({super.key}) {
    final _ = Get.put(SplashController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.transparent,
        child: Image.asset('assets/images/launch_image.png', fit: BoxFit.cover),
      ),
    );
  }
}
