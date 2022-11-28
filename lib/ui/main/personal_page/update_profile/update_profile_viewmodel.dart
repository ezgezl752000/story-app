import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:ns_read_story/base/base_view_model.dart';
import 'package:ns_read_story/repository/personal_repository.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:tuple/tuple.dart';

import '../../../../../api/request_model/update_info_request.dart';
import '../../../../../model/user.dart';
import '../../../../../ultils/global_bloc.dart';


class UpdateProfileViewModel extends BaseViewModel {
  PersonalRepository personalRepository;

  UpdateProfileViewModel({required this.personalRepository})
      : super(personalRepository){
    getData();
  }

  TextEditingController nameEdt = TextEditingController();
  TextEditingController phoneEdt = TextEditingController();
  TextEditingController birthdayEdt = TextEditingController();
  TextEditingController tagNameEdt = TextEditingController();
  String genderSelected = '1'; //1:Nam  //0:Nữ
  DateTime? birthDay;
  UserModel user = AppProvider.instance.user;
  File? fileAvatar;
  File? fileBackground;
  String networkAvatar = '';
  String networkBackground = '';

  List<Tuple2<String, String>> listGender = [
    const Tuple2('Nam', '1'),
    const Tuple2('Nữ', '0'),
  ];

  getData(){
    nameEdt.text = AppProvider.instance.user.fullName ?? '';
    tagNameEdt.text = AppProvider.instance.user.tagName ?? '';
    phoneEdt.text = AppProvider.instance.user.phoneNumber ?? '';
    if(AppProvider.instance.user.birthDate != null) {
      birthdayEdt.text = DateFormat("dd/MM/yyyy").format(
          DateTime.parse(AppProvider.instance.user.birthDate.toString()));
      birthDay =DateTime.parse(AppProvider.instance.user.birthDate.toString());
    }
    networkAvatar = AppProvider.instance.user.avatarUrl ?? '';
    networkBackground = AppProvider.instance.user.coverImage ?? '';
    if(AppProvider.instance.user.gender != null ) {
      genderSelected = AppProvider.instance.user.gender == true ? '1' : '0';
    }
  }

  void chooseGender(String value) {
    genderSelected = value;
    notifyListeners();
  }

  void pickBirthDay(DateTime date) {
    birthDay = date;
    notifyListeners();
  }

  Future<bool> uploadFile(File? file, bool isAvatar) async {
    String fileName = file!.path.split('/').last;
    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

    final response = await personalRepository.uploadFile(data);
    if (response.code == 200) {
      isAvatar
          ? networkAvatar = response.data2!
          : networkBackground = response.data2!;
      return true;
    } else {
      EasyLoading.showError('Up file $isAvatar không thành công');
    }
    return false;
  }

  Future<bool> updateUser() async {
    bool isOk = true;
    if (fileAvatar != null) {
      await uploadFile(fileAvatar, true).then((value) {
        if(!value){
          isOk = false;
        }
      });
    }
    if (fileBackground != null) {
      await uploadFile(fileBackground, false).then((value) async{
        if(!value){
          isOk = false;
        }
      });
    }
    if(!isOk){
      EasyLoading.showError("Upload ảnh không thành công");
      return false;
    }
    UpdateInfoRequest request = UpdateInfoRequest(
        birthDate: birthDay?.toIso8601String(),
        tagName: tagNameEdt.text,
        fullName: nameEdt.text,
        phoneNumber: phoneEdt.text,
        gender: genderSelected == '1' ? true : false,
        id: AppProvider.instance.user.id,
        avatarUrl: networkAvatar,
        coverImage: networkBackground);

    final res = await personalRepository.updateInfo(request);
    if (res.code == 200) {
      setData(request);
      EasyLoading.showSuccess('Cập nhập thành công');
      return true;
    } else {
      // final message = res.message;
      EasyLoading.showError('Cập nhật không thành công');
    }
    notifyListeners();
    return false;
  }

  setData(UpdateInfoRequest request) {
    AppProvider.instance.user.gender = genderSelected.checkGenderBool();
    AppProvider.instance.user.fullName = nameEdt.text;
    AppProvider.instance.user.phoneNumber = phoneEdt.text;
    AppProvider.instance.user.birthDate = birthDay?.toIso8601String();
    AppProvider.instance.user.tagName = tagNameEdt.text;
    AppProvider.instance.user.avatarUrl = request.avatarUrl;
    AppProvider.instance.user.coverImage = request.coverImage ?? '';
  }

  void getFileAvatar(File newFile) {
    fileAvatar = newFile;
    networkAvatar = fileAvatar!.path;
    notifyListeners();
  }

  void getFileBackground(File newFile) {
    fileBackground = newFile;
    networkBackground = fileBackground!.path;
    notifyListeners();
  }
}
