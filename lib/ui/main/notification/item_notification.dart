import 'package:flutter/material.dart';
import 'package:ns_read_story/model/notification_model.dart';
import 'package:ns_read_story/page_routes.dart';
import 'package:ns_read_story/repository/story_repository.dart';
import 'package:ns_read_story/ui/main/home/detail_story/read_story/read_story_viewmodel.dart';
import 'package:ns_read_story/ultils/app_config.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../model/story.dart';
import '../../../shared/cache_image_network.dart';
import 'notification_viewmodel.dart';

class ItemNotification extends StatelessWidget {
  const ItemNotification({Key? key, required this.detailNotification})
      : super(key: key);
  final NotificationModel detailNotification;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NotificationViewModel>();
    return InkWell(
      onTap: () async {
        if (!detailNotification.isRead!) {
          await AppConfig.logNotification(detailNotification.id!, context);
        }
        switch (detailNotification.type) {
          case 'FOLLOW_USER':
            await Navigator.of(context, rootNavigator: true).pushNamed(
                PageRoutes.detailUser,
                arguments: detailNotification.objectId);
            break;
          case 'LIKE_CHAPTER':
            Navigator.of(context, rootNavigator: true).pushNamed(
                PageRoutes.readStory,
                arguments: ModelReadStory(
                    idChapter: detailNotification.objectId,
                    listChapter: [],
                    story: Story()));
            break;
          case 'NEW_BOOK':
            Navigator.of(context, rootNavigator: true)
                .pushNamed(PageRoutes.detailStory, arguments:Story(id: detailNotification.objectId ?? ''));
            break;
          default:
            break;
        }
        viewModel.onRefresh();
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color:
              detailNotification.isRead! ? colorBg : blueColor.withOpacity(0.1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(150),
              child: detailNotification.author!.avatarUrl != null
                  ? CachedNetworkImageCustom(
                      url: detailNotification.author!.avatarUrl ?? '',
                      width: context.getWidth() / 9,
                      height: context.getWidth() / 9,
                      boxFit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/logo.png',
                      width: context.getWidth() / 9,
                      height: context.getWidth() / 9,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
            ),
            sizeBox10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(detailNotification.content ?? ''),
                  sizeBox10,
                  Text(detailNotification.createdAt.toString().formatDateVN(),
                      style: textHint),
                ],
              ),
            )
            // Expanded(
            //   child: UserAvatar(
            //     width: context.getWidth() / 9,
            //     height: context.getWidth() / 9,
            //     avatarUrl: detailNotification.author!.avatarUrl,
            //     name: detailNotification.content,
            //   ),
            // ),
            // sizeBox10,
            // Expanded(
            //     child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text.rich(TextSpan(
            //         text: "Betrayal ",
            //         style: textTitleBlack.copyWith(fontSize: fontSize14),
            //         children: [
            //           TextSpan(
            //               text: "Đã cập nhật ",
            //               style: textTitleBlack.copyWith(
            //                   fontSize: fontSize14,
            //                   fontWeight: FontWeight.normal),
            //               children: [
            //                 TextSpan(
            //                     text: "Vô đề - Chương 12: Vo đề địa ngục",
            //                     style:
            //                         textTitleBlack.copyWith(fontSize: fontSize14),
            //                     children: const [])
            //               ])
            //         ])),
            //     const SizedBox(
            //       height: 5,
            //     ),
            //     Row(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         SvgPicture.asset(
            //           'assets/ic_story.svg',
            //           width: 10,
            //           height: 10,
            //         ),
            //         const SizedBox(
            //           width: 5,
            //         ),
            //         Text(
            //           "21/02/2022 lúc 11:20 CH",
            //           style: textNormal.copyWith(color: colorGrey),
            //         )
            //       ],
            //     )
            //   ],
            // )),
            // const SizedBox(
            //   width: 3,
            // ),
            // Image.asset(
            //   'assets/imag_story.png',
            //   width: context.getWidth() / 7,
            //   height: context.getWidth() / 7,
            //   fit: BoxFit.cover,
            //   alignment: Alignment.topCenter,
            // )
          ],
        ),
      ),
    );
  }
}
