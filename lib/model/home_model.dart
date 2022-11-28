
import 'package:ns_read_story/model/author.dart';
import 'package:ns_read_story/model/category_model.dart';
import 'package:ns_read_story/model/detail_story.dart';

/// listBanner : [{"id":"1","deleted":false,"enabled":true,"createdAt":null,"updatedAt":null,"createdBy":null,"updatedBy":null,"thumbnail":"/story/banner1.jpg","title":"Tiêu đề"},{"id":"2","deleted":false,"enabled":true,"createdAt":null,"updatedAt":null,"createdBy":null,"updatedBy":null,"thumbnail":"/story/banner1.jpg","title":"Tiêu đề 1"}]
/// listHot : [{"id":"6218900bebd065d693baa724","deleted":false,"enabled":true,"createdAt":null,"updatedAt":"2022-02-27T07:43:35.705+0000","createdBy":null,"updatedBy":null,"name":"Tân Tây Du Ký","author":"Nguyễn Văn A","categories":[{"id":"62188a27ebd065d693baa4fc","deleted":false,"enabled":true,"createdAt":null,"updatedAt":null,"createdBy":null,"updatedBy":null,"thumbnail":"/story/kiao.svg","name":"Kỳ ảo","parentId":null}],"lastChapterId":null,"lastChapterTitle":null,"rateMark":0.0,"status":"Chưa hoàn thành","translator":false,"trend":false,"followNum":0,"viewNum":0,"completed":false,"":null,"tags":null,"warning":null,"description":null,"showAds":0,"thumbnail":"/story/t2.jpeg","totalOfMonth":1,"totalOfDay":0,"totalOfYear":0,"totalView":0},{"id":"6218904debd065d693baa744","deleted":false,"enabled":true,"createdAt":null,"updatedAt":"2022-02-26T18:00:00.074+0000","createdBy":null,"updatedBy":null,"name":"Call me your name","author":"Nguyễn Văn B","categories":[null],"lastChapterId":null,"lastChapterTitle":null,"rateMark":0.0,"status":"Chưa hoàn thành","translator":false,"trend":false,"followNum":0,"viewNum":0,"completed":false,"":null,"tags":null,"warning":null,"description":null,"showAds":0,"thumbnail":"/story/t1.jpeg","totalOfMonth":0,"totalOfDay":0,"totalOfYear":0,"totalView":0},{"id":"621990211cc67f4dcfeb4ee7","deleted":false,"enabled":true,"createdAt":"2022-02-26T02:27:45.833+0000","updatedAt":"2022-02-26T18:00:00.080+0000","createdBy":null,"updatedBy":null,"name":"Truyện lung tung","author":null,"categories":[],"lastChapterId":null,"lastChapterTitle":null,"rateMark":0.0,"status":null,"translator":false,"trend":true,"followNum":0,"viewNum":0,"completed":false,"":"1","tags":null,"warning":"Truyện ngắn là một thể loại văn học. Nó thường là các câu chuyện kể bằng văn xuôi và có xu hướng ngắn gọn, súc tích và hàm nghĩa hơn các câu truyện dài như tiểu thuyết. Thông thường truyện ngắn có độ dài chỉ từ vài dòng đến vài chục trang, trong khi đó tiểu thuyết rất khó dừng lại ở con số đó.","description":null,"showAds":0,"thumbnail":"/story/t4.jpeg","totalOfMonth":0,"totalOfDay":0,"totalOfYear":0,"totalView":0},{"id":"621a5ff5f83b2d24a3dc663d","deleted":false,"enabled":false,"createdAt":"2022-02-26T17:14:29.156+0000","updatedAt":"2022-02-26T18:00:00.085+0000","createdBy":null,"updatedBy":null,"name":"Truyện lung tung","author":null,"categories":[],"lastChapterId":null,"lastChapterTitle":null,"rateMark":0.0,"status":null,"translator":false,"trend":false,"followNum":0,"viewNum":0,"completed":false,"":"1","tags":null,"warning":null,"description":"Truyện ngắn là một thể loại văn học.","showAds":0,"thumbnail":"https://cdn.pixabay.com/photo/2022/01/20/08/16/man-6951711_960_720.png","totalOfMonth":0,"totalOfDay":0,"totalOfYear":0,"totalView":0},{"id":"621a65c6e2908f2ae34be7c9","deleted":false,"enabled":false,"createdAt":"2022-02-26T17:39:18.397+0000","updatedAt":"2022-02-26T18:00:00.091+0000","createdBy":null,"updatedBy":null,"name":"Truyện lung tung","author":null,"categories":[],"lastChapterId":null,"lastChapterTitle":null,"rateMark":0.0,"status":null,"translator":false,"trend":false,"followNum":0,"viewNum":0,"completed":false,"":"1","tags":null,"warning":null,"description":"Truyện ngắn là một thể loại văn học.","showAds":0,"thumbnail":"https://cdn.pixabay.com/photo/2022/01/20/08/16/man-6951711_960_720.png","totalOfMonth":0,"totalOfDay":0,"totalOfYear":0,"totalView":0},{"id":"621a677ee2908f2ae34be7ca","deleted":false,"enabled":false,"createdAt":"2022-02-26T17:46:38.970+0000","updatedAt":"2022-02-26T18:00:00.096+0000","createdBy":null,"updatedBy":null,"name":"Truyện lung tung","author":null,"categories":[],"lastChapterId":null,"lastChapterTitle":null,"rateMark":0.0,"status":null,"translator":false,"trend":true,"followNum":0,"viewNum":0,"completed":false,"":"1","tags":null,"warning":null,"description":"Truyện ngắn là một thể loại văn học.","showAds":0,"thumbnail":"https://cdn.pixabay.com/photo/2022/01/20/08/16/man-6951711_960_720.png","totalOfMonth":0,"totalOfDay":0,"totalOfYear":0,"totalView":0},{"id":"621b2d446cd1926019412998","deleted":false,"enabled":true,"createdAt":"2022-02-27T07:50:28.828+0000","updatedAt":"2022-02-27T07:50:28.828+0000","createdBy":null,"updatedBy":null,"name":"Truyện lung tung","author":null,"categories":[null],"lastChapterId":null,"lastChapterTitle":null,"rateMark":0.0,"status":null,"translator":false,"trend":false,"followNum":0,"viewNum":0,"completed":false,"":"1","tags":null,"warning":null,"description":"Truyện ngắn là một thể loại văn học.","showAds":0,"thumbnail":"https://cdn.pixabay.com/photo/2022/01/20/08/16/man-6951711_960_720.png","totalOfMonth":0,"totalOfDay":0,"totalOfYear":0,"totalView":0}]
/// listNew : [{"id":"6218900bebd065d693baa724","deleted":false,"enabled":true,"createdAt":null,"updatedAt":"2022-02-27T07:43:35.705+0000","createdBy":null,"updatedBy":null,"name":"Tân Tây Du Ký","author":"Nguyễn Văn A","categories":[{"id":"62188a27ebd065d693baa4fc","deleted":false,"enabled":true,"createdAt":null,"updatedAt":null,"createdBy":null,"updatedBy":null,"thumbnail":"/story/kiao.svg","name":"Kỳ ảo","parentId":null}],"lastChapterId":null,"lastChapterTitle":null,"rateMark":0.0,"status":"Chưa hoàn thành","translator":false,"trend":false,"followNum":0,"viewNum":0,"completed":false,"":null,"tags":null,"warning":null,"description":null,"showAds":0,"thumbnail":"/story/t2.jpeg","totalOfMonth":1,"totalOfDay":0,"totalOfYear":0,"totalView":0},{"id":"6218904debd065d693baa744","deleted":false,"enabled":true,"createdAt":null,"updatedAt":"2022-02-26T18:00:00.074+0000","createdBy":null,"updatedBy":null,"name":"Call me your name","author":"Nguyễn Văn B","categories":[null],"lastChapterId":null,"lastChapterTitle":null,"rateMark":0.0,"status":"Chưa hoàn thành","translator":false,"trend":false,"followNum":0,"viewNum":0,"completed":false,"":null,"tags":null,"warning":null,"description":null,"showAds":0,"thumbnail":"/story/t1.jpeg","totalOfMonth":0,"totalOfDay":0,"totalOfYear":0,"totalView":0},{"id":"621990211cc67f4dcfeb4ee7","deleted":false,"enabled":true,"createdAt":"2022-02-26T02:27:45.833+0000","updatedAt":"2022-02-26T18:00:00.080+0000","createdBy":null,"updatedBy":null,"name":"Truyện lung tung","author":null,"categories":[],"lastChapterId":null,"lastChapterTitle":null,"rateMark":0.0,"status":null,"translator":false,"trend":true,"followNum":0,"viewNum":0,"completed":false,"":"1","tags":null,"warning":"Truyện ngắn là một thể loại văn học. Nó thường là các câu chuyện kể bằng văn xuôi và có xu hướng ngắn gọn, súc tích và hàm nghĩa hơn các câu truyện dài như tiểu thuyết. Thông thường truyện ngắn có độ dài chỉ từ vài dòng đến vài chục trang, trong khi đó tiểu thuyết rất khó dừng lại ở con số đó.","description":null,"showAds":0,"thumbnail":"/story/t4.jpeg","totalOfMonth":0,"totalOfDay":0,"totalOfYear":0,"totalView":0},{"id":"621a5ff5f83b2d24a3dc663d","deleted":false,"enabled":false,"createdAt":"2022-02-26T17:14:29.156+0000","updatedAt":"2022-02-26T18:00:00.085+0000","createdBy":null,"updatedBy":null,"name":"Truyện lung tung","author":null,"categories":[],"lastChapterId":null,"lastChapterTitle":null,"rateMark":0.0,"status":null,"translator":false,"trend":false,"followNum":0,"viewNum":0,"completed":false,"":"1","tags":null,"warning":null,"description":"Truyện ngắn là một thể loại văn học.","showAds":0,"thumbnail":"https://cdn.pixabay.com/photo/2022/01/20/08/16/man-6951711_960_720.png","totalOfMonth":0,"totalOfDay":0,"totalOfYear":0,"totalView":0},{"id":"621a65c6e2908f2ae34be7c9","deleted":false,"enabled":false,"createdAt":"2022-02-26T17:39:18.397+0000","updatedAt":"2022-02-26T18:00:00.091+0000","createdBy":null,"updatedBy":null,"name":"Truyện lung tung","author":null,"categories":[],"lastChapterId":null,"lastChapterTitle":null,"rateMark":0.0,"status":null,"translator":false,"trend":false,"followNum":0,"viewNum":0,"completed":false,"":"1","tags":null,"warning":null,"description":"Truyện ngắn là một thể loại văn học.","showAds":0,"thumbnail":"https://cdn.pixabay.com/photo/2022/01/20/08/16/man-6951711_960_720.png","totalOfMonth":0,"totalOfDay":0,"totalOfYear":0,"totalView":0},{"id":"621a677ee2908f2ae34be7ca","deleted":false,"enabled":false,"createdAt":"2022-02-26T17:46:38.970+0000","updatedAt":"2022-02-26T18:00:00.096+0000","createdBy":null,"updatedBy":null,"name":"Truyện lung tung","author":null,"categories":[],"lastChapterId":null,"lastChapterTitle":null,"rateMark":0.0,"status":null,"translator":false,"trend":true,"followNum":0,"viewNum":0,"completed":false,"":"1","tags":null,"warning":null,"description":"Truyện ngắn là một thể loại văn học.","showAds":0,"thumbnail":"https://cdn.pixabay.com/photo/2022/01/20/08/16/man-6951711_960_720.png","totalOfMonth":0,"totalOfDay":0,"totalOfYear":0,"totalView":0},{"id":"621b2d446cd1926019412998","deleted":false,"enabled":true,"createdAt":"2022-02-27T07:50:28.828+0000","updatedAt":"2022-02-27T07:50:28.828+0000","createdBy":null,"updatedBy":null,"name":"Truyện lung tung","author":null,"categories":[null],"lastChapterId":null,"lastChapterTitle":null,"rateMark":0.0,"status":null,"translator":false,"trend":false,"followNum":0,"viewNum":0,"completed":false,"":"1","tags":null,"warning":null,"description":"Truyện ngắn là một thể loại văn học.","showAds":0,"thumbnail":"https://cdn.pixabay.com/photo/2022/01/20/08/16/man-6951711_960_720.png","totalOfMonth":0,"totalOfDay":0,"totalOfYear":0,"totalView":0}]

