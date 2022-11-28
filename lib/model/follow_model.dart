import 'package:ns_read_story/model/user.dart';

/// id : "622396dcad5cc40b74430def"
/// deleted : false
/// enabled : true
/// createdAt : "2022-03-05T16:59:08.558+0000"
/// updatedAt : "2022-03-05T16:59:08.558+0000"
/// userFollowingId : "6214a45022a276270c039ee0"
/// userFollowedId : "621b3c30fe702b6ff80cb8d2"
/// userFollowed : {"id":"621b3c30fe702b6ff80cb8d2","deleted":false,"enabled":true,"createdAt":"2022-02-27T08:54:08.696+0000","updatedAt":"2022-03-06T06:08:22.142+0000","birthDate":"2000-05-22","fullName":"Nhat Tien","tagName":"nhattien","password":"$2a$10$LRTqo0NEcOZ8Z5ODyOwvyuDuGRBpDkvrmHoesc6X.4ri6jKnL88Z.","phoneNumber":"","username":"0963993483","gender":true,"avatarUrl":"/story/1646546860951_image_picker7828346770505741944.jpg","coverImage":"/story/1646546902120_image_picker5543195767825615728.jpg","point":0,"followNum":1,"roles":[{"id":"USER","deleted":false,"enabled":true,"updatedAt":"2022-03-04T07:51:50.294+0000","roleDescription":"Xem app","roleName":"người dùng","roleType":"USER"}],"vip":false}
/// userFollowing : {"id":"6214a45022a276270c039ee0","deleted":false,"enabled":true,"createdAt":"2022-02-22T08:52:32.070+0000","updatedAt":"2022-03-05T16:59:52.902+0000","birthDate":"2000-03-02","fullName":"Quang Lê13","tagName":"syntax2","password":"$2a$10$1cEefrqc4fxSR9VKi9ZJK.RvY65sYxR33GnDdodbtV8gJEPioeFcS","phoneNumber":"","username":"test03","gender":true,"avatarUrl":"/story/1646156578568_image_picker695076762910275418.jpg","coverImage":"/story/1646212514146_image_picker_B69EEAF5-6BF9-498E-929A-2553C789D2B6-710-000001E25CE33C3F.jpg","point":0,"followNum":1,"roles":[{"id":"USER","deleted":false,"enabled":true,"updatedAt":"2022-03-04T07:51:50.294+0000","roleDescription":"Xem app","roleName":"người dùng","roleType":"USER"}],"vip":false}

class FollowModel {
  FollowModel({
      this.id, 
      this.deleted, 
      this.enabled, 
      this.createdAt, 
      this.updatedAt, 
      this.userFollowingId, 
      this.userFollowedId, 
      this.userFollowed, 
      this.userFollowing,});

  FollowModel.fromJson(dynamic json) {
    id = json['id'];
    deleted = json['deleted'];
    enabled = json['enabled'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userFollowingId = json['userFollowingId'];
    userFollowedId = json['userFollowedId'];
    userFollowed = json['userFollowed'] != null ? UserModel.fromJson(json['userFollowed']) : null;
    userFollowing = json['userFollowing'] != null ? UserModel.fromJson(json['userFollowing']) : null;
  }
  String? id;
  bool? deleted;
  bool? enabled;
  String? createdAt;
  String? updatedAt;
  String? userFollowingId;
  String? userFollowedId;
  UserModel? userFollowed;
  UserModel? userFollowing;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['deleted'] = deleted;
    map['enabled'] = enabled;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['userFollowingId'] = userFollowingId;
    map['userFollowedId'] = userFollowedId;
    if (userFollowed != null) {
      map['userFollowed'] = userFollowed?.toJson();
    }
    if (userFollowing != null) {
      map['userFollowing'] = userFollowing?.toJson();
    }
    return map;
  }

}
