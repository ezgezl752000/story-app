import 'package:flutter/material.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';

class MyAppBarHome extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? action;

  const MyAppBarHome({Key? key, this.title, this.action})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  _MyAppBarHomeState createState() => _MyAppBarHomeState();

  @override
  final Size preferredSize;
}

class _MyAppBarHomeState extends State<MyAppBarHome> {

  _MyAppBarHomeState();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // systemOverlayStyle: SystemUiOverlayStyle(
      //   statusBarColor: Theme.of(context).appBarTheme.backgroundColor, // Status bar
      // ),
      centerTitle: false,
      backgroundColor: colorBg,
      elevation: 0,
      title: Row(
        children: [
          Image.asset(widget.title!,height: context.getWidth()/10,)
        ],
      ),
      actions: widget.action,
    );
  }
}

