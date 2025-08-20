import 'package:get/get.dart';
import 'package:shinecash/common/http/http_model.dart';
import 'package:shinecash/common/http/http_request.dart';
import 'package:shinecash/common/http/http_toast.dart';

class PhoneListController extends GetxController {
  late final String productID;
  final model = BaseModel().obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    productID = Get.arguments['productID'];
    getPhoneListInfo(productID: productID);
  }
}

extension PhoneListVc on PhoneListController {
  getPhoneListInfo({required String productID}) async {
    try {
      ToastManager.showLoading();
      final http = ShineHttpRequest();
      Map<String, dynamic> dict = {'nodded': productID};
      final response = await http.post('/wzcnrht/crumpled', formData: dict);
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
