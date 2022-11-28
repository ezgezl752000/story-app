import 'package:flutter/material.dart';
import 'package:ns_read_story/ui/main/home/search_story/detail_user/view_follow/list_my_follow.dart';
import 'package:ns_read_story/ui/main/home/search_story/detail_user/view_follow/list_my_following.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';

class BodyViewFollow extends StatefulWidget {
  TabController controller;
   BodyViewFollow({Key? key,required this.controller}) : super(key: key);

  @override
  _BodyViewFollowState createState() => _BodyViewFollowState();
}

class _BodyViewFollowState extends State<BodyViewFollow> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          color: colorBg,
          width: context.getWidth(),
          child: TabBarView(
            children: const  [
              ListMyFollow(),
              ListMyFollowing(),
            ],
            controller: widget.controller,
          )),
    );
  }
}
