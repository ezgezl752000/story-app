class NewsCategory {
  NewsCategory({
    this.id,
    this.deleted,
    this.enabled,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.thumbnail,
    this.name,
    this.parentId,
  });

  String? id;
  bool? deleted;
  bool? enabled;
  String? createdAt;
  String? updatedAt;
  dynamic createdBy;
  dynamic updatedBy;
  String? thumbnail;
  String? name;
  dynamic parentId;

  factory NewsCategory.fromJson(Map<String, dynamic> json) => NewsCategory(
        id: json["id"],
        deleted: json["deleted"],
        enabled: json["enabled"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        thumbnail: json["thumbnail"],
        name: json["name"],
        parentId: json["parentId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "deleted": deleted,
        "enabled": enabled,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "thumbnail": thumbnail,
        "name": name,
        "parentId": parentId,
      };
}

class News {
  News({
    this.id,
    this.deleted,
    this.enabled,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.description,
    this.title,
    this.content,
    this.thumbnail,
    this.categoryId,
    this.newsCategory,
  });

  String? id;
  bool? deleted;
  bool? enabled;
  String? createdAt;
  String? updatedAt;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic description;
  String? title;
  String? content;
  String? thumbnail;
  String? categoryId;
  NewsCategory? newsCategory;

  factory News.fromJson(Map<String, dynamic> json) => News(
        id: json["id"],
        deleted: json["deleted"],
        enabled: json["enabled"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        description: json["description"],
        title: json["title"],
        content: json["content"],
        thumbnail: json["thumbnail"],
        categoryId: json["categoryId"],
        newsCategory: NewsCategory.fromJson(json["newsCategory"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "deleted": deleted,
        "enabled": enabled,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "description": description,
        "title": title,
        "content": content,
        "thumbnail": thumbnail,
        "categoryId": categoryId,
        "newsCategory": newsCategory?.toJson(),
      };
}
