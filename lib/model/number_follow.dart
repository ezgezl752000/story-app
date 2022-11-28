/// following : 1
/// followed : 1

class NumberFollow {
  NumberFollow({
      this.following, 
      this.followed,});

  NumberFollow.fromJson(dynamic json) {
    following = json['following'];
    followed = json['followed'];
  }
  int? following;
  int? followed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['following'] = following;
    map['followed'] = followed;
    return map;
  }

}