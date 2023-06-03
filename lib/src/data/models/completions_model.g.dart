// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Completions _$CompletionsFromJson(Map<String, dynamic> json) => Completions(
      id: json['id'] as String,
      object: json['object'] as String,
      created: json['created'] as int,
      model: json['model'] as String,
      choices: Choices.fromJson(json['choices'] as String),
    );

Map<String, dynamic> _$CompletionsToJson(Completions instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'created': instance.created,
      'model': instance.model,
      'choices': instance.choices,
    };
