import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ns_read_story/shared/cache_image_network.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';

class ItemFile extends StatelessWidget {
  const ItemFile({Key? key, this.img, required this.onPressDelete}) : super(key: key); 
  final Function onPressDelete;
  final String? img;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: (context.getWidth() / 3) - 10,
          height: (context.getWidth() / 3) - 10,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: FileImage(File(img!)),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: InkWell(
              onTap: () {
                onPressDelete();
              },
              child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: colorBlack.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.close, color: colorBg, size: 18))),
        )
      ],
    );
  }
}

class ItemFileNetwork extends StatelessWidget {
  const ItemFileNetwork(
      {Key? key, this.tittle= '', this.img, required this.onPressDelete})
      : super(key: key);
  final String? tittle;
  final Function onPressDelete;
  final String? img;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImageCustom(
          url: img ?? '',
          width: (context.getWidth() / 3) - 10,
          height: (context.getWidth() / 3) - 10,
          boxFit: BoxFit.cover,
          borderRadius: 8,
        ),
        Positioned(
          top: 0,
          right: 0,
          child: InkWell(
              onTap: () {
                onPressDelete();
              },
              child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: colorBlack.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.close, color: colorBg, size: 18))),
        )
      ],
    );
  }
}
