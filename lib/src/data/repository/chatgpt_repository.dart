import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_chatgpt/src/data/response/model_response.dart';
import 'package:flutter_chatgpt/src/data/services/api_endpoints.dart';
import 'package:flutter_chatgpt/src/data/services/dio_api_service.dart';

class ChatGptRepository{
  final ApiClient _apiClient;
  final String baseUrl = Endpoints.baseUrl;

  ChatGptRepository(this._apiClient);

  // 1. Getting the available models
  Future<ModelResponse> getModels() async {
    try {
      final response = await _apiClient.dio.get(Endpoints.models);

      // Map jsonError = jsonDecode(response.data);
      // if (jsonError['error'] != null) {
      //   throw HttpException(jsonError['error']['message']);
      // }
      
      final data = ModelResponse.fromJson(response.data);

      return data;
    } catch (exception) {
      log("Model Response Exception: $exception");
      rethrow;
    }
  }

  // 2. Query to a model
  Future<Response> sendQuery({required String prompt, required String model}) async {
    try {
      final response = await _apiClient.dio.post(Endpoints.query, data: {
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
