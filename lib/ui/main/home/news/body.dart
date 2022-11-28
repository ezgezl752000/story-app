import 'package:flutter/material.dart';
import 'package:ns_read_story/ui/main/home/news/news_page_view_model.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../../page_routes.dart';
import '../../../../shared/cache_image_network.dart';

class BodyNewsPage extends StatefulWidget {
  final TabController controller;

  const BodyNewsPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<BodyNewsPage> createState() => _BodyNewsPageState();
}

class _BodyNewsPageState extends State<BodyNewsPage> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NewsPageViewModel>();
    return Expanded(
      child: Container(
        color: colorBg,
        width: context.getWidth(),
        child: TabBarView(
          controller: widget.controller,
          children: viewModel.listCategory.map((e) {
            return SingleChildScrollView(
              child: Wrap(
                children: viewModel.listNews.map((item) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: ItemNews(
                      icon: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImageCustom(
                          url: item.thumbnail ?? '',
                          width: context.getWidth() / 7,
                          height: context.getWidth() / 7,
                          boxFit: BoxFit.cover,
                        ),
                      ),
                      title: item.title ?? '',
                      subTitle: item.description ?? '',
                      time: item.createdAt?.formatDate(),
                      action: () {
                        Navigator.pushNamed(
                          context,
                          PageRoutes.detailNews,
                          arguments: item,
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ItemNews extends StatelessWidget {
  final Widget icon;
  final String title;
  final String subTitle;
  final String? time;
  final Function()? action;
   const ItemNews({Key? key, 
    required this.icon,
    required this.title,
    required this.subTitle,
    this.time,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (action != null) action!();
      },
      child: Container(
        width: context.getWidth(),
        decoration: textFieldDecoration,
        padding: const EdgeInsets.all(5),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              sizeBox10,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        title,
                        style: textBoldNormalBlueDark,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(subTitle,
                          style: textNormal,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    ),
                    time == null
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                time ?? '',
                                style:
                                    textSmallBlueLight.copyWith(fontSize: 12),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              sizeBox10,
              icon,
            ],
          ),
        ),
      ),
    );
  }
}
