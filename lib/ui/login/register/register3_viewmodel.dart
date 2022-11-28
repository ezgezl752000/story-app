import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:ns_read_story/base/base_view_model.dart';
import 'package:tuple/tuple.dart';

import '../../../repository/user_repository.dart';

class Register3ViewModel extends BaseViewModel {
  UserRepository userRepository;

  Register3ViewModel({required this.userRepository}) : super(userRepository){
  }

  List<Tuple2<String,String>> listGender = [
    const Tuple2('Nam','1'),
    const Tuple2('Nữ','0'),
  ];

  var formRegister = GlobalKey<FormState>();

  TextEditingController edtUsername = TextEditingController();
  TextEditingController edtName = TextEditingController();
  TextEditingController edtNameTag = TextEditingController();
  TextEditingController edtPassword = TextEditingController();
  TextEditingController edtGender = TextEditingController();
  TextEditingController edtBirthday = TextEditingController();
  String genderSelected = '1'; //1:Nam  //0:Nữ
  DateTime? birthDay;

  void chooseGender(String value) {
    genderSelected = value;
    notifyListeners();
  }

  void pickBirthDay(DateTime date) {
    birthDay = date;
    notifyListeners();
  }

  String? validateEmpty(String? value) {
    if (value?.isEmpty == true) {
      return 'Bạn không thể để trống';
    }
    return null;
  }


  Future<bool> createAccount() async {
    final res = await userRepository.createAccount(
        edtUsername.text,
        edtName.text,
        int.parse(genderSelected),
        DateFormat('yyyy-MM-dd').format(birthDay!),
        edtPassword.text,
        edtNameTag.text);
    if(res.code==200){
      EasyLoading.showSuccess(res.message ?? 'Error');
      return true;
    }else{
      EasyLoading.showError(res.message ?? 'Error');
      return false;
    }
  }
}