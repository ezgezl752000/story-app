import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ns_read_story/api/response_model/response_message.dart';
import 'package:ns_read_story/page_routes.dart';
import 'package:ns_read_story/repository/user_repository.dart';
import 'package:ns_read_story/shared/textfield.dart';
import 'package:ns_read_story/ui/login/login_viewmodel.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:ns_read_story/ultils/global_bloc.dart';
import 'package:ns_read_story/ultils/pref_data.dart';
import 'package:provider/provider.dart';

import '../../shared/check_box.dart';
import '../../widgets/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;
  bool rememberLogin = false;

  TextEditingController edtPhone = TextEditingController();
  TextEditingController edtPass = TextEditingController();

  void _toggleVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  Future getData()async {
    rememberLogin = PreferenceManager.getBool(PreferenceManager.remember,false);
    edtPhone.text = PreferenceManager.getString(PreferenceManager.username);
  }




  @override
  void initState() {   
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LoginViewModel>();
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width ,
        decoration: const BoxDecoration(
          image:  DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.fill
          ),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 35, 16, 0),
                child: Column(
                  children: [
                    sizeBox20,
                     SizedBox(
                      height: 120,
                      width: 160,
                      child: Container(
                        decoration: const BoxDecoration(
                          image:  DecorationImage(
                              image: AssetImage('assets/logo.png'),
                              fit: BoxFit.fill
                          ),
                        ),
                      ),
                    ),
                    sizeBox20,
                    sizeBox20,
                    sizeBox20,
                    TextFieldCustom(
                      maxLine: 1,
                      hintText: "Số điện thoại",
                      controller:edtPhone ,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Stack(children: [
                      TextFieldCustom(
                        maxLine: 1,
                        hintText: "Mật khẩu",
                      controller: edtPass,
                        obscureText: !_showPassword,
                      ),
                      Positioned(
                        right: 0,
                        child: IconButton(
                            onPressed: () {
                              _toggleVisibility();
                            },
                            icon: Icon(_showPassword
                                ? Icons.visibility
                                : Icons.visibility_off, color: colorGrey.withOpacity(0.5),)),
                      ),
                    ]),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Checkbox(value: false, onChanged: onChanged)
                        CheckBoxCustom(
                          isChecked: rememberLogin,
                          onPress: (value) {
                            rememberLogin=value;
                            setState(() {});
                          },
                          title: "Ghi nhớ đăng nhập",
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, PageRoutes.register1,arguments: 'true');
                          },
                          child: Text(
                            "Quên mật khẩu?",
                            style: Theme.of(context).textTheme.button!.copyWith(
                                fontSize: fontSize14,
                                color: blueColor,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CommonButton(
                      text: "Đăng nhập",
                      onPressed: () async{
                        onClick();
                      },
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                          },
                          child: Text(
                            "Bạn chưa có tài khoản? ",
                            style: Theme.of(context).textTheme.button!.copyWith(
                                fontSize: fontSize14,
                                color: blueColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.of(context,rootNavigator:  true).pushNamed(PageRoutes.register3, arguments: 'false');
                          },
                          child: Text(
                            "Đăng ký ngay",
                            style: Theme.of(context).textTheme.button!.copyWith(
                                fontSize: fontSize14,
                                color: blueColor,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                    sizeBox20,
                    sizeBox20,
                    sizeBox20,


                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(
                        //   width: 40,height: 40,
                        //   child: SignInButton(
                        //     Buttons.Facebook,
                        //     mini: true,
                        //     onPressed: () async{
                        //       await context.read<LoginViewModel>().signInFacebook().then((res) {
                        //         if(res.code == 200){
                        //              AppProvider.instance.typeLogin = 'facebook';
                        //              PreferenceManager.setString(PreferenceManager.typeLogin, AppProvider.instance.typeLogin!);
                        //           Navigator.pushNamedAndRemoveUntil(context, PageRoutes.mainPage, (route) => false,arguments: viewModel.indexTab);
                        //         }});
                        //     },
                        //   ),
                        // ),
                        // sizeBox10,
                        sizeBox10,
                        // Visibility(
                        //   visible: Platform.isIOS,
                        //   child: SizedBox(
                        //     width: context.getWidth()/9,height: context.getWidth()/9,
                        //     child: SignInButton(
                        //       Buttons.AppleDark,
                        //       mini: true,
                        //       text: 'Đăng nhập với Apple',
                        //       onPressed: () async{
                        //         viewModel.signInWithApple(context).then((res) async{
                        //           if(res.code == 200){
                        //             AppProvider.instance.typeLogin = 'apple';
                        //             await PreferenceManager.setBool(PreferenceManager.remember, true);
                        //             PreferenceManager.setString(PreferenceManager.typeLogin, AppProvider.instance.typeLogin!);
                        //             Navigator.pushNamedAndRemoveUntil(context, PageRoutes.mainPage, (route) => false,arguments: viewModel.indexTab);
                        //           }
                        //         });
                        //       },
                        //     ),
                        //   ),
                        // ),
                      ],
                    )
                  ],
                ),
              ),
            ),
             Positioned(
              top: MediaQuery.of(context).viewPadding.top + 10,
                left: 5,
                child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_sharp)))
          ],
        ),
      ),
    );
  }

  void onClick() async {
    if (edtPhone.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Tài khoản không được để trống",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (edtPass.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Mật khẩu không được để trống",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      final ResponseMessage? res = await context.read<LoginViewModel>().login(
          context, edtPhone.text, edtPass.text,rememberLogin);
      if (res?.code == 200) {
        AppProvider.instance.typeLogin = 'phone';
        PreferenceManager.setString(PreferenceManager.typeLogin, AppProvider.instance.typeLogin!);
        await context.read<UserRepository>().getInfoUser(res?.data2 ?? '');
        Navigator.pushNamedAndRemoveUntil(context, PageRoutes.mainPage, (route) => false,arguments: context.read<LoginViewModel>().indexTab);
      } else {
        Fluttertoast.showToast(
            msg: 'Tài khoản hoặc mật khẩu không đúng',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }
}
