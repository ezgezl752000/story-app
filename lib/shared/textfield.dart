import 'package:flutter/material.dart';
import 'package:ns_read_story/ultils/constants.dart';

class MyTextField extends StatelessWidget {
  final bool? obscureText;
  final bool? enable;
  final bool? readOnly;
  final String title;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? textInputType;
  final TextStyle? style;
  const MyTextField({
    Key? key,
    this.obscureText,
    this.controller,
    required this.title,
    this.textInputType,
    this.validator,
    this.enable,
    this.readOnly,
    this.style,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: style ?? textTitleBlack,
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: heightTextField,
          decoration: textFieldDecoration,
          child: TextFormField(
            obscureText: obscureText ?? false,
            readOnly: readOnly ?? false,
            controller: controller,
            validator: validator,
            enabled: enable ?? true,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 5),
              border: InputBorder.none,
            ),
            keyboardType: textInputType,
          ),
        ),
      ],
    );
  }
}

class TextFieldCustom extends StatelessWidget {
  final bool? enable;
  final bool? readOnly;
  final String? hintText;
  final int? maxLine;
  final int? minLine;
  final int? maxLength;
  final bool obscureText;
  final bool? showBorder;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? textInputType;
  final Function(String)? onChange;
  const TextFieldCustom(
      {Key? key,
      this.maxLength,
      this.minLine,
      this.focusNode,
      this.enable,
      this.controller,
      this.hintText,
      this.maxLine,
      this.textInputType,
      this.validator,
      this.readOnly,
      this.onChange,
      this.showBorder = true,
      this.obscureText = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: showBorder! ? textFieldDecoration : null,
      child: TextFormField(
        maxLength: maxLength,
        focusNode: focusNode,
        readOnly: readOnly ?? false,
        controller: controller,
        validator: validator,
        onChanged: (value) {
          if(onChange != null)onChange!(value);
        },
        maxLines: maxLine,
        minLines: minLine,
        enabled: enable ?? true,
        obscureText: obscureText,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: textHint),
        keyboardType: textInputType,
      ),
    );
  }
}
