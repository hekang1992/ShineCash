import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/features/center/center_controller.dart';

class CenterView extends GetView<CenterController> {
  const CenterView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CenterController());
    return Scaffold(body: Container(color: AppColor.bgColor));
  }
}
