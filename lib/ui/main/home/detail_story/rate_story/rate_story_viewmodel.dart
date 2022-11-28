import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ns_read_story/model/detail_story.dart';
import 'package:ns_read_story/model/rate_story.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../base/base_view_model.dart';
import '../../../../../repository/story_repository.dart';
import '../../../../../ultils/global_bloc.dart';

class RateStoryViewModel extends BaseViewModel {
  StoryRepository storyRepository;
  TextEditingController reviewContentController = TextEditingController();
  String status = 'Hay';
  Story detailStory;
  String ratePoint = '4';
  int page = 0;
  int size = 10;
  bool isLastPage = false;
  List<RateStory> listRateStory = [];
  RefreshController refreshRateController = RefreshController();
  ScrollController scrollController = ScrollController();

  RateStoryViewModel({required this.storyRepository, required this.detailStory})
      : super(storyRepository) {
    loadMoreRatePage();
    getListRateStory(detailStory.id ?? '');
  }
  onRefreshRate() {
    page = 0;
    getListRateStory(detailStory.id ?? '');
    refreshRateController.refreshCompleted();
  }

  changeStatus(int rating) {
    ratePoint = rating.toString();
    switch (rating) {
      case 1:
        status = 'Rất tệ';
        break;
      case 2:
        status = 'Tệ';
        break;
      case 3:
        status = 'Bình thường';
        break;
      case 4:
        status = 'Hay';
        break;
      case 5:
        status = 'Rất hay';
        break;
    }
    notifyListeners();
  }

  rateStory(BuildContext context) async {
    if (listRateStory.indexWhere(
            (element) => element.userId == AppProvider.instance.user.id) >=
        0) {
      EasyLoading.showError('Bạn đã đánh giá truyện này rồi');
    } else {
      final res = await storyRepository.rateStory(
          detailStory.id ?? '', ratePoint, reviewContentController.text);
      if (res.code == 200 && res.data != null) {
        EasyLoading.showSuccess('Đánh giá thành công');
        getListRateStory(detailStory.id ?? '');
        reviewContentController.clear();
        ratePoint = '4';
      } else {
        EasyLoading.showError('Đánh giá thất bại');
      }
    }
  }

  getListRateStory(String idBook) async {
    final res = await storyRepository.getListRateStory(idBook, page, size);
    if (res.code == 200 && res.data != null) {
      listRateStory = res.data as List<RateStory>;
      isLastPage = res.isLastPage ?? false;
      storyRepository.getDetailStory(idBook).then((value) {
        detailStory = value.data as Story;
        notifyListeners();
      });
      notifyListeners();
    }
  }

  loadMoreRatePage() async {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!isLastPage) {
          page++;
          final res = await storyRepository.getListRateStory(
              detailStory.id ?? '', page, size);
          if (res.code == 200 && res.data != null) {
            listRateStory.addAll(res.data as List<RateStory>);
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
