// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:ns_read_story/ultils/extensions.dart';

import '../../../../ultils/constants.dart';

class TabRanking extends StatelessWidget {
  final TabController controller;
  const TabRanking({Key? key,required this.controller}) : super(key: key);

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
            text: 'Truyện hot',
          ),
          Tab(
            text: 'Tác giả',
          ),
          Tab(
            text: 'Dịch giả',
          ),
        ],
        controller: controller,
      ),
    );
  }
}