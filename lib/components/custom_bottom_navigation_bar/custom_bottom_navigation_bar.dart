import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key, required this.path});

  final String path;

  @override
  State<StatefulWidget> createState() {
    return _CustomBottomNavigationBarState();
  }
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _currentActiveIndex = 0;

  @override
  void initState() {
    // 设置默认选中
    final defaultActiveIndex = _navList.indexWhere((element) => element.id == widget.path);
    _currentActiveIndex = defaultActiveIndex == -1 ? 0 : defaultActiveIndex;

    super.initState();
  }

  final List<_NavItem> _navList = [
    const _NavItem(
        id: '/home',
        label: 'Home',
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home)),
    const _NavItem(
        id: '/notification',
        label: 'Notification',
        icon: Icon(Icons.notification_add_outlined),
        activeIcon: Icon(Icons.notification_add)),
    const _NavItem(
        id: '/explore',
        label: 'Explore',
        icon: Icon(Icons.explore_outlined),
        activeIcon: Icon(Icons.explore)),
    const _NavItem(
        id: '/my',
        label: 'my',
        icon: Icon(Icons.person_2_outlined),
        activeIcon: Icon(Icons.person_2)),
  ];

  List<BottomNavigationBarItem> _buildNavItem(BuildContext context) {
    return List<BottomNavigationBarItem>.from(_navList.map((e) =>
        BottomNavigationBarItem(
            icon: e.icon, label: e.label, activeIcon: e.activeIcon)));
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentActiveIndex,
      items: _buildNavItem(context),
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: (value) {
        setState(() {
          _currentActiveIndex = value;
          GoRouter.of(context).replace(_navList[_currentActiveIndex].id);
        });
      },
    );
  }
}

class _NavItem {
  const _NavItem(
      {required this.label,
      required this.icon,
      required this.activeIcon,
      required this.id});

  final String label;
  final Icon icon;
  final Icon activeIcon;
  final String id;
}
