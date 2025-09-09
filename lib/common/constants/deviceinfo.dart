import 'dart:io';
import 'dart:ui';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:disk_space/disk_space.dart';
import 'package:flutter/services.dart';
import 'package:shinecash/common/utils/save_idfv_info.dart';
import 'package:shinecash/common/utils/save_login_info.dart';
import 'package:network_info_plus/network_info_plus.dart';

// final cdisk = 6.5 * 1024;

class AssuranceModel {
  static final MethodChannel _channel = MethodChannel('shineapp_info');
  static Future<Map<String, Object?>> backDict() async {
    try {
      final Map<Object?, Object?> result = await _channel.invokeMethod(
        'getSystemInfo',
      );
      final base = result['base'];
      final spirit = result['spirit'];
      double? freeDiskSpace = await DiskSpace.getFreeDiskSpace ?? 0.0;
      double? totalDiskSpace = await DiskSpace.getTotalDiskSpace ?? 0.0;
      final diskinfo = {
        'spirit': spirit,
        'base': base,
        'plot': (((totalDiskSpace) * 1024 * 1024).toInt()).toString(),
        'scornfully': (((freeDiskSpace) * 1024 * 1024).toInt()).toString(),
      };
      return diskinfo;
    } on PlatformException catch (e) {
      print("Failed to get system info: '${e.message}'.");
      return {};
    }
  }
}

class ResentmentModel {
  static Future<Map<String, dynamic>> backDict() async {
    final battery = Battery();
    final batteryLevel = await battery.batteryLevel;
    final batteryState = await battery.batteryState;
    final isCharging = batteryState == BatteryState.charging ? 1 : 0;
    return {
      'resentment': {'anger': batteryLevel, 'stirred': isCharging},
    };
  }
}

class CalmlyModel {
  static Future<Map<String, dynamic>> backDict() async {
    final deviceInfo = DeviceInfoPlugin();
    final iosInfo = await deviceInfo.iosInfo;

    final announcement = iosInfo.systemVersion;
    final shock = iosInfo.model;
    final expected = iosInfo.utsname.machine;
    return {
      'calmly': {
        'announcement': announcement,
        'shock': shock,
        'expected': expected,
      },
    };
  }
}

class GoneModel {
  static Future<Map<String, dynamic>> backDict() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String isSimulator = '0';
    String isJailbroken = '0';

    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      String machine = iosInfo.utsname.machine;

      if (machine.contains('x86_64') || machine.contains('i386')) {
        isSimulator = '1';
      }

      if (await GoneModel.isJailbroken()) {
        isJailbroken = '1';
      }
    }
    return {
      'gone': {'impossible': isSimulator, 'shrugged': isJailbroken},
    };
  }

  static Future<bool> isJailbroken() async {
    List<String> jailbreakPaths = [
      '/Applications/Cydia.app',
      '/bin/bash',
      '/usr/sbin/sshd',
      '/etc/apt',
    ];

    for (var path in jailbreakPaths) {
      if (await File(path).exists()) {
        return true;
      }
    }
    try {
      var result = await Process.run('ls', ['/bin/bash']);
      if (result.exitCode == 0) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }
}

class ImperativelyModel {
  static Future<Map<String, dynamic>> backDict() async {
    final awaited =
        '${DateTime.now().timeZoneName}${DateTime.now().timeZoneOffset.isNegative ? "-" : "+"}${DateTime.now().timeZoneOffset.inHours.abs()}';
    final pay = await SaveIdfvInfo.getOrCreateIDFV();
    final delusion =
        '${PlatformDispatcher.instance.locales.first.languageCode}_${PlatformDispatcher.instance.locales.first.countryCode}';
    final terrible = SaveLoginInfo.getNetwork();
    final motives = await AppTrackingTransparency.getAdvertisingIdentifier();
    return {
      'imperatively': {
        'awaited': awaited,
        'pay': pay,
        'delusion': delusion,
        'terrible': terrible,
        'motives': motives,
      },
    };
  }
}

class DesertionModel {
  static Future<Map<String, dynamic>> backDict() async {
    return {
      'desertion': {'back': await BackModel.backDict()},
    };
  }
}

class BackModel {
  static Future<Map<String, dynamic>> backDict() async {
    final info = NetworkInfo();
    final madam = await info.getWifiBSSID() ?? '';
    final pens = await info.getWifiName() ?? '';
    return {'madam': madam, 'pens': pens};
  }
}

class DeviceinfoManager {
  static Future<Map<String, dynamic>> backDictAll() async {
    final onepera = await AssuranceModel.backDict();
    final twopera = await ResentmentModel.backDict();
    final threepera = await CalmlyModel.backDict();
    final fourpera = await GoneModel.backDict();
    final fivepera = await ImperativelyModel.backDict();
    final sixpera = await DesertionModel.backDict();
    final mergedDict = <String, dynamic>{};
    mergedDict
      ..addAll({'assurance': onepera})
      ..addAll(twopera)
      ..addAll(threepera)
      ..addAll(fourpera)
      ..addAll(fivepera)
      ..addAll(sixpera);
    return mergedDict;
  }
}
