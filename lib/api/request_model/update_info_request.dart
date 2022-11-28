/// id : "6214a45022a276270c039ee0"
/// birthDate : "1998-09-01T00:00:00.000+0000"
/// fullName : "Nguyễn Văn Nam"
/// phoneNumber : "12132143"
/// username : "test03"
/// gender : true
/// tagName : "test03"
/// coverImage : ""
/// avatarUrl : null

class UpdateInfoRequest {
  UpdateInfoRequest({
      this.id, 
      this.birthDate, 
      this.fullName, 
      this.phoneNumber, 
      this.username, 
      this.gender, 
      this.tagName, 
      this.coverImage, 
      this.avatarUrl,});

  UpdateInfoRequest.fromJson(dynamic json) {
    id = json['id'];
    birthDate = json['birthDate'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    username = json['username'];
    gender = json['gender'];
    tagName = json['tagName'];
    coverImage = json['coverImage'];
    avatarUrl = json['avatarUrl'];
  }
  String? id;
  String? birthDate;
  String? fullName;
  String? phoneNumber;
  String? username;
  bool? gender;
  String? tagName;
  String? coverImage;
  dynamic avatarUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['birthDate'] = birthDate;
    map['fullName'] = fullName;
    map['phoneNumber'] = phoneNumber;
    map['username'] = username;
    map['gender'] = gender;
    map['tagName'] = tagName;
    map['coverImage'] = coverImage;
    map['avatarUrl'] = avatarUrl;
    return map;
  }

}