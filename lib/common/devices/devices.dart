import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/services.dart';
import 'package:shinecash/common/http/http_request.dart';
import 'package:shinecash/common/utils/app_location.dart';
import 'package:shinecash/common/utils/save_idfv_info.dart';
import 'package:shinecash/common/utils/save_login_info.dart';

class GetLanguageInfo {
  static final MethodChannel _channel = MethodChannel('shineapp_info');

  static Future<String> getLanguageMessage() async {
    try {
      final String version = await _channel.invokeMethod('getPlatformLanguage');
      return version;
    } on PlatformException catch (e) {
      return "Failed to get version: '${e.message}'.";
    }
  }
}

class ProxyEnabled {
  static String isProxyEnabled() {
    final env = Platform.environment;
    final useProxy =
        env.containsKey('http_proxy') || env.containsKey('HTTP_PROXY');
    return useProxy ? '1' : '0';
  }
}

class VpnEnabled {
  static final MethodChannel _channel = MethodChannel('shineapp_info');
  static Future<String> isVpnActive() async {
    try {
      final result = await _channel.invokeMethod('isVpnActive');
      return result ? '1' : '0';
    } catch (e) {
      return '0';
    }
  }
}

// class PointTouchChannel {
//   static upLoadPoint({
//     required String step,
//     required String startTime,
//     required String endTime,
//     required String orderID,
//   }) async {
//     final idfv = await SaveIdfvInfo.getOrCreateIDFV();
//     final idfa = await AppTrackingTransparency.getAdvertisingIdentifier();
//     final position = await AppLocation.getDetailedLocation();
//     final pays = position['pays'] ?? '';
//     final usual = position['usual'] ?? '';
//     final dict = {
//       'excited': step,
//       'shows': '2',
//       'excitement': idfv,
//       'present': idfa,
//       'tone': startTime,
//       'unhappily': endTime,
//       'disordered': orderID,
//       'pays': pays,
//       'usual': usual,
//     };
//     try {
//       final http = ShineHttpRequest();
//       final _ = await http.post('wzcnrht/supper', formData: dict);
//     } catch (e) {}
//   }
// }

class PointTouchChannel {
  static Future<void> upLoadPoint({
    required String step,
    required String startTime,
    required String endTime,
    required String orderID,
  }) async {
    try {
      final results = await Future.wait([
        SaveIdfvInfo.getOrCreateIDFV(),
        AppTrackingTransparency.getAdvertisingIdentifier(),
      ]);

      final String idfv = results[0] as String;
      final String idfa = results[1] as String;
      // final Map? position = results[2] as Map?;

      final String pays = SaveLoginInfo.getLon() ?? '';
      final String usual = SaveLoginInfo.getLat() ?? '';

      final Map<String, dynamic> dict = {
        'excited': step,
        'shows': '2',
        'excitement': idfv,
        'present': idfa,
        'tone': startTime,
        'unhappily': endTime,
        'disordered': orderID,
        'pays': pays,
        'usual': usual,
      };

      final http = ShineHttpRequest();
      await http.post('wzcnrht/supper', formData: dict);
    } catch (e) {}
  }
}
