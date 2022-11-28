import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ns_read_story/shared/app_bar.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../shared/button.dart';
import '../../../ultils/constants.dart';
import 'forgot_password_viewmodel.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ForgotPassViewModel>();
    return Scaffold(
      backgroundColor:Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(
        title: "Quên mật khẩu",
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 30,),
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
                  if(value) Navigator.of(context).popUntil((route) => route.isFirst);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}