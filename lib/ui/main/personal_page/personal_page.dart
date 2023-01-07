import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ns_read_story/page_routes.dart';
import 'package:ns_read_story/repository/personal_repository.dart';
import 'package:ns_read_story/shared/button.dart';
import 'package:ns_read_story/shared/cover_loading.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:ns_read_story/ultils/global_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../shared/cache_image_network.dart';
import '../../../../shared/dialog.dart';
import 'header.dart';
import 'personal_page_viewmodel.dart';
import 'sub_header.dart';


BuildContext? contextPersonal;
class PersonalPage extends StatefulWidget {
  const PersonalPage({Key? key}) : super(key: key);

  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PersonalPageViewModel>();
    contextPersonal = context;
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBg,
        body: FutureBuilder(
          initialData: AppProvider.instance.token,
          builder: (_, data) {
            if (data.hasData) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Header(heroTag: 'personalPage'),
                        // SubHeader(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: NormalButton(
                            text: AppProvider.instance.isAuthor ?? false
                                ? 'Thêm truyện'
                                : 'Đăng ký làm tác giả',
                            height: 35,
                            width: double.infinity,
                            action: () async {
                              if (AppProvider.instance.isAuthor ?? false) {
                                await Navigator.of(context,
                                        rootNavigator: true)
                                    .pushNamed(PageRoutes.postStory,
                                        arguments: '');
                                viewModel.getData();
                              } else {
                                await Navigator.of(context,
                                        rootNavigator: true)
                                    .pushNamed(PageRoutes.authorRegis);
                                setState(() {});
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                  child: NormalButton(
                                colorButton: colorGrey,
                                textColor: colorBlack,
                                text: 'Chỉnh sửa thông tin cá nhân',
                                height: 35,
                                action: () async {
                                  await Navigator.of(context,
                                          rootNavigator: true)
                                      .pushNamed(PageRoutes.updateProfile);
                                  setState(() {});
                                  print(
                                      '>>>>>>>>>${AppProvider.instance.user.id}');
                                },
                              )),
                              sizeBox10,
                              NormalButton(
                                colorButton: colorGrey,
                                textColor: colorBlack,
                                text: '...',
                                height: 35,
                                width: 50,
                                action: () async {
                                  await Navigator.of(context,
                                          rootNavigator: true)
                                      .pushNamed(PageRoutes.menuPersonalPage);
                                  setState(() {});
                                  viewModel.getData();
                                },
                              ),
                            ],
                          ),
                        ),
                        sizeBox10,
                        if (AppProvider.instance.isAuthor ?? false)
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text('Danh sách truyện',
                                style: textBoldBlack),
                          ),
                        sizeBox10,
                        if (AppProvider.instance.isAuthor ?? false)
                          viewModel.listStory.isEmpty
                              ? const Center(
                                  child: Text(
                                      'Bạn chưa có truyện nào được đăng'))
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Wrap(
                                      spacing: 25,
                                      runSpacing: 20,
                                      children: viewModel.listStory
                                          .where((e) => e.deleted == false)
                                          .toList()
                                          .map((e) {
                                            return InkWell(
                                              onTap: () async {
                                                await Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pushNamed(
                                                        PageRoutes
                                                            .manageStory,
                                                        arguments: e.id);
                                                viewModel.getData();
                                                // Navigator.of(context,
                                                //         rootNavigator: true)
                                                //     .pushNamed(PageRoutes.detailStory,
                                                //         arguments: e);
                                              },
                                              child: CoverLoading(
                                                showLoading:
                                                    viewModel.isLoading,
                                                child: Column(
                                                  children: [
                                                    e.thumbnail != null
                                                        ? CachedNetworkImageCustom(
                                                            url:
                                                                e.thumbnail ??
                                                                    '',
                                                            width:
                                                                (context.getWidth() /
                                                                        3) -
                                                                    24,
                                                            height: context
                                                                    .getWidth() /
                                                                2.5,
                                                            boxFit:
                                                                BoxFit.cover,
                                                          )
                                                        : Image.asset(
                                                            'assets/logo.png',
                                                            width: 80,
                                                            height: 100,
                                                            fit: BoxFit.cover,
                                                            alignment:
                                                                Alignment
                                                                    .topCenter,
                                                          ),
                                                    sizeBox5,
                                                    SizedBox(
                                                      width:
                                                          (context.getWidth() /
                                                                  3) -
                                                              24,
                                                      child: Center(
                                                        child: Text(
                                                          e.name ?? '',
                                                          style:
                                                              textBlackThinTitle
                                                                  .copyWith(
                                                                      fontSize:
                                                                          14),
                                                          maxLines: 2,
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          })
                                          .toList()
                                          .sublist(
                                              0,
                                              viewModel.listStory.length > 5
                                                  ? 6
                                                  : viewModel
                                                      .listStory.length)),
                                ),
                        sizeBox10,
                        if (viewModel.listStory.length > 6)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                            child: NormalButton(
                                text: 'Xem thêm',
                                height: 35,
                                width: context.getWidth(),
                                action: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed(PageRoutes.listStoryManage);
                                }),
                          ),

                        sizeBox10,
                      ],
                    ),
                  ),
                  if (viewModel.showBackButton ?? false)
                    Positioned(
                        top: 5,
                        left: 5,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            iconSize: 25,
                            icon: SvgPicture.asset(
                              'assets/ic_back.svg',
                              width: 30,
                              height: 30,
                            )))
                ],
              );
            } else {
              return Center(
                child: DialogLogin(
                  mess: 'Vui lòng đăng nhập để sử dụng chức năng này',
                  action: () async {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(PageRoutes.login, arguments: 4);
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
