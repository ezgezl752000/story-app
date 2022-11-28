import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ns_read_story/model/user.dart';
import 'package:ns_read_story/page_routes.dart';
import 'package:ns_read_story/shared/button.dart';
import 'package:ns_read_story/ui/main/home/search_story/detail_user/detail_user_viewmodel.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../../../ultils/constants.dart';
import '../../../../../ultils/global_bloc.dart';
import '../../../personal_page/sub_header.dart';

class SubHeader extends StatelessWidget {
  SubHeader({Key? key}) : super(key: key);

  List<Item> list = [];

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DetailUserViewModel>();
    list = [
      Item(
          title: 'Người theo dõi',
          extra: '${viewModel.follow?.followed ?? 0}',
          action: () async {
            await Navigator.pushNamed(context, PageRoutes.viewFollow,
                arguments: [viewModel.idUser,'0']);
            viewModel.getNumberFollow();
          }),
      Item(
          title: 'Đang theo dõi',
          extra: '${viewModel.follow?.following ?? 0}',
          action: () async {
              await Navigator.pushNamed(context, PageRoutes.viewFollow,
                arguments: [viewModel.idUser,'1']);
            viewModel.getNumberFollow();
          }),
    ];
    return SizedBox(
      width: context.getWidth(),
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: list.map((e) {
              return InkWell(
                onTap: () {
                  e.action();
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: context.getWidth() / 2.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            e.extra,
                            style: textBlackThinTitle,
                          ),
                        ],
                      ),
                      sizeBox10,
                      Center(
                        child: Text(
                          e.title,
                          style: textBlackThinTitle,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: NormalButton(
                    action: () {
                      if (AppProvider.instance.token == null) {
                        AppProvider.instance.showDialogLogin(context,
                            'Bạn cần đăng nhập để sử dụng tính năng này');
                      } else {
                        if (viewModel.isFollowUser) {
                          viewModel.unFollowUser();
                        } else {
                          viewModel.followUser();
                        }
                      }
                    },
                    text: viewModel.isFollowUser ? 'Đang theo dõi' : "Theo dõi",
                    height: 35,
                    colorButton: viewModel.isFollowUser ? colorGrey : blueColor,
                    textColor: viewModel.isFollowUser ? colorBlack : colorBg,
                  ),
                ),
                sizeBox10,
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    customButton: const NormalButton(
                      text: '...',
                      height: 35,
                      width: 50,
                      textColor: colorBlack,
                      colorButton: colorGrey,
                    ),
                    // customItemsIndexes: const [2],
                    // customItemsHeight: 8,
                    items: [
                      ...MenuItems.firstItems.map(
                        (item) => DropdownMenuItem<MenuItem>(
                          value: item,
                          child: MenuItems.buildItem(item),
                        ),
                      ),
                      // const DropdownMenuItem<Divider>(
                      //     enabled: false, child: Divider()),
                      // ...MenuItems.secondItems.map(
                      //   (item) => DropdownMenuItem<MenuItem>(
                      //     value: item,
                      //     child: MenuItems.buildItem(item),
                      //   ),
                      // ),
                    ],
                    onChanged: (value) {
                      MenuItems.onChanged(
                          context, value as MenuItem, viewModel.user);
                    },
                    itemHeight: 48,
                    itemPadding: const EdgeInsets.only(left: 16, right: 16),
                    dropdownWidth: 160,
                    dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: colorBg,
                    ),
                    dropdownElevation: 8,
                    offset: const Offset(0, 8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [donate, messages];

  static const donate = MenuItem(text: 'Donate', icon: Icons.home);
  static const messages = MenuItem(text: 'Nhắn tin', icon: Icons.message);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: blueColor, size: 18),
        sizeBox10,
        Text(
          item.text,
          style: const TextStyle(
            color: colorBlack,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item, UserModel? user) {
    switch (item) {
      case MenuItems.donate:
        // Navigator.of(context).pushNamed(PageRoutes.donate, arguments: user);
        // EasyLoading.showToast("Tính năng đang phát triển");
        break;
      case MenuItems.messages:
        EasyLoading.showToast('Tính năng đang phát triển');
        break;
    }
  }
}
