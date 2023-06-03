class Model {
  Model({
    required this.id,
    required this.object,
    required this.created,
    required this.ownedBy,
  });
  late final String id;
  late final String object;
  late final int created;
  late final String ownedBy;
  
  Model.fromJson(Map<String, dynamic> json){
    id = json['id'];
    object = json['object'];
    created = json['created'];
    ownedBy = json['owned_by'];
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