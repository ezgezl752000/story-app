import 'package:ns_read_story/base/base_view_model.dart';
import 'package:ns_read_story/model/detail_story.dart';
import 'package:ns_read_story/repository/story_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../model/user.dart';

class RankingViewModel extends BaseViewModel {
  StoryRepository storyRepository;
  List<Story> listStory = [];
  List<UserModel> listAuthor = [];
  List<UserModel> listTranslator = [];
  String type = "totalView";

  RankingViewModel({required this.storyRepository}) : super(storyRepository) {
    getListStory();
    getListAuthor();
    getListTranslator();
  }

  RefreshController controllerAuthor = RefreshController();
  RefreshController controllerTranslator = RefreshController();

  getListStory() async {
    final res = await storyRepository.getRanking(type);
    if (res.code == 200 && res.data != null) {
      listStory = res.data as List<Story>;
      notifyListeners();
    }
  }

  getListAuthor() async {
    final res = await storyRepository.getListAuthorRanking(false,type);
    if (res.code == 200 && res.data != null) {
      listAuthor = res.data as List<UserModel>;
      notifyListeners();
    }
  }

  getListTranslator() async {
    final res = await storyRepository.getListAuthorRanking(true,type);
    if (res.code == 200 && res.data != null) {
      listTranslator = res.data as List<UserModel>;
      notifyListeners();
    }
  }

  Future setType(value) async {
    type = value;
     getListStory();
     getListAuthor();
     getListTranslator();
  }
}
