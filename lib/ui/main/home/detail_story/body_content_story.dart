import 'package:flutter/material.dart';
import 'package:ns_read_story/page_routes.dart';
import 'package:ns_read_story/shared/cache_image_network.dart';
import 'package:ns_read_story/ui/main/home/detail_story/detail_story_viewmodel.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../../ultils/constants.dart';

class BodyContentStory extends StatefulWidget {
  const BodyContentStory({Key? key}) : super(key: key);

  @override
  State<BodyContentStory> createState() => _BodyContentStoryState();
}

class _BodyContentStoryState extends State<BodyContentStory> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DetailStoryViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Nội dung",style: textBoldNormalBlueDark.copyWith(color: Colors.black87),),
        const Divider(),
        Text( viewModel.detailStory?.description ?? '...',
          style: textNormal.copyWith(color: Colors.black54),),
        // const Divider(),
        // sizeBox10,
        // Text("Đề xuất",style: textBoldNormalBlueDark.copyWith(color: Colors.black87),),
        // sizeBox10,
        // SizedBox(
        //   width: context.getWidth(),
        //   child: Wrap(
        //     alignment: WrapAlignment.start,
        //     spacing: 15,
        //     runAlignment: WrapAlignment.spaceBetween,
        //     runSpacing: 15,
        //     children: viewModel.listStory.map((e) {
        //       return InkWell(
        //         onTap: () {
        //           Navigator.of(context,rootNavigator: true).pushNamed(PageRoutes.detailStory,arguments: e);
        //         },
        //         child: item(
        //             icon: e.thumbnail ?? '',
        //             title: e.name ?? '',
        //             subTitle: e.author?.fullName ?? ''),
        //       );
        //     }).toList(),
        //   ),
        // ),
      ],
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
