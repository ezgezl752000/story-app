import 'package:ns_read_story/model/detail_chapter.dart';
import 'package:ns_read_story/model/detail_story.dart';

/// id : "621b557d8831936eeca30205"
/// deleted : false
/// enabled : true
/// createdAt : "2022-02-27T10:42:05.581+0000"
/// updatedAt : "2022-02-27T14:06:28.687+0000"
/// userId : "6214a45022a276270c039ee0"
/// bookId : "6218900bebd065d693baa724"
/// chapterId : "62189fc6ebd065d693baaf09"
/// chapter : {"id":"62189fc6ebd065d693baaf09","deleted":false,"enabled":true,"createdAt":null,"updatedAt":null,"createdBy":null,"updatedBy":null,"name":"Chương 1","content":"Nội dung bla bla bla","showAds":null,"isNew":null,"price":0,"bookId":"6218900bebd065d693baa724","totalView":0}
/// bookInfo : {"id":"6218900bebd065d693baa724","deleted":false,"enabled":true,"createdAt":null,"updatedAt":"2022-02-27T13:29:00.941+0000","createdBy":null,"updatedBy":null,"name":"Tân Tây Du Ký","author":"Nguyễn Văn A","categories":[{"id":"62188a27ebd065d693baa4fc","deleted":false,"enabled":true,"createdAt":null,"updatedAt":null,"createdBy":null,"updatedBy":null,"thumbnail":"/story/kiao.svg","name":"Kỳ ảo","parentId":null}],"lastChapterId":null,"lastChapterTitle":null,"rateMark":0.0,"status":"Chưa hoàn thành","translator":false,"trend":false,"followNum":0,"viewNum":0,"completed":false,"artist":null,"userId":null,"tags":null,"warning":null,"description":null,"showAds":0,"thumbnail":"/story/t2.jpeg","totalOfMonth":1,"totalOfDay":0,"totalOfYear":0,"totalView":0,"chapters":[{"id":"62189fc6ebd065d693baaf09","deleted":false,"enabled":true,"createdAt":null,"updatedAt":null,"createdBy":null,"updatedBy":null,"name":"Chương 1","content":"Nội dung bla bla bla","showAds":null,"isNew":null,"price":0,"bookId":"6218900bebd065d693baa724","totalView":0}]}

class StoryHistory {
  StoryHistory({
      this.id, 
      this.deleted, 
      this.enabled, 
      this.createdAt, 
      this.updatedAt, 
      this.userId, 
      this.bookId, 
      this.chapterId, 
      this.chapter, 
      this.bookInfo,});

  StoryHistory.fromJson(dynamic json) {
    id = json['id'];
    deleted = json['deleted'];
    enabled = json['enabled'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
    bookId = json['bookId'];
    chapterId = json['chapterId'];
    chapter = json['chapter'] != null ? Chapter.fromJson(json['chapter']) : null;
    bookInfo = json['bookInfo'] != null ? Story.fromJson(json['bookInfo']) : null;
  }
  String? id;
  bool? deleted;
  bool? enabled;
  String? createdAt;
  String? updatedAt;
  String? userId;
  String? bookId;
  String? chapterId;
  Chapter? chapter;
  Story? bookInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['deleted'] = deleted;
    map['enabled'] = enabled;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['userId'] = userId;
    map['bookId'] = bookId;
    map['chapterId'] = chapterId;
    if (chapter != null) {
      map['chapter'] = chapter?.toJson();
    }
    if (bookInfo != null) {
      map['bookInfo'] = bookInfo?.toJson();
    }
    return map;
  }

}
