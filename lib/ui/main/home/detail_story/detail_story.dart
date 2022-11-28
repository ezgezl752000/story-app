import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ns_read_story/model/user.dart';
import 'package:ns_read_story/page_routes.dart';
import 'package:ns_read_story/shared/button.dart';
import 'package:ns_read_story/shared/cover_loading.dart';
import 'package:ns_read_story/ui/main/home/detail_story/body.dart';
import 'package:ns_read_story/ui/main/home/detail_story/detail_story_viewmodel.dart';
import 'package:ns_read_story/ui/main/home/detail_story/header.dart';
import 'package:ns_read_story/ui/main/home/detail_story/read_story/read_story_viewmodel.dart';
import 'package:ns_read_story/ui/main/home/detail_story/tab_bar.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:ns_read_story/ultils/global_bloc.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../ultils/app_config.dart';

class DetailStoryScreen extends StatefulWidget {
  const DetailStoryScreen({Key? key}) : super(key: key);

  @override
  _DetailStoryScreenState createState() => _DetailStoryScreenState();
}

class _DetailStoryScreenState extends State<DetailStoryScreen>
    with TickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DetailStoryViewModel>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBg,
        body: CoverLoading(
          showLoading: viewModel.isLoading,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeaderStory(),
                    sizeBox5,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              item(
                                  icon: viewModel.isFollowed
                                      ? const Icon(
                                          Icons.bookmark_rounded,
                                          color: blueColor,
                                        )
                                      : const Icon(
                                          Icons.bookmark_outline_rounded,
                                          color: blueColor),
                                  title: "Theo dõi",
                                  action: () {
                                    if (AppProvider.instance.token == null) {
                                      AppProvider.instance.showDialogLogin(
                                          context,
                                          'Bạn cần đăng nhập để sử dụng tính năng này');
                                    } else {
                                      viewModel.followStory();
                                    }
                                  }),
                              item(
                                  icon: const Icon(
                                      Icons.report_problem_outlined,
                                      color: blueColor),
                                  title: "Báo cáo",
                                  action: () {
                                    viewModel.reportStory(context);
                                  }),
                            ],
                          ),
                        ),
                        sizeBox10,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            decoration: BoxDecoration(
                                color: colorGrey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    onTap: () async {
                                      await Navigator.of(context,
                                              rootNavigator: true)
                                          .pushNamed(PageRoutes.rateStory,
                                              arguments: viewModel.detailStory);
                                      viewModel.getData();
                                      print('>>>>>>>>>>>${viewModel.idBook}');
                                      // createRewardedAd();

                                      // EasyLoading.showToast(
                                      //     'Tính năng đang phát triển');
                                    },
                                    child: item2(
                                        value:
                                            '${viewModel.detailStory?.rateMark?.toStringAsFixed(2)}',
                                        name: "Đánh giá",
                                        hasIcon: true)),
                                item2(
                                    value: viewModel.detailStory?.totalView
                                            .toString() ??
                                        '',
                                    name: "Lượt đọc",
                                    hasIcon: false),
                                item2(
                                    value: viewModel.detailStory?.likeNum
                                            .toString() ??
                                        '',
                                    name: "Lượt tim",
                                    hasIcon: false),
                                item2(
                                    value: viewModel.detailStory?.followNum
                                            .toString() ??
                                        '',
                                    name: "Lượt theo dõi",
                                    hasIcon: false),
                              ],
                            ),
                          ),
                        ),
                        sizeBox20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            NormalButton(
                              text: viewModel.listHistory!.isEmpty
                                  ? "Bắt đầu"
                                  : "Tiếp tục",
                              height: 35,
                              radius: 25,
                              width: context.getWidth() / 2.5,
                              action: () async {
                                await Navigator.pushNamed(
                                    context, PageRoutes.readStory,
                                    arguments: ModelReadStory(
                                        idChapter:
                                            viewModel.listHistory!.isEmpty
                                                ? viewModel.listChapter[0].id
                                                : viewModel
                                                    .listHistory![0].chapterId,
                                        listChapter:
                                            viewModel.detailStory!.chapters,
                                        story: viewModel.detailStory));
                                viewModel.getData();
                                viewModel.getHistoryReadBook();
                              },
                            ),
                            sizeBox10,
                            Visibility(
                              visible: AppConfig.isShowDownload,
                              child: InkWell(
                                onTap: () {
                                  if (AppProvider.instance.token == null) {
                                    AppProvider.instance.showDialogLogin(
                                        context,
                                        'Bạn cần đăng nhập để sử dụng tính năng này');
                                  } else {
                                    viewModel.downloadStory();
                                  }
                                },
                                child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: colorGrey.withOpacity(0.6),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: const Icon(
                                      Icons.download_sharp,
                                      color: Colors.black45,
                                    )),
                              ),
                            )
                          ],
                        ),
                        sizeBox10,
                        TabBarStory(controller: controller!),
                        sizeBox10,
                        BodyStory(
                          controller: controller!,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                  top: 5,
                  left: 10,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: SvgPicture.asset(
                        'assets/ic_back.svg',
                        width: 30,
                        height: 30,
                      ))),
              Positioned(
                  top: 5,
                  right: 10,
                  child: InkWell(
                    onTap: () {
                      // if (Platform.isIOS) {
                      //   Share.share('http://appstore.com/Hải Vương Truyện');
                      // } else {
                      //   Share.share(
                      //       'https://play.google.com/store/apps/details?id=haivuongtruyen.nextsol.vn');
                      // }
                      Share.share(
                            'http://haivuongtruyen.vn/info/${viewModel.idBook}');
                    },
                    child: const Icon(
                      Icons.share,
                      color: Colors.black54,
                      size: 30,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget item(
      {required Icon icon, required String title, required Function() action}) {
    return InkWell(
      onTap: () => action(),
      child: Row(
        children: [
          icon,
          const SizedBox(
            width: 5,
          ),
          Text(
            title,
            style: textNormal.copyWith(color: blueColor, fontSize: 14),
          )
        ],
      ),
    );
  }

  Widget item2(
      {required String value, required String name, required bool hasIcon}) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              value,
              style: textBoldNormalBlueDark.copyWith(color: Colors.black),
            ),
            const SizedBox(
              width: 3,
            ),
            Visibility(
                visible: hasIcon, child: SvgPicture.asset('assets/ic_star.svg'))
          ],
        ),
        const SizedBox(
          height: 3,
        ),
        Text(name)
      ],
    );
  }
}
