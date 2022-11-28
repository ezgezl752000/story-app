import 'package:flutter/material.dart';

import '../ultils/constants.dart';
import 'cache_image_network.dart';

class UserAvatar extends StatelessWidget {
  final String? name;
  final String? tagName;
  final String? time;
  final String? avatarUrl;
  final double width;
  final double height;
  const UserAvatar(
      {Key? key,
      required this.width,
      required this.height,
      this.name,
      this.tagName,
      this.time,
      this.avatarUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(150),
          child: (avatarUrl != null && avatarUrl!='')
              ? CachedNetworkImageCustom(
                  url: avatarUrl ?? '',
                  width: width,
                  height: height,
                  boxFit: BoxFit.cover,
                )
              : Image.asset(
                  'assets/logo_no_text.png',
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
        ),
        sizeBox10,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name ?? '', style: textBoldTitleBlack),
              const SizedBox(height: 5),
              Text(time ?? tagName ?? '', style: textHint),
            ],
          ),
        )
      ],
    );
  }
}
