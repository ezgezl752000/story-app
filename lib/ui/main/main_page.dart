import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ns_read_story/page_routes.dart';
import 'package:ns_read_story/repository/home_repository.dart';
import 'package:ns_read_story/repository/story_repository.dart';
import 'package:ns_read_story/repository/user_repository.dart';
import 'package:ns_read_story/shared/bottom_bar_type.dart';
import 'package:ns_read_story/ui/main/story/book_page.dart';
import 'package:ns_read_story/ui/main/story/book_viewmodel.dart';
import 'package:ns_read_story/ui/main/home/home_page.dart';
import 'package:ns_read_story/ui/main/home/home_viewmodel.dart';
import 'package:ns_read_story/ui/main/main_page_viewmodel.dart';
import 'package:ns_read_story/ui/main/notification/notification_page.dart';
import 'package:ns_read_story/ui/main/notification/notification_viewmodel.dart';
import 'package:ns_read_story/ultils/app_config.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/global_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../repository/personal_repository.dart';
import '../../shared/dialog.dart';
import 'personal_page/personal_page.dart';
import 'personal_page/personal_page_viewmodel.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

GlobalKey keyMainPage = GlobalKey();

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin {
  final homeNav = GlobalKey<NavigatorState>();
  final bookNav = GlobalKey<NavigatorState>();
  final notificationNav = GlobalKey<NavigatorState>();
  final personalNav = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    // createRewardedInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final viewModel = context.watch<MainPageViewModel>();
    buildContext = context;
    return SafeArea(
      child: Scaffold(
        key: keyMainPage,
        body: IndexedStack(
          index: viewModel.index,
          children: <Widget>[
            Navigator(
                observers: [HeroController()],
                key: homeNav,
                initialRoute: PageRoutes.home,
                onGenerateRoute: (RouteSettings settings) {
                  WidgetBuilder builder;
                  switch (settings.name) {
                    case PageRoutes.home:
                      builder = (BuildContext _) => ChangeNotifierProvider(
                          create: (_) => HomeViewModel(
                              homeRepository: context.read<HomeRepository>()),
                          child: const HomePage());
                      break;
                    default:
                      throw Exception(
                          'homeNav Invalid route: ${settings.name}');
                  }
                  return MaterialPageRoute(
                      builder: builder, settings: settings);
                }),
            Navigator(
                key: bookNav,
                initialRoute: PageRoutes.book,
                onGenerateRoute: (RouteSettings settings) {
                  WidgetBuilder builder;
                  switch (settings.name) {
                    case PageRoutes.book:
                      builder = (BuildContext _) => ChangeNotifierProvider(
                          create: (_) => BookViewModel(
                              storyRepository: context.read<StoryRepository>()),
                          child: const BookPage());
                      break;
                    default:
                      throw Exception(
                          'bookNav Invalid route: ${settings.name}');
                  }
                  return MaterialPageRoute(
                      builder: builder, settings: settings);
                }),
            Navigator(
                key: notificationNav,
                initialRoute: PageRoutes.notification,
                onGenerateRoute: (RouteSettings settings) {
                  WidgetBuilder builder;
                  switch (settings.name) {
                    case PageRoutes.notification:
                      builder = (BuildContext _) => ChangeNotifierProvider(
                            create: (_) => NotificationViewModel(
                                userRepository: context.read<UserRepository>()),
                            child: const NotificationPage(),
                          );
                      break;
                    default:
                      throw Exception(
                          'notificationNav Invalid route: ${settings.name}');
                  }
                  return MaterialPageRoute(
                      builder: builder, settings: settings);
                }),
            Navigator(
                key: personalNav,
                initialRoute: PageRoutes.personalPage,
                onGenerateRoute: (RouteSettings settings) {
                  WidgetBuilder builder;
                  switch (settings.name) {
                    case PageRoutes.personalPage:
                      builder = (BuildContext _) => ChangeNotifierProvider(
                            create: (_) => PersonalPageViewModel(
                              personalRepository:
                                  context.read<PersonalRepository>(),
                            ),
                            child: ChangeNotifierProvider.value(
                                value: AppProvider.instance,
                                child: const PersonalPage()),
                          );
                      break;
                    default:
                      throw Exception(
                          'personalNav Invalid route: ${settings.name}');
                  }
                  return MaterialPageRoute(
                      builder: builder, settings: settings);
                }),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.grey.withOpacity(0.4)))),
                child: Row(
                  children: [
                    BottomBarItem(
                      tabType: TabType.home,
                      showBadge: false,
                      currentTabType: viewModel.currentTabType,
                      onSelected: () {
                        if (viewModel.currentTabType == TabType.home) {
                          homeNav.currentState?.maybePop();
                        } else {
                          viewModel.currentTab = TabType.home;
                        }
                      },
                    ),
                    BottomBarItem(
                      tabType: TabType.book,
                      showBadge: false,
                      currentTabType: viewModel.currentTabType,
                      onSelected: () {
                        if (viewModel.currentTabType == TabType.book) {
                          bookNav.currentState?.maybePop();
                        } else {
                          viewModel.currentTab = TabType.book;
                        }
                      },
                    ),
                    BottomBarItem(
                      tabType: TabType.notification,
                      showBadge: true,
                      count: AppProvider.instance.user.notificationCount ?? 0,
                      currentTabType: viewModel.currentTabType,
                      onSelected: () {
                        if (viewModel.currentTabType == TabType.notification) {
                          notificationNav.currentState?.maybePop();
                        } else {
                          viewModel.currentTab = TabType.notification;
                          // notificationNav.currentContext?.watch<NotificationViewModel>().onRefresh();
                          // Provider.of<NotificationViewModel>(notificationNav.currentContext!, listen: false).onRefresh();
                          contextNoti
                              ?.read<NotificationViewModel>()
                              .onRefresh();
                        }
                      },
                    ),
                    BottomBarItem(
                      tabType: TabType.personal,
                      showBadge: false,
                      currentTabType: viewModel.currentTabType,
                      onSelected: () async{
                        if (viewModel.currentTabType == TabType.personal) {
                          personalNav.currentState?.maybePop();
                        } else {
                          if(AppProvider.instance.token!=null){
                            await context.read<UserRepository>().getInfoUser(AppProvider.instance.token ?? '');
                          }
                          viewModel.currentTab = TabType.personal;
                          contextPersonal?.read<PersonalPageViewModel>().changeNotify();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;
}

class BottomBarItem extends StatelessWidget {
  final TabType tabType;
  final VoidCallback onSelected;
  final TabType currentTabType;
  final bool showBadge;
  final int? count;

  const BottomBarItem(
      {Key? key,
      required this.tabType,
      required this.onSelected,
      required this.showBadge,
      required this.currentTabType,
      this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSelected = (currentTabType == tabType);
    return Expanded(
      child: InkWell(
        onTap: onSelected,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Badge(
              showBadge: count == 0 ? false : showBadge,
              badgeColor: colorRed,
              badgeContent: Text(
                '$count',
                style: const TextStyle(color: Colors.white),
              ),
              child: Icon(tabType.selectedIcon,
                  size: 30, color: isSelected ? Colors.blue : Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
