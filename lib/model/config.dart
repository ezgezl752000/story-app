/// id : "POLICY"
/// deleted : false
/// enabled : true
/// name : "Chính sách"
/// value : "Nội dung chính sách"

class Config {
  Config({
      this.id, 
      this.deleted, 
      this.enabled, 
      this.name, 
      this.value,});

  Config.fromJson(dynamic json) {
    id = json['id'];
    deleted = json['deleted'];
    enabled = json['enabled'];
    name = json['name'];
    value = json['value'];
  }
  String? id;
  bool? deleted;
  bool? enabled;
  String? name;
  String? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['deleted'] = deleted;
    map['enabled'] = enabled;
    map['name'] = name;
    map['value'] = value;
    return map;
  }

}