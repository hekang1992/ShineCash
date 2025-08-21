import 'package:get/get.dart';
import 'package:shinecash/common/http/http_model.dart';
import 'package:shinecash/common/http/http_request.dart';
import 'package:shinecash/common/http/http_toast.dart';

class OrderController extends GetxController {
  var currentIndex = 0.obs;
  final model = BaseModel().obs;

  makeChage({required int changeIndex}) {
    currentIndex.value = changeIndex;
    if (changeIndex == 0) {
      getOrderListType(type: '4');
    } else if (changeIndex == 1) {
      getOrderListType(type: '7');
    } else if (changeIndex == 2) {
      getOrderListType(type: '6');
    } else if (changeIndex == 3) {
      getOrderListType(type: '5');
    }
  }

  @override
  void onInit() {
    super.onInit();
    makeChage(changeIndex: 0);
  }
}

extension OrderVc on OrderController {
  getOrderListType({required String type}) async {
    try {
      ToastManager.showLoading();
      final http = ShineHttpRequest();
      final dict = {'judge': type};
      final response = await http.post('/wzcnrht/satisfactory', formData: dict);
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
