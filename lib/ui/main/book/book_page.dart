import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ns_read_story/shared/app_bar_home.dart';
import 'package:ns_read_story/ui/main/book/body.dart';
import 'package:ns_read_story/ui/main/book/tab_bar.dart';
import 'package:ns_read_story/ultils/constants.dart';

import '../../../page_routes.dart';
import '../../../shared/dialog.dart';
import '../../../ultils/global_bloc.dart';

class BookPage extends StatefulWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> with TickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Hive.openBox('story');
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Hive.box('story').compact();
    // Hive.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      appBar: const MyAppBarHome(
        title: 'assets/appbar_book.png',
      ),
      body: FutureBuilder(
        initialData: AppProvider.instance.token,
        builder: (_, data) {
          if (data.hasData) {
            return Column(
              children: [
                TabBook(controller: tabController!),
                sizeBox10,
                BodyBook(controller: tabController!),
              ],
            );
          } else {
            return Center(
              child: DialogLogin(
                mess: 'Vui lòng đăng nhập để sử dụng chức năng này',
                action: () async {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(PageRoutes.login, arguments: 1);
                },
              ),
            );
          }
        },
      ),
    );
  }
}
