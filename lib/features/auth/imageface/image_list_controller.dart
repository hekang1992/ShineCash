import 'package:get/get.dart';
import 'package:shinecash/common/http/http_model.dart';
import 'package:shinecash/common/http/http_request.dart';
import 'package:shinecash/common/http/http_toast.dart';

class ImageListController extends GetxController {
  late final Map<String, dynamic> dict;

  final authlistModel = BaseModel().obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    dict = Get.arguments;
    print('dict--------$dict');
    judgeMentThat(productID: dict['productID'], type: '1');
  }
}

extension ImageListVc on ImageListController {
  judgeMentThat({required String productID, required String type}) async {
    try {
      ToastManager.showLoading();
      final http = ShineHttpRequest();
      final dict = {'nodded': productID};
      final response = await http.post('/wzcnrht/enemy', formData: dict);
      final model = BaseModel.fromJson(response.data);
      if (model.beautiful == '0' || model.beautiful == '00') {
        authlistModel.value = model;
        final rule = model.expect?.rule;
        final posted = model.expect?.rule;
        if (rule?.listening == 1 || posted?.listening == 1) {
          //人脸认证完成 -- 直接进入
        } else if (rule?.listening == 0) {
          //选择认证列表页面
        } else {}
      }
      ToastManager.hideLoading();
    } catch (e) {
      ToastManager.hideLoading();
    }
  }
}
