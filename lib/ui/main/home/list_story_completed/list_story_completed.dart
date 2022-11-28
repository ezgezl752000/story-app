import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../page_routes.dart';
import '../../../../shared/app_bar.dart';
import '../../../../shared/cover_loading.dart';
import '../../../../ultils/constants.dart';
import '../category/list_story_by_cate/item_story.dart';
import 'list_story_completed_viewmodel.dart';

class ListStoryCompleted extends StatefulWidget {
  const ListStoryCompleted({Key? key}) : super(key: key);

  @override
  _ListStoryCompletedState createState() => _ListStoryCompletedState();
}

class _ListStoryCompletedState extends State<ListStoryCompleted> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ListStoryCompletedViewModel>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBg,
        appBar: const MyAppBar(title: "Danh sách truyện mới"),
        body: CoverLoading(
          showLoading: viewModel.isLoading,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  sizeBox10,
                  Wrap(
                    runSpacing: 10,
                    children: viewModel.listStory.map((e) {
                      return ItemStoryView(
                          detailStory: e,
                          actions: () {
                            Navigator.pushNamed(context, PageRoutes.detailStory,
                                arguments: e);
                          },
                          isView: true);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
