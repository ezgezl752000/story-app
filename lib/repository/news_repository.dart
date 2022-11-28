import 'package:ns_read_story/model/news_model.dart';
import 'package:ns_read_story/repository/repository.dart';

import '../api/response_model/http_response.dart';


class NewsRepository extends Repository {
  Future<HttpResponseApi<List<NewsCategory>>> getListCategoryNews() async {
    HttpResponseApi<List<NewsCategory>> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/news-category").then((res) {
      response.code = res.statusCode;
      final List<NewsCategory> list = [];
      for (var e in res.data['data']['content']) {
        list.add(NewsCategory.fromJson(e));
      }
      response.data = list;
      response.message = res.statusMessage;
    }).catchError((e) {
      print("ssssssssssssssssss$e");
      response.code = 500;
      response.dataError = e;
      response.message = "Server Error";
    });
    return Future.value(response);
  }

  Future<HttpResponseApi<List<News>>> getListNewsByCategory(String idCategory) async {
    HttpResponseApi<List<News>> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/news/cate/$idCategory").then((res) {
      response.code = res.statusCode;
      final List<News> list = [];
      for (var e in res.data['data']['content']) {
        list.add(News.fromJson(e));
      }
      response.data = list;
      response.message = res.statusMessage;
    }).catchError((e) {
      print("ssssssssssssssssss$e");
      response.code = 500;
      response.dataError = e;
      response.message = "Server Error";
    });
    return Future.value(response);
  }
}