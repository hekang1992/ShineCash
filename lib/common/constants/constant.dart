import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:shinecash/common/utils/save_idfv_info.dart';
import 'package:shinecash/common/utils/save_login_info.dart';

class AppColor {
  static const Color bgColor = Color(0XFF7262EC);
  static const Color textColor = Color(0XFF888888);
  static const Color blackColor = Color(0XFF222222);
  static const Color btnBgColor = Color(0XFF91FA95);
  static const Color orderTypeColor = Color(0XFF7893F5);
  static const Color whiteColor = Color(0XFFFFFFFF);
}

class AppFont {
  static const String textFont = '';
}

class AppCommonPera {
  static Future<Map<String, String>> getCommonPera() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    final String features = '1.0.0';
    final String descended = iosInfo.modelName;
    final String unconfined = await SaveIdfvInfo.getOrCreateIDFV() ?? '';
    final String hair = iosInfo.systemVersion;
    final String emerging = SaveLoginInfo.getToken() ?? '';
    final String act = await AppTrackingTransparency.getAdvertisingIdentifier();
    return {
      'features': features,
      'descended': descended,
      'unconfined': unconfined,
      'hair': hair,
      'emerging': emerging,
      'act': act,
    };
  }
}
