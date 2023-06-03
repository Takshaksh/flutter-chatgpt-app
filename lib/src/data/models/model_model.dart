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
  
  factory Model.fromJson(Map<String, dynamic> json){
    return Model(
      id: json['id'], 
      object: json['object'], 
      created: json['created'], 
      ownedBy: json['owned_by']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['object'] = object;
    data['created'] = created;
    data['owned_by'] = ownedBy;
    return data;
  }
}