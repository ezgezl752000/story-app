/// username : "root"
/// password : "admin"
/// regId : "ross"
/// osDevice : "adroid"

class LoginRequest {
  LoginRequest({
      this.username, 
      this.fullName,
      this.avatarUrl,
      this.tagName,
      this.password,
      this.tokenFirebase,
  });

  LoginRequest.fromJson(dynamic json) {
    username = json['username'];
    fullName = json['fullName'];
    password = json['password'];
    tagName = json['tagName'];
    avatarUrl = json['avatarUrl'];
    tokenFirebase = json['tokenFirebase'];
  }
  String? username;
  String? password;
  String? fullName;
  String? tagName;
  String? avatarUrl;
  String? tokenFirebase;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['password'] = password;
    map['fullName'] = fullName;
    map['avatarUrl'] = avatarUrl;
    map['tagName'] = tagName;
    map['tokenFirebase'] = tokenFirebase;
    return map;
  }

}