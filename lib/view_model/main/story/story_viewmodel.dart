import 'package:ns_read_story/base/base_view_model.dart';
import 'package:ns_read_story/model/story_history.dart';
import 'package:ns_read_story/repository/story_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BookViewModel extends BaseViewModel {
  StoryRepository storyRepository;
  List<StoryHistory> listStoryViewed = [];
  List<StoryHistory> listStoryFollowed = [];


  RefreshController refreshControllerStoryFollowed = RefreshController(initialRefresh: true);
  RefreshController refreshControllerStoryViewed = RefreshController(initialRefresh: true);

  BookViewModel({required this.storyRepository}) : super(storyRepository){

    getData();
  }

  onRefreshStoryViewed() async {
    await getData();
    refreshControllerStoryViewed.refreshCompleted();
    notifyListeners();
  }

  onRefreshStoryFollowed() async {
    await getData();
    refreshControllerStoryFollowed.refreshCompleted();
    notifyListeners();
  }

  unFollowStory(StoryHistory storyHistory) async {
    final res = await storyRepository.unFollowStory(storyHistory.bookInfo!.id!);
    if(res.code == 200){
      listStoryFollowed.remove(storyHistory);
      notifyListeners();
    }
  }

  deleteHistory(StoryHistory storyHistory) async{
    final res = await storyRepository.deleteHistory(storyHistory.id!);
    if(res.code == 200){
      listStoryViewed.remove(storyHistory);
      notifyListeners();
    }
  }


  getData() async{
    setLoading=true;
    final res = await Future.wait([
      storyRepository.getListStoryViewed(),
      storyRepository.getListStoryFollowed(),
    ]);
    if(res[0].code == 200 && res[0].data != null){
      listStoryViewed = res[0].data as  List<StoryHistory>;
    }
    if(res[1].code == 200 && res[1].data != null){
      listStoryFollowed = res[1].data as  List<StoryHistory>;
    }
    setLoading=false;
    notifyListeners();
  }
}