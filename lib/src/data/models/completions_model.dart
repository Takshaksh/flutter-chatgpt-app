import 'dart:convert';
import 'package:flutter_chatgpt/src/data/models/choices_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'completions_model.g.dart';

@JsonSerializable()
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
  final Choices choices;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'object': object,
      'created': created,
      'model': model,
      'choices': choices.toMap(),
    };
  }

  factory Completions.fromMap(Map<String, dynamic> map) {
    return Completions(
      id: map['id'] as String,
      object: map['object'] as String,
      created: map['created'] as int,
      model: map['model'] as String,
      choices: Choices.fromMap(map['choices'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Completions.fromJson(String source) => Completions.fromMap(json.decode(source) as Map<String, dynamic>);
}
