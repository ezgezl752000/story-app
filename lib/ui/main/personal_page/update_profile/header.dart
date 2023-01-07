import 'dart:io';

import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ns_read_story/ultils/app_config.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/cache_image_network.dart';
import 'update_profile_viewmodel.dart';


class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<UpdateProfileViewModel>();
    return SliverAppBar(
      elevation: 0,
      pinned: true,
      snap: false,
      backgroundColor: colorBlack,
      leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },iconSize: 25,
          icon: SvgPicture.asset('assets/ic_back.svg',width: 30,height: 30,)),
      floating: false,
      expandedHeight: context.getHeight() / 3.3,
      flexibleSpace: LayoutBuilder(builder: (context, constraints) {
        // var top = constraints.biggest.height;
        return FlexibleSpaceBar(
          centerTitle: false,
          titlePadding: const EdgeInsets.all(0),
          title: Center(
              child: Stack(
                children: [
                  AlignPositioned(
                    dy: context.getWidth() / 9,
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(150),
                      child: viewModel.fileAvatar == null
                          ? viewModel.networkAvatar == ''
                          ? Image.asset(
                        'assets/logo.png',
                        width: context.getWidth() / 7,
                        height: context.getWidth() / 7,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      )
                          : ClipRRect(
                          borderRadius: BorderRadius.circular(150),
                          child: CachedNetworkImageCustom(
                            url: viewModel.networkAvatar ,
                            width: context.getWidth() / 7,
                            height: context.getWidth() / 7,
                            boxFit: BoxFit.cover,
                          ))
                          : Container(
                        width: context.getWidth() / 7,
                        height: context.getWidth() / 7,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: FileImage(
                                    File(viewModel.fileAvatar!.path)))),
                      ),
                    ),
                  ),
                  AlignPositioned(
                      dy: context.getWidth() / 6,
                      dx: 25,
                      alignment: Alignment.center,
                      child: InkWell(
                          onTap: () async {
                            final ImagePicker _picker = ImagePicker();
                            final XFile? image = await _picker.pickImage(
                                source: ImageSource.gallery, imageQuality: imageQuality);
                            if (image != null) {
                              viewModel.getFileAvatar(File(image.path));
                            }
                          },
                          child: const Icon(
                            Icons.camera_alt,
                            color: colorGrey,
                            size: 20,
                          ))
                  )
                ],
              ) ),
          background: Hero(
            tag: viewModel.fileBackground == null
                ? viewModel.networkBackground == ''
                    ? 'assets/bg_story.png'
                    : AppConfig.urlImage + '/' + viewModel.networkBackground
                : viewModel.fileBackground!.path,
            child: Stack(
              children: [
                viewModel.fileBackground == null
                    ? viewModel.networkBackground == ''
                    ? Image.asset(
                  'assets/bg_story.png',
                  width: context.getWidth(),
                  height: context.getHeight() / 2.5,
                  fit: BoxFit.fill,
                )
                    : CachedNetworkImageCustom(
                  url: viewModel.networkBackground,
                  width: context.getWidth(),
                  height: context.getHeight() / 2.5,
                  boxFit: BoxFit.fill,
                )
                    : Container(
                  width: context.getWidth(),
                  height: context.getHeight() / 2.5,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
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
        );
      }),
    );
  }
}
