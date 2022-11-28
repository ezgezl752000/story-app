import 'package:flutter/material.dart';

import '../ultils/constants.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double radius;
  final bool isInActive;
  final double verticalPadding;
  final double horizontalPadding;
  final double fontSize;
  final Widget? childRight;

  const CommonButton(
      {Key? key, required this.text, this.onPressed, this.isInActive = false})
      : verticalPadding = 15,
        radius = 8,
        fontSize = 17,
        horizontalPadding = 120,
        childRight = const SizedBox(),
        super(key: key);

  const CommonButton.center(
      {Key? key, required this.text, this.onPressed, this.isInActive = false})
      : verticalPadding = 15,
        radius = 8,
        fontSize = 17,
        horizontalPadding = 80,
        childRight = const SizedBox(),
        super(key: key);

  const CommonButton.little(
      {Key? key, required this.text, this.onPressed, this.isInActive = false})
      : verticalPadding = 4,
        radius = 4,
        fontSize = 12,
        horizontalPadding = 12,
        childRight = const SizedBox(),
        super(key: key);

  const CommonButton.right(
      {Key? key,
      required this.text,
      this.onPressed,
      this.isInActive = false,
      required this.childRight})
      : verticalPadding = 14,
        radius = 8,
        fontSize = 14,
        horizontalPadding = 24,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(blueColor),
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.button?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: fontSize),
          ),
          childRight!
        ],
      ),
    );
  }
}
