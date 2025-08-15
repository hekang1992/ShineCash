import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shinecash/features/auth/imageface/image_list_controller.dart';

class ImageListView extends GetView<ImageListController> {
  ImageListView({super.key}) {
    final _ = Get.put(ImageListController());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PopScope(
      canPop: false,
      child: Scaffold(body: Stack(children: [])),
    );
  }
}
