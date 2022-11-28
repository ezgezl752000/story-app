import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ns_read_story/ultils/constants.dart';

class NormalButton extends StatelessWidget {
  final String text;
  final double? width;
  final Function()? action;
  final double height;
  final Color? colorButton;
  final Color? textColor;
  final double? radius;

  const NormalButton(
      {Key? key,
      required this.text,
      this.action,
      this.width,
      this.colorButton,
      this.textColor,
      required this.height,
      this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: action,
        //call back khong truyen gi // neu call back truyen thi xai ()=>action(value)
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 5),
          )),
          backgroundColor: MaterialStateColor.resolveWith(
              (states) => colorButton ?? blueColor),
        ),
      ),
    );
  }
}

class ButtonRadius extends StatelessWidget {
  final String text;
  final double? width;
  final Function()? action;
  final double? height;
  final Color? color;
  final SvgPicture? svgPicture;
  final double? radius;

  const ButtonRadius(
      {Key? key,
      required this.text,
      this.radius,
      this.action,
      this.svgPicture,
      this.width,
      this.height,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: action,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            svgPicture == null
                ? const SizedBox()
                : Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: svgPicture!,
                      ),
                      const SizedBox(
                        width: 5,
                      )
                    ],
                  ),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 8),
          )),
          backgroundColor: MaterialStateColor.resolveWith((states) {
            return action == null
                ? colorGrey
                : color != null
                    ? color!
                    : blueColor;
          }),
        ),
      ),
    );
  }
}
