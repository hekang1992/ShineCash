import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/http/http_request.dart';
import 'package:shinecash/common/routers/shine_router.dart';
import 'package:shinecash/common/utils/app_location.dart';
import 'package:shinecash/common/utils/network_monitoring.dart';
import 'package:shinecash/common/utils/save_idfv_info.dart';
import 'package:shinecash/common/utils/save_login_info.dart';

class SplashController extends GetxController {
  final connectivity = Connectivity();

  @override
  void onInit() async {
    super.onInit();

    await Future.delayed(Duration(milliseconds: 500));
    // 检查网络
    NetworkMonitoring.isConnected().then((connected) {
      print(connected ? '有网络' : '无网络');
    });
    // 监听网络变化
    NetworkMonitoring.onNetworkChanged.listen((results) {
      final result = results.isNotEmpty
          ? results.first
          : ConnectivityResult.none;
      if (result == ConnectivityResult.none) {
        SaveLoginInfo.saveNetwork('None');
      } else if (result == ConnectivityResult.mobile) {
        SaveLoginInfo.saveNetwork('5G');
      } else if (result == ConnectivityResult.wifi) {
        SaveLoginInfo.saveNetwork('WIFI');
      } else {
        SaveLoginInfo.saveNetwork('Other');
      }
    });

    final idfv = await SaveIdfvInfo.getOrCreateIDFV();
    print('idfv---------$idfv');
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    // initLoginInfo().then((model) {});
    if (SaveLoginInfo.isLogin()) {
      Get.offAllNamed(ShineAppRouter.tab);
    } else {
      Get.offAllNamed(ShineAppRouter.login);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}

extension SplashVc on SplashController {}
