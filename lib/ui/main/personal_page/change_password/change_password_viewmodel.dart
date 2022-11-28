import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ns_read_story/base/base_view_model.dart';
import 'package:ns_read_story/ultils/pref_data.dart';

import '../../../../../repository/user_repository.dart';


class ChangePasswordViewModel extends BaseViewModel {
  UserRepository userRepository;

  ChangePasswordViewModel({required this.userRepository}) : super(userRepository);

  TextEditingController edtOldPass = TextEditingController();
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
    if(edtOldPass.text.isEmpty || edtNewPass.text.isEmpty || edtNewPass2.text.isEmpty){
      EasyLoading.showError("Mật khẩu không được để trống!");
    }else if(edtNewPass.text != edtNewPass2.text){
      EasyLoading.showError("Mật khẩu không khớp!");
    } else{
      final res = await userRepository.changePassword(edtOldPass.text, edtNewPass.text);
      if(res.code == 200){
        EasyLoading.showSuccess(res.message??'');
        await PreferenceManager.setString(PreferenceManager.password, edtNewPass.text);
        return true;
      }else{
        EasyLoading.showError(res.message??'');
        return false;
      }
    }
    return false;
  }

}