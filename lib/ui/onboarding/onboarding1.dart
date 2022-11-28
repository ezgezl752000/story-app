import 'package:flutter/material.dart';

import '../../ultils/constants.dart';


class OnboardingScreen1 extends StatefulWidget {
  final String icon;
  final String banner;
  final String tittle;
  final String description;

  const OnboardingScreen1({Key? key, required this.icon, required this.banner, required this.tittle, required this.description}) : super(key: key);
  @override
  State<OnboardingScreen1> createState() => _OnboardingScreen1State();
}

class _OnboardingScreen1State extends State<OnboardingScreen1> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height/7,
          child: Image.asset(widget.icon,fit: BoxFit.fill,),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height/2.5,
          child: Image.asset(widget.banner,fit: BoxFit.fill,),
        ),
        Text(widget.tittle
          ,style: textBoldBlueTitle,textAlign: TextAlign.center,),
        sizeBox15,
        Text(widget.description
          ,style: textNormalBlueBig,textAlign: TextAlign.center,),
      ],
    );
  }
}


