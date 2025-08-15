import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/http/http_model.dart';
import 'package:shinecash/common/http/http_request.dart';
import 'package:shinecash/common/http/http_toast.dart';
import 'package:shinecash/common/routers/shine_router.dart';

class HomeController extends GetxController {
  // 首页数据model
  final model = BaseModel().obs;

  // 申请model
  final applyModel = BaseModel().obs;

  // 产品详情model
  final detailModel = BaseModel().obs;

  // 认证列表model
  final authlistModel = BaseModel().obs;

  @override
  void onInit() {
    super.onInit();
    initHomeInfo();
  }
}

extension HomeVc on HomeController {
  /// 首页初始化
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

  /// 申请
  applyProductWithID(String productID) async {
    try {
      ToastManager.showLoading();
      final http = ShineHttpRequest();
      final dict = {'nodded': productID};
      final response = await http.post('/wzcnrht/kneel', formData: dict);
      final model = BaseModel.fromJson(response.data);
      if (model.beautiful == '0' || model.beautiful == '00') {
        applyModel.value = model;
        final cautiously = model.expect?.cautiously ?? '';
        if (cautiously.contains(productDetailSchemeUrl)) {
          final dict = GetQueryParametersAll.getQueryParametersAll(cautiously);
          final productID = dict['nodded']?.first ?? '';
          await getProductDetaiPageInfo(productID);
          print('dict--------$dict');
        }
      }
      ToastManager.hideLoading();
    } catch (e) {
      ToastManager.hideLoading();
    }
  }

  /// 产品详情页面
  getProductDetaiPageInfo(String productID) async {
    try {
      ToastManager.showLoading();
      final http = ShineHttpRequest();
      final dict = {'nodded': productID};
      final response = await http.post('/wzcnrht/before', formData: dict);
      final model = BaseModel.fromJson(response.data);
      if (model.beautiful == '0' || model.beautiful == '00') {
        detailModel.value = model;
        final sitting = model.expect?.allow?.sitting ?? '';
        if (sitting.isNotEmpty) {
          pushToPage(sitting, productID);
        } else {
          ToastManager.showToast('我我我我哦我我我我我我----h5');
        }
      }
      ToastManager.hideLoading();
    } catch (e) {
      ToastManager.hideLoading();
    }
  }

  /// 判断是否设置了umid 如果是that
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
          if (type == '1') {
            Get.toNamed(
              ShineAppRouter.tinList,
              arguments: {'productID': productID},
            );
          } else {
            Get.toNamed(
              ShineAppRouter.authList,
              arguments: {'productID': productID},
            );
          }
        } else {}
      }
      ToastManager.hideLoading();
    } catch (e) {
      ToastManager.hideLoading();
    }
  }

  /// pushtopage
  pushToPage(String authStr, String productID) {
    switch (authStr) {
      case 'that':
        judgeMentThat(productID: productID, type: '0');
        break;
      case 'now':
        break;
      case 'them':
        break;
      case 'Cleopatra':
        break;
      case 'desertion':
        break;
      default:
    }
  }
}
