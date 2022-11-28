import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:ns_read_story/base/base_view_model.dart';
import 'package:ns_read_story/model/category_model.dart';
import 'package:ns_read_story/page_routes.dart';
import 'package:ns_read_story/repository/personal_repository.dart';
import 'package:ns_read_story/shared/dialog.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:tuple/tuple.dart';

import '../../../../../model/detail_story.dart';


class PostStoryViewModel extends BaseViewModel{
  PersonalRepository personalRepository;
  String idBook = '';


  List<Categories> listCategories = [];
  List<Categories> listCategoriesAdd = [];
  bool translator = false;
  bool isCompleted = false;
  File? file;
  String imageNetWork = '';
  TextEditingController titleEdtController = TextEditingController();
  TextEditingController contentEdtController = TextEditingController();
  Story story = Story();
  List<Tuple2<String,String>> listRoles = [
    const Tuple2("0", "Tác giả"),
    const Tuple2("1", "Dịch giả"),
  ];
  List<Tuple2<String,String>> listStatus= [
    const Tuple2("0", "Đang tiến hành"),
    const Tuple2("1", "Đã hoàn thành"),
  ];


  String roleSelected = "0";
  String statusSelected = "0";

  PostStoryViewModel({required this.personalRepository,required this.idBook}) : super(personalRepository) {
    getListCate();
    if(idBook != '') getDetailStory();
  }


  void selectedComplete(String value) {
    statusSelected = value;
    if(value =='0'){
      isCompleted = false;
    }else{
      isCompleted = true;
    }
    notifyListeners();
  }

  getListCate()async{
    final res = await personalRepository.getListCategory();
    if(res.code == 200 && res.data != null ){
      listCategories = res.data as List<Categories>;
      notifyListeners();
    }
  }

  getDetailStory() async{
    final res = await personalRepository.getDetailStory(idBook);
    if(res.code == 200 && res.data != null ){
      story = res.data as Story;
      titleEdtController.text = story.name ?? '';
      contentEdtController.text = story.description ?? '';
      translator = story.translator ?? false;
      isCompleted = story.completed ?? false;
      if(translator){
        roleSelected = '1';
      }else{
        roleSelected = '0';
      }
      if(isCompleted){
        statusSelected = '1';
      }else{
        statusSelected = '0';
      }
      imageNetWork = story.thumbnail!;
      for(int i =0;i<story.categories!.length;i++){
        for(int j=0;j < listCategories.length;j++){
          if(story.categories![i].id == listCategories[j].id){
            listCategories[j].selected = true;
            listCategoriesAdd.add(listCategories[j]);
          }
        }
      }
      notifyListeners();
    }
  }

  selectCate(Categories cate) async {
    if(listCategoriesAdd.length<10){
      cate.selected =  !cate.selected!;
      if(cate.selected!){
        listCategoriesAdd.add(cate);
      }else{
        listCategoriesAdd.remove(cate);
      }
    }else{
      cate.selected =  false;
      listCategoriesAdd.remove(cate);
    }
    notifyListeners();
  }

  void getFile(File newFile){
    file = newFile;
    notifyListeners();
  }

  void clearFile(){
    file = null;
    imageNetWork = '';
    notifyListeners();
  }

  bool? validateEmpty(String? value) {
    if (value?.isEmpty == true) {
      return true;
    }
    return false;
  }


  selectRole(String idRole) async {
    roleSelected = idRole;
    if(roleSelected=='0'){
      translator = false;
    }else{
      translator = true;
    }
    notifyListeners();
  }

  Future<bool> uploadFile() async{
    final dir = await path_provider.getTemporaryDirectory();
    File? result = await FlutterImageCompress.compressAndGetFile(file!.path,dir.absolute.path + "/temp.jpg",quality: 50,format: CompressFormat.jpeg);
    String fileName = result!.path.split('/').last;
    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        result.path,
        filename: fileName,
      ),
    });

    final response = await personalRepository.uploadFile(data);
    if(response.code == 200  ){
      story.thumbnail = response.data2!;
      return true;
    }else{
      EasyLoading.showError("Ảnh vượt quá dung lượng cho phép");
    }
    return false;
  }

  createStory(BuildContext contextScreen) async{
    if(titleEdtController.text.isNotEmpty && contentEdtController.text.isNotEmpty && listCategories.where((e) => e.selected!).toList().isNotEmpty){
      story.name = titleEdtController.text;
      story.description = contentEdtController.text;
      story.translator = translator;
      story.categories =  listCategoriesAdd;
      story.completed =  isCompleted;
      if(file != null){
        uploadFile().then((value) async {
          if(value){
            final response = await personalRepository.createStory(story);
            if(response.code == 200){
             await showDialog(
                  context: contextScreen,
                  builder: (context) => DialogSuccess(
                    mess:
                    'Tạo thành công, tác phẩm của bạn đang được chờ duyệt',
                    action: () async{
                      await  Navigator.of(context, rootNavigator: true)
                          .pushNamed(PageRoutes.manageStory,arguments: response.dataStory?.id);
                      Navigator.of(contextScreen).pop();
                    },
                  ));
            }else{
              EasyLoading.showError("Thêm thất bại");
            }
          }else{
            EasyLoading.showError("Upload ảnh không thành công");
          }
        });
      }else{
        EasyLoading.showError("Chưa chọn ảnh truyện");
      }
    }
  }


  updateStory() async {
    if(titleEdtController.text.isNotEmpty && contentEdtController.text.isNotEmpty && listCategories.where((e) => e.selected!).toList().isNotEmpty){
      story.name = titleEdtController.text;
      story.description = contentEdtController.text;
      story.translator = translator;
      story.categories =  listCategoriesAdd;
      story.completed =  isCompleted;
      if(file != null){
        uploadFile().then((value) async {
          if(value){
            final response = await personalRepository.updateStory(story);
            if(response.code == 200){
              EasyLoading.showSuccess("Sửa thành công");
            }else{
              EasyLoading.showError("Sửa thất bại");
            }
          }else{
            EasyLoading.showError("Upload ảnh không thành công");
          }
        });
      }else{
        final response = await personalRepository.updateStory(story);
        if(response.code == 200){
          EasyLoading.showSuccess("Sửa thành công");
        }else{
          EasyLoading.showError("Sửa thất bại");
        }
      }
     notifyListeners();
    }
  }
}