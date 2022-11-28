import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:ns_read_story/model/story_history.dart';
import 'package:ns_read_story/page_routes.dart';
import 'package:ns_read_story/shared/cache_image_network.dart';
import 'package:ns_read_story/ui/main/book/book_viewmodel.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:provider/provider.dart';

class ItemStoryBook extends StatelessWidget {
  final StoryHistory story;
  final Function()? actionDelete;
  const ItemStoryBook({Key? key,required this.story,required this.actionDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<BookViewModel>();
    return InkWell(
      onTap: () async{
       await Navigator.of(context,rootNavigator: true).pushNamed(PageRoutes.detailStory,arguments: story.bookInfo);
       viewModel.getData();
      },
      child: Badge(
        badgeContent: InkWell(
            onTap: () async {
             if(actionDelete != null) actionDelete!();
            },
            child: const Icon(Icons.close,size: 20,)),
        badgeColor: colorWhite,
        alignment: Alignment.topRight,
        child: SizedBox(
          width: context.getWidth() / 3.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImageCustom(
                url: story.bookInfo?.thumbnail ?? '',
                boxFit: BoxFit.cover,
                height: context.getWidth() / 2.5,
                width: context.getWidth() / 3.5,
              ),
              const SizedBox(height: 6,),
              Center(
                child: Text(story.bookInfo?.name ?? '',
                  style: textTitleBlack,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,),
              ),
              const SizedBox(height: 6,),
              story.chapter == null ? const SizedBox() :
              Center(child: Text(story.chapter?.name ?? '',style: textNormal.copyWith(color: colorGrey),maxLines: 2,overflow: TextOverflow.ellipsis,)),
              story.chapter == null ? const SizedBox() :   const SizedBox(height: 6,),
              Center(child: Text(story.bookInfo?.author?.fullName ?? '',style: textNormal,textAlign: TextAlign.center,)),
              const SizedBox(height: 6,),
            ],
          ),
        ),
      ),
    );
  }
}
