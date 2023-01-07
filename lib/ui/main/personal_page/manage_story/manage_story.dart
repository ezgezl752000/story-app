import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ns_read_story/page_routes.dart';
import 'package:ns_read_story/shared/app_bar.dart';
import 'package:ns_read_story/shared/button.dart';
import 'package:ns_read_story/shared/cover_loading.dart';
import 'package:ns_read_story/shared/dialog.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:provider/provider.dart';

import '../../../../../model/chapter.dart';
import '../personal_page_viewmodel.dart';
import 'manager_story_viewmodel.dart';

class ManageStory extends StatelessWidget {
  const ManageStory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ManagerStoryViewModel>();
    final viewModelDetailPersonal = context.watch<PersonalPageViewModel>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBg,
        appBar: MyAppBar(
          title: 'Quản lý truyện',
          actions: [
            IconButton(
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.black,
                size: 25,
              ),
              onPressed: () {
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    context: context,
                    builder: (builder) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(Icons.edit, color: blueColor),
                            title: const Text('Chỉnh sửa'),
                            onTap: () async {
                              Future.delayed(Duration.zero).then((_) async {
                                Navigator.pop(builder);
                                await Navigator.of(context, rootNavigator: true)
                                    .pushNamed(PageRoutes.postStory,
                                        arguments: viewModel.idBook);
                                viewModel.getDetailStory();
                              });
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.delete, color: colorRed),
                            title: const Text('Xóa'),
                            onTap: () {
                              Navigator.pop(builder);
                              Future.delayed(Duration.zero)
                                  .then((_) => showDialog(
                                        context: context,
                                        builder: (context) =>
                                            DialogConfirmQuestion(
                                          mess:
                                              'Bạn có chắc chắn muốn xóa truyện này?',
                                          action: () async {
                                            await viewModelDetailPersonal
                                                .deleteStory(viewModel.idBook);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ));
                            },
                          ),
                        ],
                      );
                    });
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: marginHorizontal),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizeBox10,
                Text(
                  viewModel.story?.name ?? '',
                  style: textBoldBlack,
                ),
                sizeBox10,
                Text.rich(TextSpan(
                    text: viewModel.showMore
                        ? viewModel.story?.description ?? ''
                        : (viewModel.story?.description ?? '').length > 200
                            ? '${viewModel.story?.description?.substring(0, 200) ?? ''}...'
                            : viewModel.story?.description ?? '',
                    style: textNormal,
                    children: [
                      if ((viewModel.story?.description ?? '').length > 200)
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => viewModel.toggleShowText(),
                          text: viewModel.showMore ? ' Thu gọn' : 'Xem thêm',
                          style: textNormal.copyWith(color: blueColor),
                        )
                    ])),
                sizeBox10,
                const Text(
                  'Danh sách chương',
                  style: textBoldBlack,
                ),
                CoverLoading(
                  showLoading: viewModel.isLoading,
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: viewModel.listChapter.length,
                    itemBuilder: (context, index) {
                      final Chapter chapter = viewModel.listChapter[index];
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text.rich(TextSpan(
                                    text: chapter.name ?? '',
                                    style: textNormal,
                                    children: [
                                      TextSpan(
                                        text: chapter.enabled == false
                                            ? ' (Đang chờ duyệt)'
                                            : '',
                                        style: textNormal.copyWith(
                                            color: colorRed),
                                      )
                                    ])),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.more_horiz,
                                  color: Colors.black,
                                  size: 25,
                                ),
                                onPressed: () {
                                  showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                      ),
                                      context: context,
                                      builder: (builder) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            ListTile(
                                              leading: const Icon(Icons.edit,
                                                  color: blueColor),
                                              title: const Text('Chỉnh sửa'),
                                              onTap: () async {
                                                Navigator.pop(builder);
                                                await Navigator.pushNamed(
                                                    context,
                                                    PageRoutes.addChapter,
                                                    arguments: [
                                                      chapter.id,
                                                      'true',
                                                      viewModel.idBook,
                                                      '${(viewModel.story!.totalView! > 30000)}'
                                                    ]);
                                                await viewModel
                                                    .getListChapter();
                                              },
                                            ),
                                            ListTile(
                                              leading: const Icon(Icons.delete,
                                                  color: colorRed),
                                              title: const Text('Xóa'),
                                              onTap: () {
                                                Navigator.pop(builder);
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      DialogConfirmQuestion(
                                                    mess:
                                                        'Bạn có chắc chắn muốn xóa chương này?',
                                                    action: () async {
                                                      await viewModel
                                                          .deleteChapter(
                                                              chapter.id!);
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                              ),
                              // Row(
                              //   children: [
                              //     IconButton(
                              //         onPressed: () async {
                              //           await Navigator.pushNamed(
                              //               context, PageRoutes.addChapter,
                              //               arguments: [
                              //                 chapter.id,
                              //                 'true',
                              //                 viewModel.idBook,
                              //                 '${(viewModel.story!.totalView! > 30000)}'
                              //               ]);
                              //           await viewModel.getListChapter();
                              //         },
                              //         icon: Icon(Icons.edit, color: blueColor)),
                              //     IconButton(
                              //       icon: Icon(Icons.delete, color: colorRed),
                              //       onPressed: () {
                              //         showDialog(
                              //           context: context,
                              //           builder: (context) =>
                              //               DialogConfirmQuestion(
                              //             mess:
                              //                 'Bạn có chắc chắn muốn xóa chương này?',
                              //             action: () async {
                              //               await viewModel
                              //                   .deleteChapter(chapter.id!);
                              //               Navigator.pop(context);
                              //             },
                              //           ),
                              //         );
                              //       },
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: colorGrey,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () => viewModel.backPage(),
                          child: Icon(Icons.navigate_before_sharp,
                              size: 25,
                              color: viewModel.canBackPage ? null : colorGrey)),
                      const SizedBox(
                        width: 10,
                      ),
                      Text('${viewModel.page + 1}'),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () => viewModel.nextPage(),
                          child: Icon(
                            Icons.navigate_next_sharp,
                            size: 25,
                            color: viewModel.canNextPage ? null : colorGrey,
                          )),
                    ],
                  ),
                ),
                Center(
                  child: ButtonRadius(
                    action: () async {
                      // showDialog(
                      //     context: context,
                      //     builder: (context) => DialogSuccess(
                      //           mess:
                      //               'Giá chương sẽ được bật khi truyện đạt đủ 30k view tính tổng truyện',
                      //           action: () async{
                      //            await Navigator.pushNamed(
                      //                 context, PageRoutes.addChapter,
                      //                 arguments: ['', 'false',viewModel.idBook,'${(viewModel.story!.totalView! > 30000)}']);
                      //            viewModel.getListChapter();
                      //           },
                      //         ));
                      await Navigator.pushNamed(context, PageRoutes.addChapter,
                          arguments: [
                            '',
                            'false',
                            viewModel.idBook,
                            '${(viewModel.story!.totalView! > 30000)}'
                          ]);
                      viewModel.getListChapter();
                    },
                    text: 'Thêm chương mới',
                    width: 300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
