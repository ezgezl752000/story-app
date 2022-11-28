/// id : "62189fd7ebd065d693baaf27"
/// name : "Chương 2"
/// showAds : null
/// isNew : null
/// price : 0
/// bookId : "6218900bebd065d693baa724"
/// totalView : 0
/// enabled : true
/// updatedAt : "2022-05-12T06:57:49.040+0000"
/// totalComment : 7
/// nextChapterId : null
/// previousChapterId : "62189fc6ebd065d693baaf09"

class InfoChapter {
  InfoChapter({
    this.id,
    this.name,
    this.showAds,
    this.isNew,
    this.price,
    this.bookId,
    this.totalView,
    this.enabled,
    this.updatedAt,
    this.isBuy,
    this.nextChapterId,
    this.previousChapterId,
    this.content,
  });

  InfoChapter.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    showAds = json['showAds'];
    isNew = json['isNew'];
    price = json['price'];
    bookId = json['bookId'];
    totalView = json['totalView'];
    enabled = json['enabled'];
    updatedAt = json['updatedAt'];
    nextChapterId = json['nextChapterId'];
    previousChapterId = json['previousChapterId'];
    isBuy = json['isBuy'];
    content = json['content'];
  }

  String? id;
  String? name;
  dynamic showAds;
  dynamic isNew;
  double? price;
  bool? isBuy;
  String? bookId;
  int? totalView;
  bool? enabled;
  String? updatedAt;
  String? nextChapterId;
  String? previousChapterId;
  String? content;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['showAds'] = showAds;
    map['isNew'] = isNew;
    map['price'] = price;
    map['bookId'] = bookId;
    map['totalView'] = totalView;
    map['enabled'] = enabled;
    map['updatedAt'] = updatedAt;
    map['nextChapterId'] = nextChapterId;
    map['isBuy'] = isBuy;
    map['previousChapterId'] = previousChapterId;
    map['content'] = content;
    return map;
  }
}
