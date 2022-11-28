import 'package:dio/dio.dart';
import 'package:ns_read_story/api/response_model/response_message.dart';
import 'package:ns_read_story/model/detail_chapter.dart';
import 'package:ns_read_story/model/follow_model.dart';
import 'package:ns_read_story/model/info_chapter.dart';
import 'package:ns_read_story/model/number_follow.dart';
import 'package:ns_read_story/model/story_history.dart';
import 'package:ns_read_story/model/user.dart';
import 'package:ns_read_story/repository/repository.dart';

import '../api/response_model/http_response.dart';
import '../model/category_model.dart';
import '../model/detail_story.dart';
import '../model/rate_story.dart';
import '../ultils/app_config.dart';
import '../ultils/global_bloc.dart';

class StoryRepository extends Repository {
  Future<HttpResponseApi<Story>> getDetailStory(String idBook) async {
    HttpResponseApi<Story> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/books/$idBook").then((res) {
      response.code = res.statusCode;
      Story detailStory = Story.fromJson(res.data['data']);
      response.data = detailStory;
      response.message = res.statusMessage;
    });
    return Future.value(response);
  }

  Future<HttpResponseApi<InfoChapter>> getInfoChapter(
      String idBook, String idChapter) async {
    HttpResponseApi<InfoChapter> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/chapter/$idChapter/book/$idBook").then((res) {
      response.code = res.statusCode;
      InfoChapter detailStory = InfoChapter.fromJson(res.data['data']);
      response.data = detailStory;
      response.message = res.statusMessage;
    });
    return Future.value(response);
  }

  Future<HttpResponseApi<List<RateStory>>> getListRateStory(
      String idBook, int page, int size) async {
    HttpResponseApi<List<RateStory>> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/books/$idBook/rate", queryParameters: {
      'page': page,
      'size': size,
      "sort": "createdAt,desc",
    }).then((res) async {
      response.code = res.statusCode;
      final List<RateStory> list = [];
      for (var e in res.data['data']['content']) {
        RateStory rate = RateStory.fromJson(e);
        list.add(rate);
      }
      response.data = list;
      response.message = res.statusMessage;
      response.isLastPage = res.data['data']['last'];
    }).catchError((e) {
      response.code = 500;
      response.dataError = e;
      response.message = "Server Error";
    });
    return Future.value(response);
  }

  Future<HttpResponseApi<RateStory>> rateStory(
      String idBook, String ratePoint, String content) async {
    HttpResponseApi<RateStory> response = HttpResponseApi();
    await dioHelper!.post("/api/v1/books/$idBook/rate/add", data: {
      "bookId": idBook,
      "userId": AppProvider.instance.user.id,
      "ratePoint": ratePoint,
      "content": content
    }).then((res) {
      response.code = res.statusCode;
      RateStory rateData = RateStory.fromJson(res.data);
      response.data = rateData;
      response.message = res.statusMessage;
    }).catchError((e) {
      response.code = 500;
      response.dataError = e;
      response.message = "Server Error";
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

  Future<HttpResponseApi<List<Chapter>>> getListChapterCheckToken(
      String idBook, int page, int size) async {
    HttpResponseApi<List<Chapter>> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/chapter/book/enable/v2/$idBook",
        queryParameters: {"page": page, "size": size}).then((res) {
      response.code = res.statusCode;
      List<Chapter> list = [];
      for (var e in res.data['data']['content']) {
        list.add(Chapter.fromJson(e));
      }
      response.isLastPage = res.data['data']['last'];
      response.page = res.data['data']['number'];
      response.data = list;
      response.message = res.statusMessage;
    }).catchError((e) {
      response.code = 500;
      response.dataError = e;
      response.message = "Server Error";
    });
    return Future.value(response);
  }

  Future<HttpResponseApi<List<Chapter>>> getListChapter(
      String idBook, int page, int size) async {
    HttpResponseApi<List<Chapter>> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/chapter/book/enable/$idBook",
        queryParameters: {"page": page, "size": size}).then((res) {
      response.code = res.statusCode;
      List<Chapter> list = [];
      for (var e in res.data['data']['content']) {
        list.add(Chapter.fromJson(e));
      }
      response.isLastPage = res.data['data']['last'];
      response.page = res.data['data']['number'];
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

  Future<HttpResponseApi<Chapter>> getDetailChapterView(
      String idChapter) async {
    HttpResponseApi<Chapter> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/chapter/view/$idChapter").then((res) {
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

  Future<HttpResponseApi<List<Story>>> getListStoryHot() async {
    HttpResponseApi<List<Story>> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/books/top",
        queryParameters: {"size": 20, "type": "totalView"}).then((res) {
      response.code = res.statusCode;
      List<Story> list = [];
      for (var e in res.data['data']) {
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

  Future<HttpResponseApi<List<Story>>> getListStoryByCate(
      String idCate, int page, int size) async {
    HttpResponseApi<List<Story>> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/books/cate/$idCate",
        queryParameters: {"size": size, "page": page}).then((res) {
      response.code = res.statusCode;
      List<Story> list = [];
      for (var e in res.data['data']['content']) {
        list.add(Story.fromJson(e));
      }
      response.isLastPage = res.data['data']['last'];
      response.data = list;
      response.message = res.statusMessage;
    }).catchError((e) {
      response.code = 500;
      response.dataError = e;
      response.message = "Server Error";
    });
    return Future.value(response);
  }

  Future<HttpResponseApi<List<Story>>> getListStoryNew() async {
    HttpResponseApi<List<Story>> response = HttpResponseApi();
    await dioHelper!
        .get("/api/v1/books/newst?sort=createdAt,desc&sort=0")
        .then((res) {
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

  Future<HttpResponseApi<List<Story>>> getListStoryCompleted() async {
    HttpResponseApi<List<Story>> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/books/completed").then((res) {
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

  Future<HttpResponseApi<List<StoryHistory>>> getListStoryViewed() async {
    HttpResponseApi<List<StoryHistory>> response = HttpResponseApi();
    await dioHelper!
        .get("/api/v1/history/user/${AppProvider.instance.user.id}")
        .then((res) {
      response.code = res.statusCode;
      List<StoryHistory> list = [];
      for (var e in res.data['data']['content']) {
        list.add(StoryHistory.fromJson(e));
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

  Future<HttpResponseApi<List<StoryHistory>>> getListStoryFollowed() async {
    HttpResponseApi<List<StoryHistory>> response = HttpResponseApi();
    await dioHelper!
        .get("/api/v1/book-follow/user/${AppProvider.instance.user.id}")
        .then((res) {
      response.code = res.statusCode;
      List<StoryHistory> list = [];
      for (var e in res.data['data']['content']) {
        list.add(StoryHistory.fromJson(e));
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

  Future<ResponseMessage> followStory(String bookId) async {
    ResponseMessage response = ResponseMessage();
    await dioHelper!.post("/api/v1/book-follow", data: {
      "userId": AppProvider.instance.user.id,
      "bookId": bookId,
    }).then((res) {
      response = ResponseMessage.fromJsonDataDiff(res.data);
    });
    return Future.value(response);
  }

  Future<ResponseMessage> unFollowStory(String bookId) async {
    ResponseMessage response = ResponseMessage();
    await dioHelper!.post("/api/v1/book-follow/delete", queryParameters: {
      "userId": AppProvider.instance.user.id,
      "bookId": bookId
    }).then((res) {
      response = ResponseMessage.fromJsonDataBool(res.data);
    });
    return Future.value(response);
  }

  Future<ResponseMessage> checkIsFollowedBool(String idBook) async {
    ResponseMessage response = ResponseMessage();
    await dioHelper!.get("/api/v1/book-follow/exist", queryParameters: {
      "userId": AppProvider.instance.user.id,
      "bookId": idBook
    }).then((res) {
      response = ResponseMessage.fromJsonDataBool(res.data);
    });
    return Future.value(response);
  }

  Future<HttpResponseApi<List<Story>>> getRanking(String type) async {
    HttpResponseApi<List<Story>> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/books/top",
        queryParameters: {"size": 20, "type": type}).then((res) {
      response.code = res.statusCode;
      List<Story> list = [];
      for (var e in res.data['data']) {
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

  Future<HttpResponseApi<List<Story>>> searchStory(String keySearch) async {
    HttpResponseApi<List<Story>> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/books/filter", queryParameters: {
      "size": 100,
      "name": keySearch,
      "sort": "createdAt,desc",
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

  Future<HttpResponseApi<List<UserModel>>> searchUser(String keySearch) async {
    HttpResponseApi<List<UserModel>> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/users/filter", queryParameters: {
      "size": 100,
      "name": keySearch,
      "sort": "createdAt,desc",
    }).then((res) {
      response.code = res.statusCode;
      List<UserModel> list = [];
      for (var e in res.data['data']['content']) {
        list.add(UserModel.fromJson(e));
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

  Future<ResponseMessage> likeChapter(String idChapter) async {
    ResponseMessage response = ResponseMessage();
    await dioHelper!.post("/api/v1/chapter-favorite/add", data: {
      "userId": AppProvider.instance.user.id,
      "chapterId": idChapter
    }).then((res) {
      response = ResponseMessage.fromJsonDataDiff(res.data);
    });
    return Future.value(response);
  }

  Future<ResponseMessage> checkIsLikedBool(String idChapter) async {
    ResponseMessage response = ResponseMessage();
    await dioHelper!.get("/api/v1/chapter-favorite/exist", queryParameters: {
      "userId": AppProvider.instance.user.id,
      "chapterId": idChapter
    }).then((res) {
      response = ResponseMessage.fromJsonDataBool(res.data);
    });
    return Future.value(response);
  }

  Future<HttpResponseApi<List<UserModel>>> getListAuthorRanking(
      bool isTranslator, String type) async {
    HttpResponseApi<List<UserModel>> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/users/top", queryParameters: {
      "isTranslator": isTranslator,
      "type": type,
      "size": "10"
    }).then((res) {
      response.code = res.statusCode;
      List<UserModel> list = [];
      for (var e in res.data['data']) {
        list.add(UserModel.fromJson(e));
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

  Future<HttpResponseApi<List<StoryHistory>>> getHistoryReadBook(
      String id, String? idBook) async {
    HttpResponseApi<List<StoryHistory>> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/history/book",
        queryParameters: {"userId": id, "bookId": idBook}).then((res) {
      response.code = res.statusCode;
      List<StoryHistory> list = [];
      for (var e in res.data['data']) {
        list.add(StoryHistory.fromJson(e));
      }
      response.data = list;
      response.message = res.statusMessage;
    }).catchError((e) {
      response.code = 500;
      response.dataError = e;
      response.message = "Server Error";
    });
    return response;
  }

  Future<HttpResponseApi<UserModel>> getDetailUser(String id) async {
    HttpResponseApi<UserModel> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/users/$id").then((res) {
      response.code = res.statusCode;
      response.data = UserModel.fromJson(res.data['data']);
      response.message = res.statusMessage;
    }).catchError((e) {
      response.code = 500;
      response.dataError = e;
      response.message = "Server Error";
    });
    return Future.value(response);
  }

  Future<HttpResponseApi<List<Story>>> getListStoryByUser(String userID) async {
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

  Future<ResponseMessage> checkFollowedUser(String idUser) async {
    ResponseMessage response = ResponseMessage();
    await dioHelper!.get("/api/v1/user-follow/exist", queryParameters: {
      "userId": AppProvider.instance.user.id,
      "userFollowedId": idUser,
    }).then((res) {
      response = ResponseMessage.fromJsonDataBool(res.data);
    });
    return Future.value(response);
  }

  Future<ResponseMessage> followUser(String idUser) async {
    ResponseMessage response = ResponseMessage();
    await dioHelper!.post("/api/v1/user-follow", data: {
      "userFollowingId": AppProvider.instance.user.id,
      "userFollowedId": idUser,
    }).then((res) {
      response = ResponseMessage.fromJsonDataDiff(res.data);
    });
    return Future.value(response);
  }

  Future<ResponseMessage> unFollowUser(String idUser) async {
    ResponseMessage response = ResponseMessage();
    await dioHelper!.post("/api/v1/user-follow/delete", queryParameters: {
      "userId": AppProvider.instance.user.id,
      "userFollowedId": idUser,
    }).then((res) {
      response = ResponseMessage.fromJsonDataDiff(res.data);
    });
    return Future.value(response);
  }

  Future<ResponseMessage> seenChapter(String bookId, String chapterId) async {
    ResponseMessage response = ResponseMessage();
    await dioHelper!.post("/api/v1/history", data: {
      "userId": AppProvider.instance.user.id,
      "bookId": bookId,
      "chapterId": chapterId
    }).then((res) {
      response = ResponseMessage.fromJsonDataDiff(res.data);
    });
    return Future.value(response);
  }

  Future<ResponseMessage> deleteHistory(String id) async {
    ResponseMessage response = ResponseMessage();
    await dioHelper!.delete("/api/v1/history/$id").then((res) {
      response = ResponseMessage.fromJsonDataDiff(res.data);
    });
    return Future.value(response);
  }

  Future<HttpResponseApi<List<FollowModel>>> getListFollow(
      {required bool isMyFollowed, required String userId}) async {
    HttpResponseApi<List<FollowModel>> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/user-follow/user", queryParameters: {
      "userId": userId,
      "follow": isMyFollowed
    }).then((res) {
      response.code = res.statusCode;
      List<FollowModel> list = [];
      for (var e in res.data['data']['content']) {
        list.add(FollowModel.fromJson(e));
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

  Future isShowDownloadStory() async {
    await dioHelper!.put("/api/v1/config/download/BTT_DOWNLOAD").then((res) {
      AppConfig.isShowDownload = res.data['data']['visible'] ?? false;
    });
    print(">>>>>>>>>>>show ${AppConfig.isShowDownload}");
  }

  Future<ResponseMessage> uploadImage(FormData data) async {
    ResponseMessage response = ResponseMessage();
    await dioHelper!.post('/api/v1/upload-file', data: data).then((res) {
      response = ResponseMessage.fromJsonDataString(res.data);
    });
    return Future.value(response);
  }

  Future<HttpResponseApi<List<Map<String, dynamic>>>> getListUserSuggest(
      String name) async {
    HttpResponseApi<List<Map<String, dynamic>>> response = HttpResponseApi();
    await dioHelper!.get("/api/v1/users/filter", queryParameters: {
      "sort": "createdAt,desc",
      "size": 10,
      "name": name
    }).then((res) {
      response.code = res.statusCode;
      final List<Map<String, dynamic>> list = [];
      for (var e in res.data['data']['content']) {
        list.add(e);
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
