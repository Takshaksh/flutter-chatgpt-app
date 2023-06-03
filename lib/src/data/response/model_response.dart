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
    log("MR start");
    var list = <Model>[];

    json['data'].forEach((v){
      list.add(Model.fromJson(v));
    });
    log("MR b4 return");

    return ModelResponse(
      object: json['object'], 
      data: list
    );

  }
    // if (json['data'] != null) {
    //   data = <Model>[];
    //   json['data'].forEach((v){
    //     data.add(Model.fromJson(v));
    //   });
    // }
  }

