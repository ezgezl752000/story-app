import 'package:flutter/material.dart';
import 'package:ns_read_story/shared/app_bar.dart';
import 'package:ns_read_story/shared/button.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/textfield.dart';
import 'check_file.dart';
import 'post_story_viewmodel.dart';

class PostStory extends StatefulWidget {
  const PostStory({Key? key}) : super(key: key);

  @override
  _PostStoryState createState() => _PostStoryState();
}

class _PostStoryState extends State<PostStory> {


  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PostStoryViewModel>();
    return Scaffold(
      backgroundColor: colorBg,
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(
        title: viewModel.idBook == '' ? "Thêm tiểu thuyết" : "Sửa Tiểu thuyết",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizeBox15,
              TextFieldCustom(
                hintText: 'Tiêu đề tiểu thuyết',
                controller: viewModel.titleEdtController,
              ),
              sizeBox10,
              SizedBox(
                height: MediaQuery.of(context).size.height / 3.5,
                child: TextFieldCustom(
                  hintText: 'Nội dung tiểu thuyết',
                  onChange: (value){
                    setState(() {});
                  },
                  controller: viewModel.contentEdtController,
                  textInputType: TextInputType.multiline,
                ),
              ),
              sizeBox10,
              const CheckFile(),
              sizeBox20,
              const Text(
                'Bạn là',
                style: textBoldBlack,
              ),
              sizeBox10,
              Wrap(
                spacing: 15,
                children: viewModel.listRoles.map((e) {
                  return InkWell(
                    onTap: () => viewModel.selectRole(e.item1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      width: context.getWidth()/3.5,
                      decoration: BoxDecoration(
                        border: Border.all(color: borderTextFieldColor),
                        borderRadius: BorderRadius.circular(15),
                        color: viewModel.roleSelected == e.item1 ? colorGrey : colorWhite,
                      ),
                      child: Center(
                        child: Text(
                          e.item2,
                          style: textGreyItalic,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              sizeBox10,
              const Text(
                'Thể loại',
                style: textBoldBlack,
              ),
              sizeBox10,
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: viewModel.listCategories.map((e) {
                  return GestureDetector(
                    onTap: () => viewModel.selectCate(e),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                      decoration: BoxDecoration(
                        border: Border.all(color: borderTextFieldColor),
                        borderRadius: BorderRadius.circular(15),
                        color: e.selected! ? colorGrey : colorWhite,
                      ),
                      child: Text(
                        e.name ?? '',
                        style: textGreyItalic,
                      ),
                    ),
                  );
                }).toList(),
              ),
              sizeBox20,
              const Text(
                'Trạng thái',
                style: textBoldBlack,
              ),
              sizeBox10,
              Wrap(
                spacing: 15,
                children: viewModel.listStatus.map((e) {
                  return InkWell(
                    onTap: () => viewModel.selectedComplete(e.item1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      width: context.getWidth()/3,
                      decoration: BoxDecoration(
                        border: Border.all(color: borderTextFieldColor),
                        borderRadius: BorderRadius.circular(15),
                        color: viewModel.statusSelected == e.item1 ? colorGrey : colorWhite,
                      ),
                      child: Center(
                        child: Text(
                          e.item2,
                          style: textGreyItalic,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              sizeBox20,
              Center(
                child: NormalButton(
                  width: context.getWidth()/1.5,
                  height: 35,
                  text:viewModel.idBook == '' ? "Thêm tiểu thuyết" : "Lưu",
                  action: () async{
                    if(viewModel.idBook == ''){
                     await viewModel.createStory(context);
                    }else{
                      await viewModel.updateStory();
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
              sizeBox10
            ],
          ),
        ),
      ),
    );
  }
}
