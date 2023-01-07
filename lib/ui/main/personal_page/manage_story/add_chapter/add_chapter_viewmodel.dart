import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:ns_read_story/base/base_view_model.dart';
import 'package:ns_read_story/model/chapter.dart';
import 'package:ns_read_story/repository/personal_repository.dart';

class AddChapterViewModel extends BaseViewModel {
  PersonalRepository personalRepository;
  String idChapter;
  String idBook;
  String isEdit;
  String canEnterPrice;
  HtmlEditorController htmlController = HtmlEditorController();
  TextEditingController edtName = TextEditingController();
  TextEditingController edtPrice = TextEditingController();

  Chapter? chapter;

  AddChapterViewModel({required this.personalRepository,required this.idChapter,required this.isEdit,required this.idBook,required this.canEnterPrice}) : super(personalRepository){
    if(isEdit == 'true')getData();
  }


  getData() async {
    final res = await personalRepository.getDetailChapter(idChapter);
    if(res.code == 200 && res.data != null){
      chapter = res.data as Chapter;
      edtName.text = chapter?.name ?? '';
      edtPrice.text = '${chapter?.price?.toInt() ?? ''}';
      notifyListeners();
    }
  }


 Future<bool> checkEditChapter() async {
   if(canEnterPrice == 'true'){
     if(int.parse(edtPrice.text)< 100){
       EasyLoading.showError('Giá chương tối thiểu là 100 xu');
     }else{
       return await editChapter();
     }
   }else{
     return await editChapter();
   }
   return false;
  }

  Future<bool> editChapter() async {
    final res = await personalRepository.editChapter(idChapter, idBook, edtName.text,await htmlController.getText(),double.parse(edtPrice.text));
    if(res.code == 200){
      EasyLoading.showSuccess('Thành công');
      return true;
    }else{
      EasyLoading.showSuccess(' Sửa thất bại');
    }
    return false;
  }

  Future<bool> checkAddChapter() async {
    if(edtName.text.isEmpty){
      EasyLoading.showError('Chưa nhập tên chương');
    } else{
      if(canEnterPrice == 'true'){
        if(int.parse(edtPrice.text)< 100){
          EasyLoading.showError('Giá chương tối thiểu là 100 xu');
        }else{
          return await addChapter();
        }
      }else{
        return await addChapter();
      }
    }
    return false;
  }

  Future<bool> addChapter() async {
    final res = await personalRepository.addChapter(idBook, edtName.text,await htmlController.getText(),edtPrice.text.isEmpty ? 0 :double.parse(edtPrice.text));
    if(res.code == 200){
      EasyLoading.showSuccess('Thành công');
      return true;
    }else{
      EasyLoading.showError(' Sửa thất bại');
    }
    return false;
  }


}