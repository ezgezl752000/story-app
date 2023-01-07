import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ns_read_story/base/base_view_model.dart';
import 'package:ns_read_story/model/chapter.dart';
import 'package:ns_read_story/model/story.dart';
import 'package:ns_read_story/repository/personal_repository.dart';

class ManagerStoryViewModel extends BaseViewModel {
  PersonalRepository personalRepository;
  String idBook;
  Story? story;
  bool showMore = false;
  List<Chapter> listChapter = [];
  ManagerStoryViewModel({required this.personalRepository,required this.idBook}) : super(personalRepository){
    getDetailStory();
    getListChapter();
  }
  int page = 0;
  bool canNextPage = false;
  bool canBackPage = false;

  nextPage() {
    if(canNextPage){
      page++;
      getListChapter();
    }
  }
  backPage() {
    if(canBackPage){
      page--;
      getListChapter();
    }
  }

  toggleShowText () {
    showMore = !showMore;
    notifyListeners();
  }


  getDetailStory() async {
    final res = await  personalRepository.getDetailStory(idBook);
    if(res.code == 200 && res.data != null){
      story = res.data as Story;
    }
    notifyListeners();
  }

  getListChapter() async {
    setLoading=true;
    final res = await   personalRepository.getListChapter(idBook,page);
    if(res.code == 200&& res.data != null){
      listChapter =  res.data as List<Chapter>;
      canBackPage=true;
      if(page == 0) canBackPage=false;
      canNextPage = res.isLastPage ?? false; // lastPage = true là trang cuối nếu là trang cuối thì không thể next page
      canNextPage=!canNextPage; // nếu lastPage = true thì canNextPage sẽ phải = false (ngược lại của lastPage)
    }
    setLoading=false;
    notifyListeners();
  }


  deleteChapter(String idChapter) async {
    final res = await personalRepository.deleteChapter(idChapter);
    if(res.code==200){
      EasyLoading.showSuccess("Xoá thành công");
      getListChapter();
    }else{
      EasyLoading.showError("Xoá chương thất bại");
    }
  }
}