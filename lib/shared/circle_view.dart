import 'package:flutter/material.dart';
import 'package:ns_read_story/ultils/constants.dart';

class CircleViewLoading extends StatelessWidget {
  const CircleViewLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child:  CircularProgressIndicator.adaptive(valueColor: AlwaysStoppedAnimation<Color>(colorGrey.withOpacity(0.5))));
  }
}
