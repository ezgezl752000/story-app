import 'package:flutter/material.dart';
import 'package:ns_read_story/base/base_view_model.dart';
import 'package:ns_read_story/model/story.dart';
import 'package:ns_read_story/repository/story_repository.dart';

import '../../../../model/user.dart';

class SearchViewModel extends BaseViewModel {
  StoryRepository storyRepository;
  ModelSearch? modelSearch;

  SearchViewModel({required this.storyRepository}) : super(storyRepository);

  TextEditingController edtSearch = TextEditingController();

  clearText() async {
    edtSearch.clear();
    notifyListeners();
  }

  Future<List<ModelSearch>> searchStorySuggest(String keySearch) async{
    List<ModelSearch> listSearch = [];
    List<Story> listStory = [];
    List<UserModel> listUser = [];
    if(keySearch.isNotEmpty){
      listSearch.clear();
      final res1 = await storyRepository.searchStory(keySearch);
      final res2 = await storyRepository.searchUser(keySearch);
      if(res1.code==200 && res1.data !=null){
        listStory = res1.data as List<Story>;
        for(var e in listStory){
          listSearch.add(ModelSearch(title: e.name, id: e.id, story: e, type: 'story',avt: ''));
        }
      }
      if(res2.code==200 && res2.data !=null){
        listUser = res2.data as List<UserModel>;
        for(var e in listUser){
          listSearch.add(ModelSearch(title: e.fullName, id: e.id, story: Story(), type: 'user',avt: e.avatarUrl));
        }
      }
      listSearch.sort((a,b) {
        return a.title!.toLowerCase().compareTo(b.title!.toLowerCase());
      });
      notifyListeners();
    }
    return listSearch;
  }



}


class ModelSearch{
  String? type;
  String? id;
  String? avt;
  String? title;
  Story? story;

  ModelSearch({
    this.type,
    this.id,
    this.title,
    this.avt,
    this.story,
  });
}