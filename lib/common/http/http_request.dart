import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

const String websiteUrl = 'http://47.84.60.25:8520';
const String apiUrl = '$websiteUrl/iukws';

class HttpRequest {
  static final HttpRequest _instance = HttpRequest._internal();
  factory HttpRequest() => _instance;
  late final Dio _dio;

  HttpRequest._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: apiUrl,
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }

  /// GET请求, 参数可选
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// POST请求, 参数可选, 支持json和表单
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  // 上传单张图片, 可选参数
  Future<Response> uploadImage(
    String path, {
    required File imageFile,
    Map<String, dynamic>? extraData,
    CancelToken? cancelToken,
    String fileField = 'image',
    int quality = 85,
    int minWidth = 1000,
    int minHeight = 1000,
  }) async {
    // Read and compress the image first
    Uint8List originalData = await imageFile.readAsBytes();
    Uint8List? compressedData = await FlutterImageCompress.compressWithList(
      originalData,
      minHeight: minHeight,
      minWidth: minWidth,
      quality: quality.clamp(0, 100), // Ensure quality is between 0-100
    );

    // Create form data
    FormData formData = FormData.fromMap({
      fileField: MultipartFile.fromBytes(
        compressedData,
        filename: 'image',
        contentType: DioMediaType("image", "jpeg"),
      ),
      ...?extraData,
    });

    return await _dio.post(
      path,
      data: formData,
      options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      cancelToken: cancelToken,
    );
  }
}
