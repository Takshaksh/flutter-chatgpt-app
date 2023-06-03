import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Model {
  Model({
    required this.id,
    required this.object,
    required this.created,
    required this.ownedBy,
  });

  final String id;
  final String object; 
  final int created;
  final String ownedBy;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'object': object,
      'created': created,
      'ownedBy': ownedBy,
    };
  }

  factory Model.fromMap(Map<String, dynamic> map) {
    return Model(
      id: map['id'] as String,
      object: map['object'] as String,
      created: map['created'] as int,
      ownedBy: map['ownedBy'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Model.fromJson(String source) => Model.fromMap(json.decode(source) as Map<String, dynamic>);
}
