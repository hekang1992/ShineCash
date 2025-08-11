import 'package:flutter_easyloading/flutter_easyloading.dart';

class ToastManager {
  static showToast(String msg) {
    EasyLoading.showToast(
      msg,
      duration: Duration(seconds: 3),
      toastPosition: EasyLoadingToastPosition.center,
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: false,
    );
  }

  static showLoading() {
    EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: false,
    );
  }

  static hideLoading() {
    EasyLoading.dismiss();
  }
}
