import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Choices {
  Choices({
    required this.text,
    required this.index,
    required this.finishReason,
  });

final String text;
  final int index;
  final String finishReason;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'index': index,
      'finish_reason': finishReason,
    };
  }

  factory Choices.fromMap(Map<String, dynamic> map) {
    return Choices(
      text: map['text'] as String,
      index: map['index'] as int,
      finishReason: map['finish_reason'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Choices.fromJson(String source) => Choices.fromMap(json.decode(source) as Map<String, dynamic>);
}
