import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ns_read_story/api/response_model/response_message.dart';
import 'package:ns_read_story/model/detail_chapter.dart';
import 'package:ns_read_story/model/number_follow.dart';
import 'package:ns_read_story/model/user.dart';
import 'package:ns_read_story/repository/repository.dart';
import 'package:ns_read_story/ultils/global_bloc.dart';

import '../api/request_model/update_info_request.dart';
import '../api/response_model/http_response.dart';
import '../model/category_model.dart';
import '../model/detail_story.dart';

class PersonalRepository extends Repository {
  Future<HttpResponseApi<List<Story>>> getListStorys(String userID) async {
    HttpResponseApi<List<Story>> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/books/user/$userID", queryParameters: {
      "size": 9999999,
      "page": "0",
    }).then((res) {
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

  Future<ResponseMessage> uploadFile(FormData data) async {
    ResponseMessage response = ResponseMessage();
    await dioHelper!.post('/api/v1/upload-file', data: data).then((res) {
      response = ResponseMessage.fromJsonDataString(res.data);
    });
    return Future.value(response);
  }

  Future<HttpResponseApi<Story>> getDetailStory(String idBook) async {
    HttpResponseApi<Story> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/books/$idBook").then((res) {
      response.code = res.statusCode;
      Story detailStory = Story.fromJson(res.data['data']);
      response.data = detailStory;
      response.message = res.statusMessage;
    }).catchError((e) {
      response.code = 500;
      response.dataError = e;
      response.message = "Server Error";
    });
    return Future.value(response);
  }

  Future<HttpResponseApi<List<Chapter>>> getListChapter(
      String idBook, int page) async {
    HttpResponseApi<List<Chapter>> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/chapter/book/$idBook", queryParameters: {
      "page": page,
    }).then((res) {
      response.code = res.statusCode;
      List<Chapter> list = [];
      for (var e in res.data['data']['content']) {
        list.add(Chapter.fromJson(e));
      }
      response.data = list;
      response.isLastPage = res.data['data']['last'];

      response.message = res.statusMessage;
    }).catchError((e) {
      response.code = 500;
      response.dataError = e;
      response.message = "Server Error";
    });
    return Future.value(response);
  }

  Future<ResponseMessage> addChapter(
      String bookId, String name, String content, double price) async {
    ResponseMessage response = ResponseMessage();
    await dioHelper!.post("/api/v1//chapter", data: {
      "bookId": bookId,
      "name": name,
      "content": content,
      "price": price,
    }).then((res) {
      response = ResponseMessage.fromJsonDataDiff(res.data);
    });
    return Future.value(response);
  }

  Future<ResponseMessage> createStory(Story story) async {
    ResponseMessage response = ResponseMessage();
    await dioHelper!.post("/api/v1/books", data: {
      "name": story.name,
      "description": story.description,
      "thumbnail": story.thumbnail,
      "userId": AppProvider.instance.user.id,
      "artist": AppProvider.instance.user.fullName,
      "translator": story.translator,
      "categories": story.categories,
      "completed": story.completed,
    }).then((res) {
      response = ResponseMessage.fromJsonDataStory(res.data);
    });
    return Future.value(response);
  }

  Future<ResponseMessage> updateStory(Story story) async {
    ResponseMessage response = ResponseMessage();
    await dioHelper!.put("/api/v1/books", data: {
      "id": story.id,
      "name": story.name,
      "description": story.description,
      "thumbnail": story.thumbnail,
      "userId": AppProvider.instance.user.id,
      "artist": AppProvider.instance.user.fullName,
      "translator": story.translator,
      "categories": story.categories,
      "completed": story.completed,
    }).then((res) {
      response = ResponseMessage.fromJsonDataDiff(res.data);
    });
    return Future.value(response);
  }

  Future<ResponseMessage> editChapter(String idChapter, String bookId,
      String name, String content, double price) async {
    ResponseMessage response = ResponseMessage();
    await dioHelper!.put("/api/v1/chapter", data: {
      "id": idChapter,
      "bookId": bookId,
      "name": name,
      "content": content,
      "price": price,
    }).then((res) {
      response = ResponseMessage.fromJsonDataDiff(res.data);
    });
    return Future.value(response);
  }

  Future<ResponseMessage> deleteChapter(String idChapter) async {
    ResponseMessage response = ResponseMessage();
    await dioHelper!.delete("/api/v1/chapter/$idChapter").then((res) {
      response = ResponseMessage.fromJsonDataString(res.data);
    });
    return Future.value(response);
  }

  Future<HttpResponseApi<Chapter>> getDetailChapter(String idChapter) async {
    HttpResponseApi<Chapter> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/chapter/$idChapter").then((res) {
      response.code = res.statusCode;
      Chapter detailChapter = Chapter.fromJson(res.data['data']);
      response.data = detailChapter;
      response.message = res.statusMessage;
    }).catchError((e) {
      response.code = 500;
      response.dataError = e;
      response.message = "Server Error";
    });
    return Future.value(response);
  }

  Future<HttpResponseApi<UserModel>> authorRegis() async {
    HttpResponseApi<UserModel> response = HttpResponseApi();
    await dioHelper!.post("/api/v1/users/registerAuthor", queryParameters: {
      'id': AppProvider.instance.user.id,
    }).then((res) {
      UserModel user = UserModel.fromJson(res.data['data']);
      AppProvider.instance.user = user;
      AppProvider.instance.isAuthor =
          user.listRole?.map((e) => e.id).toList().contains('AUTHOR');
      print('>>>>>>>>>>${AppProvider.instance.isAuthor}');
      response.code = res.statusCode;
      response.data = user;
      response.message = res.statusMessage;
    }).catchError((e) {
      response.code = 500;
      response.dataError = e;
      response.message = "Server Error";
    });
    return Future.value(response);
  }

  Future<ResponseMessage> deleteStory(String idBook) async {
    ResponseMessage response = ResponseMessage();
    await dioHelper!.delete("/api/v1/books/$idBook").then((res) {
      response = ResponseMessage.fromJsonDataString(res.data);
    });
    return Future.value(response);
  }

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

  Future<HttpResponseApi> updateInfo(
      UpdateInfoRequest updateInfoRequest) async {
    HttpResponseApi response = HttpResponseApi();
    await dioHelper!
        .put("/api/v1/users", data: json.encode(updateInfoRequest))
        .then((res) {
      response.code = res.statusCode;
      response.data = res.data;
      response.message = res.statusMessage;
    }).catchError((e) {
      response.code = 500;
      response.dataError = e;
      response.message = "Server Error";
    });
    return Future.value(response);
  }

  Future<HttpResponseApi<NumberFollow>> getNumberFollow(String idUser) async {
    HttpResponseApi<NumberFollow> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/user-follow/count",
        queryParameters: {"userId": idUser}).then((res) {
      response.code = res.statusCode;
      response.data = NumberFollow.fromJson(res.data['data']);
      response.message = res.statusMessage;
    }).catchError((e) {
      response.code = 500;
      response.dataError = e;
      response.message = "Server Error";
    });
    return Future.value(response);
  }

  Future<ResponseMessage> logOut() async {
    ResponseMessage response = ResponseMessage();
    await dioHelper!.get("/api/v1/users/logout/${AppProvider.instance.user.id}").then((res) {
      response = ResponseMessage.fromJsonDataString(res.data);
    });
    return Future.value(response);
  }

}
