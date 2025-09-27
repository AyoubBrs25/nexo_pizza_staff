import 'package:flutter/material.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../HomePagesManager/all_pages.dart';
import '../models/user_model.dart';

class AuthController extends GetxController {
  final Dio dio;
  final PersistCookieJar cookieJar;
  Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  UserModel tempUser = UserModel();
  final box = GetStorage();
  AuthController(this.dio, this.cookieJar);

  // Future<String?> getAccessToken() async {
  //   final url = 'http://192.168.1.12:8008/api/v1/refresh';

  //   List<Cookie> cookies = await cookieJar.loadForRequest(Uri.parse(url));

  //   final newAccessToken = cookies
  //       .where((cookie) => cookie.name == 'accessToken')
  //       .cast<Cookie?>()
  //       .firstOrNull;

  //   if (newAccessToken != null && !_isExpired(newAccessToken)) {
  //     return newAccessToken.value;
  //   }

  //   final refreshed = await _refreshToken();

  //   if(refreshed){
  //     cookies = await cookieJar.loadForRequest(Uri.parse(url));
  //     final newAccessToken = cookies
  //         .where((cookie) => cookie.name == 'accessToken')
  //         .cast<Cookie?>()
  //         .firstOrNull;
  //     return newAccessToken!.value;
  //   }
  //   return null;
  // }
  // Future<bool> _refreshToken() async {
  //   final refreshUri = Uri.parse('http://192.168.1.12:8008/api/v1/refresh');

  //   final refreshCookies = await cookieJar.loadForRequest(refreshUri);
  //   final refreshToken = refreshCookies
  //       .where((cookie) => cookie.name == 'refreshToken')
  //       .cast<Cookie?>()
  //       .firstOrNull;

  //   if (refreshToken == null || _isExpired(refreshToken)) {
  //     return false;
  //   }

  //   try {
  //     final response = await dio.post(
  //       refreshUri.toString(),
  //       options: Options(headers: {
  //         'Authorization': 'Bearer ${refreshToken.value}',
  //       }),
  //     );

  //     final setCookieHeaders = response.headers.map['set-cookie'];
  //     if (setCookieHeaders != null) {
  //       final newCookies = setCookieHeaders
  //           .map((str) => Cookie.fromSetCookieValue(str))
  //           .toList();
  //       await cookieJar.saveFromResponse(refreshUri, newCookies);
  //     }

  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  Future<void> login(String email, String password) async {
    try {
      final res = await dio.post(
        "http://192.168.1.12:8008/api/v1/login_patient_email",
        data: {"email": email, "password": password},
        options: Options(extra: {'skipAuth': true}),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        currentUser.value = UserModel.fromJson(res.data['user']);
        Get.offAll(() => const AllPages());
      }
    } on DioException catch (e) {
      final res = e.response;
      if (res != null && res.statusCode == 401) {
        Get.snackbar(
          '',
          '',
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
          ), // Changed to .h for vertical padding
          messageText: Text(
            'Password is incorrect',
            style: TextStyle(
              fontSize: 10.sp, // Using .sp for font size
              color:
                  Theme.of(Get.context!).scaffoldBackgroundColor == Colors.black
                  ? Colors.white
                  : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          titleText: Text(
            'Error',
            style: TextStyle(
              fontSize: 13.sp, // Using .sp for font size
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.red.withAlpha(51),
          snackPosition: SnackPosition.TOP,
          icon: Icon(
            Icons.error,
            size: 25.r, // Changed to .w for icon size
            color: Colors.red,
          ),
        );
      } else {
        if (kDebugMode) {
          print("DioError: ${e.message}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Other Error: $e");
      }
    }
  }

  Future<bool> checkAutoLogin() async {
    final refreshUri = Uri.parse('http://192.168.1.12:8008/api/v1/refresh');
    final cookies = await cookieJar.loadForRequest(refreshUri);

    final refreshTokenCookie = cookies
        .where((cookie) => cookie.name == 'refreshToken')
        .cast<Cookie?>()
        .firstOrNull;

    if (refreshTokenCookie != null && !_isExpired(refreshTokenCookie)) {
      try {
        final refreshResponse = await dio.post(
          '$refreshUri',
          options: Options(
            headers: {'Authorization': 'Bearer ${refreshTokenCookie.value}'},
            extra: {'skipAuth': true},
          ),
        );

        if (refreshResponse.statusCode == 200 ||
            refreshResponse.statusCode == 201) {
          final res = await dio.get(
            "http://192.168.1.12:8008/api/v1/me_patient",
            options: Options(extra: {'skipAuth': false}),
          );
          if (res.statusCode == 200 || res.statusCode == 201) {
            currentUser.value = UserModel.fromJson(res.data['user']);
            return true;
          }
        }
      } catch (_) {
        return false;
      }
    }
    return false;
  }

  bool _isExpired(Cookie cookie) {
    return cookie.expires != null && cookie.expires!.isBefore(DateTime.now());
  }
}
