import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/cache_image_network.dart';
import 'update_profile_viewmodel.dart';


class HeaderUpdate extends StatelessWidget {
  const HeaderUpdate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<UpdateProfileViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: context.getHeight() / 5 + context.getWidth() /4.7,
          child: Stack(
            children: [
              Hero(
                  tag: 'assets/bg_personal.png',
                  child: Stack(
                    children: [
                      viewModel.fileBackground == null
                          ? viewModel.networkBackground == ''
                          ? Image.asset(
                        'assets/bg_story.png',
                        width: context.getWidth(),
                        height: context.getHeight() / 4,
                        fit: BoxFit.cover,
                      )
                          : CachedNetworkImageCustom(
                        url: viewModel.networkBackground,
                        width: context.getWidth(),
                        height: context.getHeight() / 4,
                        boxFit: BoxFit.cover,
                      )
                          : Container(
                        width: context.getWidth(),
                        height: context.getHeight() / 4,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(
                                    File(viewModel.fileBackground!.path)))),
                      ),
                      Positioned(
                          bottom: 5,
                          right: 10,
                          child: InkWell(
                              onTap: () async {
                                final ImagePicker _picker = ImagePicker();
                                final XFile? image =
                                await _picker.pickImage(source: ImageSource.gallery, imageQuality: imageQuality);
                                if (image != null) {
                                  viewModel.getFileBackground(File(image.path));
                                }
                              },
                              child: const Icon(
                                Icons.camera_alt,
                                color: colorGrey,
                                size: 25,
                              )))
                    ],
                  )
              ),
              Positioned(
                  top: context.getHeight() /6.5,
                  left: 0,
                  right: 0,
                  child:  Center(
                    child: Hero(
                      tag: 'assets/logo.png',
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(150),
                            child: viewModel.fileAvatar == null
                                ? viewModel.networkAvatar == ''
                                ? Image.asset(
                              'assets/logo.png',
                              width: context.getWidth() /  3.5,
                              height: context.getWidth() /  3.5,
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            )
                                : ClipRRect(
                                borderRadius: BorderRadius.circular(150),
                                child: CachedNetworkImageCustom(
                                  url: viewModel.networkAvatar ,
                                  width: context.getWidth() / 3.5,
                                  height: context.getWidth() /  3.5,
                                  boxFit: BoxFit.cover,
                                ))
                                : Container(
                              width: context.getWidth() /  3.5,
                              height: context.getWidth() /  3.5,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: FileImage(
                                          File(viewModel.fileAvatar!.path)))),
                            ),
                          ),
                          Positioned(
                            right: 5,
                              bottom: 5,
                              child: InkWell(
                              onTap: () async {
                                final ImagePicker _picker = ImagePicker();
                                final XFile? image = await _picker.pickImage(
                                    source: ImageSource.gallery,
                                    imageQuality: imageQuality);
                                if (image != null) {
                                  viewModel.getFileAvatar(File(image.path));
                                }
                              },
                              child: const Icon(
                                Icons.camera_alt,
                                color: colorGrey,
                                size: 25,
                              )))
                        ],
                      ),
                    ),
                  ),
              )
            ],
          ),
        )
      ],
    );
  }
}
