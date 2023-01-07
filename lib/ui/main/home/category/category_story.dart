import 'package:flutter/material.dart';
import 'package:ns_read_story/page_routes.dart';
import 'package:ns_read_story/shared/app_bar.dart';
import 'package:ns_read_story/ui/main/home/category/category_viewmodel.dart';
import 'package:ns_read_story/ui/main/home/home_item.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../../model/category_model.dart';
import '../../../../shared/cache_image_network.dart';

class CategoryStory extends StatefulWidget {
  const CategoryStory({Key? key}) : super(key: key);

  @override
  _CategoryStoryState createState() => _CategoryStoryState();
}

class _CategoryStoryState extends State<CategoryStory> {


  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CategoryViewModel>();
    return SafeArea(
        child: Scaffold(
          appBar: const MyAppBar(
            title: "Thể loại",
          ),
          backgroundColor: colorBg,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [                 
                  sizeBox10,
                  GridView.builder(
                    itemCount: viewModel.listCategory.length >= viewModel.count ? viewModel.count : viewModel.listCategory.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1,
                    ),
                    primary: false,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      Categories e = viewModel.listCategory[index];
                      return  HomeItem(
                        iconPng: 'assets/The loai.png',
                        title: e.name ?? '',
                        action: (){
                          Navigator.of(context,rootNavigator: true).pushNamed(PageRoutes.listStoryByCate,arguments: [e.id,e.name]);
                        },
                        width: context.getWidth() / 7,
                        height: context.getWidth() / 7,
                      );
                    },
                  ),
                  viewModel.count > 8 ?
                  Center(
                    child: InkWell(
                        onTap: (){
                          viewModel.collapse();
                        },
                        child: const Icon(Icons.keyboard_arrow_up_sharp,color: blueColor,size: 35,)),
                  )
                      :
                  Center(
                    child: InkWell(
                        onTap: (){
                          viewModel.viewMore();
                        },
                        child: const Icon(Icons.keyboard_arrow_down_sharp,color: blueColor,size: 35,)),
                  ),
                  const Divider(),
                  const Text('Danh sách truyện',style: textBoldTitleBlack,),
                  sizeBox10,
                  SizedBox(
                    width: context.getWidth(),
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 15,
                      runAlignment: WrapAlignment.spaceBetween,
                      runSpacing: 15,
                      children: viewModel.listStory.map((e) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context,rootNavigator: true).pushNamed(PageRoutes.detailStory,arguments: e);
                          },
                          child: item(
                              icon: e.thumbnail ?? '',
                              title: e.name ?? '',
                              subTitle: e.author?.fullName ?? ''),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }


  Widget item({required String icon,required String title,required String subTitle}) {
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
