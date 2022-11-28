import 'dart:convert';
import 'package:ns_read_story/api/request_model/login_request.dart';
import 'package:ns_read_story/api/response_model/http_response.dart';
import 'package:ns_read_story/api/response_model/response_message.dart';
import 'package:ns_read_story/model/attend_model.dart';
import 'package:ns_read_story/model/config.dart';
import 'package:ns_read_story/model/notification_model.dart';
import 'package:ns_read_story/model/user.dart';
import 'package:ns_read_story/repository/repository.dart';
import 'package:ns_read_story/ultils/app_config.dart';
import 'package:ns_read_story/ultils/global_bloc.dart';
import 'package:ns_read_story/ultils/pref_data.dart';

class UserRepository extends Repository {
  Future<ResponseMessage>  login(LoginRequest loginRequest) async {
    ResponseMessage response = ResponseMessage();
    await dioHelper!
        .post("/api/v1/users/login", data: jsonEncode(loginRequest))
        .then((res) async {
      response = ResponseMessage.fromJsonDataString(res.data);
      await getInfoUser(response.data2 ?? '');
      await getConfig();
      if (response.code == 200) {
        await PreferenceManager.setToken(response.data2 ?? '');
      }
    }).catchError((e) {
      response.code = 500;
      response.message = "Server Error";
    });
    return Future.value(response);
  }

