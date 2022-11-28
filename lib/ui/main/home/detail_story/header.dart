import 'package:flutter/material.dart';
import 'package:ns_read_story/page_routes.dart';
import 'package:ns_read_story/shared/cache_image_network.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../../ultils/constants.dart';
import 'detail_story_viewmodel.dart';

class HeaderStory extends StatefulWidget {
  const HeaderStory({Key? key}) : super(key: key);

  @override
  _HeaderStoryState createState() => _HeaderStoryState();
}

class _HeaderStoryState extends State<HeaderStory> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DetailStoryViewModel>();
    return Stack(
      children: [
        Stack(
          children: [
            // Opacity(
            //   opacity: 0.2,
            //   child: CachedNetworkImageCustom(
            //     url: viewModel.detailStory?.thumbnail ?? '',
            //     boxFit: BoxFit.cover,
            //     height: context.getWidth()/1.6,
            //     width: context.getWidth(),
            //   ),
            // ),
            Image.asset('assets/bg_story.png',
              fit: BoxFit.cover,
              height: context.getWidth()/1.6,
              width: context.getWidth(),
            ),
            Positioned(
              top: context.getWidth()/2.1,
              bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient:LinearGradient(
                      colors: [
                        colorWhiteOpacity,
                        colorWhiteOpacity2,
                      ],
                      begin: FractionalOffset(0, 0),
                      end: FractionalOffset(0, 0.8),
                      stops: [0, 1],
                    )
                  ),
                )
            )
          ],
        ),
        Positioned(
          top: 0,
            bottom: 10,
            right: 25,
            left: 10,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CachedNetworkImageCustom(
                  url: viewModel.detailStory?.thumbnail ?? '',
                  width: context.getWidth()/3.5,
                  boxFit: BoxFit.fitHeight,
                ),
                sizeBox15,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(viewModel.detailStory?.name ?? '',
                          style: textHeaderWhite.copyWith(fontSize: fontSize20,fontWeight: FontWeight.bold,color: const Color(0xff04326f)),
                          // textAlign: TextAlign.center,
                        ),
                      ),
                      sizeBox10,
                      InkWell(
                          onTap: () async{
                            navigatorToUserPage(context, viewModel.detailStory?.author?.id ?? '');
                            // if(viewModel.detailStory?.author?.id == AppProvider.instance.user.id){
                            //   Navigator.of(context,rootNavigator: true).pushNamed(PageRoutes.personalPage, arguments: viewModel.detailStory?.author?.id);
                            // }else{
                            //   await Navigator.pushNamed(context, PageRoutes.detailUser,arguments: viewModel.detailStory?.author?.id);
                            // }
                          },
                          child: Text(viewModel.detailStory?.author?.fullName ?? '',style: const TextStyle(color: blueDarkColor,fontSize: 15),)),
                      const SizedBox(height: 7,),
                      Wrap(
                        runSpacing: 5,
                        spacing: 5,
                        children: viewModel.detailStory?.categories?.map((e) {
                          return InkWell(
                            onTap: (){
                              Navigator.of(context,rootNavigator: true).pushNamed(PageRoutes.listStoryByCate,arguments: [e.id,e.name]);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(color: blueColor),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                '${e.name}',
                                  style: textNormal.copyWith(color: blueColor,fontSize: fontSize13,fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }).toList() ?? [],
                       )
                    ],
                  ),
                )
              ],
            )
        )
      ],
    );
  }
}
