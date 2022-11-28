import 'package:flutter/material.dart';
import 'package:ns_read_story/ui/main/book/story_downloaded/story_downloaded.dart';
import 'package:ns_read_story/ui/main/book/story_followed/story_followed.dart';
import 'package:ns_read_story/ui/main/book/story_viewed/story_viewed.dart';
import 'package:ns_read_story/ultils/extensions.dart';

import '../../../ultils/constants.dart';

// ignore: must_be_immutable
class BodyBook extends StatelessWidget {
  TabController controller;
   BodyBook({Key? key,required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
          color: colorBg,
          width: context.getWidth(),
          child: TabBarView(
            children: const <Widget>[
              StoryFollowed(),
              StoryViewed(),
              StoryDownloaded(),
            ],
            controller: controller,
          )
      ),
    );
  }
}
