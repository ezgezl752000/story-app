import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ns_read_story/base/base_view_model.dart';
import 'package:ns_read_story/model/story.dart';
import 'package:ns_read_story/model/number_follow.dart';
import 'package:ns_read_story/model/user.dart';
import 'package:ns_read_story/repository/story_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../shared/dialog.dart';

class DetailUserViewModel extends BaseViewModel {
  StoryRepository storyRepository;
  String idUser;
  NumberFollow? follow;
  bool isFollowUser = false;
  List<Story> listStory = [];

  UserModel? user;

  int page = 0;
  int size = 10;
  bool isLastPage = false;
  RefreshController refreshController = RefreshController();
  ScrollController scrollController = ScrollController();

  DetailUserViewModel({required this.storyRepository, required this.idUser})
      : super(storyRepository) {
    getUser();
    checkFollow();
    getListStoryByUser();
    getNumberFollow();
  }

  getUser() async {
    final res = await storyRepository.getDetailUser(idUser);
    if (res.code == 200) {
      user = res.data as UserModel;
    }
    notifyListeners();
  }

  followUser() async {
    final res = await storyRepository.followUser(idUser);
    if (res.code == 200) {
      checkFollow();
    }
  }

  getNumberFollow() async {
    final res = await storyRepository.getNumberFollow(idUser);
    if (res.code == 200 && res.data != null) {
      follow = res.data as NumberFollow;
      notifyListeners();
    }
  }

  unFollowUser() async {
    final res = await storyRepository.unFollowUser(idUser);
    if (res.code == 200) {
      checkFollow();
    }
  }

  checkFollow() async {
    final res = await storyRepository.checkFollowedUser(idUser);
    if (res.code == 200) {
      isFollowUser = res.dataBool ?? false;
      getNumberFollow();
    }
    notifyListeners();
  }

  getListStoryByUser() async {
    final res = await storyRepository.getListStoryByUser(idUser);
    if (res.code == 200) {
      listStory = res.data as List<Story>;
      listStory.removeWhere((element) => element.enabled == false);
    }
    notifyListeners();
  }
}
