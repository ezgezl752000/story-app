import 'package:flutter/material.dart';

class CheckBoxCustom extends StatefulWidget {
  String? title = "";
  bool isChecked;

  Function(bool value) onPress;

  CheckBoxCustom(
      {Key? key, this.title,
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
        InkWell(
          onTap: (){
            setState(() {
              widget.isChecked = !widget.isChecked;
              widget.onPress(widget.isChecked);
            });
          },
          // child: SvgPicture.asset(
          //   widget.isChecked ? 'assets/ic_checkbox.svg' :
          //   'assets/ic_uncheckbox.svg',width: 20,),
        ),
        const SizedBox(width: 5,),
        Text(
          widget.title ?? "",
          style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14),
        )
      ],
    );
  }
}