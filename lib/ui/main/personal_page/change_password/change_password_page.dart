import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ns_read_story/shared/button.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/app_bar.dart';
import 'change_password_viewmodel.dart';



class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);
  
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ChangePasswordViewModel>();
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: const MyAppBar(
        title: "Đổi mật khẩu",
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30,),
              TextFormField(
                controller: viewModel.edtOldPass,
                decoration: InputDecoration(
                    hintText: "Nhập mật khẩu cũ",
                    prefixIcon: IconButton(
                      icon: SvgPicture.asset(
                        "assets/lock_ic.svg",
                        width: 15,
                      ),
                      onPressed: () {},
                    ),
                    enabledBorder: borderOutLineTextFormField,
                    focusedBorder: borderOutLineTextFormField),
              ),
              const SizedBox(height: 15,),
              TextFormField(
                obscureText: !viewModel.showNewPass,
                controller: viewModel.edtNewPass,
                decoration: InputDecoration(
                  hintText: "Nhập mật khẩu mới",
                  prefixIcon: IconButton(
                    icon: SvgPicture.asset(
                      "assets/lock_ic.svg",
                      width: 13,
                    ),
                    onPressed: () {},
                  ),
                  suffixIcon: IconButton(
                    icon: SvgPicture.asset(
                      viewModel.showNewPass
                          ? "assets/visiable_ic.svg"
                          : "assets/un_visiable_ic.svg",
                      width: 20,
                    ),
                    onPressed: () {
                      viewModel.togglevisibility();
                    },
                  ),
                  enabledBorder: borderOutLineTextFormField,
                  focusedBorder: borderOutLineTextFormField,
                ),
              ),
              const SizedBox(height: 15,),
              TextFormField(
                obscureText: !viewModel.showNewPass2,
                controller: viewModel.edtNewPass2,
                decoration: InputDecoration(
                  hintText: "Nhập lại mật khẩu mới",
                  prefixIcon: IconButton(
                    icon: SvgPicture.asset(
                      "assets/lock_ic.svg",
                      width: 13,
                    ),
                    onPressed: () {},
                  ),
                  suffixIcon: IconButton(
                    icon: SvgPicture.asset(
                      viewModel.showNewPass2
                          ? "assets/visiable_ic.svg"
                          : "assets/un_visiable_ic.svg",
                      width: 20,
                    ),
                    onPressed: () {
                      viewModel.togglevisibility2();
                    },
                  ),
                  enabledBorder: borderOutLineTextFormField,
                  focusedBorder: borderOutLineTextFormField,
                ),
              ),
              const SizedBox(height: 30,),
              NormalButton(text: "Lưu", width: context.getWidth(), height: 45,
                action: (){
                  viewModel.changePass().then((value) {
                    if(value) Navigator.pop(context);
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
