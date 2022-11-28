import 'package:flutter/material.dart';
import 'package:ns_read_story/shared/app_bar.dart';
import 'package:ns_read_story/ui/main/home/news/tab_bar.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:provider/provider.dart';

import 'body.dart';
import 'news_page_view_model.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with TickerProviderStateMixin {
  TabController? tabController;
  int selectedIndex = 0;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final viewModel = context.watch<NewsPageViewModel>();
    tabController = TabController(
        vsync: this,
        length: viewModel.listCategory.length,
        initialIndex: selectedIndex);
    if (viewModel.listNews.isEmpty) {
      viewModel.selectCate(viewModel.listCategory[selectedIndex].id);
    }
    tabController!.addListener(() {
      setState(() {
        selectedIndex = tabController!.index;
      });
      viewModel.selectCate(viewModel.listCategory[selectedIndex].id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      appBar: const  MyAppBar(
        title: "Tin tức",
      ),
      body: Column(
        children: [
         sizeBox10,
          SizedBox(
            width: context.getWidth(),
            height: context.getHeight() * 0.25,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:10),
              child: ClipRRect(child: Image.asset('assets/banner.jpeg', fit: BoxFit.cover)),
            )),
          sizeBox10,
          TabNews(controller: tabController!),
          BodyNewsPage(controller: tabController!),
        ],
      ),
    );
  }
}
