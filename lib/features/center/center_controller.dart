import 'package:get/get.dart';
import 'package:shinecash/common/http/http_request.dart';
import 'package:shinecash/common/http/http_toast.dart';

class CenterController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initCenterInfo();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}

extension CenterVc on CenterController {
  Future initCenterInfo() async {
    ToastManager.showLoading();
    final http = ShineHttpRequest();
    try {
      final respose = await http.get('/wzcnrht/natural');
      ToastManager.hideLoading();
    } catch (e) {
      ToastManager.hideLoading();
    }
  }
}
