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
      throw Exception('定位服务未开启');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        final alertShow = SaveLoginInfo.getAlert();
        if (alertShow == '1') {
          LocationAlert.alertShow();
        }
        throw Exception('location error');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      final alertShow = SaveLoginInfo.getAlert();
      if (alertShow == '1') {
        LocationAlert.alertShow();
      }
      throw Exception('location erroe');
    }

    final position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );

    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isEmpty) {
      final alertShow = SaveLoginInfo.getAlert();
      if (alertShow == '1') {
        LocationAlert.alertShow();
      }
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

    return locationdict;
  }
}

class LocationAlert {
  static alertShow() {
    Get.dialog(
      AlertDialog(
        title: Row(
          children: [
            Icon(Icons.location_off, color: Colors.orange),
            SizedBox(width: 10),
            Text('location_error'.tr),
          ],
        ),
        content: Text('location_permission_denied_message'.tr),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Cancel'.tr),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              openAppSettings();
            },
            child: Text('Settings'.tr),
          ),
        ],
      ),
    );
  }
}
