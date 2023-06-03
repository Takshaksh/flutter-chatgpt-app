import 'dart:developer';
import 'package:dio/dio.dart';

class LoggerInterceptor implements Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log('❌ Dio Error!');
    log('❌ Url: ${err.requestOptions.uri}');
    log('❌ ${err.stackTrace}');
    log('❌ Response Error: ${err.response?.data}');

    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('🌍 Sending network request: ${options.baseUrl}${options.path}');
    log('🌍 Request parameters: ${options.data.toString()}');
    log('---------------------------------');

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    String endpoint = "${response.requestOptions.baseUrl}${response.requestOptions.path}";

    log('🐦 Received network response →');
    log('${response.statusCode != 200 ? '❌ ${response.statusCode} ❌' : '✅ 200 →'} $endpoint');
    log('Query params: ${response.requestOptions.queryParameters}');
    log('Response on response: ${response.toString().substring(0, 100)}');
    log('---------------------------------');

    return handler.next(response);
  }
}