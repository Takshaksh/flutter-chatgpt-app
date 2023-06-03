import 'dart:convert';

class Error {
  Error({
    required this.message,
    required this.type,
    this.param,
    this.code,
  });
  
  final String message;
  final String type;
  final String? param;
  final String? code;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'type': type,
      'param': param,
      'code': code,
    };
  }

  factory Error.fromMap(Map<String, dynamic> map) {
    return Error(
      message: map['message'] as String,
      type: map['type'] as String,
      param: map['param'] != null ? map['param'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Error.fromJson(String source) => Error.fromMap(json.decode(source) as Map<String, dynamic>);
}
