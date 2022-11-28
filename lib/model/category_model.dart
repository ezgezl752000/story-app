import 'package:hive/hive.dart';

/// id : "62188a27ebd065d693baa4fc"
/// deleted : false
/// enabled : true
/// createdAt : null
/// updatedAt : null
/// createdBy : null
/// updatedBy : null
/// thumbnail : "/story/kiao.svg"
/// name : "Kỳ ảo"
/// parentId : null
part 'category_model.g.dart';

@HiveType(typeId: 1)
class Categories {
  Categories({
    this.id,
    this.deleted,
    this.enabled,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.thumbnail,
    this.name,
    this.selected = false,
    this.parentId,});

  Categories.fromJson(dynamic json) {
    id = json['id'];
    deleted = json['deleted'];
    enabled = json['enabled'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    thumbnail = json['thumbnail'];
    name = json['name'];
    parentId = json['parentId'];
  }

  @HiveField(0)
  String? id;

  @HiveField(1)
  bool? deleted;

  @HiveField(2)
  bool? enabled;

  @HiveField(3)
  dynamic createdAt;

  @HiveField(4)
  dynamic updatedAt;

  @HiveField(5)
  dynamic createdBy;

  @HiveField(6)
  dynamic updatedBy;

  @HiveField(7)
  String? thumbnail;

  @HiveField(8)
  String? name;

  bool? selected =false;
  dynamic parentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['deleted'] = deleted;
    map['enabled'] = enabled;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['thumbnail'] = thumbnail;
    map['name'] = name;
    map['parentId'] = parentId;
    return map;
  }

}
