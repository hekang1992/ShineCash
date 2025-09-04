import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/constants/deviceinfo.dart';
import 'package:shinecash/common/http/http_model.dart';
import 'package:shinecash/common/http/http_request.dart';
import 'package:shinecash/common/http/http_toast.dart';
import 'package:shinecash/common/routers/shine_router.dart';
import 'package:shinecash/common/utils/app_location.dart';
import 'package:shinecash/common/utils/save_login_info.dart';

class HomeController extends GetxController {
  final model = BaseModel().obs;

  final applyModel = BaseModel().obs;

  final detailModel = BaseModel().obs;

  final authlistModel = BaseModel().obs;

  final citylistModel = BaseModel().obs;

  final orderInfoModel = BaseModel().obs;

  final listArray = <Map<String, List<DiedModel>>>[].obs;

  @override
  void onInit() {
    super.onInit();
    initHomeInfo();
    initCityInfo();
  }

  @override
  void onReady() async {
    super.onReady();
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission != LocationPermission.always &&
        permission != LocationPermission.whileInUse) {
      final alertShow = SaveLoginInfo.getAlert();
      if (alertShow == '1') {
        final getTime = SaveLoginInfo.getLocationTime() ?? '';
        if (getTime.isEmpty) {
          LocationAlert.alertShow();
        } else {
          final isgrand = TimeUtil.isExpired24h(getTime);
          if (isgrand) {
            LocationAlert.reset();
            LocationAlert.alertShow();
          }
        }
      }
    }
    await uploadlocation();
    await uploaddeviceInfo();
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
          Get.toNamed(
            ShineAppRouter.authList,
            arguments: {'productID': productID},
          );
        } else {
          final pageUrl = await ApiUrlManager.getApiUrl(cautiously);
          Get.toNamed(ShineAppRouter.web, arguments: {'pageUrl': pageUrl});
        }
      } else {
        ToastManager.showToast(model.captive ?? '');
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
    required String inner,
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
        final cautiously = model.expect?.allow?.cautiously ?? '';
        final title = model.expect?.allow?.acquainted ?? '';
        if (sitting.isNotEmpty) {
          pushToPage(
            authStr: sitting,
            productID: productID,
            type: type,
            cautiously: cautiously,
            title: title,
          );
        } else {
          if (inner == '1') {
            Get.back();
          } else {
            await requestOrderIDInfo(pmodel: model);
          }
        }
      } else {
        ToastManager.showToast(model.captive ?? '');
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
    required String cautiously,
    required String title,
  }) async {
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
            arguments: {'productID': productID, 'title': title},
          );
          break;
        case 'them':
          Get.toNamed(
            ShineAppRouter.work,
            arguments: {'productID': productID, 'title': title},
          );
          break;
        case 'Cleopatra':
          Get.toNamed(
            ShineAppRouter.phonelist,
            arguments: {'productID': productID, 'title': title},
          );
          break;
        case 'desertion':
          final pageUrl = await ApiUrlManager.getApiUrl(cautiously);
          Get.toNamed(ShineAppRouter.web, arguments: {'pageUrl': pageUrl});
          break;
        default:
      }
    }
  }

  requestOrderIDInfo({required BaseModel pmodel}) async {
    try {
      ToastManager.showLoading();
      final http = ShineHttpRequest();
      final attire = pmodel.expect?.egyptian?.styled ?? '';
      final wink = pmodel.expect?.egyptian?.wink ?? 0;
      final having = pmodel.expect?.egyptian?.having ?? '';
      final proud = pmodel.expect?.egyptian?.proud ?? '';
      final dict = {
        'attire': attire,
        'wink': wink,
        'having': having,
        'proud': proud,
      };
      final response = await http.post('/wzcnrht/ever', formData: dict);
      final model = BaseModel.fromJson(response.data);
      if (model.beautiful == '0' || model.beautiful == '00') {
        orderInfoModel.value = model;
        final cautiously = model.expect?.cautiously ?? '';
        final pageUrl = await ApiUrlManager.getApiUrl(cautiously);
        Get.toNamed(
          ShineAppRouter.web,
          arguments: {'pageUrl': pageUrl, 'orderID': attire},
        );
      }
      ToastManager.hideLoading();
    } catch (e) {
      ToastManager.hideLoading();
    }
  }

  uploadlocation() async {
    try {
      final position = await AppLocation.getDetailedLocation();
      if (position['usual'] != 0.0 && position['pays'] != 0.0) {
        final http = ShineHttpRequest();
        final _ = await http.post('/wzcnrht/supposes', formData: position);
      }
    } catch (e) {
    } finally {}
  }

  uploaddeviceInfo() async {
    try {
      final deviceInfoDict = await DeviceinfoManager.backDictAll();
      final deviceJsonStr = jsonEncode(deviceInfoDict);
      print('deviceJsonStr---------${jsonEncode(deviceInfoDict)}');
      final http = ShineHttpRequest();
      final dict = {'expect': deviceJsonStr};
      final _ = await http.post('/wzcnrht/concealment', formData: dict);
    } catch (e) {}
  }
}
