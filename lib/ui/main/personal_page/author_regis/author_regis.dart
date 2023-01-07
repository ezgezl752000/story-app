import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ns_read_story/shared/app_bar.dart';
import 'package:ns_read_story/shared/button.dart';
import 'package:ns_read_story/ultils/app_config.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:provider/provider.dart';

import '../personal_page_viewmodel.dart';

class AuthorRegis extends StatelessWidget {
  const AuthorRegis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PersonalPageViewModel>();
    return Scaffold(
      backgroundColor: colorBg,
      appBar: const MyAppBar(title: "Đăng ký làm tác giả"),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(children: [
          sizeBox10,
          const Text("Chính sách và điều khoản",
              style: textBoldBlue),
          sizeBox10,
          Container(
            width: context.getWidth(),
            decoration: BoxDecoration(
              color: viewModel.isAgreePolicy
                  ? blueColor.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(5),
            ),
            child: InkWell(
              onTap: () {
                viewModel.agreePolicy();
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(children: [
                  SvgPicture.asset(
                    viewModel.isAgreePolicy
                        ? "assets/ic_checkbox1.svg"
                        : "assets/ic_uncheckbox.svg",
                  ),
                  sizeBox10,
                  const Flexible(
                    child: Text.rich(TextSpan(
                        text: "Tôi đã đọc và chấp thuận ",
                        style: textNormal,
                        children: [
                        ])),
                  ),
                ]),
              ),
            ),
          ),
          sizeBox10,
          NormalButton(
            colorButton: viewModel.isAgreePolicy ? blueColor : colorGrey,
            text: "Đăng ký",
            height: 35,
            width: double.infinity,
            action: viewModel.isAgreePolicy
                ? () async {
                    viewModel.authorRegister(context);
                  }
                : null,
          )
        ]),
      ),
    );
  }
}
