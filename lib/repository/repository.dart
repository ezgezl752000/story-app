import 'package:dio/dio.dart';
import 'package:ns_read_story/api/res_client.dart';

class Repository {
  Dio? dioHelper;
  Dio? dioHelperFile;

  Repository() {
    dioHelper = ResClient.instance.dio;
  }
  
}
