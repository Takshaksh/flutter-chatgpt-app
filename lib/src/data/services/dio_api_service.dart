import 'package:dio/dio.dart';
import 'package:flutter_chatgpt/src/data/services/api_endpoints.dart';
import 'package:flutter_chatgpt/src/data/services/logger_intercepter.dart';

class ApiClient{
  final Dio _dio;
  String baseUrl = Endpoints.baseUrl;

  // On instantiation, creating the Dio client
  ApiClient(String token) : _dio = Dio() {
    _dio.options.baseUrl = Endpoints.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: Endpoints.connectionTimeout);
    _dio.options.receiveTimeout = const Duration(seconds: Endpoints.connectionTimeout);

    // Adding intercepter
    _dio.interceptors.add(LoggerInterceptor());

    // Adding headers
    _dio.options.headers['Content-Type'] = 'application/json';
  }

  // Token header setter
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // 1. Getting the available models
  Future<Response> getModels() async {
    try {
      final response = await _dio.get(baseUrl+Endpoints.models);

      return response;
    } catch (exception) {
      rethrow;
    }
  }

  // 2. Query to a model
  Future<Response> sendQuery({required String prompt, required String model}) async {
    try {
      final response = await _dio.post(baseUrl+Endpoints.query, data: {
        'model': model,
        'prompt': prompt,
        'max_tokens': Endpoints.maxTokens
      });

      return response;
    } catch (exception) {
      rethrow;
    }
  }

}

// TODO: Setup Riverpod state management providers
/*
final apiClientProvider = Provider.autoDispose<ApiClient>((ref) {
  final token = ref.watch(tokenProvider);
  return ApiClient(token);
});
*/