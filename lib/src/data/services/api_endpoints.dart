class Endpoints{
  Endpoints._();

  // Common
  static const String baseUrl = "https://api.openai.com/v1";
  static const int connectionTimeout = 10000;
  static const int receiveTimeout = 15000;
  static const int maxTokens = 300;

  // OpenAI
  static const String query = "/completions";
  static const String models = "/models";

}