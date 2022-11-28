import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:ns_read_story/base/base_view_model.dart';
import 'package:ns_read_story/model/detail_chapter.dart';
import 'package:ns_read_story/model/detail_story.dart';
import 'package:ns_read_story/model/story_history.dart';
import 'package:ns_read_story/repository/story_repository.dart';
import 'package:ns_read_story/ultils/global_bloc.dart';

import '../../../../shared/dialog.dart';

class DetailStoryViewModel extends BaseViewModel {
  StoryRepository storyRepository;
  String? idBook = '';  
  int indexTab = 0;
  Story? detailStory;
  List<Chapter> listChapter = [];
  List<Story> listStory = [];
  bool isFollowed = false;
  List<StoryHistory>? listHistory = [];

  DetailStoryViewModel(
      {required this.storyRepository, required this.detailStory})
      : super(storyRepository) {
    idBook = detailStory!.id!;
    showDownloadStory();
    getHistoryReadBook();
    checkFollowed();
    getListChapter();
    getData();
  }

  int page = 0;
  int size = 20;
  bool canNextPage = false;
  bool canBackPage = false;
  int checkNumberPage=0;

  nextPage() {
    if (canNextPage) {
      page++;
      getListChapter();
    }
  }

  backPage() {
    if (canBackPage) {
      page--;
      getListChapter();
    }
  }

  getListChapter() async {
    final res = AppProvider.instance.token == null ? await storyRepository.getListChapter(idBook!, page, size) : await storyRepository.getListChapterCheckToken(idBook!, page, size);
    if (res.code == 200 && res.data != null) {
      listChapter = res.data as List<Chapter>;
      canBackPage = true;
      if (page == 0) canBackPage = false;
      canNextPage = res.isLastPage ?? false; // lastPage = true là trang cuối nếu là trang cuối thì không thể next page
      canNextPage = !canNextPage; // nếu lastPage = true thì canNextPage sẽ phải = false (ngược lại của lastPage)
      checkNumberPage = res.page ??0;
      print(">>>>>>>>>>>>> $checkNumberPage}");
    }
    notifyListeners();
  }

  showDownloadStory() async {
    await storyRepository.isShowDownloadStory();
    notifyListeners();
  }

  getData() async {
    final res = await Future.wait([
      storyRepository.getDetailStory(idBook!),
      storyRepository.getListStorySuggest(),
    ]);
    if (res[0].code == 200 && res[0].data != null) {
      detailStory = res[0].data as Story;
    }
    if (res[1].code == 200 && res[1].data != null) {
      listStory = res[1].data as List<Story>;
    }

    notifyListeners();
  }

  downloadStory() async {
    EasyLoading.show();
    final storyBox = Hive.box('story');
    var keyItem;
    storyBox.toMap().forEach((key, value) {
      if (value.id == detailStory!.id) {
        keyItem = key;
      }
    });
    storyBox.delete(keyItem);
    final Story? story = detailStory;
    story!.chapters?.removeWhere((e) => e.price!=0);
    storyBox.add(story);
    EasyLoading.dismiss();
    EasyLoading.showSuccess("Tải truyện thành công");
  }

  followStory() async {
    if (isFollowed) {
      await storyRepository.unFollowStory(idBook!);
    } else {
      await storyRepository.followStory(idBook!);
    }
    await checkFollowed();
    notifyListeners();
  }

  checkFollowed() async {
    final res = await storyRepository.checkIsFollowedBool(idBook!);
    if (res.code == 200) {
      isFollowed = res.dataBool!;
      getData();
    }
    notifyListeners();
  }

  void selectTab(int index) {
    indexTab = index;
    notifyListeners();
  }

  Future getHistoryReadBook() async {
    final response = await storyRepository.getHistoryReadBook(
        AppProvider.instance.user.id ?? "", idBook);
    if (response.data != null) {
      listHistory = response.data as List<StoryHistory>;
    }
    notifyListeners();
  }
  
  reportStory (BuildContext contextScreen) {
    Future.delayed(Duration.zero).then((_) {
      showDialog(
          context: contextScreen,
          builder: (context) => DialogReport(
              mess: "Báo cáo truyện",
              action: () {
                Navigator.pop(contextScreen);
                EasyLoading.showSuccess('Báo cáo thành công');
              }));
    });
  }
}
