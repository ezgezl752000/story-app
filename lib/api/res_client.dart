
import 'package:dio/dio.dart';
import 'package:ns_read_story/ultils/app_config.dart';
import 'package:ns_read_story/ultils/handler_response.dart';
import 'package:ns_read_story/ultils/pref_data.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ResClient {
  static final BaseOptions _options = BaseOptions(
    baseUrl: AppConfig.BASE_URL,
    connectTimeout: 5000,
    receiveTimeout: 10000,
    validateStatus: (status) {
      return status! <= 500;
    },
  );
  static final Dio _dio = Dio(_options);

  ResClient._internal() {
    _dio.interceptors.add(
      PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 1000),
    );
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await PreferenceManager.getToken();
        if (token != null && irgoreTokenPath(options.path)) {
          options.headers["Authorization"] = "Bearer " + token;
        }
        handler.next(options);
      },
    ));
    _dio.interceptors.add(ResponseInterceptor());

  }

  irgoreTokenPath(String path) {
    return !path.contains('login');
  }

  static final ResClient instance = ResClient._internal();

  Dio get dio => _dio;
}
