import 'package:flutter/material.dart';
import 'package:ns_read_story/ui/main/home/search_story/detail_user/view_follow/item_user_follow.dart';
import 'package:ns_read_story/ui/main/home/search_story/detail_user/view_follow/view_follow_viewmodel.dart';
import 'package:provider/provider.dart';

class ListMyFollow extends StatelessWidget {
  const ListMyFollow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ViewFollowViewModel>();
    return SingleChildScrollView(
      child: Column(
        children: [
          Wrap(
            children: viewModel.listMyFollow?.map((e) {
              return ItemUserFollow(user: e.userFollowing!,);
            }).toList() ?? [],
          ),
        ],
      ),
    );
  }
}
