import 'package:flutter/material.dart';
import 'package:ns_read_story/page_routes.dart';
import 'package:ns_read_story/ui/main/home/category/list_story_by_cate/item_story.dart';
import 'package:ns_read_story/ui/main/home/list_story_new/list_story_new_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../../shared/app_bar.dart';
import '../../../../shared/cover_loading.dart';
import '../../../../ultils/constants.dart';

class ListStoryNew extends StatefulWidget {
  const ListStoryNew({Key? key}) : super(key: key);

  @override
  _ListStoryNewState createState() => _ListStoryNewState();
}

class _ListStoryNewState extends State<ListStoryNew> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ListStoryNewViewModel>();
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
