import 'package:get/get.dart';
import 'package:shinecash/common/http/http_model.dart';
import 'package:shinecash/common/http/http_request.dart';
import 'package:shinecash/common/http/http_toast.dart';

class HomeController extends GetxController {
  final model = BaseModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initHomeInfo();
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

extension HomeVc on HomeController {
  initHomeInfo() async {
    try {
      ToastManager.showLoading();
      final http = ShineHttpRequest();
      final response = await http.get('/wzcnrht/crowned');
      final model = BaseModel.fromJson(response.data);
      if (model.beautiful == '0' || model.beautiful == '00') {
        this.model.value = model;
      }
      ToastManager.hideLoading();
    } catch (e) {
      ToastManager.hideLoading();
    }
  }
}
