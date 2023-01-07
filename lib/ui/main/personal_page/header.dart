import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:ns_read_story/ultils/global_bloc.dart';

import '../../../../shared/cache_image_network.dart';
import '../../../../ultils/constants.dart';
import '../../../page_routes.dart';

class Header extends StatefulWidget {
  final String heroTag;
  const Header({Key? key, required this.heroTag}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.getHeight() / 5 + context.getWidth() / 4.7,
          child: Stack(
            children: [
              Hero(
                tag: '${widget.heroTag}/assets/logo.png',
                child: (AppProvider.instance.user.coverImage != null &&
                        AppProvider.instance.user.coverImage != '')
                    ? CachedNetworkImageCustom(
                        url: AppProvider.instance.user.coverImage!,
                        width: context.getWidth(),
                        height: context.getHeight() / 4,
                        boxFit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/bg_story.png',
                        width: context.getWidth(),
                        height: context.getHeight() / 4,
                        fit: BoxFit.cover,
                      ),
              ),
              Positioned(
                  top: context.getHeight() / 6.5,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Hero(
                      tag: '${widget.heroTag}/assets/logo.png',
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(150),
                          child: AppProvider.instance.user.avatarUrl != null
                              ? CachedNetworkImageCustom(
                                  url:
                                      AppProvider.instance.user.avatarUrl ?? '',
                                  width: context.getWidth() / 3.5,
                                  height: context.getWidth() / 3.5,
                                  boxFit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/logo.png',
                                  width: context.getWidth() / 3.5,
                                  height: context.getWidth() / 3.5,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topCenter,
                                )),
                    ),
                  ))
            ],
          ),
        ),
        Text(
          AppProvider.instance.user.fullName ?? '',
          style: textStyleFullName,
        ),
        sizeBox5,
        Text(
          '@${AppProvider.instance.user.tagName ?? ''}',
          style: textStyleTagName,
        ),
        sizeBox15,
      ],
    );
  }
}
