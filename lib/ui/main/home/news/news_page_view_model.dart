import 'package:ns_read_story/base/base_view_model.dart';
import 'package:ns_read_story/model/news_model.dart';
import 'package:ns_read_story/repository/news_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewsPageViewModel extends BaseViewModel {
  NewsRepository newsRepository;
  String idSelectCate = '';
  List<NewsCategory> listCategory = [];
  List<News> listNews = [];

  NewsPageViewModel({required this.newsRepository}) : super(newsRepository) {
    getListCategory();
  }

  RefreshController controllerRefresh = RefreshController();
  void selectCate(id) {
    idSelectCate = id;
    notifyListeners();
    getNews();
  }

  getListCategory() async {
    setLoading = true;
    final res = await newsRepository.getListCategoryNews();
    if (res.code == 200 && res.data != null) {
      listCategory = res.data as List<NewsCategory>;
      setLoading = false;
      notifyListeners();
    }
  }

  getNews() async {
    setLoading = true;
    final res = await newsRepository.getListNewsByCategory(idSelectCate);
    if (res.code == 200 && res.data != null) {
      listNews = res.data as List<News>;
      setLoading = false;
      notifyListeners();
    }
  }
}
