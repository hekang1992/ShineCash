import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:shinecash/common/constants/deviceinfo.dart';
import 'package:shinecash/common/devices/devices.dart';
import 'package:shinecash/common/http/http_model.dart';
import 'package:shinecash/common/http/http_request.dart';
import 'package:shinecash/common/routers/shine_router.dart';
import 'package:shinecash/common/utils/app_location.dart';
import 'package:shinecash/common/utils/google_market.dart';
import 'package:shinecash/common/utils/save_login_info.dart';

class SplashController extends GetxController {
  final connectivity = Connectivity();
  final RxString netStatus = ''.obs;

  StreamSubscription? _networkSubscription;

  @override
  void onInit() {
    super.onInit();

    print('SplashController 初始化');

    _initNetworkMonitoring();

    ever(netStatus, (value) async {
      print('网络状态变化: $value');
      await initThreeInfo();
    });
  }

  @override
  void onClose() {
    _networkSubscription?.cancel();
    super.onClose();
  }
}

extension SplashVc on SplashController {
  void _initNetworkMonitoring() async {
    await _checkCurrentNetworkStatus();

    _networkSubscription = connectivity.onConnectivityChanged.listen((results) {
      _updateNetStatus(results);
    });
  }

  Future<void> _checkCurrentNetworkStatus() async {
    try {
      var results = await connectivity.checkConnectivity();
      _updateNetStatus(results);
    } catch (e) {
      netStatus.value = 'Error';
    }
  }

  void _updateNetStatus(List<ConnectivityResult> results) {
    final result = results.isNotEmpty ? results.first : ConnectivityResult.none;
    if (result == ConnectivityResult.none) {
      SaveLoginInfo.saveNetwork('None');
      netStatus.value = 'None';
    } else if (result == ConnectivityResult.mobile) {
      SaveLoginInfo.saveNetwork('5G');
      netStatus.value = '5G';
    } else if (result == ConnectivityResult.wifi) {
      SaveLoginInfo.saveNetwork('WIFI');
      netStatus.value = 'WIFI';
    } else {
      SaveLoginInfo.saveNetwork('Other');
      netStatus.value = 'Other';
    }
  }

  initThreeInfo() async {
    await initLoginInfo();
    await uploadlocation();
    await uploaddeviceInfo();
  }

  Future<void> uploadlocation() async {
    try {
      final position = await AppLocation.getDetailedLocation();
      if (position['usual'] != 0.0 && position['pays'] != 0.0) {
        final http = ShineHttpRequest();
        final _ = await http.post('wzcnrht/supposes', formData: position);
        print('position================position');
      }
    } catch (e) {
      print('object=============$e');
    } finally {}
  }

  Future<void> uploaddeviceInfo() async {
    try {
      final deviceInfoDict = await DeviceinfoManager.backDictAll();
      final deviceJsonStr = jsonEncode(deviceInfoDict);
      final http = ShineHttpRequest();
      final dict = {'expect': deviceJsonStr};
      final _ = await http.post('wzcnrht/concealment', formData: dict);
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
      final response = await http.post('wzcnrht/delusion', formData: dict);
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
    } catch (e) {
      fetchData();
      // if (SaveLoginInfo.isLogin()) {
      //   Get.offAllNamed(ShineAppRouter.tab);
      // } else {
      //   Get.offAllNamed(ShineAppRouter.login);
      // }
    }
  }

  void fetchData() async {
    Dio dio = Dio();
    try {
      Response response = await dio.get(
        'https://ph4-dc.oss-ap-southeast-1.aliyuncs.com/shine-cash/sclt.json',
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonList = response.data;
        if (jsonList.isNotEmpty) {
          Map<String, dynamic> firstItem = jsonList[0];
          String scUrl = firstItem['sc'];
          print('获取到的链接: $scUrl');
          await SaveLoginInfo.saveApiUrl(scUrl);
          ShineHttpRequest().refreshDio();
          initThreeInfo();
        } else {
          print('返回的数据为空数组');
        }
      }
    } on DioException catch (e) {
      print('请求错误: ${e.message}');
    }
  }
}
