import 'package:flutter/material.dart';
import 'package:ns_read_story/page_routes.dart';
import 'package:ns_read_story/shared/app_bar.dart';
import 'package:ns_read_story/shared/cover_loading.dart';
import 'package:ns_read_story/ui/main/home/category/list_story_by_cate/item_story.dart';
import 'package:ns_read_story/ui/main/home/category/list_story_by_cate/list_story_by_cate_viewmodel.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListStoryByCate extends StatefulWidget {
  const ListStoryByCate({Key? key}) : super(key: key);

  @override
  _ListStoryByCateState createState() => _ListStoryByCateState();
}

class _ListStoryByCateState extends State<ListStoryByCate> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ListStoryByCateViewModel>();
    return SafeArea(
        child: Scaffold(
      appBar: MyAppBar(
        title: viewModel.nameCateSelected,
      ),
          backgroundColor: colorBg,
          body: CoverLoading(
            showLoading: viewModel.isLoading,
            child: SmartRefresher(
                  scrollController: viewModel.scrollController,
                  controller: viewModel.refreshController,
                  enablePullUp: viewModel.isLastPage ? false : true,
                  onLoading: () => viewModel.loadMoreStory(),
                  onRefresh: () => viewModel.onRefresh(),
                  child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    sizeBox10,                 
                    SizedBox(
                      height: 40,
                      width: context.getWidth(),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: viewModel.listCategory.map((e) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: InkWell(
                              onTap: ()=>viewModel.selectCate(e.id!,e.name!),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(color: borderTextFieldColor),
                                  borderRadius: BorderRadius.circular(15),
                                  color: e.id == viewModel.idCateSelected ? colorGrey : colorWhite,
                                ),
                                child: Center(
                                  child: Text(
                                    '${e.name}',
                                    style: textGreyItalic,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    sizeBox10,
                    Wrap(
                      runSpacing: 10,
                      children: viewModel.listStory.map((e) {
                        return ItemStoryView(
                            detailStory: e,
                            isView:true,
                            actions: (){
                              Navigator.pushNamed(context, PageRoutes.detailStory,arguments: e);
                            }
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
            ),
          ),
    ),),);
  }
}
