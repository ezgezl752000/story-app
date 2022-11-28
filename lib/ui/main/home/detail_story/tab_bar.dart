import 'package:flutter/material.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:provider/provider.dart';

import 'detail_story_viewmodel.dart';

// ignore: must_be_immutable
class TabBarStory extends StatelessWidget {
  TabController controller;
  TabBarStory({Key? key,required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DetailStoryViewModel>();
    return SizedBox(
      width: context.getWidth(),
      height: 40,
      child: TabBar(
        labelColor: blueColor,
        onTap:(index) => viewModel.selectTab(index),
        unselectedLabelColor: Colors.black,
        tabs: const <Tab>[
          Tab(
            text: 'Tóm tắt nội dung',
          ),
          Tab(
            text: 'Danh sách chương',
          ),
        ],
        controller: controller,
      ),
    );
  }
}
