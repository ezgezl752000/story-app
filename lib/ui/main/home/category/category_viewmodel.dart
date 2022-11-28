import 'package:ns_read_story/base/base_view_model.dart';
import 'package:ns_read_story/model/category_model.dart';
import 'package:ns_read_story/model/detail_story.dart';
import 'package:ns_read_story/repository/home_repository.dart';

class CategoryViewModel extends BaseViewModel {
HomeRepository homeRepository;
List<Categories> listCategory = [];
List<Story> listStory = [];
int count = 8;

  CategoryViewModel({required this.homeRepository}) : super(homeRepository){
    getData();
  }

  viewMore() async {
    count = listCategory.length;
    notifyListeners();
  }

  collapse() async {
    count = 8;
    notifyListeners();
  }

  getData() async {
    setLoading = true;
    final res = await Future.wait([
      homeRepository.getListCategory(),
      homeRepository.getListStorySuggest(),
    ]);
    if(res[0].code == 200 && res[0].data != null){
      listCategory = res[0].data as List<Categories>;
    }
    if(res[1].code == 200 && res[1].data != null){
      listStory = res[1].data as List<Story>;
    }
    setLoading = false;
    notifyListeners();
  }


}