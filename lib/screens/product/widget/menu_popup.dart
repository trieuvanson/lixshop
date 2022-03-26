
import 'package:flutter/material.dart';

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [home, share, reports];
  static const List<MenuItem> secondItems = [logout];

  static const home = MenuItem(text: 'Quay lại trang chủ', icon: Icons.home);
  static const share = MenuItem(text: 'Chia sẻ sản phẩm', icon: Icons.share);
  static const reports =
  MenuItem(text: 'Báo cáo sản phẩm', icon: Icons.bug_report_sharp);
  static const logout = MenuItem(text: 'Đăng xuất', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.black, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.home:
      //Do something
        break;
      case MenuItems.reports:
      //Do something
        break;
      case MenuItems.share:
      //Do something
        break;
      case MenuItems.logout:
      //Do something
        break;
    }
  }
}
