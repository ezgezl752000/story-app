import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';

import '../../../ultils/app_config.dart';

class HomeItem extends StatelessWidget {
  final String? icon;
  final String? iconPng;
  final bool isImageNetWork;
  final String title;
  final double? width;
  final double? height;
  final Function()? action;
  const HomeItem(
      {Key? key,
      this.icon,
      required this.title,
      required this.action,
      this.iconPng,
      this.isImageNetWork = false,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalPadding = 70;
    return InkWell(
      onTap: action,
      child: SizedBox(
        width: (context.getWidth() - totalPadding) / 5,
        child: Column(
          children: [
            isImageNetWork
                ? SvgPicture.network(
                    '${AppConfig.urlImage}$icon',
                    width: width ?? context.getWidth() / 8,
                    height: height ?? context.getWidth() / 8,
                    fit: BoxFit.cover,
                  )
                : icon != null
                    ? SvgPicture.asset(
                        icon ?? '',
                        width: width ?? context.getWidth() / 8,
                        height: height ?? context.getWidth() / 8,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(iconPng ?? '',
                        width: width ?? context.getWidth() / 8,
                        height: height ?? context.getWidth() / 8,
                        fit: BoxFit.cover),
            const SizedBox(
              height: 5,
            ),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, fontSize: fontSize15),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
