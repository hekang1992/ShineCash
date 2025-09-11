import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageSuccessListController extends GetxController {
  final oneVc = TextEditingController();
  final twoVc = TextEditingController();
  final threeVc = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    oneVc.text = '';
    twoVc.text = '';
    threeVc.text = '';
  }
}
