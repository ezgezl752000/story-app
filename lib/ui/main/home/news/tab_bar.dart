// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:ns_read_story/ui/main/home/news/news_page_view_model.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../../ultils/constants.dart';

class TabNews extends StatelessWidget {
  final TabController controller;
  const TabNews({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NewsPageViewModel>();
    return Container(
      width: context.getWidth(),
      color: colorGrey.withOpacity(0.2),
      height: 45,
      child: TabBar(
        onTap: (index) {
          viewModel.selectCate(viewModel.listCategory[index].id);
        },      
        isScrollable: true,
        unselectedLabelColor: colorBlack,
        labelColor: blueColor,
        controller: controller,
        tabs: viewModel.listCategory.map((e) {
          return Tab(
            text: e.name ?? '',
          );
        }).toList(),
      ),
    );
  }
}
