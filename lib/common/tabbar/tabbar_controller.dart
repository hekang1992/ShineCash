import 'package:get/get.dart';
import 'package:shinecash/features/center/center_controller.dart';
import 'package:shinecash/features/home/home_controller.dart';

class TabbarController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Get.put(HomeController());
    Get.put(CenterController());
    Get.put(HomeController());
  }

  var selectedIndex = 0.obs;
  void changeIndex(int index) {
    selectedIndex.value = index;
    if (index == 0) {
      final vc = Get.find<HomeController>();
      vc.initHomeInfo();
    } else if (index == 1) {
    } else {
      final vc = Get.find<CenterController>();
      vc.initCenterInfo();
    }
  }
}
