import 'package:dio/dio.dart';
import 'package:flutter_chatgpt/src/data/services/api_endpoints.dart';
import 'package:flutter_chatgpt/src/data/services/logger_intercepter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/common_providers.dart';

class ApiClient{
  final Dio _dio;
  final providerContainer = ProviderContainer();

  // On instantiation, creating the Dio client
  ApiClient() : _dio = Dio() {
    _dio.options.baseUrl = Endpoints.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: Endpoints.connectionTimeout);
    _dio.options.receiveTimeout = const Duration(seconds: Endpoints.connectionTimeout);

    // Adding intercepter
    _dio.interceptors.add(LoggerInterceptor());

    // Adding headers
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['Authorization'] = 'Bearer ${providerContainer.read(tokenProvider)}';
  }

  // Token header setter
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // Dio getter
  Dio get dio => _dio;
}

// TODO: Setup Riverpod state management providers
/*
final apiClientProvider = Provider.autoDispose<ApiClient>((ref) {
  final token = ref.watch(tokenProvider);
  return ApiClient(token);
});
*/