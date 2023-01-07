import 'package:flutter/material.dart';
import 'package:ns_read_story/ui/main/story/book_viewmodel.dart';
import 'package:ns_read_story/ui/main/story/item_story_book.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StoryFollowed extends StatelessWidget {
  const StoryFollowed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<BookViewModel>();
    return SmartRefresher(
      controller: viewModel.refreshControllerStoryFollowed,
      onRefresh: () => viewModel.onRefreshStoryFollowed(),
      child: Wrap(
        runSpacing: 8,
        spacing: 8,
        children:  viewModel.listStoryFollowed.map((e) {
          return ItemStoryBook(
            story: e,
            actionDelete: () async{
              viewModel.unFollowStory(e);
            },
          );
        }).toList(),
      ),
    );
  }
}
