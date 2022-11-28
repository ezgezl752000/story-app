import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ns_read_story/ultils/constants.dart';

import 'circle_view.dart';

class CoverLoading extends StatelessWidget {
  final Widget child;
  final bool showLoading;

  const CoverLoading({Key? key, this.showLoading = false,  required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(child: child),
        showLoading
            ? Positioned.fill(
                child: Container(
                  color:colorBg,
                  child: Center(
                    child: Container(
                      height: 80,
                      width: 80,
                      padding: const EdgeInsets.all(8),
                      child: const CircleViewLoading(),
                    ),
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
