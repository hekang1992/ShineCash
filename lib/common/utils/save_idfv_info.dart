import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/utils/upidfa_controller.dart';

class SaveIdfvInfo {
  static const _storageKey = 'idfv_storage_key';
  static final _storage = FlutterSecureStorage();

  /// 获取设备IDFV（优先从钥匙串读取，如果没有则获取并存储）
  static Future<String?> getOrCreateIDFV() async {
    try {
      // 1. 首先尝试从钥匙串读取
      final storedIdfv = await _storage.read(key: _storageKey);
      if (storedIdfv != null) {
        return storedIdfv;
      }

      // 2. 钥匙串中没有，则获取新的IDFV
      final newIdfv = await _getDeviceIDFV();
      if (newIdfv != null) {
        // 3. 将新IDFV存入钥匙串
        await _saveIDFVToKeychain(newIdfv);
        return newIdfv;
      }

      return null;
    } catch (e) {
      print('Error in getOrCreateIDFV: $e');
      return null;
    }
  }

  /// 获取设备IDFV（不从钥匙串读取，直接获取设备信息）
  static Future<String?> _getDeviceIDFV() async {
    try {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isIOS) {
        final IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
        return iosDeviceInfo.identifierForVendor;
      }
      return null;
    } catch (e) {
      print('Error getting device IDFV: $e');
      return null;
    }
  }

  /// 将IDFV存入钥匙串
  static Future<void> _saveIDFVToKeychain(String idfv) async {
    try {
      await _storage.write(key: _storageKey, value: idfv);
      print('IDFV saved to keychain successfully');
    } catch (e) {
      print('Error saving IDFV to keychain: $e');
    }
  }
}

class GetIDFVInfo {
  static Future<void> requestIDFA() async {
    // 检查追踪权限状态
    TrackingStatus status =
        await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      // 请求权限
      status = await AppTrackingTransparency.requestTrackingAuthorization();
    }

    if (status == TrackingStatus.authorized) {
      String? idfa = await AppTrackingTransparency.getAdvertisingIdentifier();
      print('idfa-----------$idfa');

      final controller = Get.put(UpidfaController());

      final pay = await SaveIdfvInfo.getOrCreateIDFV() ?? '';
      final dict = {'pay': pay, 'motives': idfa};
      controller.setIDFAParams(dict);
    }
  }
}
