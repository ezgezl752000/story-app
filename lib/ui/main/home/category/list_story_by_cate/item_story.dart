
import 'package:flutter/material.dart';
import 'package:ns_read_story/model/story.dart';
import 'package:ns_read_story/shared/cache_image_network.dart';
import 'package:ns_read_story/ultils/constants.dart';

class ItemStoryView extends StatelessWidget {
  Story detailStory;
  bool isView = false;
  Function()? actions;
  ItemStoryView({Key? key, required this.detailStory,this.actions,required this.isView})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:actions== null ? null : (){
        actions!();
      },
      child: Row(
        children: [
          CachedNetworkImageCustom(
              url: detailStory.thumbnail ?? '',
          width: 80,
            height: 100,
            boxFit: BoxFit.cover,
          ),
          const SizedBox(width: 5,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        detailStory.name ?? '',
                        style: textTitleBlack,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Visibility(
                      visible: detailStory.completed ?? false,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: colorGrey)
                          ),
                          child: const Text("Full",style:  TextStyle(color: colorGrey),),
                        ),
                      ),
                    ),
                      Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: blueColor)
                        ),
                        child: const Text("New",style: TextStyle(color: blueColor),),
                      ),
                    ),
                     Visibility(
                       visible: detailStory.trend ?? false,
                       child: Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: colorRed)
                          ),
                          child: const Text("Hot",style: TextStyle(color: colorRed),),
                        ),
                    ),
                     ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  detailStory.author?.fullName ?? '',
                  style: textBlackThinTitle,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  detailStory.description ?? 'Ông Cư bảo, ông rất kinh ngạc khi thấy bạn mình tay không hạ gục mấy thanh niên lực lưỡng dù chưa từng một ngày luyện võ. Tuy nhiên, câu chuyện mà ông ông Hởi kể về chuyện bỗng nhiên được truyền thụ võ công thần thánh thì ông vẫn hoài nghi.',
                  style: textNormalGray,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    subFunction(
                        const Icon(
                          Icons.remove_red_eye,
                          size: 17,
                          color: textGray,
                        ),
                        '${detailStory.totalView}'),
                    subFunction(
                        const Icon(
                          Icons.menu,
                          size: 17,
                          color: textGray,
                        ),
                        '${detailStory.chapterEnableNum}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  subFunction(Widget icon, String text) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 3,),
        Text(text, style: const TextStyle(color: textGray, fontSize: fontSize14)),
        const SizedBox(
          width: 18,
        )
      ],
    );
  }
}