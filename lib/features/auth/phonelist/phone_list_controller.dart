import 'package:get/get.dart';
import 'package:shinecash/common/devices/devices.dart';
import 'package:shinecash/common/http/http_model.dart';
import 'package:shinecash/common/http/http_request.dart';
import 'package:shinecash/common/http/http_toast.dart';
import 'package:shinecash/features/home/home_controller.dart';

class PhoneListController extends GetxController {
  late final String productID;
  final model = BaseModel().obs;

  var startTime = '';
  var endTime = '';

  @override
  void onInit() {
    super.onInit();
    productID = Get.arguments['productID'];
    getPhoneListInfo(productID: productID);
    startTime = DateTime.now().second.toString();
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

  uploadAllInfo({required String expect}) async {
    try {
      final http = ShineHttpRequest();
      Map<String, dynamic> dict = {'expect': expect};
      final response = await http.post('/wzcnrht/later', formData: dict);
      final model = BaseModel.fromJson(response.data);
      if (model.beautiful == '0' || model.beautiful == '00') {}
    } catch (e) {}
  }

  saveAllInfo({required String expect, required String productID}) async {
    try {
      ToastManager.showLoading();
      final http = ShineHttpRequest();
      Map<String, dynamic> dict = {'expect': expect, 'nodded': productID};
      final response = await http.post('/wzcnrht/dirty', formData: dict);
      final model = BaseModel.fromJson(response.data);
      if (model.beautiful == '0' || model.beautiful == '00') {
        final homeVc = Get.find<HomeController>();
        homeVc.getProductDetaiPageInfo(
          productID: productID,
          type: '1',
          inner: '1',
        );
        await PointTouchChannel.upLoadPoint(
          step: '7',
          startTime: startTime,
          endTime: DateTime.now().millisecondsSinceEpoch.toString(),
          orderID: '',
        );
      }
      ToastManager.showToast(model.captive ?? '');
      ToastManager.hideLoading();
    } catch (e) {
      ToastManager.hideLoading();
    }
  }
}
