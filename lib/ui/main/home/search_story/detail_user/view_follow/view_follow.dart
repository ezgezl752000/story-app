import 'package:flutter/material.dart';
import 'package:ns_read_story/shared/app_bar.dart';
import 'package:ns_read_story/ui/main/home/search_story/detail_user/view_follow/body.dart';
import 'package:ns_read_story/ui/main/home/search_story/detail_user/view_follow/tab_bar.dart';
import 'package:ns_read_story/ui/main/home/search_story/detail_user/view_follow/view_follow_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../../../../ultils/constants.dart';

class ViewFollow extends StatefulWidget {
  const ViewFollow({Key? key}) : super(key: key);

  @override
  _ViewFollowState createState() => _ViewFollowState();
}

class _ViewFollowState extends State<ViewFollow>  with TickerProviderStateMixin{


  TabController? tabController;

  @override
  void initState() {   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ViewFollowViewModel>();
    tabController = TabController(length: 2, vsync: this,initialIndex: viewModel.initIndexTab);
    return Scaffold(
      backgroundColor: colorBg,
      appBar: MyAppBar(
        title: viewModel.user?.fullName ?? '',
      ),
      body: Column(
        children: [
          TabBarViewFollow(controller: tabController!,),
          BodyViewFollow(controller: tabController!,)
        ],
      ),
    );
  }
}
