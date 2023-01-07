import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ns_read_story/model/story.dart';
import 'package:ns_read_story/page_routes.dart';
import 'package:ns_read_story/shared/cache_image_network.dart';
import 'package:ns_read_story/ui/main/home/ranking/ranking_viewmodel.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:provider/provider.dart';

class ItemStoryRanking extends StatelessWidget {
  final Story detailStory;
  final bool isView;
  final Function()? actions;
  const ItemStoryRanking(
      {Key? key,
      required this.detailStory,
      required this.actions,
      required this.isView})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RankingViewModel>();
    return InkWell(
      onTap: () async {
        await Navigator.pushNamed(context, PageRoutes.detailStory,
            arguments: detailStory);
        viewModel.getListStory();
      },
      child: Row(
        children: [
          CachedNetworkImageCustom(
            url: detailStory.thumbnail ?? '',
            width: 80,
            height: 110,
            boxFit: BoxFit.cover,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              detailStory.name ?? '',
                              style: textTitleBlack,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Visibility(
                            visible: detailStory.completed ?? false,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    border: Border.all(color: colorGrey)),
                                child: const Text(
                                  "Full",
                                  style: TextStyle(color: colorGrey),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  border: Border.all(color: blueColor)),
                              child: const Text(
                                "New",
                                style: TextStyle(color: blueColor),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: detailStory.trend ?? false,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    border: Border.all(color: colorRed)),
                                child: const Text(
                                  "Hot",
                                  style: TextStyle(color: colorRed),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: context.getWidth() / 12,
                      child: viewModel.listStory[0].id == detailStory.id
                          ? SvgPicture.asset("assets/ic_rank_top1.svg")
                          : viewModel.listStory[1].id == detailStory.id
                              ? SvgPicture.asset("assets/ic_rank_top2.svg")
                              : viewModel.listStory[2].id == detailStory.id
                                  ? SvgPicture.asset("assets/ic_rank_top3.svg")
                                  : const SizedBox.shrink(),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  detailStory.author?.fullName ?? '',
                  style: textBlackThinTitle,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  detailStory.description ?? '',
                  style: textNormalGray,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    subFunction(
                        const Icon(
                          Icons.remove_red_eye,
                          size: 17,
                          color: textGray,
                        ),
                        '${detailStory.totalView}'),
                    subFunction(
                        const Icon(
                          Icons.favorite,
                          size: 17,
                          color: textGray,
                        ),
                        '${detailStory.likeNum}'),
                    subFunction(
                        const Icon(
                          Icons.menu,
                          size: 17,
                          color: textGray,
                        ),
                        '${detailStory.chapterEnableNum}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  subFunction(Widget icon, String text) {
    return Row(
      children: [
        icon,
        const SizedBox(
          width: 3,
        ),
        Text(text,
            style: const TextStyle(color: textGray, fontSize: fontSize14)),
        const SizedBox(
          width: 18,
        )
      ],
    );
  }
}
