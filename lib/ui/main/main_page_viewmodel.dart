import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:ns_read_story/base/base_view_model.dart';
import 'package:ns_read_story/model/attend_model.dart';
import 'package:ns_read_story/repository/user_repository.dart';
import 'package:ns_read_story/shared/bottom_bar_type.dart';
import 'package:ns_read_story/ultils/global_bloc.dart';

class MainPageViewModel extends BaseViewModel {
  int index = 0;
  UserRepository userRepository;
  List<AttendModel> listDayAttended = [];

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

  void getDayOfWeek() {
    final now = DateTime.now();
    final startFrom = now.subtract(Duration(days: now.weekday - 1));
    listDayofWeek =
        List.generate(7, (i) => startFrom.add(Duration(days: i))).map((e) {
      final AttendModel? isAttend = listDayAttended.firstWhere(
        (element) {
          return element.attendanceDay == DateFormat('yyyy-MM-dd').format(e);
        },
        orElse: () => AttendModel(),
      );
      final Map<String, dynamic> dayOfWeek = {
        'day': DateFormat('yyyy-MM-dd').format(e),
        'isAttended': isAttend?.attendanceDay != null ? true : false,
        'isToday': e.day == now.day,
        'point': isAttend?.point ?? 1,
      };

      if (dayOfWeek['isToday'] == true) {
        AppProvider.instance.isAttended = dayOfWeek['isAttended'];
      }
      return dayOfWeek;
    }).toList();
    final lastAttend = listDayAttended.firstWhere(
      (element) => element.attendanceDay == yesterday,
      orElse: () => AttendModel(),
    );
    if (lastAttend.point != null) {
      for (int i = 0; i < listDayofWeek!.length; i++) {
        final DateTime day = DateTime.parse(listDayofWeek![i]['day']);
        if (day.day == now.day) {
          listDayofWeek![i]['point'] = lastAttend.point! + 1;
        } else if (day.isAfter(now)) {
          listDayofWeek![i]['point'] = listDayofWeek![i - 1]['point'] + 1;
        }
      }
    } else {
      for (int i = 0; i < listDayofWeek!.length; i++) {
        final DateTime day = DateTime.parse(listDayofWeek![i]['day']);
        if (day.isAfter(now)) {
          listDayofWeek![i]['point'] = listDayofWeek![i - 1]['point'] + 1;
        }
      }
    }

    notifyListeners();
  }
}
