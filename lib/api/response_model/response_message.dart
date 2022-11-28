import 'package:ns_read_story/model/detail_story.dart';
import 'package:ns_read_story/model/user.dart';

/// status : "OK"
/// code : 200
/// message : "
/// Đăng nhập thành công"
/// data : {"deleted":false,"enabled":false,"userId":274,"osDevice":"adroid","regPushNotification":"ross","token":"eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NDYzNTk1MTUsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkMmRNUGZHOGdLMVoxNlRVamZIMFdnT1N2XC9xUWtIZUFqWlN3T3BBSm16aFRXZHFcL0NCT1RidSIsInRva2VuSWQiOm51bGwsImlkIjoyNzQsImVuYWJsZWQiOnRydWUsImF1dGhvcml0aWVzIjpbXSwidXNlcm5hbWUiOiJyb290In19.2ORWzw7-bq9KOewMKPwF2vaHDWAyj0YCGMb6BXLu1Yo","tokenExpiredDate":"2022-03-04T02:05:15.709+00:00","userName":"root","fullName":"nam","phoneNumber":"12132143"}
/// timestamp : "21-01-2022 10:05:18"

class ResponseMessage {
  ResponseMessage({
    this.status,
    this.code,
    this.message,
    this.data,
    this.data2,
    this.dataUser,
    this.dataStory,
    this.dataBool = false,
    this.timestamp,
  });

  ResponseMessage.fromJson(dynamic json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    timestamp = json['timestamp'];
  }

  ResponseMessage.fromJsonDataString(dynamic json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data2 = json['data'];
    timestamp = json['timestamp'];
  }

  ResponseMessage.fromJsonDataInt(dynamic json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    dataCount = json['data'];
    timestamp = json['timestamp'];
  }

  ResponseMessage.fromJsonDataBool(dynamic json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    dataBool = json['data'];
    timestamp = json['timestamp'];
  }

  ResponseMessage.fromJsonDataDiff(dynamic json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    timestamp = json['timestamp'];
  }

  ResponseMessage.fromJsonDataStory(dynamic json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    dataStory = Story.fromJson(json['data']);
    timestamp = json['timestamp'];
  }

  ResponseMessage.fromJsonDataUser(dynamic json) {
    status = json['status'];
    code = json['code'];
    dataUser = UserModel.fromJson(json['data']);
    timestamp = json['timestamp'];
  }

  dynamic status;
  int? code;
  String? message;
  String? data2;
  int? dataCount;
  bool? dataBool;
  Data? data;
  Story? dataStory;
  String? timestamp;
  UserModel? dataUser;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['code'] = code;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['data'] = data2;
    map['data'] = dataStory;
    map['data'] = dataBool;
    map['timestamp'] = timestamp;
    return map;
  }
}

/// deleted : false
/// enabled : false
/// userId : 274
/// osDevice : "adroid"
/// regPushNotification : "ross"
/// token : "eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NDYzNTk1MTUsInVzZXIiOnsicGFzc3dvcmQiOiIkMmEkMTAkMmRNUGZHOGdLMVoxNlRVamZIMFdnT1N2XC9xUWtIZUFqWlN3T3BBSm16aFRXZHFcL0NCT1RidSIsInRva2VuSWQiOm51bGwsImlkIjoyNzQsImVuYWJsZWQiOnRydWUsImF1dGhvcml0aWVzIjpbXSwidXNlcm5hbWUiOiJyb290In19.2ORWzw7-bq9KOewMKPwF2vaHDWAyj0YCGMb6BXLu1Yo"
/// tokenExpiredDate : "2022-03-04T02:05:15.709+00:00"
/// userName : "root"
/// fullName : "nam"
/// phoneNumber : "12132143"

class Data {
  Data({
    this.deleted,
    this.enabled,
    this.userId,
    this.osDevice,
    this.regPushNotification,
    this.token,
    this.tokenExpiredDate,
    this.userName,
    this.fullName,
    this.phoneNumber,
  });

  Data.fromJson(dynamic json) {
    deleted = json['deleted'];
    enabled = json['enabled'];
    userId = json['userId'];
    osDevice = json['osDevice'];
    regPushNotification = json['regPushNotification'];
    token = json['token'];
    tokenExpiredDate = json['tokenExpiredDate'];
    userName = json['userName'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
  }
  bool? deleted;
  bool? enabled;
  int? userId;
  String? osDevice;
  String? regPushNotification;
  String? token;
  String? tokenExpiredDate;
  String? userName;
  String? fullName;
  String? phoneNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['deleted'] = deleted;
    map['enabled'] = enabled;
    map['userId'] = userId;
    map['osDevice'] = osDevice;
    map['regPushNotification'] = regPushNotification;
    map['token'] = token;
    map['tokenExpiredDate'] = tokenExpiredDate;
    map['userName'] = userName;
    map['fullName'] = fullName;
    map['phoneNumber'] = phoneNumber;
    return map;
  }
}
