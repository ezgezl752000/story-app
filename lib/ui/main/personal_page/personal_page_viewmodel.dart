import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ns_read_story/base/base_view_model.dart';
import 'package:ns_read_story/model/story.dart';
import 'package:ns_read_story/model/number_follow.dart';
import 'package:ns_read_story/repository/personal_repository.dart';
import 'package:ns_read_story/ultils/global_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../shared/dialog.dart';

class PersonalPageViewModel extends BaseViewModel {
  PersonalRepository personalRepository;
  List<Story> listStory = [];
  NumberFollow? follow;
  int page = 0;
  int size = 10;
  bool isLastPage = false;
  ScrollController scrollController = ScrollController();
  RefreshController refreshController = RefreshController();

  bool? showBackButton;
  bool isAgreePolicy = false;

  PersonalPageViewModel({required this.personalRepository, this.showBackButton})
      : super(personalRepository) {
    getData();
    getNumberFollow();
  }
  getData() async {
    setLoading = true;
    final response = await personalRepository
        .getListStorys(AppProvider.instance.user.id ?? '');
    if (response.code == 200 && response.data != null) {
      listStory = response.data as List<Story>;
      setLoading = false;
      // getListForum();
      notifyListeners();
    }
  }

  changeNotify() {
    notifyListeners();
  }

  agreePolicy() {
    isAgreePolicy = !isAgreePolicy;
    notifyListeners();
  }

  authorRegister(BuildContext context) async {
    final res = await personalRepository.authorRegis();
    if (res.code == 200 && res.data != null) {
      AppProvider.instance.isAuthor = true;
      Navigator.of(context).pop();
      EasyLoading.showSuccess('Đăng ký thành công');
    } else {
      EasyLoading.showError('Đăng ký thất bại');
    }
  }

  getNumberFollow() async {
    final res =
        await personalRepository.getNumberFollow(AppProvider.instance.user.id!);
    if (res.code == 200 && res.data != null) {
      follow = res.data as NumberFollow;
      notifyListeners();
    }
  }

  deleteStory(String id) async {
    final res = await personalRepository.deleteStory(id);
    if (res.code == 200) {
      getData();      
    } else {
      EasyLoading.showError("Xoá thất bại");
    }
  }
}
