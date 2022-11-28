import 'package:flutter/material.dart';
import 'package:ns_read_story/page_routes.dart';
import 'package:ns_read_story/shared/app_bar.dart';
import 'package:ns_read_story/shared/cover_loading.dart';
import 'package:ns_read_story/ui/main/home/list_storys_hot/list_story_hot_viewmodel.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:provider/provider.dart';

import '../category/list_story_by_cate/item_story.dart';

class ListStoryHot extends StatefulWidget {
  const ListStoryHot({Key? key}) : super(key: key);

  @override
  _ListStoryHotState createState() => _ListStoryHotState();
}

class _ListStoryHotState extends State<ListStoryHot> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ListStoryHotViewModel>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBg,
        appBar: const MyAppBar(
          title: "Danh sách truyện hot",
        ),
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
