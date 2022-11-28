import 'package:flutter/material.dart';
import 'package:ns_read_story/shared/app_bar.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/global_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../../page_routes.dart';
import '../../../../../shared/cover_loading.dart';
import '../../../../../shared/dialog.dart';
import '../item_story.dart';
import '../personal_page_viewmodel.dart';

class ListStoryManage extends StatelessWidget {
  const ListStoryManage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PersonalPageViewModel>();
    return Scaffold(
      backgroundColor: colorBg,
      appBar: MyAppBar(
        title: 'Truyện đã đăng',
        actions: [
          TextButton(
              onPressed: () async {
                await Navigator.of(context, rootNavigator: true)
                    .pushNamed(PageRoutes.postStory, arguments: '');
                viewModel.getData();
              },
              child: const Text('Thêm truyện', style: textBoldBlue)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              viewModel.listStory.isEmpty
                  ? const Center(
                      child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text('Bạn chưa có truyện nào được đăng'),
                    ))
                  : Wrap(
                      children: viewModel.listStory
                          .where((e) => e.deleted == false)
                          .toList()
                          .map((e) {
                      return CoverLoading(
                        showLoading: viewModel.isLoading,
                        child: ItemStoryManager(
                          idUser: AppProvider.instance.user.id ?? '',
                          detailStory: e,
                          isView: false,
                          isEnable: e.enabled ?? false,
                          actions: () async {
                            Navigator.pop(context);
                            await Navigator.of(context, rootNavigator: true)
                                .pushNamed(PageRoutes.manageStory,
                                    arguments: e.id);
                            viewModel.getData();
                          }, //
                          actionsDelete: () {
                            showDialog(
                              context: context,
                              builder: (context) => DialogConfirmQuestion(
                                mess: 'Bạn có chắc chắn muốn xóa truyện này?',
                                action: () async {
                                  await viewModel.deleteStory(e.id!);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          },
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
