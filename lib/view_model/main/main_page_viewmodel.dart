import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:ns_read_story/base/base_view_model.dart';
import 'package:ns_read_story/repository/user_repository.dart';
import 'package:ns_read_story/shared/bottom_bar_type.dart';
import 'package:ns_read_story/ultils/global_bloc.dart';

class MainPageViewModel extends BaseViewModel {
  int index = 0;
  UserRepository userRepository;

  MainPageViewModel({required this.userRepository, required this.index})
      : super(userRepository) {
    currentTabType = tabs[index];
    index = tabs.indexOf(currentTabType);
  }

  List<TabType> tabs = [
    TabType.home,
    TabType.book,
    TabType.notification,
    TabType.personal
  ];

  TabType currentTabType = TabType.home;

  List<Map<String, dynamic>>? listDayofWeek;

  final yesterday = DateFormat('yyyy-MM-dd')
      .format(DateTime.now().subtract(const Duration(days: 1)));

  set currentTab(TabType value) {
    currentTabType = value;
    index = tabs.indexOf(value);
    switch (value) {
      case TabType.home:
        break;
      case TabType.book:
        break;
      case TabType.notification:
        break;
      case TabType.personal:
        break;
    }
    notifyListeners();
  }
}
