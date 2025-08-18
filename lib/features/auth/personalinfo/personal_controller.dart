import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/http/http_model.dart';
import 'package:shinecash/common/http/http_request.dart';
import 'package:shinecash/common/http/http_toast.dart';

class PersonalController extends GetxController {
  late final String productID;
  final model = BaseModel().obs;
  List<TextEditingController> textControllers =
      []; // 存储所有的 TextEditingController
  @override
  void onInit() {
    super.onInit();
    productID = Get.arguments['productID'];
    findPersonalInfo(productID: productID);
  }
}

extension PersonalVc on PersonalController {
  findPersonalInfo({required String productID}) async {
    try {
      ToastManager.showLoading();
      final http = ShineHttpRequest();
      Map<String, dynamic> dict = {'nodded': productID};
      final response = await http.post('/wzcnrht/fair', formData: dict);
      final model = BaseModel.fromJson(response.data);
      if (model.beautiful == '0' || model.beautiful == '00') {
        this.model.value = model;
        textControllers.clear();
        for (TemporaryModel element in model.expect?.temporary ?? []) {
          textControllers.add(TextEditingController());
        }
      }
      ToastManager.hideLoading();
    } catch (e) {
      ToastManager.hideLoading();
    }
  }
}
