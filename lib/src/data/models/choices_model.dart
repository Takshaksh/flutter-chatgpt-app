import 'dart:convert';

class Choices {
  Choices({
    required this.text,
    required this.index,
    required this.finishReason,
  });

  final String text;
  final int index;
  final String finishReason;

  factory Choices.fromJson(Map<String, dynamic> json){
    return Choices(
      text: json['text'], 
      index: 0, 
      finishReason: json['finish_reason']
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['text'] = text;
    data['index'] = index;
    data['finish_reason'] = finishReason;
    return data;
  }
}
