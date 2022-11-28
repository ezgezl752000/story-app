import 'package:ns_read_story/model/user.dart';

class NotificationModel {
  NotificationModel({
    this.id,
    this.deleted,
    this.enabled,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.content,
    this.userId,
    this.type,
    this.objectId,
    this.userSendId,
    this.author,
    this.isRead,
  });

  String? id;
  bool? deleted;
  bool? enabled;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  String? content;
  String? userId;
  String? type;
  String? objectId;
  String? userSendId;
  UserModel? author;
  bool? isRead;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        deleted: json["deleted"],
        enabled: json["enabled"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        content: json["content"],
        userId: json["userId"],
        type: json["type"],
        objectId: json["objectId"],
        userSendId: json["userSendId"],
        author: UserModel.fromJson(json["author"]),
        isRead: json["isRead"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "deleted": deleted,
        "enabled": enabled,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "content": content,
        "userId": userId,
        "type": type,
        "objectId": objectId,
        "userSendId": userSendId,
        "author": author?.toJson(),
        "isRead": isRead,
      };
}
