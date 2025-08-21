import 'dart:async';
import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/http/http_model.dart';
import 'package:shinecash/common/http/http_request.dart';
import 'package:shinecash/common/http/http_toast.dart';
import 'package:shinecash/common/routers/shine_router.dart';
import 'package:shinecash/common/utils/save_idfv_info.dart';
import 'package:shinecash/common/utils/save_login_info.dart';

class LoginController extends GetxController {
  /// idfa轮询
  Timer? _timer;

  /// 获取验证码
  Timer? _codetimer;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  final RxBool isclickAgreement = false.obs;

  final RxInt seconds = 0.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    startPolling();
  }

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel();
    _timer = null;
    _codetimer?.cancel();
    _codetimer = null;
  }
}

extension LoginVc on LoginController {
  /// 改边状态
  void changeType(bool grand) {
    isclickAgreement.value = grand;
  }

  /// 点击获取验证码
  void getCode(String phone, {String? type}) async {
    if (phone.isEmpty) {
      ToastManager.showToast('Please enter your mobile number.');
      return;
    }
    ToastManager.showLoading();
    try {
      final http = ShineHttpRequest();
      final dict = {'ever': phone, 'feeling': '1'};
      final respose = await http.post('/wzcnrht/feeling', formData: dict);
      print('respose---------${respose.data}');
      final model = BaseModel.fromJson(respose.data);
      final String beautiful = model.beautiful ?? '';
      final String captive = model.captive ?? '';
      final List<String> successList = ['0', '00'];
      if (successList.contains(beautiful)) {
        if (type == 'code') {
          startCodeReduce();
        }
      }
      ToastManager.showToast(captive);
      ToastManager.hideLoading();
    } catch (e) {
      print('response-failure: $e');
      ToastManager.hideLoading();
    }
  }

  void startCodeReduce() {
    if (_codetimer != null && _codetimer!.isActive) return;
    seconds.value = 60;
    _codetimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds.value == 0) {
        timer.cancel();
      } else {
        seconds.value--;
      }
    });
  }

  /// idfa轮询
  void startPolling() {
    fetchData();

    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      fetchData();
    });
  }

  void fetchData() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      final isPhysicalDevice = iosInfo.isPhysicalDevice != true;
      if (!isPhysicalDevice) {
        String? idfa = await AppTrackingTransparency.getAdvertisingIdentifier();
        await GetIDFVInfo.requestIDFA();
        if (idfa != '00000000-0000-0000-0000-000000000000') {
          dispose();
        }
      }
    } else {
      dispose();
    }
  }

  /// 记得在不再需要时取消定时器（如在dispose中）
  void dispose() {
    _timer?.cancel();
    _timer = null;
  }

  /// 登录
  void toLogin({required String phone, required String code}) async {
    if (phone.isEmpty) {
      ToastManager.showToast('Please enter your phone number.');
      return;
    }
    if (code.isEmpty) {
      ToastManager.showToast('Please enter your verification code.');
      return;
    }
    if (isclickAgreement.value == false) {
      ToastManager.showToast('Please review and accept the privacy policy.');
      return;
    }

    try {
      ToastManager.showLoading();
      final http = ShineHttpRequest();
      final respose = await http.post(
        '/wzcnrht/beautiful',
        formData: {'satisfactory': phone, 'doesn': code},
      );
      final model = BaseModel.fromJson(respose.data);

      final String beautiful = model.beautiful ?? '';
      final String captive = model.captive ?? '';
      ToastManager.showToast(captive);
      final List<String> successList = ['0', '00'];
      if (successList.contains(beautiful)) {
        final phone = model.expect?.satisfactory ?? '';
        final token = model.expect?.emerging ?? '';
        SaveLoginInfo.savePhone(phone);
        SaveLoginInfo.saveToken(token);
        Future.delayed(Duration(microseconds: 500));
        Get.offAllNamed(ShineAppRouter.tab);
      }
      ToastManager.hideLoading();
    } catch (e) {
      print('response-failure: $e');
      ToastManager.hideLoading();
    }
  }
}
