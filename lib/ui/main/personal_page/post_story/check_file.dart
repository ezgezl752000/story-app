import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../../ultils/constants.dart';
import 'item_file.dart';
import 'post_story_viewmodel.dart';


class CheckFile extends StatelessWidget {
  const CheckFile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PostStoryViewModel>();
    return Column(
      children: [
        Column(
          children: [
            viewModel.imageNetWork == ''
                ? viewModel.file == null
                    ? InkWell(
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(color: blueColor),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.photo_library_outlined,
                                    color: blueColor, size: 18),
                                sizeBox5,
                                Text('Hình ảnh',
                                    style: textBoldBlue.copyWith(
                                        fontSize: fontSize12)),
                              ],
                            )),
                        onTap: () async {
                          final ImagePicker _picker = ImagePicker();
                          final XFile? image = await _picker.pickImage(
                              source: ImageSource.gallery,
                              imageQuality: imageQuality);
                          if (image != null) {
                            viewModel.getFile(File(image.path));
                          }
                        },
                      )
                    : ItemFile(
                        onPressDelete: () {
                          viewModel.clearFile();
                        },
                        img: viewModel.file!.path,
                        
                      )
                : ItemFileNetwork(
                    onPressDelete: () {
                      viewModel.clearFile();
                    },
                    img: viewModel.imageNetWork,
                    tittle: viewModel.imageNetWork.split('/').last,
                  ),
          ],
        ),
      ],
    );
  }
}
