import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ns_read_story/shared/button.dart';
import 'package:ns_read_story/shared/textfield.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../repository/story_repository.dart';
import '../../../../../shared/app_bar.dart';
import '../../../../../shared/cache_image_network.dart';
import 'rate_story_viewmodel.dart';

class RateStory extends StatelessWidget {
  const RateStory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RateStoryViewModel>();
    return Scaffold(
        backgroundColor: colorBg,
        appBar: const MyAppBar(
          title: "Đánh giá",
        ),
        body: SmartRefresher(
          enablePullUp: viewModel.isLastPage ? false : true,
          onLoading: () => viewModel.loadMoreRatePage(),
          onRefresh: () => viewModel.onRefreshRate(),
          controller: viewModel.refreshRateController,
          scrollController: viewModel.scrollController,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  sizeBox10,
                  Container(
                      width: context.getWidth(),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: colorGrey,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${viewModel.detailStory.rateMark?.toStringAsFixed(2) ?? 0}',
                                    style: textBoldBlue.copyWith(fontSize: 50),
                                  ),
                                  RatingBarIndicator(
                                    rating: viewModel.detailStory.rateMark ?? 0,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 18,
                                    direction: Axis.horizontal,
                                  ),
                                  sizeBox20,
                                  Text(
                                    '${viewModel.detailStory.rateCount ?? 0} đánh giá',
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Wrap(
                                runSpacing: 8,
                                children: [5, 4, 3, 2, 1].map((number) {
                                  return LinearPercentIndicator(
                                    leading: Text('$number'),
                                    animation: true,
                                    barRadius: const Radius.circular(10),
                                    lineHeight: 12,
                                    percent: viewModel.listRateStory
                                            .where((element) =>
                                                element.ratePoint == number)
                                            .toList()
                                            .isEmpty
                                        ? 0
                                        : viewModel.listRateStory
                                                .where((element) =>
                                                    element.ratePoint == number)
                                                .toList()
                                                .length /
                                            viewModel.listRateStory.length,
                                    backgroundColor: Colors.grey,
                                    progressColor: Colors.blue,
                                  );
                                }).toList(),
                              ),
                            )
                          ],
                        ),
                      )),
                  sizeBox10,
                  NormalButton(
                    text: "Viết đánh giá",
                    height: 35,
                    width: context.getWidth(),
                    action: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          context: context,
                          builder: (builder) {
                            return ChangeNotifierProvider(
                                create: (_) => RateStoryViewModel(
                                    detailStory: viewModel.detailStory,
                                    storyRepository:
                                        context.read<StoryRepository>()),
                                child: const ModalRateStory());
                          });
                    },
                  ),
                  sizeBox10,
                  Wrap(
                    runSpacing: 10,
                    children: viewModel.listRateStory.map((e) {
                      return Container(
                        width: context.getWidth(),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: colorGrey,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(150),
                                    child: e.avatarUrl != null
                                        ? CachedNetworkImageCustom(
                                            url: e.avatarUrl ?? '',
                                            width: context.getWidth() / 9,
                                            height: context.getWidth() / 9,
                                            boxFit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'assets/logo.png',
                                            width: context.getWidth() / 9,
                                            height: context.getWidth() / 9,
                                            fit: BoxFit.cover,
                                            alignment: Alignment.topCenter,
                                          ),
                                  ),
                                  sizeBox10,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(e.fullName ?? '',
                                            style: textTitleBlack),
                                        const SizedBox(height: 5),
                                        RatingBarIndicator(
                                          rating: e.ratePoint ?? 0,
                                          itemBuilder: (context, index) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 5,
                                          itemSize: 18,
                                          direction: Axis.horizontal,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(e.createdAt.toString().formatDateVN(),
                                      style: textHint),
                                ],
                              ),
                              const Divider(),
                              Text(e.reviewContent ?? '')
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}


class ModalRateStory extends StatefulWidget {
  const ModalRateStory({Key? key}) : super(key: key);

  @override
  State<ModalRateStory> createState() => _ModalRateStoryState();
}

class _ModalRateStoryState extends State<ModalRateStory> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RateStoryViewModel>();
    return Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              sizeBox10,
              Text(viewModel.status,
                  style: textNormal.copyWith(
                      fontSize: 20)),
              sizeBox10,
              RatingBar.builder(
                initialRating: 4,
                minRating: 1,
                direction: Axis.horizontal,
                // allowHalfRating: true,
                itemCount: 5,
                itemPadding:
                const EdgeInsets.symmetric(
                    horizontal: 4.0),
                itemBuilder: (context, _) =>
                const Icon(Icons.star,
                    color: Colors.amber),
                onRatingUpdate: (rating) {
                  viewModel
                      .changeStatus(rating.toInt());
                  setState(() {

                  });
                },
              ),
              sizeBox10,
              TextFieldCustom(
                controller: viewModel
                    .reviewContentController,
                hintText: "Viết gì đó...",
                maxLine: 7,
              ),
              sizeBox10,
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () =>
                          Navigator.pop(context),
                      child:
                      const Text('Quay lại')),
                  NormalButton(
                    text: "Gửi",
                    height: 35,
                    width: context.getWidth() / 5,
                    action: () async {
                      await viewModel
                          .rateStory(context);
                      await viewModel
                          .getListRateStory(
                          viewModel.detailStory
                              .id ??
                              '');
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

