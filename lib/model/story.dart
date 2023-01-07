import 'package:hive/hive.dart';
import 'package:ns_read_story/model/author.dart';
import 'package:ns_read_story/model/category_model.dart';
import 'package:ns_read_story/model/chapter.dart';

/// id : "6218900bebd065d693baa724"
/// deleted : false
/// enabled : true
/// updatedAt : "2022-02-26T18:00:00.041+0000"
/// name : "Tân Tây Du Ký"
/// artist : "Nguyễn Văn A"
/// categories : [{"id":"62188a27ebd065d693baa4fc","deleted":false,"enabled":true,"createdAt":null,"updatedAt":null,"createdBy":null,"updatedBy":null,"thumbnail":"/story/kiao.svg","name":"Kỳ ảo","parentId":null}]
/// rateMark : 0.0
/// status : "Chưa hoàn thành"
/// translator : false
/// trend : false
/// followNum : 0
/// viewNum : 0
/// completed : false
/// showAds : 0
/// thumbnail : "/story/t2.jpeg"
/// totalOfMonth : 1
/// totalOfDay : 0
/// totalOfYear : 0
/// totalView : 0
/// chapters : [{"id":"62189fc6ebd065d693baaf09","deleted":false,"enabled":true,"createdAt":null,"updatedAt":null,"createdBy":null,"updatedBy":null,"name":"Chương 1","content":"Nội dung bla bla bla","showAds":null,"isNew":null,"price":0,"bookId":"6218900bebd065d693baa724"}]
part 'story.g.dart';

@HiveType(typeId: 0)
class Story extends HiveObject {
  Story({
    this.id,
    this.deleted,
    this.enabled,
    this.updatedAt,
    this.name,
    this.categories,
    this.rateMark,
    this.rateCount,
    this.status,
    this.description,
    this.translator,
    this.trend,
    this.author,
    this.followNum,
    this.completed,
    this.showAds,
    this.thumbnail,
    this.totalOfMonth,
    this.totalOfDay,
    this.totalOfYear,
    this.likeNum,
    this.totalView,
    this.chapterNum,
    this.chapterEnableNum,
    this.chapters,
  });

  Story.fromJson(dynamic json) {
    id = json['id'];
    deleted = json['deleted'] ?? false;
    enabled = json['enabled'];
    updatedAt = json['updatedAt'];
    name = json['name'];
    author = json['author'] == null ? null : Author.fromJson(json['author']);
    description = json['description'];
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }
    rateMark = json['rateMark'];
    completed = json['completed'];
    rateCount = json['rateCount'];
    status = json['status'];
    translator = json['translator'];
    trend = json['trend'];
    followNum = json['followNum'];
    completed = json['completed'];
    showAds = json['showAds'];
    thumbnail = json['thumbnail'];
    totalOfMonth = json['totalOfMonth'];
    totalOfDay = json['totalOfDay'];
    totalOfYear = json['totalOfYear'];
    totalView = json['totalView'];
    likeNum = json['likeNum'];
    chapterNum = json['chapterNum'];
    chapterEnableNum = json['chapterEnableNum'];
    if (json['chapters'] != null) {
      chapters = [];
      json['chapters'].forEach((v) {
        chapters?.add(Chapter.fromJson(v));
      });
    }
  }
  @HiveField(0)
  String? id;

  @HiveField(1)
  bool? deleted;

  @HiveField(2)
  bool? enabled;

  @HiveField(3)
  String? updatedAt;

  @HiveField(4)
  String? name;

  @HiveField(5)
  List<Categories>? categories;

  @HiveField(6)
  double? rateMark;

  int? rateCount;

  @HiveField(7)
  String? status;

  @HiveField(8)
  String? description;

  @HiveField(9)
  bool? translator;

  @HiveField(10)
  bool? trend;

  @HiveField(11)
  int? followNum;

  @HiveField(12)
  bool? completed;

  @HiveField(13)
  int? showAds;

  @HiveField(14)
  String? thumbnail;

  @HiveField(15)
  int? totalOfMonth;

  @HiveField(16)
  int? totalOfDay;

  @HiveField(17)
  int? totalOfYear;

  @HiveField(18)
  int? totalView;

  @HiveField(19)
  Author? author;

  @HiveField(20)
  List<Chapter>? chapters;

  @HiveField(21)
  int? likeNum;

  @HiveField(22)
  int? chapterNum;

  @HiveField(23)
  int? chapterEnableNum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['deleted'] = deleted;
    map['enabled'] = enabled;
    map['updatedAt'] = updatedAt;
    map['name'] = name;
    map['description'] = description;
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    map['rateMark'] = rateMark;
    map['rateCount'] = rateCount;
    map['status'] = status;
    map['translator'] = translator;
    map['trend'] = trend;
    map['followNum'] = followNum;
    map['completed'] = completed;
    map['showAds'] = showAds;
    map['thumbnail'] = thumbnail;
    map['totalOfMonth'] = totalOfMonth;
    map['totalOfDay'] = totalOfDay;
    map['author'] = author;
    map['totalOfYear'] = totalOfYear;
    map['totalView'] = totalView;
    map['likeNum'] = likeNum;
    map['chapterNum'] = chapterNum;
    map['chapterEnableNum'] = chapterEnableNum;
    if (chapters != null) {
      map['chapters'] = chapters?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
