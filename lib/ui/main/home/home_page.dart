import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ns_read_story/page_routes.dart';
import 'package:ns_read_story/repository/user_repository.dart';
import 'package:ns_read_story/shared/cache_image_network.dart';
import 'package:ns_read_story/shared/cover_loading.dart';
import 'package:ns_read_story/shared/search_text_field.dart';
import 'package:ns_read_story/ui/main/home/home_item.dart';
import 'package:ns_read_story/ui/main/home/home_viewmodel.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:ns_read_story/ultils/global_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../shared/dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();   
    return Scaffold(
      backgroundColor: colorBg,
      body: SmartRefresher(
        controller: viewModel.refreshController,
        onRefresh: () => viewModel.onRefresh(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 30),
                SearchTextField(
                  hint: "Tìm kiếm truyện, tác giả hoặc ...",
                  enable: false,
                  action: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(PageRoutes.search);
                  },
                  icon: const Icon(
                    Icons.search_sharp,
                    color: colorBlack,
                  ),
                ),
                sizeBox10,
                CoverLoading(
                  showLoading: viewModel.isLoading,
                  child: CarouselSlider.builder(
                    itemCount: viewModel.homeModel?.listBanner?.length,
                    carouselController: carouselController,
                    itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) {
                      return InkWell(
                          child: CachedNetworkImageCustom(
                        url: viewModel
                                .homeModel?.listBanner?[itemIndex].thumbnail ??
                            '',
                        width: context.getWidth(),
                        boxFit: BoxFit.fitWidth,
                      ));
                    },
                    options: CarouselOptions(
                      aspectRatio: 16 / 8,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 7),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 500),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
                sizeBox10,
                const Divider(),
                sizeBox10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: HomeItem(
                        // icon: 'assets/ic_chart.svg',
                        icon: 'assets/bxh.svg',
                        title: 'Bảng xếp hạng',
                        action: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed(PageRoutes.rankingPage);
                        },
                      ),
                    ),
                    Expanded(
                      child: HomeItem(
                        // icon: 'assets/ic_classify.svg',
                        iconPng: 'assets/The loai.png',
                        title: 'Thể loại',
                        action: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed(PageRoutes.category);
                        },
                      ),
                    ),
                  ],
                ),
                sizeBox20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Truyện hot",
                      style: textTitleBlack,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed(PageRoutes.listStoryHot);
                        },
                        child: const Text(
                          "Xem thêm",
                          style: textNormal,
                        )),
                  ],
                ),
                sizeBox10,
                CoverLoading(
                  showLoading: viewModel.isLoading,
                  child: SizedBox(
                    width: context.getWidth(),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 10,
                        children: viewModel.homeModel?.listHot?.map((e) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed(PageRoutes.detailStory,
                                          arguments: e);
                                },
                                child: item(
                                    icon: e.thumbnail ?? '',
                                    title: e.name ?? '',
                                    subTitle: e.author?.fullName ?? ''),
                              );
                            }).toList() ??
                            [],
                      ),
                    ),
                  ),
                ),
                sizeBox20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Truyện mới",
                      style: textTitleBlack,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed(PageRoutes.listStoryNew);
                        },
                        child: const Text(
                          "Xem thêm",
                          style: textNormal,
                        )),
                  ],
                ),
                sizeBox10,
                CoverLoading(
                  showLoading: viewModel.isLoading,
                  child: SizedBox(
                    width: context.getWidth(),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 10,
                        children: viewModel.homeModel?.listNew?.map((e) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed(PageRoutes.detailStory,
                                          arguments: e);
                                },
                                child: item(
                                    icon: e.thumbnail ?? '',
                                    title: e.name ?? '',
                                    subTitle: e.author?.fullName ?? ''),
                              );
                            }).toList() ??
                            [],
                      ),
                    ),
                  ),
                ),
                sizeBox20,
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     const Text(
                //       "Truyện hoàn thành",
                //       style: textTitleBlack,
                //     ),
                //     InkWell(
                //         onTap: () {
                //           Navigator.of(context, rootNavigator: true)
                //               .pushNamed(PageRoutes.listStoryCompleted);
                //         },
                //         child: const Text(
                //           "Xem thêm",
                //           style: textNormal,
                //         )),
                //   ],
                // ),
                // sizeBox10,
                CoverLoading(
                  showLoading: viewModel.isLoading,
                  child: SizedBox(
                    width: context.getWidth(),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 10,
                        children: viewModel.homeModel?.listCompleted?.map((e) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed(PageRoutes.detailStory,
                                          arguments: e);
                                },
                                child: item(
                                    icon: e.thumbnail ?? '',
                                    title: e.name ?? '',
                                    subTitle: e.author?.fullName ?? ''),
                              );
                            }).toList() ??
                            [],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget item(
      {required String icon, required String title, required String subTitle}) {
    return SizedBox(
      width: context.getWidth() / 3.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CachedNetworkImageCustom(
            url: icon,
            boxFit: BoxFit.cover,
            height: context.getWidth() / 2.5,
            width: context.getWidth() / 3.5,
          ),
          const SizedBox(
            height: 6,
          ),
          Center(
            child: Text(
              title,
              maxLines: 3,
              style: textTitleBlack,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Center(
            child: Text(
              subTitle,
              style: textNormal,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
        ],
      ),
    );
  }
}
