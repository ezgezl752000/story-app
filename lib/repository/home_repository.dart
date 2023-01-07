import 'package:ns_read_story/model/config.dart';
import 'package:ns_read_story/model/story.dart';
import 'package:ns_read_story/repository/repository.dart';

import '../api/response_model/http_response.dart';
import '../model/category_model.dart';
import '../model/home_model.dart';
import '../ultils/app_config.dart';

class HomeRepository extends Repository{


  Future<HttpResponseApi<HomeModel>> getHome() async {
    HttpResponseApi<HomeModel> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/home").then((res) {
      response.code = res.statusCode;
      HomeModel homeModel = HomeModel.fromJson(res.data['data']);
      response.data = homeModel;
      response.message = res.statusMessage;
    }).catchError((e) {
      print("ssssssssssssssssss$e");
      response.code = 500;
      response.dataError = e;
      response.message = "Server Error";
    });
    return Future.value(response);
  }

  // Future<HttpResponseApi<List<Config>>> getConfig() async {
  //   HttpResponseApi<List<Config>> response = HttpResponseApi();
  //   await dioHelper!.get("/api/v1/config").then((res) {
  //     response.code = res.statusCode;
  //     List<Config> list = [];
  //     for (var e in res.data['data']) {
  //       list.add(Config.fromJson(e));
  //     }
  //     AppConfig.policy = list.where((e) => e.id == 'POLICY').first.value ??'';
  //     AppConfig.urlImage = list.where((e) => e.id == 'URL_FILE').first.value ?? '';
  //     response.data = list;
  //     response.message = res.statusMessage;
  //   }).catchError((e) {
  //     response.code = 500;
  //     response.dataError = e;
  //     response.message = "Server Error";
  //   });
  //   return Future.value(response);
  // }


  Future<HttpResponseApi<List<Categories>>> getListCategory() async {
    HttpResponseApi<List<Categories>> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/category").then((res) {
      response.code = res.statusCode;
      List<Categories> list = [];
      for (var e in res.data) {
        list.add(Categories.fromJson(e));
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

  Future<HttpResponseApi<List<Story>>> getListStorySuggest() async {
    HttpResponseApi<List<Story>> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/books/trend").then((res) {
      response.code = res.statusCode;
      List<Story> list = [];
      for (var e in res.data['data']['content']) {
        list.add(Story.fromJson(e));
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



}