import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ns_read_story/ultils/constants.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;

 const MyAppBar({Key? key, this.title, this.actions})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  final Size preferredSize;
}

class _MyAppBarState extends State<MyAppBar> {
  _MyAppBarState();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const Border(bottom: BorderSide(color: colorGrey, width: 1)),
      backgroundColor: colorBg,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor:
            Theme.of(context).appBarTheme.backgroundColor, // Status bar
      ),
      centerTitle: false,
      elevation: 0,
      title: Text(
        widget.title ?? "",
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_sharp,
          color: Colors.black,
          size: 25,
        ),
      ),
      actions: widget.actions,
    );
  }
}
