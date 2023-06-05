import 'dart:developer';

import 'package:flutter_chatgpt/env/env.dart';
import 'package:flutter_chatgpt/src/data/models/completions_model.dart';
import 'package:flutter_chatgpt/src/data/models/message_model.dart';
import 'package:flutter_chatgpt/src/data/models/quary_parameters.dart';
import 'package:flutter_chatgpt/src/data/providers/message_notifier.dart';
import 'package:flutter_chatgpt/src/data/repository/chatgpt_repository.dart';
import 'package:flutter_chatgpt/src/data/response/model_response.dart';
import 'package:flutter_chatgpt/src/data/services/dio_api_service.dart';
import 'package:flutter_chatgpt/src/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/* API related providers */
// Client providers
final apiClientProvider = Provider.autoDispose<ApiClient>((ref) => ApiClient());

/// Token provider
final tokenProvider = Provider.autoDispose<String>((ref) => Env.apiKey);

// Selected model provider
// Setting state: ref.read(modelProvider.notifier).state = value;
final selectedModelProvider = StateProvider<String>((ref) => "");

// Repository & endpoints providers
final chatGptRepoProvider = Provider.autoDispose<ChatGptRepository>((ref) {
  // The FutureProvider returns Sharedpreferences with AsyncValue wrapper
  // We have to extract the pref value in order to use the sharedpreferences functions.
  // Eg. final sharedPreferences = ref.watch(sharedPreferencesProvider).value;
  // Eg. sharedPreferences?.getString(Constants.prefToken) ?? 'null';
  return ChatGptRepository(ref.watch(apiClientProvider));
});

// Fetches models list from OpenAI API
final modelsProvider = FutureProvider.autoDispose<ModelResponse>((ref) {
  final repository = ref.watch(chatGptRepoProvider);
  return repository.getModels();
});

// Sends a prompt to the OpenAI API and gets the response requires {model name and prompt message}
final sendQueryProvider = FutureProvider.autoDispose.family<Completions, QueryParameters>((ref, arg) {
  final repository = ref.watch(chatGptRepoProvider);
  return repository.sendQuery(model: arg.model, prompt: arg.prompt);
});


/* Other common providers */
// Loading provider
final isLoadingProvider = StateProvider.autoDispose<bool>((ref) => false);

// Sharedpreference provider
final sharedPrefProvider = FutureProvider.autoDispose<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

// Locally stored models list provider
final prefModelListProvider = FutureProvider.autoDispose<String>((ref) async {
  final sharedPreferences = ref.watch(sharedPrefProvider).value;
  return sharedPreferences?.getString(Constants.prefModels) ?? 'null';
});

// Chat list statenotifier provider
final messagesProvider = StateNotifierProvider<MessagesNotifier, List<Message>>((ref) => MessagesNotifier());