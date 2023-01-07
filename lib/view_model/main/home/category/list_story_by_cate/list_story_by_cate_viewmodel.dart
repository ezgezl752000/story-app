import 'package:flutter/cupertino.dart';
import 'package:ns_read_story/base/base_view_model.dart';
import 'package:ns_read_story/model/story.dart';
import 'package:ns_read_story/repository/story_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../model/category_model.dart';

class ListStoryByCateViewModel extends BaseViewModel {
  StoryRepository storyRepository;
  String idCateSelected;
  String nameCateSelected;
  List<Categories> listCategory = [];
  List<Story> listStory = [];
  ListStoryByCateViewModel(
      {required this.storyRepository,
      required this.idCateSelected,
      required this.nameCateSelected})
      : super(storyRepository) {
    getData();
    scrollController.addListener(loadMoreStory);
  }
  ScrollController scrollController = ScrollController();
  RefreshController refreshController = RefreshController();
  int page = 0;
  int size = 20;
  bool isLastPage = false;

  void selectCate(String id, String name) async {
    idCateSelected = id;
    nameCateSelected = name;
    getListStory();
    notifyListeners();
  }

  getData() async {
    setLoading = true;
    await getListCate();
    await getListStory();
    setLoading = false;
  }

  getListCate() async {
    final res = await storyRepository.getListCategory();
    if (res.code == 200 && res.data != null) {
      listCategory = res.data as List<Categories>;
    }

    notifyListeners();
  }

  getListStory() async {
    final res2 =
        await storyRepository.getListStoryByCate(idCateSelected, page, size);
    if (res2.code == 200 && res2.data != null) {
      isLastPage = res2.isLastPage ?? false;
      listStory = res2.data as List<Story>;
    }
    notifyListeners();
  }

  onRefresh() {
    page = 0;
    getListStory();
    refreshController.refreshCompleted();
  }

  loadMoreStory() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (!isLastPage) {
        page++;
        final res = await storyRepository.getListStoryByCate(
            idCateSelected, page, size);
        if (res.code == 200 && res.data != null) {
          listStory.addAll(res.data as List<Story>);
          isLastPage = res.isLastPage ?? false;
        }
        notifyListeners();
      }
    }
  }
}
