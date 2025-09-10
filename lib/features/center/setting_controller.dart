import 'package:get/get.dart';
import 'package:shinecash/common/http/http_model.dart';
import 'package:shinecash/common/http/http_request.dart';
import 'package:shinecash/common/http/http_toast.dart';
import 'package:shinecash/common/routers/shine_router.dart';
import 'package:shinecash/common/utils/save_login_info.dart';

class SettingController extends GetxController {
  late BaseModel model;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    model = Get.arguments['model'];
    print('object===========$model');
  }
}

extension SettingVc on SettingController {
  logOutInfo() async {
    try {
      ToastManager.showLoading();
      final http = ShineHttpRequest();
      final response = await http.get('wzcnrht/sent');
      final model = BaseModel.fromJson(response.data);
      if (model.beautiful == '0' || model.beautiful == '00') {
        SaveLoginInfo.clearAll();
        Get.offAllNamed(ShineAppRouter.splash);
      }
      ToastManager.showToast(model.captive ?? '');
      ToastManager.hideLoading();
    } catch (e) {
      ToastManager.hideLoading();
    }
  }
}
