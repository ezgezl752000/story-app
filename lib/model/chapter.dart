import 'package:hive/hive.dart';

/// id : "62189fc6ebd065d693baaf09"
/// deleted : false
/// enabled : true
/// createdAt : null
/// updatedAt : null
/// createdBy : null
/// updatedBy : null
/// name : "Chương 1"
/// content : "Nội dung bla bla bla"
/// showAds : null
/// isNew : null
/// price : 0
/// bookId : "6218900bebd065d693baa724"
part 'chapter.g.dart';

@HiveType(typeId: 2)
class Chapter {
  Chapter({
      this.id, 
      this.deleted, 
      this.enabled, 
      this.createdAt, 
      this.updatedAt, 
      this.createdBy, 
      this.updatedBy, 
      this.name, 
      this.content, 
      this.showAds, 
      this.isNew, 
      this.price, 
      this.isBuy,
      this.totalView,
      this.bookId,});

  Chapter.fromJson(dynamic json) {
    id = json['id'];
    deleted = json['deleted'];
    enabled = json['enabled'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    name = json['name'];
    content = json['content'];
    showAds = json['showAds'];
    isNew = json['isNew'];
    price = json['price'];
    bookId = json['bookId'];
    isBuy = json['isBuy'];
    totalView = json['totalView'];
  }
  @HiveField(0)
  String? id;

  @HiveField(1)
  bool? deleted;

  @HiveField(2)
  bool? enabled;

  @HiveField(3)
  String? createdAt;

  @HiveField(4)
  dynamic updatedAt;

  @HiveField(5)
  dynamic createdBy;

  @HiveField(6)
  dynamic updatedBy;

  @HiveField(7)
  String? name;

  @HiveField(8)
  String? content;

  @HiveField(9)
  dynamic showAds;

  @HiveField(10)
  dynamic isNew;

  @HiveField(11)
  double? price;

  @HiveField(12)
  int? totalView;

  @HiveField(13)
  String? bookId;

  @HiveField(14)
  bool? isBuy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['deleted'] = deleted;
    map['enabled'] = enabled;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['name'] = name;
    map['content'] = content;
    map['showAds'] = showAds;
    map['isNew'] = isNew;
    map['price'] = price;
    map['isBuy'] = isBuy;
    map['totalView'] = totalView;
    map['bookId'] = bookId;
    return map;
  }

}