  Future<HttpResponseApi<List<Config>>> getConfig() async {
    HttpResponseApi<List<Config>> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/config").then((res) async {
      response.code = res.statusCode;
      List<Config> list = [];
      for (var e in res.data['data']) {
        list.add(Config.fromJson(e));
      }
      AppConfig.policy = list.where((e) => e.id == 'POLICY').first.value ?? '';
      AppConfig.version = list.where((e) => e.id == 'VERSION').first.value ?? '';
      AppConfig.urlImage = list.where((e) => e.id == 'URL_FILE').first.value ?? '';

      response.data = list;
      response.message = res.statusMessage;
    }).catchError((e) {
      response.code = 500;
      response.dataError = e;
      response.message = "Server Error";
    });
    return Future.value(response);
  }

  Future<HttpResponseApi<UserModel>> getInfoUser(String token) async {
    HttpResponseApi<UserModel> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/users/token/$token").then((res) async {
      response.code = res.statusCode;
      UserModel user = UserModel();
      user = UserModel.fromJson(res.data['data']);
      AppProvider.instance.user = user;
      AppProvider.instance.isAuthor =
          user.listRole?.map((e) => e.id).toList().contains('AUTHOR');
      // await getCountNotificationUnRead();
      response.data = user;
      response.message = res.statusMessage;
    }).catchError((e) {
      response.code = 500;
      response.dataError = e;
      response.message = "Server Error";
    });
    return Future.value(response);
  }

  Future<ResponseMessage> forgotPass(
      String username, String newPass, String tokenOtp) async {
    ResponseMessage response = ResponseMessage();
    await dioHelper!.post("/api/v1/users/forgot", queryParameters: {
      "username": username,
      "password": newPass,
      "token": tokenOtp
    }).then((res) {
      response = ResponseMessage.fromJsonDataString(res.data);
    });
    return Future.value(response);
  }

  Future<ResponseMessage> createAccount(String username, String fullName,
      int gender, String birthDate, String pass, String tagName) async {
    ResponseMessage response = ResponseMessage();
    await dioHelper!.post("/api/v1/register", data: {
      "username": username,
      "fullName": fullName,
      "gender": gender,
      "birthDate": birthDate,
      "password": pass,
      "tagName": tagName,
    }).then((res) {
      response = ResponseMessage.fromJsonDataString(res.data);
    });
    return Future.value(response);
  }

  Future<ResponseMessage> checkExistUser(String username) async {
    ResponseMessage response = ResponseMessage();
    await dioHelper!.get("/api/v1/existUser", queryParameters: {
      "username": username,
    }).then((res) {
      response = ResponseMessage.fromJsonDataBool(res.data);
    });
    return Future.value(response);
  }

  Future<ResponseMessage> changePassword(String oldPass, String newPass) async {
    ResponseMessage response = ResponseMessage();
    await dioHelper!.post("/api/v1/users/pass", data: {
      "id": AppProvider.instance.user.id,
      "oldPass": oldPass,
      "newPass": newPass
    }).then((res) {
      response = ResponseMessage.fromJsonDataString(res.data);
    });
    return Future.value(response);
  }

  Future<ResponseMessage> loginFbGg(LoginRequest loginRequest) async {
    ResponseMessage response = ResponseMessage();
    await dioHelper!.post("/api/v1/loginExtend", data: {
      "username": loginRequest.username,
      "fullName": loginRequest.fullName,
      "phoneNumber": '',
      "gender": 1,
      "birthDate": '',
      "tokenFirebase": loginRequest.tokenFirebase,
      "password": '',
      "avatarUrl": loginRequest.avatarUrl,
      "tagName": loginRequest.tagName,
    }).then((res) async {
      response = ResponseMessage.fromJsonDataString(res.data);
      await getInfoUser(response.data2 ?? '');
      await getConfig();
      if (response.code == 200) {
        await PreferenceManager.setToken(response.data2 ?? '');
      }
    });
    return Future.value(response);
  }

  Future<HttpResponseApi<List<NotificationModel>>> getListNotification(
      int page, int size) async {
    HttpResponseApi<List<NotificationModel>> response = HttpResponseApi();
    await dioHelper!.get(
        "/api/v1/notification/user/${AppProvider.instance.user.id}",
        queryParameters: {
          'page': page,
          'size': size,
          'sort': 'createdAt,desc'
        }).then((res) {
      response.code = res.statusCode;
      response.isLastPage = res.data['data']['last'];
      final List<NotificationModel> list = [];
      for (var e in res.data['data']['content']) {
        NotificationModel notification = NotificationModel.fromJson(e);
        list.add(notification);
      }
      response.data = list;
      response.message = res.statusMessage;
    }).catchError((e) {
      response.code = 500;
      response.dataError = e;
      response.message = "Server Error";
    });
    return Future.value(response);
  }

  Future<ResponseMessage> readNotification(String id) async {
    ResponseMessage response = ResponseMessage();
    await dioHelper!.get("/api/v1/notification/read/$id").then((res) {
      response = ResponseMessage.fromJsonDataString(res.data);
    });
    return Future.value(response);
  }

  // Future<ResponseMessage> getCountNotificationUnRead() async {
  //   // dell
  //   ResponseMessage response = ResponseMessage();
  //   await dioHelper!
  //       .get("/api/v1/notification/unread/${AppProvider.instance.user.id}")
  //       .then((res) {
  //     response = ResponseMessage.fromJsonDataInt(res.data);
  //     AppProvider.instance.countNotificationUnRead = response.dataCount ?? 0;
  //   });
  //   return Future.value(response);
  // }

  Future<ResponseMessage> resetCountNotification() async {
    ResponseMessage response = ResponseMessage();
    await dioHelper!
        .get("/api/v1/users/notification/${AppProvider.instance.user.id}")
        .then((res) {
      response = ResponseMessage.fromJsonDataUser(res.data);
      if (response.code == 200) {
        AppProvider.instance.user.notificationCount =
            response.dataUser!.notificationCount ?? 0;
      }
    });
    return Future.value(response);
  }

  Future<HttpResponseApi<List<AttendModel>>> getListDayAttended() async {
    HttpResponseApi<List<AttendModel>> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/attendance",
        queryParameters: {"userId": AppProvider.instance.user.id}).then((res) {
      response.code = res.statusCode;
      final List<AttendModel> list = [];
      for (var e in res.data['data']) {
        list.add(AttendModel.fromJson(e));
      }
      response.data = list;
      response.message = res.statusMessage;
    }).catchError((e) {
      response.code = 500;
      response.dataError = e;
      response.message = "Server Error";
    });
    return Future.value(response);
  }

  Future<HttpResponseApi<AttendModel>> setAttended() async {
    HttpResponseApi<AttendModel> response = HttpResponseApi();
    await dioHelper!.post("/api/v1/attendance").then((res) {
      response.code = res.statusCode;
      response.data = AttendModel.fromJson(res.data['data']);
      response.message = res.statusMessage;
    }).catchError((e) {
      response.code = 500;
      response.dataError = e;
      response.message = "Đã điểm danh";
    });
    return Future.value(response);
  }

  Future<HttpResponseApi<ResponseMessage>> viewAds() async {
    HttpResponseApi<ResponseMessage> response = HttpResponseApi();
    await dioHelper!.post("/api/v1/viewAds").then((res) {
      response.code = res.statusCode;
      response.data = ResponseMessage.fromJson(res.data);
      response.message = res.statusMessage;
    }).catchError((e) {
      response.code = 500;
      response.dataError = e;
      response.message = "Lỗi hệ thống";
    });
    return Future.value(response);
  }
}
