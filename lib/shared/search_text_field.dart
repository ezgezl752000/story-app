import 'package:flutter/material.dart';
import 'package:ns_read_story/ultils/constants.dart';

class SearchTextField extends StatelessWidget {
  String hint;
  Widget? icon;
  bool? enable;
  Function()? action;
   SearchTextField({Key? key,required this.hint,this.icon,this.enable,this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(action!=null)action!();
      },
      child: Container(
        height: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: searchBarBackgroundColor,
          border: Border.all(color: Colors.grey.withOpacity(0.4))
        ),
        child:  TextField(
          decoration: InputDecoration(
              hintText: hint,
              enabled: enable ?? true,
              border: InputBorder.none,
              prefixIcon : icon,
            contentPadding: const EdgeInsets.only(top: 9)
          ),
        ),
      ),
    );
  }
}
