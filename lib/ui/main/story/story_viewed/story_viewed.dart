import 'package:flutter/material.dart';
import 'package:ns_read_story/ui/main/story/book_viewmodel.dart';
import 'package:ns_read_story/ui/main/story/item_story_book.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StoryViewed extends StatelessWidget {
  const StoryViewed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<BookViewModel>();
    return SmartRefresher(
      controller: viewModel.refreshControllerStoryViewed,
      onRefresh: () => viewModel.onRefreshStoryViewed(),
      child: Wrap(
        runSpacing: 8,
        spacing: 8,
        children: viewModel.listStoryViewed.map((e) {
          return ItemStoryBook(
            story: e,
            actionDelete: () {
              viewModel.deleteHistory(e);
            },
          );
        }).toList(),
      ),
    );
  }
}
