import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ns_read_story/repository/user_repository.dart';
import 'package:provider/provider.dart';

class AppConfig {
  // static const String BASE_URL = "http://222.252.27.93:82"; //dev
  // static const String BASE_URL = "http://222.252.27.93:92"; // test
  static const String BASE_URL = "http://103.183.112.32:8080"; // domain
  static const String notificationToken = "token";
  static  String version = "";

  static const int pageSizeDefault = 20;
  static String urlImage = '';
  static String policy = '';
  static bool isShowDownload = false;

  static double brightnessValue = 0.5;
  static double fontSizeValue = 18;
  static double lineHeightValue = 1.5;
  static Color colorBgValue = Colors.white;
  static String fontValue = "Roboto";

  static String checkDeviceType() {
    if (Platform.isIOS) {
      return "ios";
    } else if (Platform.isAndroid) {
      return "android";
    } else {
      return "DTDD";
    }
  }

  // static Future<String?> getId() async {
  //   var deviceInfo = DeviceInfoPlugin();
  //   if (Platform.isIOS) {
  //     var iosDeviceInfo = await deviceInfo.iosInfo;
  //     return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  //   } else {
  //     var androidDeviceInfo = await deviceInfo.androidInfo;
  //     return androidDeviceInfo.androidId; // unique ID on Android
  //   }
  // }

//   static Future<MultipartFile> parseFile ({required List<ImageCheck> list,required String key}) async {
//     return MultipartFile.fromFile(list.where((e) => e.key==key).toList().first.image!.path,
//         filename: list.where((e) => e.key==key).toList().first.image!.path.split('/').last);
// }

static Future<bool> logNotification (String idNoti,BuildContext context) async {
    await context.read<UserRepository>().readNotification(idNoti);
    return true;
}

}
