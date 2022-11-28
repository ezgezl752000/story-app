import 'package:ns_read_story/base/base_view_model.dart';
import 'package:ns_read_story/model/follow_model.dart';
import 'package:ns_read_story/model/user.dart';
import 'package:ns_read_story/repository/story_repository.dart';


class ViewFollowViewModel extends BaseViewModel{
  StoryRepository storyRepository;
  String userId;
  UserModel? user;
  List<FollowModel>? listMyFollow;
  List<FollowModel>? listMyFollowing;
  int initIndexTab = 0;

  ViewFollowViewModel({required this.storyRepository,required this.userId,required this.initIndexTab}) : super(storyRepository){
    getMyListFollowing(); // người mình theo dõi
    getMyListFollow(); // người theo dõi mình
    getUser();
  }

  refreshData(){
    getMyListFollowing();
    getMyListFollow();
  }

  getMyListFollowing() async {
    final res = await storyRepository.getListFollow(isMyFollowed: true,userId: userId);
    if(res.code == 200 && res.data != null){
      listMyFollowing = res.data as List<FollowModel>;
      notifyListeners();
    }
  }

  getMyListFollow() async {
    final res = await storyRepository.getListFollow(isMyFollowed: false,userId: userId);
    if(res.code == 200 && res.data != null){
      listMyFollow = res.data as List<FollowModel>;
      notifyListeners();
    }
  }


  getUser() async{
    final res = await storyRepository.getDetailUser(userId);
    if(res.code == 200){
      user = res.data as UserModel;
    }
    notifyListeners();
  }
}