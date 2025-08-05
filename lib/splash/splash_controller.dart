import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/routers/shinerouter.dart';
import 'package:shinecash/common/utils/network_monitoring.dart';
import 'package:shinecash/common/utils/save_idfv_info.dart';
import 'package:shinecash/common/utils/save_login_info.dart';

class SplashController extends GetxController {
  final connectivity = Connectivity();

  @override
  void onInit() async {
    super.onInit();

    await Future.delayed(Duration(milliseconds: 200));

    // 检查网络
    NetworkMonitoring.isConnected().then((connected) {
      if (kDebugMode) {
        print(connected ? '有网络' : '无网络');
      }
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
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    Get.offAllNamed(ShineAppRouter.login);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
