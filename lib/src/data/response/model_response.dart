import 'dart:developer';

import 'package:flutter_chatgpt/src/data/models/model_model.dart';

class ModelResponse {
  ModelResponse({
    required this.object,
    required this.data,
  });
  late final String object;
  late final List<Model> data;
  
  ModelResponse.fromJson(Map<String, dynamic> json){
    log("MR start");
    object = json['object'];
    log("MR after obj");
    if (json['data'] != null) {
      log("MR in if null");
      data = <Model>[];
      json['data'].forEach((v){
        data.add(Model.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['object'] = object;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}
