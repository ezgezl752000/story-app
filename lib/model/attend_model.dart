import 'package:intl/intl.dart';

class AttendModel {
  AttendModel({
    this.id,
    this.deleted,
    this.enabled,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.attendanceDay,
    this.point,
    this.userId,
  });

  String? id;
  bool? deleted;
  bool? enabled;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  String? attendanceDay;
  int? point;
  String? userId;

  factory AttendModel.fromJson(Map<String, dynamic> json) => AttendModel(
        id: json["id"],
        deleted: json["deleted"],
        enabled: json["enabled"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        attendanceDay: DateFormat('yyyy-MM-dd').format(DateTime.parse(json["attendanceDay"]).toLocal()),
        point: json["point"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "deleted": deleted,
        "enabled": enabled,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "attendanceDay": attendanceDay,
        "point": point,
        "userId": userId,
      };
}
