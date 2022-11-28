import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:ns_read_story/shared/app_bar.dart';
import 'package:ns_read_story/ui/login/register/register3_viewmodel.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../../shared/button.dart';
import '../../../shared/dropdown.dart';
import '../../../shared/textfield.dart';
import '../../../ultils/constants.dart';

class RegisterScreen3 extends StatefulWidget {
  const RegisterScreen3({Key? key}) : super(key: key);

  @override
  _RegisterScreen3State createState() => _RegisterScreen3State();
}

class _RegisterScreen3State extends State<RegisterScreen3> {
  bool _showPassword = false;
  
  void _toggleShowPass() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<Register3ViewModel>();
    return Scaffold(
      backgroundColor:Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: const MyAppBar(title: '',),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.fill,
                  ),
                  SizedBox(height: 30,width: context.getWidth(),),
                ],
              ),
              Form(
                key: viewModel.formRegister,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextField(title: 'Tài khoản.',controller: viewModel.edtUsername,validator: viewModel.validateEmpty,),
                    sizeBox15,
                    MyTextField(title: 'Họ tên.',controller: viewModel.edtName,validator: viewModel.validateEmpty,),
                    sizeBox15,
                    MyTextField(title: 'Biệt danh',controller: viewModel.edtNameTag,validator: viewModel.validateEmpty,),
                    sizeBox15,
                    const Text("Giới tính",style: textTitleBlack),
                    const SizedBox(height: 5,),
                    SizedBox(
                      height: heightTextField,
                      child: DropDownCustom<String>(
                        listItem: viewModel.listGender
                            .map((e) => Tuple2(e.item1, e.item2))
                            .toList(),
                        onChange: (a) {
                          viewModel.chooseGender(a);
                        },
                        value: viewModel.genderSelected,
                      ),
                    ),
                    sizeBox15,
                    InkWell(
                        onTap: (){
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              maxTime: DateTime.now(),
                              onChanged: (date) {}, onConfirm: (date) {
                                viewModel.pickBirthDay(date);
                                viewModel.edtBirthday.text =
                                    DateFormat("dd/MM/yyyy").format(date);
                              }, currentTime: viewModel.birthDay, locale: LocaleType.vi);
                        },
                        child: MyTextField(title: 'Ngày sinh.',enable: false,controller: viewModel.edtBirthday,validator: viewModel.validateEmpty,)),
                    sizeBox15,
                    Stack(
                      children: [
                        MyTextField(title: 'Mật khẩu.',controller: viewModel.edtPassword,validator: viewModel.validateEmpty,textInputType: TextInputType.visiblePassword, obscureText: !_showPassword,),
                        Positioned(
                          right: 0,
                          top: 25,
                          child: IconButton(
                            onPressed: () {
                              _toggleShowPass();
                            },
                            icon: Icon(_showPassword
                                ? Icons.visibility
                                : Icons.visibility_off, color: colorGrey.withOpacity(0.5),)),
                        ),
                      ],
                    ),
                    sizeBox15,
                    Center(
                        child: NormalButton(text: "Tạo", height: 40,width: context.getWidth()/3,
                          action: (){
                            if (viewModel.formRegister.currentState!.validate()) {
                              viewModel.createAccount().then((value) {
                                if(value)Navigator.of(context).popUntil((route) => route.isFirst);
                              });
                            }
                          },
                        )
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
