import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/utils/upidfa_controller.dart';
import 'package:shinecash/features/login/login_controller.dart';

class SaveIdfvInfo {
  static const _storageKey = 'idfv_storage_key';
  static final _storage = FlutterSecureStorage();
  static Future<String?> getOrCreateIDFV() async {
    try {
      final storedIdfv = await _storage.read(key: _storageKey);
      if (storedIdfv != null) {
        return storedIdfv;
      }
      final newIdfv = await _getDeviceIDFV();
      if (newIdfv != null) {
        await _saveIDFVToKeychain(newIdfv);
        return newIdfv;
      }

      return null;
    } catch (e) {
      print('Error in getOrCreateIDFV: $e');
      return null;
    }
  }

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
  static Future<void> requestIDFA(LoginController loginVc) async {
    TrackingStatus status =
        await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      status = await AppTrackingTransparency.requestTrackingAuthorization();
    }

    if (status == TrackingStatus.restricted) {
      print('status==============$status');
    }

    if (status == TrackingStatus.denied) {
      print('status==============$status');
      String? idfa = await AppTrackingTransparency.getAdvertisingIdentifier();
      final controller = Get.put(UpidfaController());
      final pay = await SaveIdfvInfo.getOrCreateIDFV() ?? '';
      final dict = {'pay': pay, 'motives': idfa};
      controller.setIDFAParams(dict);
      loginVc.dispose1();
    }

    if (status == TrackingStatus.authorized) {
      String? idfa = await AppTrackingTransparency.getAdvertisingIdentifier();
      final controller = Get.put(UpidfaController());
      final pay = await SaveIdfvInfo.getOrCreateIDFV() ?? '';
      final dict = {'pay': pay, 'motives': idfa};
      controller.setIDFAParams(dict);
      loginVc.dispose1();
    }
  }
}
