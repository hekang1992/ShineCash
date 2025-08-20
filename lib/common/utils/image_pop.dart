import 'package:flutter/services.dart';

class ImageChannel {
  static const MethodChannel _channel = MethodChannel("shineapp_info");

  static Future<Uint8List> openCamera(String type) async {
    final dict = {'type': type};
    final Uint8List data = await _channel.invokeMethod("openCamera", dict);
    return data;
  }

  static Future<Uint8List> openGallery() async {
    final Uint8List data = await _channel.invokeMethod("openGallery");
    return data;
  }
}

class PhoneNameChannel {
  static const MethodChannel _channel = MethodChannel("shineapp_info");

  /// get name phone
  static Future<List<Contact>> getAllContacts() async {
    try {
      final contacts = await _channel.invokeMethod('getAllContacts');
      return (contacts as List)
          .map((e) => Contact.fromMap(Map<String, String>.from(e)))
          .toList();
    } on PlatformException catch (e) {
      print("name==phone===: ${e.message}");
      return [];
    }
  }

  /// single phone
  static Future<Contact?> pickContact() async {
    try {
      final contact = await _channel.invokeMethod('pickSingleContact');
      return contact != null
          ? Contact.fromMap(Map<String, String>.from(contact))
          : null;
    } on PlatformException catch (e) {
      print("select--phone===== ${e.message}");
      return null;
    }
  }
}

class Contact {
  final String ever;
  final String pens;

  Contact({required this.ever, required this.pens});

  factory Contact.fromMap(Map<String, String> map) {
    return Contact(ever: map['ever'] ?? '', pens: map['pens'] ?? '');
  }

  @override
  String toString() => 'Contact(ever: $ever, pens: $pens)';
}

class ToAppStoreChannel {
  static const MethodChannel _channel = MethodChannel('to_appstroe');
  static Future<void> toAppChanel() async {
    try {
      await _channel.invokeMethod('to_appstroe');
    } catch (e) {}
  }
}
