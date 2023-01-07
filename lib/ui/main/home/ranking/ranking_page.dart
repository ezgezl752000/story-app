import 'package:flutter/material.dart';
import 'package:ns_read_story/shared/app_bar.dart';
import 'package:ns_read_story/ui/main/home/ranking/tab_bar.dart';
import 'package:ns_read_story/ultils/constants.dart';

import 'body.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({Key? key}) : super(key: key);

  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> with TickerProviderStateMixin {

  TabController? tabController;

  @override
  void initState() {    
    super.initState();
    tabController = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      appBar: const MyAppBar(
        title: "Bảng xếp hạng",
      ),
      body: Column(
        children: [
          TabRanking(controller: tabController!,),
          BodyRankingPage(controller: tabController!,)
        ],
      ),
    );
  }
}
