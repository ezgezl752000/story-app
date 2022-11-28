import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../../../../shared/dropdown.dart';
import '../../../../../ultils/constants.dart';
import '../../../../../widgets/button.dart';
import 'header_new.dart';
import 'update_profile_viewmodel.dart';



class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<UpdateProfileViewModel>();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: colorBg,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const HeaderUpdate(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: viewModel.nameEdt,
                          decoration: InputDecoration(
                              hintText:'Họ và tên',
                              enabledBorder: borderOutLineTextFormField,
                              focusedBorder: borderOutLineTextFormField),
                        ),
                        sizeBox15,
                        TextFormField(
                          controller: viewModel.tagNameEdt,
                          decoration: InputDecoration(
                              hintText:  'Bút danh',
                              enabledBorder: borderOutLineTextFormField,
                              focusedBorder: borderOutLineTextFormField),
                        ),
                        sizeBox15,
                        TextFormField(
                          controller: viewModel.phoneEdt,
                          decoration: InputDecoration(
                              hintText:  'Số điện thoại',
                              enabledBorder: borderOutLineTextFormField,
                              focusedBorder: borderOutLineTextFormField),
                        ),
                        sizeBox15,
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
                        GestureDetector(
                          onTap: (){
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                maxTime: DateTime.now(),
                                onChanged: (date) {}, onConfirm: (date) {
                                  viewModel.pickBirthDay(date);
                                  viewModel.birthdayEdt.text =
                                      DateFormat("dd/MM/yyyy").format(date);
                                }, currentTime: viewModel.birthDay, locale: LocaleType.vi);
                          },
                          child:  TextFormField(
                            enabled: false,
                            controller: viewModel.birthdayEdt,
                            decoration: InputDecoration(
                                hintText:  'Ngày sinh',
                                border: borderOutLineTextFormField,
                                enabledBorder: borderOutLineTextFormField,
                                focusedBorder: borderOutLineTextFormField),
                          ),
                        ),

                        const SizedBox(height: 50,),
                        CommonButton.center(
                          text: "Cập nhật",
                          onPressed: () async{
                            await viewModel.updateUser().then((value){
                              if(value){
                                // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                Navigator.pop(context);
                              }
                            });
                          },
                        ),
                      ],

                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: 5,
                left: 5,
                child: IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },iconSize: 25,
                    icon: SvgPicture.asset('assets/ic_back.svg',width: 30,height: 30,)))
          ],
        ),

      ),
    );
  }
}
