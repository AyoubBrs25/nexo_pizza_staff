import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ConnectionCntrl extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
    Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      _updateconncetion(results);
    });
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    _updateconncetion(connectivityResult);
  }

  void _updateconncetion(List<ConnectivityResult> cnctres) {
    if (cnctres.contains(ConnectivityResult.none)) {
      if (!Get.isDialogOpen!) {
        Get.dialog(
          AlertDialog(
            alignment: Alignment.center,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wifi_tethering_error_rounded_rounded,
                  size: 50.sp,
                  color: const Color(0xffe23a00),
                ),
                SizedBox(height: 10.sp),
                Text(
                  "Whoops!",
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Check your internet connection.",
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15.sp),
                GestureDetector(
                  onTap: () {
                    if (Platform.isAndroid || Platform.isIOS) {
                      exit(0);
                    }
                  },
                  child: Container(
                    width: 120.sp,
                    padding: EdgeInsets.all(8.sp),
                    decoration: BoxDecoration(
                      color: const Color(0xffe23a00),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        "Try Later",
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.white,
          ),
          barrierDismissible: false,
        );
      }
    } else {
      if (Get.isDialogOpen!) {
        Get.back();
      }
    }
  }
}
