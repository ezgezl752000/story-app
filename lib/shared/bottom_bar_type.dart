import 'package:flutter/material.dart';

enum TabType { home, book, notification, personal }

extension TabTypeExtension on TabType {
  String get label {
    switch (this) {
      case TabType.home:
        return 'Trang chủ';
      case TabType.book:
        return 'Tủ sách';
      case TabType.notification:
        return 'Thông báo';
      case TabType.personal:
        return 'Cá nhân';
    }
  }

  IconData get selectedIcon {
    switch (this) {
      case TabType.home:
        return Icons.home_outlined;
      case TabType.book:
        return Icons.menu_book_outlined;
      case TabType.notification:
        return Icons.notifications_outlined;
      case TabType.personal:
        return Icons.person_outline;
    }
  }
}
