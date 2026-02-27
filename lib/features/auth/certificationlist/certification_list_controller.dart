import 'package:get/get.dart';
import 'package:shinecash/common/http/http_model.dart';
import 'package:shinecash/common/http/http_request.dart';
import 'package:shinecash/common/http/http_toast.dart';
import 'package:shinecash/common/utils/app_location.dart';

class CertificationListController extends GetxController {
  late final String productID;

  final model = BaseModel().obs;

  @override
  void onInit() async {
    super.onInit();
    productID = Get.arguments['productID'];
    print('🧊productID-------$productID');
    initAuthListInfo(productID);
    await AppLocation.getDetailedLocation();
  }
}

extension CertificationlistVc on CertificationListController {
  initAuthListInfo(String productID) async {
    try {
      ToastManager.showLoading();
      final http = ShineHttpRequest();
      final response = await http.post(
        'wzcnrht/before',
        formData: {'nodded': productID},
      );
      final model = BaseModel.fromJson(response.data);
      final beautiful = model.beautiful ?? '';
      if (beautiful == '0' || beautiful == '00') {
        this.model.value = model;
      }
      ToastManager.hideLoading();
    } catch (e) {
      ToastManager.hideLoading();
    }
  }
}
