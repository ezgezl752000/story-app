import 'package:flutter/material.dart';
import 'package:ns_read_story/ui/main/home/detail_story/body_chapter.dart';
import 'package:ns_read_story/ui/main/home/detail_story/body_content_story.dart';
import 'package:ns_read_story/ui/main/home/detail_story/detail_story_viewmodel.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:provider/provider.dart';

class BodyStory extends StatelessWidget {
  TabController controller;
  BodyStory({Key? key,required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DetailStoryViewModel>();
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: colorBg,
        width: context.getWidth(),
        child: Column(
          children:  <Widget>[
            Visibility(
              visible: viewModel.indexTab == 0,
                child: const BodyContentStory()),
            Visibility(
                visible: viewModel.indexTab == 1,
                child: const BodyChapter())
          ],
        )
    );
  }
}




