import 'package:get/get.dart';
import 'package:shinecash/common/utils/app_location.dart';

class TinListController extends GetxController {
  var startTime = '';
  var endTime = '';

  @override
  void onInit() async {
    super.onInit();
    startTime = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    await AppLocation.getDetailedLocation();
  }
}
