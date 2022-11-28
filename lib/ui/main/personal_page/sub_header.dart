import 'package:flutter/material.dart';
import 'package:ns_read_story/page_routes.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:ns_read_story/ultils/global_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../ultils/constants.dart';
import 'personal_page_viewmodel.dart';

class SubHeader extends StatelessWidget {
  SubHeader({Key? key}) : super(key: key);

  List<Item> list = [];

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PersonalPageViewModel>();
    list = [
      Item(
          title: 'Người theo dõi',
          extra: '${viewModel.follow?.followed ?? 0}',
          action: () async {
            await Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.viewFollow,
                arguments: [AppProvider.instance.user.id,'0']);
            viewModel.getNumberFollow();
          }),
      Item(
          title: 'Đang theo dõi',
          extra: '${viewModel.follow?.following ?? 0}',
          action: () async {
            await Navigator.of(context, rootNavigator: true).pushNamed(PageRoutes.viewFollow,
                arguments: [AppProvider.instance.user.id,'1']);
            viewModel.getNumberFollow();
          }),
    ];
    return SizedBox(
      width: context.getWidth(),
      child: Wrap(
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
                        style: textBoldBlue,
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
    );
  }
}

class Item {
  String title;
  String extra;
  var action;

  Item({required this.title, required this.extra, required this.action});
}
