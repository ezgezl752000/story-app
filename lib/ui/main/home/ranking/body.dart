import 'package:flutter/material.dart';
import 'package:ns_read_story/ui/main/home/ranking/author_ranking.dart';
import 'package:ns_read_story/ui/main/home/ranking/story_ranking.dart';
import 'package:ns_read_story/ui/main/home/ranking/translator_ranking.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';

class BodyRankingPage extends StatefulWidget {
  final TabController controller;
  const BodyRankingPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<BodyRankingPage> createState() => _BodyRankingPageState();
}

class _BodyRankingPageState extends State<BodyRankingPage> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          color: colorBg,
          width: context.getWidth(),
          child: TabBarView(
            children: const[
              StoryRanking(),
            ],
            controller: widget.controller,
          )),
    );
  }
}

