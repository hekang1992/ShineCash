import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:shinecash/common/constants/constant.dart';
import 'package:shinecash/common/utils/save_login_info.dart';

class ShineHttpRequest {
  static final ShineHttpRequest _instance = ShineHttpRequest._internal();
  factory ShineHttpRequest() => _instance;

  late Dio _dio;
  bool _isInitialized = false;

  // 动态获取 API URL
  String get _apiUrl {
    String dynamicUrl = SaveLoginInfo.getApiUrl() ?? '';
    return dynamicUrl.isEmpty
        ? 'https://sclt.lynxlogic-tech.com/iukws/'
        : dynamicUrl;
  }

  ShineHttpRequest._internal() {
    _initDio();
  }

  // 初始化 Dio 实例
  void _initDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _apiUrl,
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // 添加日志拦截器
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        logPrint: (obj) => print(obj),
      ),
    );

    // _configureProxy();
    _isInitialized = true;

    print('Dio 初始化完成，baseUrl: $_apiUrl');
  }

  // 刷新 Dio 实例（在域名更新后调用）
  void refreshDio() {
    print('刷新 Dio 实例，新的 baseUrl: $_apiUrl');
    _initDio();
  }

  // 配置代理
  void _configureProxy() {
    String proxyIP = '192.168.71.48';
    String proxyPort = "8888";

    if (proxyIP.isNotEmpty) {
      (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final client = HttpClient();
        client.findProxy = (uri) {
          return 'PROXY $proxyIP:$proxyPort';
        };
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
  }

  /// GET请求
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    if (!_isInitialized) {
      _initDio();
    }

    final resolvedUrl = await ApiUrlManager.getApiUrl(path) ?? '';
    return await _dio.get(
      resolvedUrl,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// POST请求
  Future<Response> post(
    String path, {
    dynamic formData,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    if (!_isInitialized) {
      _initDio();
    }

    final resolvedUrl = await ApiUrlManager.getApiUrl(path) ?? '';
    final form = FormData.fromMap(formData);
    return await _dio.post(
      resolvedUrl,
      data: form,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  // 上传单张图片
  Future<Response> uploadImage(
    String path, {
    required Uint8List originalData,
    Map<String, dynamic>? extraData,
    CancelToken? cancelToken,
    String fileField = 'image',
    int quality = 80,
    int minWidth = 850,
    int minHeight = 850,
  }) async {
    if (!_isInitialized) {
      _initDio();
    }

    FormData formData = FormData.fromMap({
      fileField: MultipartFile.fromBytes(
        originalData,
        filename: 'image',
        contentType: DioMediaType("image", "jpeg"),
      ),
      ...?extraData,
    });

    final resolvedUrl = await ApiUrlManager.getApiUrl(path) ?? '';
    return await _dio.post(
      resolvedUrl,
      data: formData,
      options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      cancelToken: cancelToken,
    );
  }

  // 获取当前 baseUrl（用于调试）
  String get currentBaseUrl => _dio.options.baseUrl;
}

/// 获取实际请求的api地址
class ApiUrlManager {
  static Future<String?> getApiUrl(String path) async {
    Map<String, String> dict = await AppCommonPera.getCommonPera();
    String? apiUrl = URLParameterHelper.appendQueryParameters(path, dict) ?? '';
    return apiUrl;
  }
}

/// 拼接字典参数
class URLParameterHelper {
  static String? appendQueryParameters(
    String url,
    Map<String, String> parameters,
  ) {
    try {
      final uri = Uri.parse(url);
      final newUri = uri.replace(
        queryParameters: {...uri.queryParameters, ...parameters},
      );
      return newUri.toString();
    } catch (e) {
      return null;
    }
  }
}
