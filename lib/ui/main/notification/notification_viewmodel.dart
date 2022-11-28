import 'package:flutter/cupertino.dart';
import 'package:ns_read_story/base/base_view_model.dart';
import 'package:ns_read_story/model/notification_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../repository/user_repository.dart';

class NotificationViewModel extends BaseViewModel {
  UserRepository userRepository;
  int page = 0;
  int size = 10;
  bool isLastPage = false;
  List<NotificationModel> listNotification = [];
  ScrollController scrollController = ScrollController();
  RefreshController refreshController = RefreshController(initialRefresh: true);
  NotificationViewModel({required this.userRepository})
      : super(userRepository) {
    loadMoreNotification();
    getListNotification();
  }

  getListNotification() async {
    final res = await userRepository.getListNotification(page, size);
    if (res.code == 200 && res.data != null) {
      listNotification = res.data as List<NotificationModel>;
      isLastPage = res.isLastPage ?? false;
    }
    notifyListeners();
  }

  onRefresh() async {
    page = 0;
    getListNotification();
    resetCountNotification();
    refreshController.refreshCompleted();
  }

  resetCountNotification() async {
    await userRepository.resetCountNotification();
  }


  loadMoreNotification() async {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!isLastPage) {
          page++;
          final res = await userRepository.getListNotification(page, size);
          if (res.code == 200 && res.data != null) {
            listNotification.addAll(res.data as List<NotificationModel>);
            isLastPage = res.isLastPage ?? false;
          }
          notifyListeners();
        } else {
          print('>>>>>>>>>> last page');
        }
      }
    });
  }
}
