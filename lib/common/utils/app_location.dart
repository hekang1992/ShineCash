import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shinecash/common/utils/save_login_info.dart';

class AppLocation {
  static Future<Map<String, dynamic>> getDetailedLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('location error');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('location error');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      final locationdict = {
        'cure': '',
        'agreed': '',
        'best': '',
        'terms': '',
        'usual': 0.0,
        'pays': 0.0,
        'conspiracy': '',
        'share': '',
      };
      return locationdict;
    }

    final position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );

    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isEmpty) {
      throw Exception('locaton error');
    }

    final Placemark place = placemarks.first;

    final locationdict = {
      'cure': place.administrativeArea,
      'agreed': place.country,
      'best': place.isoCountryCode,
      'terms': '${place.subLocality ?? ''} ${place.street ?? ''}',
      'usual': position.latitude.toStringAsFixed(6),
      'pays': position.longitude.toStringAsFixed(6),
      'conspiracy': place.locality,
      'share': place.subLocality,
    };

    SaveLoginInfo.saveLat(position.latitude.toStringAsFixed(6));
    SaveLoginInfo.saveLon(position.longitude.toStringAsFixed(6));

    return locationdict;
  }
}

class LocationAlert {
  static bool _isAlertShown = false;
  static alertShow() {
    if (_isAlertShown) return;
    _isAlertShown = true;
    Get.dialog(
      AlertDialog(
        title: Row(
          children: [
            Icon(Icons.location_off, color: Colors.orange),
            SizedBox(width: 10),
            Text('Permission denied'.tr),
          ],
        ),
        content: Text('Please go to settings to enable the permission.'.tr),
        actions: [
          TextButton(
            onPressed: () {
              final time = (DateTime.now().millisecondsSinceEpoch ~/ 1000)
                  .toString();
              SaveLoginInfo.saveLocationTime(time);
              Get.back();
            },
            child: Text('Cancel'.tr),
          ),
          ElevatedButton(
            onPressed: () {
              final time = (DateTime.now().millisecondsSinceEpoch ~/ 1000)
                  .toString();
              SaveLoginInfo.saveLocationTime(time);
              Get.back();
              openAppSettings();
            },
            child: Text('Settings'.tr),
          ),
        ],
      ),
    );
  }

  static void reset() {
    _isAlertShown = false;
  }
}

class TimeUtil {
  static bool isExpired24h(String? savedTimestamp) {
    if (savedTimestamp == null || savedTimestamp.isEmpty) {
      return true;
    }

    final savedTime = int.tryParse(savedTimestamp) ?? 0;
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    final diff = now - savedTime;
    return diff >= 24 * 60 * 60;
  }

  static String saveNowTime() {
    final time = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    SaveLoginInfo.saveLocationTime(time);
    return time;
  }
}
