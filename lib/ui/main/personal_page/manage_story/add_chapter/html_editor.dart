import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';

class HtmlEditorCustom extends StatelessWidget {
  HtmlEditorController controller;
  String value;
  final Function(String)? onChange;

  HtmlEditorCustom(
      {Key? key, required this.controller, required this.value, this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HtmlEditor(
          controller: controller,
          htmlEditorOptions: HtmlEditorOptions(
            hint: 'Nội dung',
            shouldEnsureVisible: true,
            initialText: value,
          ),
          callbacks: Callbacks(
              onChangeContent: (value) {
                if (onChange != null) onChange!(value!);
              },
              ),
          htmlToolbarOptions: const HtmlToolbarOptions(
            toolbarPosition: ToolbarPosition.custom, //by de// fault
            toolbarType: ToolbarType.nativeScrollable,
            defaultToolbarButtons: [],
          ),
          otherOptions: OtherOptions(
            height: context.getHeight() / 2,
            decoration: textFieldDecoration,
          ),
        ),
        // Positioned(
        //   top: 10,
        //   right: 0,
        //   child: InkWell(
        //       onTap: () async {
        //         ClipboardData? data = await Clipboard.getData('text/plain');
        //         print("sdasdasd ${data?.text} ád");
        //         // _parseHtmlString(await data?.text);
        //         controller.insertHtml(data?.text ?? '');
        //       },
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.end,
        //         children: const [
        //           Icon(Icons.content_paste_outlined),
        //           sizeBox10,
        //         ],
        //       )),
        // ),
      ],
    );
  }
}