class HomeModel {
  HomeModel({
      this.listBanner, 
      this.listHot, 
      this.listCompleted,
      this.listNew,});

  HomeModel.fromJson(dynamic json) {
    if (json['listBanner'] != null) {
      listBanner = [];
      json['listBanner'].forEach((v) {
        listBanner?.add(ListBanner.fromJson(v));
      });
    }
    if (json['listHot'] != null) {
      listHot = [];
      json['listHot'].forEach((v) {
        listHot?.add(Story.fromJson(v));
      });
    }
    if (json['listNew'] != null) {
      listNew = [];
      json['listNew'].forEach((v) {
        listNew?.add(Story.fromJson(v));
      });
    }
    if (json['listCompleted'] != null) {
      listCompleted = [];
      json['listCompleted'].forEach((v) {
        listCompleted?.add(Story.fromJson(v));
      });
    }
  }
  List<ListBanner>? listBanner;
  List<Story>? listHot;
  List<Story>? listNew;
  List<Story>? listCompleted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (listBanner != null) {
      map['listBanner'] = listBanner?.map((v) => v.toJson()).toList();
    }
    if (listHot != null) {
      map['listHot'] = listHot?.map((v) => v.toJson()).toList();
    }
    if (listNew != null) {
      map['listNew'] = listNew?.map((v) => v.toJson()).toList();
    }
    if (listCompleted != null) {
      map['listCompleted'] = listCompleted?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "6218900bebd065d693baa724"
/// deleted : false
/// enabled : true
/// createdAt : null
/// updatedAt : "2022-02-27T07:43:35.705+0000"
/// createdBy : null
/// updatedBy : null
/// name : "Tân Tây Du Ký"
/// author : "Nguyễn Văn A"
/// categories : [{"id":"62188a27ebd065d693baa4fc","deleted":false,"enabled":true,"createdAt":null,"updatedAt":null,"createdBy":null,"updatedBy":null,"thumbnail":"/story/kiao.svg","name":"Kỳ ảo","parentId":null}]
/// lastChapterId : null
/// lastChapterTitle : null
/// rateMark : 0.0
/// status : "Chưa hoàn thành"
/// translator : false
/// trend : false
/// followNum : 0
/// viewNum : 0
/// completed : false
///  : null
/// tags : null
/// warning : null
/// description : null
/// showAds : 0
/// thumbnail : "/story/t2.jpeg"
/// totalOfMonth : 1
/// totalOfDay : 0
/// totalOfYear : 0
/// totalView : 0

class ListNew {
  ListNew({
      this.id, 
      this.deleted, 
      this.enabled, 
      this.createdAt, 
      this.updatedAt, 
      this.createdBy, 
      this.updatedBy, 
      this.name, 
      this.author, 
      this.categories, 
      this.lastChapterId, 
      this.lastChapterTitle, 
      this.rateMark, 
      this.status, 
      this.translator, 
      this.trend, 
      this.followNum, 
      this.viewNum, 
      this.completed,
      this.tags, 
      this.warning, 
      this.description, 
      this.showAds, 
      this.thumbnail, 
      this.totalOfMonth, 
      this.totalOfDay, 
      this.totalOfYear, 
      this.totalView,});

  ListNew.fromJson(dynamic json) {
    id = json['id'];
    deleted = json['deleted'];
    enabled = json['enabled'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    name = json['name'];
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }
    lastChapterId = json['lastChapterId'];
    lastChapterTitle = json['lastChapterTitle'];
    rateMark = json['rateMark'];
    status = json['status'];
    translator = json['translator'];
    trend = json['trend'];
    author =json['author'] == null ? null : Author.fromJson(json['author']);
    followNum = json['followNum'];
    viewNum = json['viewNum'];
    completed = json['completed'];
    tags = json['tags'];
    warning = json['warning'];
    description = json['description'];
    showAds = json['showAds'];
    thumbnail = json['thumbnail'];
    totalOfMonth = json['totalOfMonth'];
    totalOfDay = json['totalOfDay'];
    totalOfYear = json['totalOfYear'];
    totalView = json['totalView'];
  }
  String? id;
  bool? deleted;
  bool? enabled;
  dynamic createdAt;
  String? updatedAt;
  dynamic createdBy;
  dynamic updatedBy;
  String? name;
  Author? author;
  List<Categories>? categories;
  dynamic lastChapterId;
  dynamic lastChapterTitle;
  double? rateMark;
  String? status;
  bool? translator;
  bool? trend;
  int? followNum;
  int? viewNum;
  bool? completed;
  dynamic tags;
  dynamic warning;
  dynamic description;
  int? showAds;
  String? thumbnail;
  int? totalOfMonth;
  int? totalOfDay;
  int? totalOfYear;
  int? totalView;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['deleted'] = deleted;
    map['enabled'] = enabled;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['name'] = name;
    map['author'] = author;
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    map['lastChapterId'] = lastChapterId;
    map['lastChapterTitle'] = lastChapterTitle;
    map['rateMark'] = rateMark;
    map['status'] = status;
    map['translator'] = translator;
    map['trend'] = trend;
    map['followNum'] = followNum;
    map['viewNum'] = viewNum;
    map['completed'] = completed;
    map['tags'] = tags;
    map['warning'] = warning;
    map['description'] = description;
    map['showAds'] = showAds;
    map['thumbnail'] = thumbnail;
    map['totalOfMonth'] = totalOfMonth;
    map['totalOfDay'] = totalOfDay;
    map['totalOfYear'] = totalOfYear;
    map['totalView'] = totalView;
    return map;
  }

}



/// id : "1"
/// deleted : false
/// enabled : true
/// createdAt : null
/// updatedAt : null
/// createdBy : null
/// updatedBy : null
/// thumbnail : "/story/banner1.jpg"
/// title : "Tiêu đề"

class ListBanner {
  ListBanner({
      this.id, 
      this.deleted, 
      this.enabled, 
      this.createdAt, 
      this.updatedAt, 
      this.createdBy, 
      this.updatedBy, 
      this.thumbnail, 
      this.title,});

  ListBanner.fromJson(dynamic json) {
    id = json['id'];
    deleted = json['deleted'];
    enabled = json['enabled'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    thumbnail = json['thumbnail'];
    title = json['title'];
  }
  String? id;
  bool? deleted;
  bool? enabled;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic createdBy;
  dynamic updatedBy;
  String? thumbnail;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['deleted'] = deleted;
    map['enabled'] = enabled;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['createdBy'] = createdBy;
    map['updatedBy'] = updatedBy;
    map['thumbnail'] = thumbnail;
    map['title'] = title;
    return map;
  }

}