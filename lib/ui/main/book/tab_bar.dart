import 'package:flutter/material.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';

// ignore: must_be_immutable
class TabBook extends StatelessWidget {
  TabController controller;
   TabBook({Key? key,required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth(),
      color: colorGrey.withOpacity(0.2),
      height: 45,
      child: TabBar(
        labelColor: blueColor,
        unselectedLabelColor: Colors.black,
        tabs: const <Tab>[
          Tab(
            text: 'Đang theo dõi',
          ),
          Tab(
            text: 'Vừa xem',
          ),
          Tab(
            text: 'Tải xuống',
          ),
        ],
        controller: controller,
      ),
    );
  }
}
