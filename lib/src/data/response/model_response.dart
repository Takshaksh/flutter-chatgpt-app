import 'dart:convert';
import 'package:flutter_chatgpt/src/data/models/model_model.dart';

class ModelResponse {
  ModelResponse({
    required this.object,
    required this.data,
  });

  final String object;
  final List<Model> data;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'object': object,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory ModelResponse.fromMap(Map<String, dynamic> map) {
    return ModelResponse(
      object: map['object'] as String,
      data: List<Model>.from((map['data'] as List<int>).map<Model>((x) => Model.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelResponse.fromJson(String source) => ModelResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
