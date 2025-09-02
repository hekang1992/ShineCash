import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:shinecash/common/constants/deviceinfo.dart';
import 'package:shinecash/common/devices/devices.dart';
import 'package:shinecash/common/http/http_model.dart';
import 'package:shinecash/common/http/http_request.dart';
import 'package:shinecash/common/routers/shine_router.dart';
import 'package:shinecash/common/utils/app_location.dart';
import 'package:shinecash/common/utils/google_market.dart';
import 'package:shinecash/common/utils/network_monitoring.dart';
import 'package:shinecash/common/utils/save_login_info.dart';

class SplashController extends GetxController {
  final connectivity = Connectivity();
  final RxString netStatus = ''.obs;
  @override
  void onInit() async {
    super.onInit();

    await Future.delayed(Duration(milliseconds: 500));

    // 监听网络变化
    NetworkMonitoring.onNetworkChanged.listen((results) {
      final result = results.isNotEmpty
          ? results.first
          : ConnectivityResult.none;
      if (result == ConnectivityResult.none) {
        SaveLoginInfo.saveNetwork('None');
        netStatus.value = 'None';
      } else if (result == ConnectivityResult.mobile) {
        SaveLoginInfo.saveNetwork('4G/5G');
        netStatus.value = '4G/5G';
      } else if (result == ConnectivityResult.wifi) {
        SaveLoginInfo.saveNetwork('WIFI');
        netStatus.value = 'WIFI';
      } else {
        SaveLoginInfo.saveNetwork('Other');
        netStatus.value = 'Other';
      }
    });
    ever(netStatus, (value) async {
      await initThreeInfo();
    });
  }
}

extension SplashVc on SplashController {
  initThreeInfo() async {
    await uploadlocation();
    await uploaddeviceInfo();
    await initLoginInfo();
  }

  Future<void> uploadlocation() async {
    try {
      final position = await AppLocation.getDetailedLocation();
      if (position['usual'] != 0.0 && position['pays'] != 0.0) {
        final http = ShineHttpRequest();
        final _ = await http.post('/wzcnrht/supposes', formData: position);
        print('position================position');
      }
    } catch (e) {
    } finally {}
  }

  Future<void> uploaddeviceInfo() async {
    try {
      final deviceInfoDict = await DeviceinfoManager.backDictAll();
      final deviceJsonStr = jsonEncode(deviceInfoDict);
      final http = ShineHttpRequest();
      final dict = {'expect': deviceJsonStr};
      final _ = await http.post('/wzcnrht/concealment', formData: dict);
      print('deviceJsonStr================deviceJsonStr');
    } catch (e) {}
  }

  Future<void> initLoginInfo() async {
    try {
      final http = ShineHttpRequest();
      final delusion = await GetLanguageInfo.getLanguageMessage();
      final proudly = await VpnEnabled.isVpnActive();
      final feeling = ProxyEnabled.isProxyEnabled();
      final dict = {
        'delusion': delusion,
        'feeling': feeling,
        'proudly': proudly,
      };
      final response = await http.post('/wzcnrht/delusion', formData: dict);
      final model = BaseModel.fromJson(response.data);
      if (model.beautiful == '0' || model.beautiful == '00') {
        final alert = (model.expect?.driving ?? 0).toString();
        final kiss = model.expect?.kiss ?? '';
        SaveLoginInfo.saveAlert(alert);
        SaveLoginInfo.saveKiss(kiss);
        final fairModel = model.expect?.fair;
        final Map<String, String> fromJson = {
          'answers': fairModel?.answers ?? '',
          'crumpled': fairModel?.crumpled ?? '',
          'dirty': fairModel?.dirty ?? '',
          'taking': fairModel?.taking ?? '',
        };
        GoogleMarket.isVpnActive(fromJson);

        if (SaveLoginInfo.isLogin()) {
          Get.offAllNamed(ShineAppRouter.tab);
        } else {
          Get.offAllNamed(ShineAppRouter.login);
        }
        print('initLoginInfo================initLoginInfo');
      }
    } catch (e) {}
  }
}
