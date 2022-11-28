import 'package:flutter/material.dart';
import 'package:ns_read_story/ui/main/home/ranking/item_author.dart';
import 'package:ns_read_story/ui/main/home/ranking/ranking_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tuple/tuple.dart';

import '../../../../shared/dropdown.dart';
import '../../../../ultils/constants.dart';

class AuthorRanking extends StatelessWidget {
  const AuthorRanking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RankingViewModel>();
    return SmartRefresher(
      controller: viewModel.controllerAuthor,
      onRefresh: () async {
        await viewModel.getListAuthor();
        viewModel.controllerAuthor.refreshCompleted();
      },
      child: SingleChildScrollView(
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
                children: viewModel.listAuthor.map((e) {
                  int index = viewModel.listAuthor.indexOf(e);
                  return ItemAuthor(user: e,index:index ,);
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
