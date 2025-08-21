import 'package:get/get.dart';
import 'package:shinecash/common/http/http_model.dart';
import 'package:shinecash/common/http/http_request.dart';
import 'package:shinecash/common/http/http_toast.dart';

class CenterController extends GetxController {
  final nameStr = ['All Orders', 'Repaying', 'Completed'];

  ///返回的数据
  final model = BaseModel().obs;

  @override
  void onInit() {
    super.onInit();
    initCenterInfo();
  }
}

extension CenterVc on CenterController {
  Future initCenterInfo() async {
    try {
      ToastManager.showLoading();
      final http = ShineHttpRequest();
      final response = await http.get('/wzcnrht/natural');
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
