import 'dart:convert';
import 'package:flutter_chatgpt/src/data/models/error_model.dart';

class ErrorResponse {
  ErrorResponse({
    required this.error,
  });

  final Error error;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'error': error.toMap(),
    };
  }

  factory ErrorResponse.fromMap(Map<String, dynamic> map) {
    return ErrorResponse(
      error: Error.fromMap(map['error'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorResponse.fromJson(String source) => ErrorResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
