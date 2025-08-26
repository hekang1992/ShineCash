import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:shinecash/common/constants/constant.dart';

const String websiteUrl = 'http://47.84.60.25:8520';
const String apiUrl = '$websiteUrl/iukws';

class ShineHttpRequest {
  static final ShineHttpRequest _instance = ShineHttpRequest._internal();

  factory ShineHttpRequest() => _instance;

  late final Dio _dio;

  ShineHttpRequest._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: apiUrl,
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // 添加日志拦截器，方便调试
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

    _configureProxy();
  }

  // 配置代理
  _configureProxy() {
    // String proxyIP = '10.1.1.84';
    // String proxyIP = '192.168.71.22';
    String proxyIP = '192.168.0.70';
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

  /// GET请求, 参数可选
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final resolvedUrl = await ApiUrlManager.getApiUrl(path) ?? '';
    return await _dio.get(
      resolvedUrl,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// POST请求, 参数可选, 支持json和表单
  Future<Response> post(
    String path, {
    dynamic formData,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
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

  // 上传单张图片, 可选参数
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
    // Read and compress the image first

    // Create form data
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
