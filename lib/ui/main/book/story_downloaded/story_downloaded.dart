import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ns_read_story/model/detail_story.dart';
import 'package:ns_read_story/page_routes.dart';
import 'package:ns_read_story/shared/cache_image_network.dart';
import 'package:ns_read_story/ultils/extensions.dart';

import '../../../../ultils/constants.dart';

class StoryDownloaded extends StatefulWidget {
  const StoryDownloaded({Key? key}) : super(key: key);

  @override
  _StoryDownloadedState createState() => _StoryDownloadedState();
}

class _StoryDownloadedState extends State<StoryDownloaded> {
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WatchBoxBuilder(
      box: Hive.box('story'),
      builder: (_,storyBox){
        return GridView.builder(
          itemCount: storyBox.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.47,
            crossAxisSpacing: 15,
            mainAxisSpacing: 10
          ),
          primary: false,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final story = storyBox.getAt(index) as Story;
            return InkWell(
              onTap: () {
                Navigator.of(context,rootNavigator: true).pushNamed(PageRoutes.detailStory,arguments: story);
              },
              child: Badge(
                badgeContent: InkWell(
                    onTap: () async {
                      storyBox.deleteAt(index);
                      setState(() {});
                    },
                    child: const Icon(Icons.close,size: 15,)),
                badgeColor: colorWhite,
                alignment: Alignment.topRight,
                child: item(
                    icon: story.thumbnail ?? '',
                    title: story.name ?? '',
                    subTitle: story.author?.fullName ?? ''
                ),
              ),
            );
          },
        );
    },
    );
  }


  Widget item(
      {required String icon, required String title, required String subTitle}) {
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
            height: 5,
          ),
          Center(
            child: Text(
              title,
              maxLines: 2,
              style: textTitleBlack,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Center(
            child: Text(
              subTitle,
              style: textNormal,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 3 ,
          ),
        ],
      ),
    );
  }
}
