import 'package:ns_read_story/base/base_view_model.dart';
import 'package:ns_read_story/repository/story_repository.dart';

import '../../../../model/story.dart';

class ListStoryNewViewModel extends BaseViewModel {
  StoryRepository storyRepository;
  List<Story> listStory = [];

  ListStoryNewViewModel({required this.storyRepository}) : super(storyRepository){
    getData();
  }


  getData() async{
    setLoading = true;
    final res = await storyRepository.getListStoryNew();
    if(res.code == 200 && res.data != null){
      listStory = res.data as List<Story>;
      setLoading = false;
      notifyListeners();
    }
  }
}