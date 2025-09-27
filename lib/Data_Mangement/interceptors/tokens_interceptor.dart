import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final PersistCookieJar cookieJar;

  AuthInterceptor(this.dio, this.cookieJar);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.extra['skipAuth'] == true) {
      return handler.next(options);
    }

    // Load the cookies for the current request URI
    final cookies = await cookieJar.loadForRequest(options.uri);

    // Get the access token cookie safely
    final accessTokenCookie = cookies
        .where((cookie) => cookie.name == 'accessToken')
        .cast<Cookie?>()
        .firstOrNull;

    if (accessTokenCookie != null && !_isExpired(accessTokenCookie)) {
      // If valid, add it to request headers
      options.headers['Authorization'] = 'Bearer ${accessTokenCookie.value}';
    }

    // Proceed to the next handler
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !_isRetry(err.requestOptions)) {
      try {
        // URI for refreshing the token
        final refreshUri = Uri.parse('http://192.168.1.12:8008/api/v1/refresh');

        // Load cookies for refresh URI
        final refreshCookies = await cookieJar.loadForRequest(refreshUri);
        final refreshTokenCookie = refreshCookies
            .where((cookie) => cookie.name == 'refreshToken')
            .cast<Cookie?>()
            .firstOrNull;

        if (refreshTokenCookie == null || _isExpired(refreshTokenCookie)) {
          return handler.next(err);  // No valid refresh token
        }

        // Mark request as retried to avoid infinite loops
        err.requestOptions.extra["retried"] = true;

        // Make the request to refresh the token
        final response = await dio.post(
          refreshUri.toString(),
          options: Options(headers: {
            'Authorization': 'Bearer ${refreshTokenCookie.value}',
          }),
        );

        // Save new cookies returned by the server
        final setCookieHeaders = response.headers.map['set-cookie'];
        if (setCookieHeaders != null) {
          final newCookies = setCookieHeaders
              .map((str) => Cookie.fromSetCookieValue(str))
              .toList();
          await cookieJar.saveFromResponse(refreshUri, newCookies);
        }

        // Get the new access token from the cookies
        final originalOptions = err.requestOptions;
        final newCookies = await cookieJar.loadForRequest(originalOptions.uri);
        final newAccessToken = newCookies
            .where((cookie) => cookie.name == 'accessToken')
            .cast<Cookie?>()
            .firstOrNull;

        if (newAccessToken == null) {
          return handler.next(err);  // No new access token
        }

        originalOptions.headers['Authorization'] = 'Bearer ${newAccessToken.value}';

        // Retry original request using updated headers and all original options
        final res = await dio.fetch(originalOptions);
        return handler.resolve(res);
      } catch (e) {
        return handler.next(err);  // If error, continue with the original error
      }
    }else{
      return handler.next(err);  // For non-401 errors, continue
    }
  }

  bool _isRetry(RequestOptions options) {
    return options.extra["retried"] == true;
  }

  bool _isExpired(Cookie cookie) {
    return cookie.expires != null && cookie.expires!.isBefore(DateTime.now());
  }
}
