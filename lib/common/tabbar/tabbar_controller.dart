import 'package:get/get.dart';
import 'package:shinecash/features/center/center_controller.dart';
import 'package:shinecash/features/home/home_controller.dart';
import 'package:shinecash/features/order/order_controller.dart';

class TabbarController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Get.put(HomeController());
    Get.put(OrderController());
    Get.put(CenterController());
  }

  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
    if (index == 0) {
      final homeVc = Get.find<HomeController>();
      homeVc.initHomeInfo();
      homeVc.uploadlocation();
      homeVc.uploaddeviceInfo();
    } else if (index == 1) {
      final vc = Get.find<OrderController>();
      vc.isShowBack.value = false;
      vc.makeChage(changeIndex: vc.currentIndex.value);
    } else {
      final vc = Get.find<CenterController>();
      vc.initCenterInfo();
    }
  }
}
