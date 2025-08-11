import 'package:flutter_easyloading/flutter_easyloading.dart';

class ToastManager {
  static showToast(String msg) {
    EasyLoading.showToast(
      msg,
      duration: Duration(seconds: 2),
      toastPosition: EasyLoadingToastPosition.center,
      dismissOnTap: false,
    );
  }

  static showLoading() {
    EasyLoading.show(status: 'loading...');
  }

  static hideLoading() {
    EasyLoading.dismiss();
  }
}
