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

  final citylistModel = BaseModel().obs;

  @override
  void onInit() {
    super.onInit();
    initHomeInfo();
    initCityInfo();
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

  initCityInfo() async {
    try {
      ToastManager.showLoading();
      final http = ShineHttpRequest();
      final response = await http.get('/wzcnrht/finished');
      final model = BaseModel.fromJson(response.data);
      if (model.beautiful == '0' || model.beautiful == '00') {
        citylistModel.value = model;
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
          await getProductDetaiPageInfo(productID: productID, type: '0');
          print('dict--------$dict');
        }
      }
      ToastManager.hideLoading();
    } catch (e) {
      ToastManager.hideLoading();
    }
  }

  /// 产品详情页面
  getProductDetaiPageInfo({
    required String productID,
    required String type,
  }) async {
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
          pushToPage(authStr: sitting, productID: productID, type: type);
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
          Get.toNamed(
            ShineAppRouter.imagePhoto,
            arguments: {'productID': productID},
          );
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
  pushToPage({
    required String authStr,
    required String productID,
    required String type,
  }) {
    if (type == '0') {
      Get.toNamed(ShineAppRouter.authList, arguments: {'productID': productID});
    } else {
      switch (authStr) {
        case 'that':
          judgeMentThat(productID: productID, type: type);
          break;
        case 'now':
          Get.toNamed(
            ShineAppRouter.personal,
            arguments: {'productID': productID},
          );
          break;
        case 'them':
          Get.toNamed(ShineAppRouter.work, arguments: {'productID': productID});
          break;
        case 'Cleopatra':
          ToastManager.showToast('Cleopatra');
          break;
        case 'desertion':
          ToastManager.showToast('desertion');
          break;
        default:
      }
    }
  }
}
