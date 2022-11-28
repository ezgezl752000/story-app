import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ns_read_story/ultils/app_config.dart';
import 'package:ns_read_story/ultils/extensions.dart';

class CachedNetworkImageCustom extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? boxFit;
  final double? borderRadius;
  const CachedNetworkImageCustom({required this.url,this.width,this.height,this.boxFit,this.borderRadius, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: CachedNetworkImage(
        imageUrl: url.contains('https') ? url :'${AppConfig.urlImage}$url',
        width: width,
        height: height,
        alignment: Alignment.center,
        fit: boxFit,
        placeholder: (context, url) =>  Center(child:  CircularProgressIndicator.adaptive(valueColor: AlwaysStoppedAnimation<Color>(Colors.grey.shade600))),
        errorWidget: (context, url, error) =>  Image.asset('assets/logo_no_text.png',
          width: context.getWidth() /3.5,
          height: context.getWidth() /3.5,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }
}
