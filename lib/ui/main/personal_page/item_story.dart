import 'package:flutter/material.dart';
import 'package:ns_read_story/model/detail_story.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/global_bloc.dart';

import '../../../../page_routes.dart';
import '../../../../shared/cache_image_network.dart';

class ItemStoryManager extends StatelessWidget {
 final Story detailStory;
 final bool isView;
 final Function()? actions;
 final bool isEnable;
 final Function()? actionsDelete;
 final String idUser;
 const ItemStoryManager(
      {Key? key,
      required this.detailStory,
      required this.actions,
      this.isView = false,
      required this.actionsDelete,
      required this.isEnable,
      required this.idUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context, rootNavigator: true)
          .pushNamed(PageRoutes.detailStory, arguments: detailStory),
      child: Container(
        padding: const EdgeInsets.all(5),
        // color: Colors.blue,
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImageCustom(
                    url: detailStory.thumbnail ?? '',
                    width: 80,
                    height: 100,
                    boxFit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                detailStory.name ?? '',
                                maxLines: 2,
                                style: textTitleBlack,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(
                              width: 45,
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
                        Flexible(
                          child: Text(
                            detailStory.description ?? '...',
                            style: textNormalGray,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
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
                                  Icons.favorite,
                                  size: 17,
                                  color: textGray,
                                ),
                                '${detailStory.likeNum}'),
                            subFunction(
                                const Icon(
                                  Icons.menu,
                                  size: 17,
                                  color: textGray,
                                ),
                                '${detailStory.chapterNum}'),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        isEnable
                            ? const SizedBox()
                            : Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Đang chờ duyệt',
                                  style: textTitleBlack.copyWith(
                                      color: colorRed, fontSize: fontSize13),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (idUser == AppProvider.instance.user.id)
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        context: context,
                        builder: (builder) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading:
                                    const Icon(Icons.edit, color: blueColor),
                                title: const Text('Chỉnh sửa'),
                                onTap: actions ?? () {},
                              ),
                              ListTile(
                                leading:
                                    const Icon(Icons.delete, color: colorRed),
                                title: const Text('Xóa'),
                                onTap: actionsDelete ?? () {},
                              ),
                            ],
                          );
                        });
                  },
                  icon: const Icon(Icons.more_horiz)),
            // Column(
            //   children: [
            //     isView ? const SizedBox() : InkWell(
            //       onTap: actions ?? () {},
            //       child: const  Icon(Icons.edit, color: blueColor),
            //     ),
            //     sizeBox20,
            //     isView ? const SizedBox() : InkWell(
            //     onTap: actionsDelete ??  () {},
            //     child: const  Icon(Icons.delete, color: colorRed)),
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  subFunction(Widget icon, String text) {
    return Row(
      children: [
        icon,
        const SizedBox(
          width: 3,
        ),
        Text(text,
            style: const TextStyle(color: textGray, fontSize: fontSize14)),
        const SizedBox(
          width: 18,
        )
      ],
    );
  }
}
