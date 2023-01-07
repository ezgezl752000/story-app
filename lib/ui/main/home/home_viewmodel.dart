import 'package:ns_read_story/base/base_view_model.dart';
import 'package:ns_read_story/model/home_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../repository/home_repository.dart';

class HomeViewModel extends BaseViewModel {
  HomeRepository homeRepository;
  HomeModel? homeModel;

  HomeViewModel({required this.homeRepository}) : super(homeRepository){
    getData();
  }

  RefreshController refreshController = RefreshController();

  onRefresh() async {
    await getData();
    refreshController.refreshCompleted();
    notifyListeners();
  }



  getData() async{
    setLoading = true;
    final res = await homeRepository.getHome();
    if(res.code == 200 && res.data != null){
      homeModel = res.data as HomeModel;
      notifyListeners();
    }
    setLoading = false;
  }
}