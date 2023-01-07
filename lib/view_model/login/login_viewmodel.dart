import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:ns_read_story/api/request_model/login_request.dart';
import 'package:ns_read_story/api/response_model/response_message.dart';
import 'package:ns_read_story/base/base_view_model.dart';
import 'package:ns_read_story/repository/user_repository.dart';
import 'package:ns_read_story/ultils/global_bloc.dart';
import 'package:ns_read_story/ultils/pref_data.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginViewModel extends BaseViewModel {
  UserRepository userRepository;
  int indexTab;

  LoginViewModel({required this.userRepository,required this.indexTab}) : super(userRepository);

  Future<ResponseMessage?> login(BuildContext context,String username, String password,bool remember) async {
    EasyLoading.show();
    LoginRequest loginRequest = LoginRequest()
      ..username = username
      ..password = password;
    final res = await userRepository.login(loginRequest);
    if (res.code == 200) {
      await PreferenceManager.setString(PreferenceManager.username, username);
      await PreferenceManager.setString(PreferenceManager.password, password);
      await PreferenceManager.setBool(PreferenceManager.remember, remember);
      EasyLoading.dismiss();
      return res;
    } else {
      EasyLoading.dismiss();
      return res;
    }
  }
}
