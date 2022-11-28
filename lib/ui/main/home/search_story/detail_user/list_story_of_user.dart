import 'package:flutter/material.dart';
import 'package:ns_read_story/shared/app_bar.dart';
import 'package:ns_read_story/ui/main/home/search_story/detail_user/detail_user_viewmodel.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/cover_loading.dart';
import '../../../personal_page/item_story.dart';
class ListStoryOfUser extends StatelessWidget {
  const ListStoryOfUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DetailUserViewModel>();
    return Scaffold(
      backgroundColor: colorBg,
      appBar: const MyAppBar(
        title: 'Danh sách truyện',
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5,0,5,5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              sizeBox10,
              Wrap(
                  children: viewModel.listStory
                      .where((e) => e.deleted == false && e.enabled == true)
                      .toList()
                      .map((e) {
                    return CoverLoading(
                      showLoading: viewModel.isLoading,
                      child: ItemStoryManager(
                        idUser: viewModel.idUser,
                        detailStory: e,
                        isView: false,
                        isEnable: e.enabled ?? false,
                        actions: null,
                        actionsDelete: null,
                      ),
                    );
                  }).toList()),
            ],
          ),
        ),
      ),
    );
  }
}
