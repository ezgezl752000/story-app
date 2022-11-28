import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ResponseInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    // TODO: implement onError
    super.onError(err, handler);
    // if (err.type == DioErrorType.connectTimeout) {
    //   EasyLoading.showError(
    //       "Không thể kết nối tới máy chủ,\n vui lòng thử lại");
    // }

    // else if (err.type == DioErrorType.receiveTimeout) {
    //   EasyLoading.showError("Kết nối mạng kém,\n vui lòng thử lại");
    // } else
    if (err.type == DioErrorType.response) {
      if (err.response!.statusCode == 406) {

        EasyLoading.showError("Phiên đăng nhập hết hạn, vui lòng đăng nhập lại");
      }
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // TODO: implement onResponse

    if (response.statusCode == 406 || response.statusCode == 401) {
      // if (AppProvider.instance.limitAgain <= 3) {
      //   AppProvider.instance.limitAgain ++;
      //   await checkLogin(response, handler);
      // }
    } else {
      handler.next(response);
    }
  }
  //
  // Future checkLogin(
  //     Response response, ResponseInterceptorHandler handler) async {
  //   await Future.delayed(const Duration(milliseconds: 1000));
  //   String timeNow = DateFormat("yyyy/MM/dd HH:mm:ss").format(DateTime.now());
  //   String username = PreferenceManager.getString(PreferenceManager.username);
  //   String password = PreferenceManager.getString(PreferenceManager.password);
  //   if (username.isNotEmpty && password.isNotEmpty) {
  //     LoginRequest loginRequest = LoginRequest()
  //       ..email = null
  //       ..username = username
  //       ..password =
  //           MyTools.getMd5(timeNow + password + AppConfig.PRIVATE_SALT) +
  //               "@$timeNow"
  //       ..expiration = AppConfig.expiration
  //       ..deviceInfo = DeviceInfo(
  //         appId: AppConfig.appId,
  //         appVersion: AppConfig.app_version,
  //         deviceId: AppProvider.instance.deviceID,
  //         deviceType: AppConfig.checkDeviceType(),
  //         notificationToken: AppProvider.instance.firebaseToken,
  //       );
  //     HttpResponseApi<LoginResponse> result = HttpResponseApi();
  //     await ResClient.instance.dio
  //         .post("/api/auth/login", data: jsonEncode(loginRequest))
  //         .then((res) async {
  //       result.statusCode = res.statusCode;
  //       result.data = LoginResponse.fromJson(res.data);
  //       result.message = res.statusMessage;
  //       if (result.data?.accessToken != null) {
  //         if (result.data!.accessToken!.isNotEmpty) {
  //           // set limit về 0
  //           AppProvider.instance.limitAgain = 0;
  //           final String token = result.data?.accessToken ?? "";
  //           await PreferenceManager.setToken(token);
  //         }
  //       }
  //       final responseLogin =
  //           await ResClient.instance.dio.fetch(response.requestOptions);
  //       handler.next(responseLogin);
  //     }).catchError((e) {
  //       EasyLoading.showError("Error login");
  //       result.statusCode = 500;
  //       result.dataError = e;
  //       result.message = "Server Error";
  //     });
  //   } else {
  //     EasyLoading.showError("Error");
  //   }
  // }
}
