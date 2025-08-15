import 'package:get/get.dart';

class ImageListController extends GetxController {
  late final Map<String, dynamic> dict;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    dict = Get.arguments;
    print('dict--------$dict');
  }
}
