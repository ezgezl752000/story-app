import 'package:hive/hive.dart';

/// id : "6214a45022a276270c039ee0"
/// deleted : false
/// enabled : true
/// createdAt : "2022-02-22T08:52:32.070+0000"
/// updatedAt : "2022-03-01T17:52:37.977+0000"
/// birthDate : "2000-03-02"
/// fullName : "Quang Lê13"
/// tagName : "syntaxx"
/// password : "$2a$10$1cEefrqc4fxSR9VKi9ZJK.RvY65sYxR33GnDdodbtV8gJEPioeFcS"
/// phoneNumber : ""
/// username : "test03"
/// gender : false
/// avatarUrl : "/story/1646156578568_image_picker695076762910275418.jpg"
/// coverImage : "/story/1646156824093_image_picker4759850133178526672.jpg"
/// point : 0
/// roles : [{"id":"USER","deleted":false,"enabled":true,"updatedAt":"2022-03-02T05:47:01.636+0000","roleDescription":"Xem app","roleName":"người dùng","roleType":"USER"}]
/// vip : false
part 'author.g.dart';

@HiveType(typeId: 3)
class Author {
  Author({
    this.id,
    this.deleted,
    this.enabled,
    this.createdAt,
    this.updatedAt,
    this.birthDate,
    this.fullName,
    this.tagName,
    this.password,
    this.phoneNumber,
    this.username,
    this.gender,
    this.avatarUrl,
    this.coverImage,
    this.point,
    this.roles,
    this.vip,
  });

  Author.fromJson(dynamic json) {
    id = json['id'];
    deleted = json['deleted'];
    enabled = json['enabled'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    birthDate = json['birthDate'];
    fullName = json['fullName'];
    tagName = json['tagName'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    username = json['username'];
    gender = json['gender'];
    avatarUrl = json['avatarUrl'];
    coverImage = json['coverImage'];
    point = json['point'];
    if (json['roles'] != null) {
      roles = [];
      json['roles'].forEach((v) {
        roles?.add(Roles.fromJson(v));
      });
    }
    vip = json['vip'];
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
  String? updatedAt;

  @HiveField(5)
  String? birthDate;

  @HiveField(6)
  String? fullName;

  @HiveField(7)
  String? tagName;

  @HiveField(8)
  String? password;

  @HiveField(9)
  String? phoneNumber;

  @HiveField(10)
  String? username;

  @HiveField(11)
  bool? gender;

  @HiveField(12)
  String? avatarUrl;

  @HiveField(13)
  String? coverImage;

  @HiveField(14)
  int? point;

  @HiveField(15)
  bool? vip;

  List<Roles>? roles;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['deleted'] = deleted;
    map['enabled'] = enabled;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['birthDate'] = birthDate;
    map['fullName'] = fullName;
    map['tagName'] = tagName;
    map['password'] = password;
    map['phoneNumber'] = phoneNumber;
    map['username'] = username;
    map['gender'] = gender;
    map['avatarUrl'] = avatarUrl;
    map['coverImage'] = coverImage;
    map['point'] = point;
    if (roles != null) {
      map['roles'] = roles?.map((v) => v.toJson()).toList();
    }
    map['vip'] = vip;

    return map;
  }
}

/// id : "USER"
/// deleted : false
/// enabled : true
/// updatedAt : "2022-03-02T05:47:01.636+0000"
/// roleDescription : "Xem app"
/// roleName : "người dùng"
/// roleType : "USER"

class Roles {
  Roles({
    this.id,
    this.deleted,
    this.enabled,
    this.updatedAt,
    this.roleDescription,
    this.roleName,
    this.roleType,
  });

  Roles.fromJson(dynamic json) {
    id = json['id'];
    deleted = json['deleted'];
    enabled = json['enabled'];
    updatedAt = json['updatedAt'];
    roleDescription = json['roleDescription'];
    roleName = json['roleName'];
    roleType = json['roleType'];
  }
  String? id;
  bool? deleted;
  bool? enabled;
  String? updatedAt;
  String? roleDescription;
  String? roleName;
  String? roleType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['deleted'] = deleted;
    map['enabled'] = enabled;
    map['updatedAt'] = updatedAt;
    map['roleDescription'] = roleDescription;
    map['roleName'] = roleName;
    map['roleType'] = roleType;
    return map;
  }
}
