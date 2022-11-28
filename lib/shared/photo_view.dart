import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../ultils/app_config.dart';

class PhotoViewPage extends StatelessWidget {
  PhotoViewPage({
    Key? key,
    this.initialIndex = 0,
    required this.listImage,
    this.scrollDirection = Axis.vertical,
  })  : pageController = PageController(initialPage: initialIndex),
        super(key: key);

  final int initialIndex;
  final PageController pageController;
  final List<String> listImage;
  final Axis scrollDirection;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            backgroundDecoration: const BoxDecoration(color: colorBg),
            scrollPhysics: const BouncingScrollPhysics(),
            builder: _buildItem,
            itemCount: listImage.length,
            pageController: pageController,
            scrollDirection: scrollDirection,
          ),
          Positioned(
              top: 25,
              left: 10,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset(
                    'assets/ic_back.svg',
                    width: 30,
                    height: 30,
                  ))),
        ],
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(context, int index) {
    final item = listImage[index];
    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(
          item.contains('https') ? item : '${AppConfig.urlImage}$item'),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained,
      maxScale: PhotoViewComputedScale.covered * 2,
      heroAttributes: PhotoViewHeroAttributes(tag: item),
    );
  }
}
