import 'package:flutter/material.dart';
import 'package:ns_read_story/shared/cache_image_network.dart';
import 'package:ns_read_story/ui/main/home/detail_story/read_story/read_story_viewmodel.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:provider/provider.dart';

class HeaderReadStory extends StatelessWidget {
  const HeaderReadStory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ReadStoryViewModel>();
    return Stack(
      children: [
        Opacity(
          opacity: 0.2,
          child: CachedNetworkImageCustom(
           url: viewModel.imageHeader ?? '',
            boxFit: BoxFit.cover,
            height: context.getWidth()/1.6,
            width: context.getWidth(),
          ),
        ),
        Positioned(
            top: context.getWidth()/2.1,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                  gradient:LinearGradient(
                    colors: [
                      colorWhiteOpacity,
                      colorWhiteOpacity2,
                    ],
                    begin: FractionalOffset(0, 0),
                    end: FractionalOffset(0, 0.8),
                    stops: [0, 1],
                  )
              ),
            )
        )
      ],
    );
  }
}
