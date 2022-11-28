import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ns_read_story/shared/app_bar.dart';
import 'package:ns_read_story/ultils/app_config.dart';
import 'package:ns_read_story/ultils/constants.dart';

class PolicyPage extends StatelessWidget {
  const PolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      appBar: const MyAppBar(title: "Chính sách và điều khoản"),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(          
          children: [
          sizeBox10,
          const Text("Chính sách và điều khoản của Hải Vương Truyện",
              style: textBoldBlue),
          sizeBox10,
          Expanded(
            child: SingleChildScrollView(child: Html(data: AppConfig.policy)),
          ),
        ]),
      ),
    );
  }
}
