// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_chatgpt/src/data/models/choices_model.dart';

class Completions {
  Completions({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.choices,
  });

  final String id;
  final String object; 
  final int created;
  final String model;
  final List<Choices> choices;

  factory Completions.fromJson(Map<String, dynamic> json) {
    // var list = (json['data'] as List).map((v) => Model.fromJson(v)).toList();
    var list = (json['choices'] as List).map((e) => Choices.fromJson(e)).toList();
    return Completions(
      id: json['id'],
      object: json['object'],
      created: json['created'],
      model: json['model'],
      choices: list
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'object': object,
      'created': created,
      'model': model,
      'choices': choices.map((x) => x.toJson()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

}
