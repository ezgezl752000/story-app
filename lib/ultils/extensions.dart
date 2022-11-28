import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:html/parser.dart';
import '../page_routes.dart';
import 'global_bloc.dart';


extension SizeScreen on BuildContext {
  double getWidth() {
    return MediaQuery.of(this).size.width;
  }

  double getHeight() {
    return MediaQuery.of(this).size.height;
  }

  double getHeightSafe() {
    return getHeight() -
        kBottomNavigationBarHeight -
        MediaQuery.of(this).padding.top -
        MediaQuery.of(this).padding.bottom;
  }
}

extension Gender on bool {
  String checkGender() {
    if (this == true) {
      return 'Nam';
    } else {
      return 'Nữ';
    }
  }

  String checkGenderInt() {
    if (this == true) {
      return '1';
    } else {
      return '0';
    }
  }
}

extension FormatDate on String {
  String formatDate() {
    if (isNotEmpty) {
      return DateFormat('dd/MM/yyyy').format(DateTime.parse(this));
    } else {
      return dataNull;
    }
  }

  String formatDateTime() {
    if (isNotEmpty) {
      return DateFormat('dd/MM/yyyy - HH:mm').format(DateTime.parse(this).toLocal());
    } else {
      return dataNull;
    }
  }
    
  String formatDateVN () {
    if (isNotEmpty) {
      return timeago.format(DateTime.parse(this).toLocal(), locale: 'vi');
    } else {
      return dataNull;
    } 
  }

  bool checkGenderBool() {
    if (this == '1') {
      return true;
    } else {
      return false;
    }
  }

  String parseHtmlString() {
    final document = parse(this);
    final String parsedString = parse(document.body?.text).documentElement?.text ?? '';

    return parsedString;
  }



  String replaceStyleFromHtml() {
    return replaceAll('style="font-size: 12.8px;', '')
        .replaceAll('style', '')
        .replaceAll('fl', '')
        .replaceAll('&nbsp;', '')
        .replaceAll('&quot;', '')
        .replaceAll('Times New Roman', '')
        .replaceAll('font-family:', '')
        .replaceAll('font-variant-numeric: normal;', '')
        .replaceAll('font-variant-east-asian: normal', '');
  }
}

extension DateTimextention on DateTime {
  String? get dateTimeToDayOfWeekVN {
    String? dayOfWeek;
    switch (weekday) {
      case DateTime.monday:
        dayOfWeek = "Thứ Hai";
        break;
      case DateTime.tuesday:
        dayOfWeek = "Thứ Ba";
        break;
      case DateTime.wednesday:
        dayOfWeek = "Thứ Tư";
        break;
      case DateTime.thursday:
        dayOfWeek = "Thứ Năm";
        break;
      case DateTime.friday:
        dayOfWeek = "Thứ Sáu";
        break;
      case DateTime.saturday:
        dayOfWeek = "Thứ Bảy";
        break;
      case DateTime.sunday:
        dayOfWeek = "Chủ Nhật";
        break;
    }
    return dayOfWeek;
  }
}

navigatorToUserPage(context, String id) async{
  final isMyAccount = id == AppProvider.instance.user.id;
  if (isMyAccount) {
   await Navigator.of(context, rootNavigator: true)
        .pushNamed(PageRoutes.personalPage, arguments: isMyAccount);
  } else {
    await Navigator.of(context, rootNavigator: true)
        .pushNamed(PageRoutes.detailUser, arguments: id);
  }
}
