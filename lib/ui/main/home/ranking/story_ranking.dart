import 'package:flutter/material.dart';
import 'package:ns_read_story/page_routes.dart';
import 'package:ns_read_story/shared/dropdown.dart';
import 'package:ns_read_story/ui/main/home/ranking/item_story_ranking.dart';
import 'package:ns_read_story/ui/main/home/ranking/ranking_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../../../../ultils/constants.dart';

class StoryRanking extends StatelessWidget {
  const StoryRanking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RankingViewModel>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizeBox10,
            DropDownCustomRounded<String>(
              listItem: const [
                Tuple2("Ngày", "totalOfDay"),
                Tuple2("Tháng", "totalOfMonth"),
                Tuple2("Năm", "totalOfYear"),
                Tuple2("Toàn bộ", "totalView"),
              ],
              value: viewModel.type,
              onChange: (value) async{
               await viewModel.setType(value);
              },
            ),
            sizeBox10,
            Wrap(
              runSpacing: 10,
              children: viewModel.listStory.map((e) {
                return ItemStoryRanking(
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
    );
  }
}
