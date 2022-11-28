import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ns_read_story/model/news_model.dart';
import 'package:ns_read_story/ultils/extensions.dart';

import '../../../../../shared/app_bar.dart';
import '../../../../../shared/cache_image_network.dart';
import '../../../../../ultils/constants.dart';

class DetailNewsPage extends StatefulWidget {
  const DetailNewsPage({Key? key}) : super(key: key);

  @override
  _DetailNewsPageState createState() => _DetailNewsPageState();
}

class _DetailNewsPageState extends State<DetailNewsPage> {
  @override
  Widget build(BuildContext context) {
    final news = ModalRoute.of(context)!.settings.arguments as News;
    return Scaffold(
      backgroundColor: colorBg,
      appBar: const MyAppBar(
        title: "Chi tiết tin tức",
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizeBox10,
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImageCustom(
                  url: news.thumbnail ?? '',
                  width: context.getWidth(),
                  boxFit: BoxFit.fitWidth,
                ),
              ),
              sizeBox10,
              Text(
                news.title ?? '',
                style: textTitleBlack,
              ),
              sizeBox10,
              Text(
                news.createdAt?.formatDate() ?? '',
                style: textHint.copyWith(fontSize: 12),
              ),
              Html(
                data: news.content ?? '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
