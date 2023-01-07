import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ns_read_story/page_routes.dart';
import 'package:ns_read_story/repository/story_repository.dart';
import 'package:ns_read_story/ui/main/home/search_story/detail_user/detail_user_viewmodel.dart';
import 'package:ns_read_story/ui/main/home/search_story/detail_user/header.dart';
import 'package:ns_read_story/ui/main/home/search_story/detail_user/sub_header.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../shared/button.dart';
import '../../../../../shared/cache_image_network.dart';
import '../../../../../shared/cover_loading.dart';
import '../../../../../ultils/constants.dart';

class DetailUser extends StatefulWidget {
  const DetailUser({Key? key}) : super(key: key);

  @override
  _DetailUserState createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DetailUserViewModel>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBg,
        body: Stack(
          children: [
            SmartRefresher(
              enablePullUp: viewModel.isLastPage ? false : true,
              controller: viewModel.refreshController,
              scrollController: viewModel.scrollController,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeaderDetailUser(),
                    SubHeader(),
                    sizeBox10,
                    // if (viewModel.user?.listRole
                    //         ?.map((e) => e.id)
                    //         .toList()
                    //         .contains('AUTHOR') ??
                    //     false)
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text('Danh sách truyện', style: textBoldBlack),
                    ),
                    sizeBox10,
                    // if (viewModel.user?.listRole
                    //         ?.map((e) => e.id)
                    //         .toList()
                    //         .contains('AUTHOR') ??
                    //     false)
                    viewModel.listStory.isEmpty
                        ? const Center(child: Text('Chưa có truyện'))
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Wrap(
                              spacing: 25,
                              runSpacing: 20,
                              children: viewModel.listStory
                                  .where((e) => e.deleted == false)
                                  .toList()
                                  .map((e) {
                                    return InkWell(
                                      onTap: () => Navigator.of(context,
                                              rootNavigator: true)
                                          .pushNamed(PageRoutes.detailStory,
                                              arguments: e),
                                      child: CoverLoading(
                                        showLoading: viewModel.isLoading,
                                        child: Column(
                                          children: [
                                            e.thumbnail != null
                                                ? CachedNetworkImageCustom(
                                                    url: e.thumbnail ?? '',
                                                    width: (context.getWidth() /
                                                            3) -
                                                        24,
                                                    height: context.getWidth() /
                                                        2.5,
                                                    boxFit: BoxFit.cover,
                                                  )
                                                : Image.asset(
                                                    'assets/logo.png',
                                                    width: 80,
                                                    height: 100,
                                                    fit: BoxFit.cover,
                                                    alignment:
                                                        Alignment.topCenter,
                                                  ),
                                            sizeBox5,
                                            SizedBox(
                                              width:
                                                  (context.getWidth() / 3) - 24,
                                              child: Center(
                                                child: Text(
                                                  e.name ?? '',
                                                  style: textBlackThinTitle
                                                      .copyWith(fontSize: 14),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                          : viewModel.listStory.length),
                            ),
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
                                  .pushNamed(PageRoutes.listStoryManage,
                                      arguments: viewModel.idUser);
                            }),
                      ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text('Bài viết', style: textBoldBlack),
                    ),
                    sizeBox10,
                  ],
                ),
              ),
            ),
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
        ),
      ),
    );
  }
}
