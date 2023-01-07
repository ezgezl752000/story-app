import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html/parser.dart';
import 'package:ns_read_story/shared/app_bar.dart';
import 'package:ns_read_story/shared/button.dart';
import 'package:ns_read_story/shared/textfield.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:provider/provider.dart';

import 'add_chapter_viewmodel.dart';
import 'html_editor.dart';


class AddChapter extends StatefulWidget {
  const AddChapter({Key? key}) : super(key: key);

  @override
  State<AddChapter> createState() => _AddChapterState();
}

class _AddChapterState extends State<AddChapter> {

  String content = '';



  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AddChapterViewModel>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBg,
        appBar: MyAppBar(
          title: viewModel.isEdit == 'true' ? viewModel.chapter?.name ?? '' : 'Thêm chương mới',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                sizeBox10,
                TextFieldCustom(
                  hintText: 'Tên chương',
                  controller: viewModel.edtName,
                ),
                sizeBox15,
                HtmlEditorCustom(
                  controller: viewModel.htmlController,
                  value: viewModel.chapter?.content??'',
                // onChange: (value) async{
                //   content =   (await viewModel.htmlController.getText()).parseHtmlString();
                //   setState(() { });
                // },
                ),
                sizeBox15,
                ButtonRadius(
                  text: viewModel.isEdit == 'true' ? 'Lưu' :'Tạo',
                  action: () async{
                    if(viewModel.isEdit == 'true'){
                      viewModel.checkEditChapter().then((value) {
                        if(value){
                          Navigator.pop(context);
                        }
                      });
                    }else{
                      viewModel.checkAddChapter().then((value) {
                        if(value){
                          Navigator.pop(context);
                        }
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
