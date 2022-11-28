import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:ns_read_story/page_routes.dart';
import 'package:ns_read_story/ui/main/personal_page/personal_page_viewmodel.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/global_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../model/user.dart';
import '../../../../shared/dialog.dart';
import '../../../../ultils/pref_data.dart';
import '../../../repository/personal_repository.dart';
import 'header.dart';

class MenuPersonalPage extends StatelessWidget {
  const MenuPersonalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PersonalPageViewModel>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBg,
        body: Stack(
          children: [
            FutureBuilder(
              initialData: AppProvider.instance.token,
              builder: (_, data) {
                if (data.hasData) {
                  return Column(
                    children: [
                      const Header(heroTag: 'menu'),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              // ItemMenu(
                              //     icon: 'assets/ic_store.svg',
                              //     title: 'Nạp xu',
                              //     action: () {}),
                              // ItemMenu(
                              //     icon: 'assets/ic_trans_history.svg',
                              //     title: 'Lịch sử giao dịch',
                              //     action: () {}),
                              if (AppProvider.instance.isAuthor ?? false)
                                ItemMenu(
                                    icon: const Icon(Icons.book_outlined,
                                        color: blueColor),
                                    title: 'Truyện đã đăng',
                                    action: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pushNamed(
                                              PageRoutes.listStoryManage);
                                    }),
                              ItemMenu(
                                  icon: const Icon(Icons.lock_outline,
                                      color: blueColor),
                                  title: 'Đổi mật khẩu',
                                  action: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pushNamed(PageRoutes.changePassword);
                                  }),
                              // ItemMenu(
                              //     icon: 'assets/ic_info.svg',
                              //     title: 'Về Hải Vương',
                              //     action: () {}),
                              // ItemMenu(
                              //     icon: 'assets/ic_rate_hv.svg',
                              //     title: 'Rate cho chúng tôi',
                              //     action: () {}),
                              // ItemMenu(
                              //     icon: 'assets/ic_info.svg',
                              //     title: 'Giới thiệu về ứng dụng nhận thưởng',
                              //     action: () {}),
                              ItemMenu(
                                  icon: const Icon(Icons.logout_outlined,
                                      color: colorRed),
                                  title: 'Đăng xuất',
                                  action: () async {
                                    await logOut(context);
                                  }),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                } else {
                  return Center(
                    child: DialogLogin(
                      mess: 'Vui lòng đăng nhập để sử dụng chức năng này',
                      action: () async {
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed(PageRoutes.login, arguments: 4);
                      },
                    ),
                  );
                }
              },
            ),
            Positioned(
                top: 5,
                left: 10,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset(
                      'assets/ic_back.svg',
                      width: 30,
                      height: 30,
                    ))),
          ],
        ),
      ),
    );
  }
}

Future logOut(BuildContext context) async {
  await context.read<PersonalRepository>().logOut();
  await PreferenceManager.clear();
  await PreferenceManager.setBool(PreferenceManager.remember, false);
  await PreferenceManager.setBool(PreferenceManager.isFirstLogin, false);
  AppProvider.instance.token = null;
  AppProvider.instance.user = UserModel();
  Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
      PageRoutes.mainPage, (route) => false,
      arguments: 0);
}

class ItemMenu extends StatelessWidget {
  Icon icon;
  String title;
  var action;
  ItemMenu(
      {Key? key, required this.icon, required this.title, required this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action ?? () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: colorGrey.withOpacity(0.5)))),
          child: Row(
            children: [
              // SizedBox(
              //   width: 25,
              //   height: 25,
              //   child: Center(
              //     child: SvgPicture.asset(
              //       icon,
              //       width: 20,
              //       height: 20,
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              icon,
              const SizedBox(
                width: 12,
              ),
              Expanded(
                  child: Text(
                title,
                style: textNormal.copyWith(fontSize: fontSize14),
              )),
              const Icon(
                Icons.navigate_next,
                color: colorGrey,
                size: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}
