import 'package:ns_read_story/model/user.dart';

class NotificationModel {
  NotificationModel({
    this.id,
    this.createdAt,
    this.createdBy,
    this.updatedBy,
    this.content,
    this.userId,
    this.type,
    this.author,
    this.userSendId,
    this.isRead,
  });

  String? id;
  bool? enabled;
  String? createdAt;
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
        createdAt: json["createdAt"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        content: json["content"],
        userId: json["userId"],
        type: json["type"],
        userSendId: json["userSendId"],
        author: UserModel.fromJson(json["author"]),
        isRead: json["isRead"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "enabled": enabled,
        "createdAt": createdAt,
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
