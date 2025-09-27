import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:get/get.dart';
import 'package:nexo_pizza_staff/Data_Mangement/controllers/auth_controller.dart';
import 'package:nexo_pizza_staff/Data_Mangement/interceptors/tokens_interceptor.dart';
import 'package:path_provider/path_provider.dart';

class AuthBinding {
  static Future<void> init() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final cookieJar = PersistCookieJar(
      storage: FileStorage('${appDocDir.path}/.cookies'),
    );

    final dio = Dio();
    dio.interceptors.add(CookieManager(cookieJar));
    dio.interceptors.add(AuthInterceptor(dio, cookieJar));

    Get.put(AuthController(dio, cookieJar));
  }
}
