import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/utils/network_monitoring.dart';

class SplashController extends GetxController {
  final connectivity = Connectivity();

  @override
  void onInit() async {
    super.onInit();

    await Future.delayed(Duration(milliseconds: 1000));

    // 检查网络
    NetworkMonitoring.isConnected().then((connected) {
      print(connected ? '有网络' : '无网络');
    });
    // 监听网络变化
    NetworkMonitoring.onNetworkChanged.listen((result) {
      print('网络变为: $result');
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
