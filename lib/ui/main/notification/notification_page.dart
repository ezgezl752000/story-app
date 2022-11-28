import 'package:flutter/material.dart';
import 'package:ns_read_story/page_routes.dart';
import 'package:ns_read_story/shared/app_bar_home.dart';
import 'package:ns_read_story/shared/dialog.dart';
import 'package:ns_read_story/ui/main/notification/item_notification.dart';
import 'package:ns_read_story/ui/main/notification/notification_viewmodel.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../ultils/global_bloc.dart';

BuildContext? contextNoti;
class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NotificationViewModel>();
    contextNoti = context;
    return Scaffold(
      backgroundColor: colorBg,
      appBar: const MyAppBarHome(
        title: 'assets/appbar_notification.png',
      ),
      body: FutureBuilder(
        initialData: AppProvider.instance.token,
        builder: (_, data) {
          if (data.hasData) {
            return SmartRefresher(
              scrollController: viewModel.scrollController,
              controller: viewModel.refreshController,
              enablePullUp: viewModel.isLastPage ? false : true,
              onLoading: () => viewModel.loadMoreNotification(),
              onRefresh: () => viewModel.onRefresh(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Wrap(
                      children: viewModel.listNotification.map((e) {
                        return ItemNotification(detailNotification: e);
                      }).toList(),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: DialogLogin(
                mess: 'Vui lòng đăng nhập để sử dụng chức năng này',
                action: () async {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(PageRoutes.login, arguments: 3);
                },
              ),
            );
          }
        },
      ),
    );
  }
}
