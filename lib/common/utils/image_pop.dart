import 'package:flutter/services.dart';

class ImageChannel {
  static const MethodChannel _channel = MethodChannel("shineapp_info");

  /// 打开相机
  static Future<Uint8List> openCamera(String type) async {
    final dict = {'type': type};
    final Uint8List data = await _channel.invokeMethod("openCamera", dict);
    return data;
  }

  /// 打开相册
  static Future<Uint8List> openGallery() async {
    final Uint8List data = await _channel.invokeMethod("openGallery");
    return data;
  }
}
