/// id : "6214a45022a276270c039ee0"
/// birthDate : "2000-03-02T00:00:00.000+0000"
/// fullName : "Quang Lê13"
/// phoneNumber : ""
/// username : "test03"
/// gender : true
/// avatarUrl : "/story/1646156578568_image_picker695076762910275418.jpg"
/// tagName : "syntax2"
/// point : 0
/// coverImage : "/story/1646212514146_image_picker_B69EEAF5-6BF9-498E-929A-2553C789D2B6-710-000001E25CE33C3F.jpg"
/// followNum : 1
/// totalView : null
/// listRole : [{"id":"USER","deleted":false,"enabled":true,"updatedAt":"2022-03-04T07:51:50.294+0000","roleDescription":"Xem app","roleName":"người dùng","roleType":"USER"}]

class UserModel {
  UserModel({
    this.id,
    this.userId,
    this.birthDate,
    this.fullName,
    this.phoneNumber,
    this.username,
    this.gender,
    this.avatarUrl,
    this.tagName,
    this.point = 0,
    this.coverImage,
    this.followNum,
    this.totalView,
    this.listRole,
    this.notificationCount,
    this.slogan,   
  });

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    userId = json['userId'];
    birthDate = json['birthDate'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    username = json['username'];
    gender = json['gender'];
    avatarUrl = json['avatarUrl'];
    tagName = json['tagName'];
    point = json['point'] ?? 0;
    coverImage = json['coverImage'];
    followNum = json['followNum'];
    totalView = json['totalView'];
    notificationCount = json['notificationCount'];
    if (json['listRole'] != null) {
      listRole = [];
      json['listRole'].forEach((v) {
        listRole?.add(ListRole.fromJson(v));
      });
    }
    slogan = json['slogan'];
  }
  String? id;
  String? userId;
  String? birthDate;
  String? fullName;
  String? phoneNumber;
  String? username;
  bool? gender;
  String? avatarUrl;
  String? tagName;
  int? point;
  String? coverImage;
  int? followNum;
  dynamic totalView;
  List<ListRole>? listRole;
  int? notificationCount;
  String? slogan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userId'] = userId;
    map['birthDate'] = birthDate;
    map['fullName'] = fullName;
    map['phoneNumber'] = phoneNumber;
    map['username'] = username;
    map['gender'] = gender;
    map['avatarUrl'] = avatarUrl;
    map['tagName'] = tagName;
    map['point'] = point;
    map['coverImage'] = coverImage;
    map['followNum'] = followNum;
    map['totalView'] = totalView;
    map['notificationCount'] = notificationCount;
    if (listRole != null) {
      map['listRole'] = listRole?.map((v) => v.toJson()).toList();
    }
    map['slogan'] = slogan;
    return map;
  }
}

/// id : "USER"
/// deleted : false
/// enabled : true
/// updatedAt : "2022-03-04T07:51:50.294+0000"
/// roleDescription : "Xem app"
/// roleName : "người dùng"
/// roleType : "USER"

class ListRole {
  ListRole({
    this.id,
    this.deleted,
    this.enabled,
    this.updatedAt,
    this.roleDescription,
    this.roleName,
    this.roleType,
  });

  ListRole.fromJson(dynamic json) {
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
