import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../base/base_view_model.dart';
import '../../../repository/user_repository.dart';

class ForgotPassViewModel extends BaseViewModel {
  UserRepository userRepository;
  String username;
  String token;

  ForgotPassViewModel({required this.userRepository,required this.username,required this.token}) : super(userRepository){
    print(">>>>>>>>>>$token");
  }

  TextEditingController edtNewPass = TextEditingController();
  TextEditingController edtNewPass2 = TextEditingController();

  bool showNewPass = false;
  bool showNewPass2 = false;

  void togglevisibility() {
    showNewPass = !showNewPass;
    notifyListeners();
  }

  void togglevisibility2() {
    showNewPass2 = !showNewPass2;
    notifyListeners();
  }


  Future<bool> changePass () async {
    if(edtNewPass.text.isEmpty || edtNewPass2.text.isEmpty){
      EasyLoading.showError("Mật khẩu không được để trống!");
    }else if(edtNewPass.text != edtNewPass2.text){
      EasyLoading.showError("Mật khẩu không khớp!");
    } else{
      final res = await userRepository.forgotPass(username, edtNewPass.text,token);
      if(res.code == 200){
        EasyLoading.showSuccess(res.message??'');
        return true;
      }else{
        EasyLoading.showError(res.message??'');
        return false;
      }
    }
    return false;
  }

}