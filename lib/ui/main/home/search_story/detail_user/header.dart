import 'package:flutter/material.dart';
import 'package:ns_read_story/shared/cache_image_network.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:provider/provider.dart';

import 'detail_user_viewmodel.dart';

class HeaderDetailUser extends StatelessWidget {
  const HeaderDetailUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DetailUserViewModel>();
    return Column(
      children: [
        SizedBox(
          height: context.getHeight() / 5 + context.getWidth() /4.7,
          child: Stack(
            children: [
              Hero(
                tag: 'assets/bg_personal.png',
                child: (viewModel.user?.coverImage != null && viewModel.user?.coverImage != '') ?
                CachedNetworkImageCustom(
                  url:  viewModel.user!.coverImage!,
                  width: context.getWidth(),
                  height: context.getHeight() / 4,
                  boxFit: BoxFit.cover,
                )
                    :
                Image.asset('assets/bg_story.png',
                  width: context.getWidth(),
                  height: context.getHeight() / 4,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  top: context.getHeight() /6.5,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Hero(
                      tag: 'assets/logo_no_text.png',
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(150),
                          child:(viewModel.user?.avatarUrl != null && viewModel.user?.avatarUrl != '') ? CachedNetworkImageCustom(
                            url: viewModel.user!.avatarUrl! ,
                            width: context.getWidth() /3.5,
                            height: context.getWidth() /3.5,
                            boxFit: BoxFit.cover,
                          ) : Image.asset('assets/logo_no_text.png',
                            width: context.getWidth() /3.5,
                            height: context.getWidth() /3.5,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          )
                      ),
                    ),
                  )
              )

            ],
          ),
        ),
        Text(
          viewModel.user?.fullName ?? '',
          style: textStyleFullName,
        ),
        const SizedBox(height: 3,),
        Text(
          '@${viewModel.user?.tagName ?? ''}',
          style: textStyleTagName,
        ),
      ],
    );
  }
}
