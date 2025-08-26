import 'package:get/get.dart';

class TinListController extends GetxController {
  var startTime = '';
  var endTime = '';

  @override
  void onInit() {
    super.onInit();
    startTime = DateTime.now().second.toString();
  }
}
