import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CheckBoxCustom extends StatefulWidget {
  String title = "";
  bool isChecked;

  Function(bool value) onPress;

  CheckBoxCustom(
      {Key? key,
      required this.title,
      required this.onPress,
      required this.isChecked})
      : super(key: key);

  @override
  _CheckBoxCustomState createState() => _CheckBoxCustomState();
}

class _CheckBoxCustomState extends State<CheckBoxCustom> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              setState(() {
                widget.isChecked = !widget.isChecked;
                widget.onPress(widget.isChecked);
              });
            },
            icon: SvgPicture.asset(widget.isChecked
                ? "assets/ic_checkbox1.svg"
                : "assets/ic_uncheckbox.svg",
            // width: 20,height: 20,
            )),
        Text(
          widget.title,
        )
      ],
    );
  }
}
