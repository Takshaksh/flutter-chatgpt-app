// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_chatgpt/src/data/models/model_model.dart';

class ModelResponse {
  ModelResponse({
    required this.object,
    required this.data,
  });

  final String object;
  final List<Model> data;
  
  factory ModelResponse.fromJson(Map<String, dynamic> json){
    var list = (json['data'] as List).map((v) => Model.fromJson(v)).toList();
    // var list = <Model>[];
    // json['data'].forEach((v) => list.add(Model.fromJson(v)));

    return ModelResponse(
      object: json['object'], 
      data: list
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'object': object,
      'data': data.map((x) => x.toJson()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
}

