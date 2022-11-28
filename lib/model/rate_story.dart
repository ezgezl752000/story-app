import 'package:ns_read_story/model/user.dart';

class RateStory {
  RateStory({
    this.id,
    this.deleted,
    this.enabled,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.bookId,
    this.userId,
    this.reviewContent,
    this.ratePoint,
    this.fullName,
    this.avatarUrl,
    this.tagName,
    this.user,
  });

  String? id;
  bool? deleted;
  bool? enabled;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  String? bookId;
  String? userId;
  String? reviewContent;
  double? ratePoint;
  String? fullName;
  String? avatarUrl;
  String? tagName;
  UserModel? user;

  factory RateStory.fromJson(Map<String, dynamic> json) => RateStory(
        id: json["id"],
        deleted: json["deleted"],
        enabled: json["enabled"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        bookId: json["bookId"],
        userId: json["userId"],
        reviewContent: json["reviewContent"],
        ratePoint: json["ratePoint"],
        fullName: json["fullName"],
        avatarUrl: json["avatarUrl"],
        tagName: json["tagName"],
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "deleted": deleted,
        "enabled": enabled,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "bookId": bookId,
        "userId": userId,
        "reviewContent": reviewContent,
        "ratePoint": ratePoint,
        "fullName": fullName,
        "avatarUrl": avatarUrl,
        "tagName": tagName,
        "user": user?.toJson(),
      };
}
