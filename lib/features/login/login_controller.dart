import 'dart:async';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/utils/save_idfv_info.dart';

class LoginController extends GetxController {
  Timer? _timer;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();

    /// 开启轮询
    startPolling();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}

extension LoginVc on LoginController {
  void startPolling() {
    // 立即执行一次
    fetchData();

    // 然后每1秒执行一次
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      fetchData();
    });
  }

  void fetchData() async {
    // 这里写你的轮询逻辑
    String? idfa = await AppTrackingTransparency.getAdvertisingIdentifier();
    print('idfa---login------$idfa');
    if (idfa.isEmpty || idfa == '00000000-0000-0000-0000-000000000000') {
      await GetIDFVInfo.requestIDFA();
    } else {
      dispose();
    }
  }

  // 记得在不再需要时取消定时器（如在dispose中）
  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
